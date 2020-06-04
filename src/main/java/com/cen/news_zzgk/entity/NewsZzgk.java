package com.cen.news_zzgk.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.cen.news.entity.BaseNewsEntity;

import java.util.Date;

public class NewsZzgk extends BaseNewsEntity {

    private String newsModule; //新闻所属模块：news_zzgk-政务公开

    public String getNewsModule() {
        return newsModule;
    }

    public void setNewsModule(String newsModule) {
        this.newsModule = newsModule;
    }
}