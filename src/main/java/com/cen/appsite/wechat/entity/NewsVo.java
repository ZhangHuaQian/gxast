package com.cen.appsite.wechat.entity;

import java.util.List;

/**
 * 发送图文消息（点击跳转到外链） 图文消息条数限制在8条以内，注意，如果图文数超过8，则将会无响应
 * Created by Administrator on 2017/3/20.
 */
public class NewsVo {
    private List<ArticleVo> articles;

    public List<ArticleVo> getArticles() {
        return articles;
    }

    public void setArticles(List<ArticleVo> articles) {
        this.articles = articles;
    }
}
