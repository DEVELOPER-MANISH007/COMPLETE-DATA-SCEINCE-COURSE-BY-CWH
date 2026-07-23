import streamlit as st
import pickle 
import pandas as pd
import requests

# page config
st.set_page_config(page_title="Movie Recommender", layout="wide")

## fetch poster function
def fetch_poster(movie_id):
    response = requests.get(
        'https://api.themoviedb.org/3/movie/{}?api_key=7f7a3cbd77e28e2d2badf830dfce7f1b'.format(movie_id)
    )
    data = response.json()

    poster_path = data.get('poster_path')

    if poster_path:
        return "https://image.tmdb.org/t/p/w500/" + poster_path
    else:
        return "https://via.placeholder.com/500x750?text=No+Image"


movies = pickle.load(open("movies.pkl", "rb"))
similarity = pickle.load(open("similarity.pkl","rb"))

def recommend(movie):
    movie_index = movies[movies['title'] == movie].index[0]
    distances = similarity[movie_index]
    
    movie_list = sorted(list(enumerate(distances)), reverse=True, key=lambda x: x[1])[1:6]
    
    recommended_movies = []
    recommended_movies_poster = []

    for i in movie_list:
        movie_id = movies.iloc[i[0]].movie_id
        recommended_movies.append(movies.iloc[i[0]].title)
        recommended_movies_poster.append(fetch_poster(movie_id))
        
    return recommended_movies, recommended_movies_poster


# UI
st.markdown("<h1 style='text-align: center;'>🎬 Movie Recommender System</h1>", unsafe_allow_html=True)
st.markdown("<p style='text-align: center; color: gray;'>Find your next favorite movie 🍿</p>", unsafe_allow_html=True)

selected_movie_name = st.selectbox(
    '🎥 Select a movie',
    movies['title'].values,
    index=None,
    placeholder="Select a movie..."
)

if st.button("✨ Recommend"):
    
    if selected_movie_name is None:
        st.warning("⚠️ Please select a movie first")
    
    else:
        with st.spinner("⏳ Waiting for suggestions..."):
            names, posters = recommend(selected_movie_name)

        st.markdown("## 🔥 Top Recommendations")

        col1, col2, col3, col4, col5 = st.columns(5)

        with col1:
            st.image(posters[0])
            st.caption(names[0])

        with col2:
            st.image(posters[1])
            st.caption(names[1])

        with col3:
            st.image(posters[2])
            st.caption(names[2])

        with col4:
            st.image(posters[3])
            st.caption(names[3])

        with col5:
            st.image(posters[4])
            st.caption(names[4])