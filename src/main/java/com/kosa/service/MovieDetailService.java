package com.kosa.service;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kosa.dto.MovieDTO;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

@Service
public class MovieDetailService {

    private static final String API_URL = "https://api.themoviedb.org/3";
    private static final String API_KEY = "d1e27f779c2acf34d9cb97b6c11d8a84";
    
    private OkHttpClient client = new OkHttpClient();

    public String getTVShowDetails(String tvType, int tvShowId) throws IOException {
        String url = API_URL + "/"+tvType+"/" + tvShowId + "?language=ko-KR";
        Request request = new Request.Builder()
                .url(url)
                .get()
                .addHeader("accept", "application/json")
                .addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMWUyN2Y3NzljMmFjZjM0ZDljYjk3YjZjMTEzZGE4NCIsIm5iZiI6MTcxOTgyMzMyNy45ODU3NTgsInN1YiI6IjY2ODI2YWYwNzFiMjM4ZmZmNzE3ODEyNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-EWdMHyqmb79grQ2lohJrmnS_HZk1DNG3T8ET2ztwSM")
                .build();

        try (Response response = client.newCall(request).execute()) {
            return response.body().string();
        }
    }
}

