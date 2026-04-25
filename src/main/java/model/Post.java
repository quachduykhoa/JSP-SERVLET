package model;

import java.sql.Timestamp;

public class Post {
    private int id;
    private String title;
    private String body;
    private int userId;
    private String status;
    private Timestamp createdAt;

    private int likeCount;
    private int commentCount;
    private String username;
    private String avatar;

    public Post() {
    }

    public Post(int id, String title, String body, int userId, String status,
                Timestamp createdAt, int likeCount, int commentCount,
                String username, String avatar) {
        this.id = id;
        this.title = title;
        this.body = body;
        this.userId = userId;
        this.status = status;
        this.createdAt = createdAt;
        this.likeCount = likeCount;
        this.commentCount = commentCount;
        this.username = username;
        this.avatar = avatar;
    }

    // Getters
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getBody() { return body; }
    public int getUserId() { return userId; }
    public String getStatus() { return status; }
    public Timestamp getCreatedAt() { return createdAt; }

    public int getLikeCount() { return likeCount; }
    public int getCommentCount() { return commentCount; }
    public String getUsername() { return username; }
    public String getAvatar() { return avatar; }

    // Setters
    public void setLikeCount(int likeCount) { this.likeCount = likeCount; }
    public void setCommentCount(int commentCount) { this.commentCount = commentCount; }
    public void setUsername(String username) { this.username = username; }
    public void setAvatar(String avatar) { this.avatar = avatar; }

    public void setId(int id) { this.id = id; }
    public void setTitle(String title) { this.title = title; }
    public void setBody(String body) { this.body = body; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setStatus(String status) { this.status = status; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}