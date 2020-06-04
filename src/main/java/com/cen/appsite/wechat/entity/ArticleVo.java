package com.cen.appsite.wechat.entity;

/**
 * 图文消息模板
 * 图文消息（点击跳转到外链）
 */
public class ArticleVo {
    private String title;

    private String description;

    private String url;

    private String picurl;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getPicurl() {
        return picurl;
    }

    public void setPicurl(String picurl) {
        this.picurl = picurl;
    }
}