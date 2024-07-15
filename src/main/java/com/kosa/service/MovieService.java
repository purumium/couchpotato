package com.kosa.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kosa.dto.MovieDTO;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Service
public class MovieService {

    public List<MovieDTO> fetchMovies(String query, int page) {
        OkHttpClient client = new OkHttpClient();
        List<MovieDTO> movies = new ArrayList<>();
        
        try {
            String encodedQuery = URLEncoder.encode(query, StandardCharsets.UTF_8.toString());
            String url = "https://api.themoviedb.org/3/search/multi?query=" + encodedQuery + "&include_adult=false&language=ko-KR&page="+page;
            
            Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("accept", "application/json")
                .addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMWUyN2Y3NzljMmFjZjM0ZDljYjk3YjZjMTEzZGE4NCIsIm5iZiI6MTcxOTgyMzMyNy45ODU3NTgsInN1YiI6IjY2ODI2YWYwNzFiMjM4ZmZmNzE3ODEyNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-EWdMHyqmb79grQ2lohJrmnS_HZk1DNG3T8ET2ztwSM")
                .build();

            try (Response response = client.newCall(request).execute()) {
                if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);

                ObjectMapper mapper = new ObjectMapper();
                JsonNode rootNode = mapper.readTree(response.body().string());
                JsonNode results = rootNode.path("results");

                for (JsonNode node : results) {
                    MovieDTO movie = new MovieDTO();
                    movie.setTitle(node.path("title").asText());
                    movie.setReleaseDate(node.path("release_date").asText());
                    movie.setOverview(node.path("overview").asText());
                    movie.setMediatype(node.path("media_type").asText());
                    movie.setName(node.path("name").asText());
                    movie.setId(node.path("id").asInt());
                    movie.setPosterpath(node.path("poster_path").asText());
                    movies.add(movie);
                }
                return movies;
            }
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
    public int fetchMovies2(String query) {
        OkHttpClient client = new OkHttpClient();
        
        try {
            String encodedQuery = URLEncoder.encode(query, StandardCharsets.UTF_8.toString());
            String url = "https://api.themoviedb.org/3/search/multi?query=" + encodedQuery + "&include_adult=false&language=ko-KR&page=1";
            
            Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("accept", "application/json")
                .addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMWUyN2Y3NzljMmFjZjM0ZDljYjk3YjZjMTEzZGE4NCIsIm5iZiI6MTcxOTgyMzMyNy45ODU3NTgsInN1YiI6IjY2ODI2YWYwNzFiMjM4ZmZmNzE3ODEyNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-EWdMHyqmb79grQ2lohJrmnS_HZk1DNG3T8ET2ztwSM")
                .build();

            try (Response response = client.newCall(request).execute()) {
                if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);

                ObjectMapper mapper = new ObjectMapper();
                JsonNode rootNode = mapper.readTree(response.body().string());
                return rootNode.path("total_pages").asInt();
                
            }
        } catch (IOException e) {
            e.printStackTrace();
            return 0;
        }
    }
}

