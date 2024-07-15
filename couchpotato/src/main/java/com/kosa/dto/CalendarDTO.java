package com.kosa.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CalendarDTO {
    private int user_number;
    private String user_id;
    private String username;
    private String email;
    private String profile_picture_url;
    private String date_of_birth;
    
    private int review_number;
    private String content_name;
    private String review_text;
    private double rating;
    private String content_image_url;
    private String review_create_at;
    private String review_month;
    
    private int calendar_number;
}
