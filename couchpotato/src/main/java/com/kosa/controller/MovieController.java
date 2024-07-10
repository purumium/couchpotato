package com.kosa.controller;

import com.kosa.dto.MovieDTO;
import com.kosa.dto.ReviewDTO;
import com.kosa.service.MovieDetailService;
import com.kosa.service.MovieService;
import com.kosa.service.ReviewService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class MovieController {

    @Autowired
    private MovieService movieService;
    @Autowired
    private MovieDetailService movieDeatilService;
    @Autowired
    private ReviewService reviewService;


    @GetMapping("/movies")
    public String showMoviesPage(@RequestParam(name = "query", required = false, defaultValue = "") String query, Model model) {
        List<MovieDTO> movies = movieService.fetchMovies(query);
        model.addAttribute("movies", movies);
        return "movies"; // "movies.jsp" 또는 "movies.html" 파일을 의미
    }
    
    @GetMapping("/movie/detail/{mediatype}/{id}")
    public String showMovieDetail(@PathVariable String mediatype,
                                  @PathVariable int id,
                                  Model model) {
    	String result = "";
    	try {
    		String tvShowDetails = movieDeatilService.getTVShowDetails(mediatype, id);
            model.addAttribute("mediatype", mediatype);
            model.addAttribute("id", id);
            model.addAttribute("tvShowDetails", tvShowDetails);
            model.addAttribute("mediatype", mediatype);
            
            //크롤링
         // URL에 있는 HTML 내용을 가져옵니다.
            Document doc = Jsoup.connect("https://www.themoviedb.org/"+mediatype+"/"+id).get();

            

            Elements divs = doc.select("div.text"); // class가 'text'인 모든 div 요소를 선택
            String stringToRemove = "Now Streaming on ";
            
            for (Element div : divs) {
                Elements links = div.select("a"); // div 내부의 모든 a 태그를 선택
                for (Element link : links) {
                    String title = link.attr("title"); // a 태그의 title 속성을 가져옴
                    result = title.replace(stringToRemove, "");
                    
                }
            }
            model.addAttribute("ott",result);
            
            //리뷰 불러오기
            ReviewDTO reviewDTO = new ReviewDTO();
            reviewDTO.setContentId(id);
            reviewDTO.setContentType(mediatype);
            System.out.println(reviewDTO);
            List<ReviewDTO> test = reviewService.selectReviews(reviewDTO);
            System.out.println(test);
            model.addAttribute("selectreviews",test);
            
    	}catch (IOException e) {
            e.printStackTrace(); // 예외 처리
            // 예외 처리 로직 추가
        }
    	
        
        return "detail"; // detail.jsp로 이동하는 경로
    }
   
}
