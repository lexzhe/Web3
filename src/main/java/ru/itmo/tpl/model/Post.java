package ru.itmo.tpl.model;

public class Post {
    private long id;
    private String title;
    private String text;
    private long userId;

    public Post(long id, long userId, String title, String text) {
        this.id = id;
        this.title = title;
        this.text = text;
        this.userId = userId;
    }

    public long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getText() {
        return text;
    }

    public long getUserId() {
        return userId;
    }
}
