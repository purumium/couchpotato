package com.kosa.dto;

import lombok.Data;

public class MovieRanking {
    private int id;
    private String site;
    private String title;
    private String imageUrl;

    public MovieRanking(int id, String site, String title, String imageUrl) {
        this.id = id;
        this.site = site;
        this.title = title;
        this.imageUrl = imageUrl;
    }
    
    public int getId() {
        return id;
    }

    public String getSite() {
        return site;
    }

    public String getTitle() {
        return title;
    }

    public String getImageUrl() {
        return imageUrl;
    }

   
}
