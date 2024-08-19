package com.sound.entity;

import lombok.Data;

@Data
public class Board {
	
	private int idx;
	private String id;
    private String title;
	private String writer;
    private String content;
    private String img; 
    private String createdDate;
    private int count;

}
