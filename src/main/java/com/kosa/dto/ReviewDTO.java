package com.kosa.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewDTO {
    private int userNumber;
    private String userId;
    private String contentName;
    private int contentId;
    private String contentType;
    private String reviewContent;
    private double rating;
    private String imgurl;
    private String create_at;

    // Getter와 Setter는 생략했습니다. 필요시 추가하세요.
}
