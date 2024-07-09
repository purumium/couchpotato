package com.kosa.controller;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kosa.dto.MovieRanking;



@Controller
public class HomeController {
	
	@GetMapping(value = "/")
    public String start(Model model) {
        // 파일 경로를 지정합니다.
		String filePath = "static/ott_movies.txt";
        // 파일의 내용을 저장할 리스트를 생성합니다.
        List<MovieRanking> rankings = new ArrayList<>();
        
        try (BufferedReader br = new BufferedReader(new InputStreamReader(new ClassPathResource(filePath).getInputStream()))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Assuming each line is comma-separated
                String[] movieData = line.split(",");
                int id = Integer.parseInt(movieData[0].trim());
                String site = movieData[1].trim();
                String title = movieData[2].trim();
                String imageUrl = movieData[3].trim();

                // MovieRanking 객체 생성 및 리스트에 추가
                MovieRanking movie = new MovieRanking(id, site, title, imageUrl);
                rankings.add(movie);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        ObjectMapper objectMapper = new ObjectMapper();
        try {
			String jsonn = objectMapper.writeValueAsString(rankings);
			model.addAttribute("m_array", jsonn);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return "home";
    }
	
	

}