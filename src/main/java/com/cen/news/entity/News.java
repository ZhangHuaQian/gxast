package com.cen.news.entity;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.Date;

public class News extends BaseNewsEntity{
    private String newsModule; //新闻所属模块：news-新闻中心

    public String getNewsModule() {
        return newsModule;
    }

    public void setNewsModule(String newsModule) {
        this.newsModule = newsModule;
    }
}