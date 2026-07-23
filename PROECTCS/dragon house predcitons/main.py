# ==============================
# 1. IMPORTS
# ==============================
import pandas as pd
import numpy as np

from sklearn.model_selection import StratifiedShuffleSplit, cross_val_score
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.impute import SimpleImputer
from sklearn.compose import ColumnTransformer

from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error

from joblib import dump


# ==============================
# 2. LOAD DATA
# ==============================
def load_data(path):
    return pd.read_csv(path)


# ==============================
# 3. SPLIT
# ==============================
def stratified_split(data):
    split = StratifiedShuffleSplit(n_splits=1, test_size=0.2, random_state=42)

    for train_idx, test_idx in split.split(data, data['CHAS']):
        train_set = data.loc[train_idx]
        test_set = data.loc[test_idx]

    return train_set, test_set


# ==============================
# 4. FEATURE ENGINEERING
# ==============================
def add_features(df):
    df = df.copy()
    df['TAXRM'] = df['TAX'] / df['RM']
    return df


# ==============================
# 5. PIPELINE (ADVANCED)
# ==============================
def create_pipeline(df):
    # Separate columns
    num_cols = df.select_dtypes(include=[np.number]).columns.tolist()
    cat_cols = df.select_dtypes(exclude=[np.number]).columns.tolist()

    # Remove target if present
    if "MEDV" in num_cols:
        num_cols.remove("MEDV")

    # Numeric pipeline
    num_pipeline = Pipeline([
        ('imputer', SimpleImputer(strategy='median')),
        ('scaler', StandardScaler())
    ])

    # Categorical pipeline
    cat_pipeline = Pipeline([
        ('imputer', SimpleImputer(strategy='most_frequent')),
        ('encoder', OneHotEncoder(handle_unknown='ignore'))
    ])

    # Combine
    full_pipeline = ColumnTransformer([
        ('num', num_pipeline, num_cols),
        ('cat', cat_pipeline, cat_cols)
    ])

    return full_pipeline


# ==============================
# 6. MODEL TRAIN
# ==============================
def train_model(X, y):
    model = RandomForestRegressor()
    model.fit(X, y)
    return model


# ==============================
# 7. EVALUATION
# ==============================
def evaluate(model, X, y):
    preds = model.predict(X)
    rmse = np.sqrt(mean_squared_error(y, preds))
    return rmse


def cross_val(model, X, y):
    scores = cross_val_score(
        model, X, y,
        scoring='neg_mean_squared_error',
        cv=10
    )
    return np.sqrt(-scores)


# ==============================
# 8. MAIN
# ==============================
def main():
    data = load_data("data.csv")

    train_set, test_set = stratified_split(data)

    # Feature engineering
    train_set = add_features(train_set)
    test_set = add_features(test_set)

    # Split features & labels
    X_train = train_set.drop("MEDV", axis=1)
    y_train = train_set["MEDV"].copy()

    X_test = test_set.drop("MEDV", axis=1)
    y_test = test_set["MEDV"].copy()

    # Pipeline
    pipeline = create_pipeline(train_set)

    X_train_prepared = pipeline.fit_transform(X_train)
    X_test_prepared = pipeline.transform(X_test)

    # Model
    model = train_model(X_train_prepared, y_train)

    # Evaluation
    print("Train RMSE:", evaluate(model, X_train_prepared, y_train))

    cv_scores = cross_val(model, X_train_prepared, y_train)
    print("CV Scores:", cv_scores)
    print("CV Mean:", cv_scores.mean())

    print("Test RMSE:", evaluate(model, X_test_prepared, y_test))

    # Save
    dump(model, "Dragon.joblib")
    dump(pipeline, "Pipeline.joblib")

    print("✅ Model + Pipeline saved")


# ==============================
# ENTRY
# ==============================
if __name__ == "__main__":
    main()