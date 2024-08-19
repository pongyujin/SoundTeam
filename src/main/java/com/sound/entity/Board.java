package com.sound.entity;

import lombok.Data;

@Data
public class Board {

    private int postId;          // POST_ID와 매핑
    private String postTitle;    // POST_TITLE과 매핑
    private String postContent;  // POST_CONTENT와 매핑
    private String postFile;     // POST_FILE과 매핑
    private int viewCount;       // VIEW_COUNT와 매핑
    private String usrId;        // USR_ID와 매핑
    private String createdAt;    // CREATED_AT와 매핑
    private String updatedAt;    // UPDATED_AT와 매핑
}
