package com.cen.news_axhd.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.cen.news.entity.BaseNewsEntity;

import java.util.Date;

public class NewsAxhd extends BaseNewsEntity {

    private String newsModule; //新闻所属模块：news_axhd-党建工作

    public String getNewsModule() {
        return newsModule;
    }

    public void setNewsModule(String newsModule) {
        this.newsModule = newsModule;
    }
}