package com.cen.appsite.wechat.entity;

/**
 * 客服接口图文消息模板
 */
public class CustomerServiceNewsMessageVo extends CustomerServiceBaseMessageVo {
    private NewsVo news;

    public NewsVo getNews() {
        return news;
    }

    public void setNews(NewsVo news) {
        this.news = news;
    }
}
