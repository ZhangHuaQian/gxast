package com.cen.news_comment.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.cen.news.entity.BaseNewsEntity;
import com.cen.news.entity.News;
import com.cen.news_reply.entity.news_reply;

import java.util.Date;
import java.util.List;

public class NewsComment {
    private Integer id;

    private Integer topicId;

    private String topicType;

    private String content;

    private String fromUid;

    private String commentstate;


    private Date time;

    private Date startTime;

    private Date endTime;

    private List<news_reply> replayList;

    private String name;

    private String photo;

    private Integer newsId; // 手机用户 - 个人中心 --> 资讯 --> 我的评论 资讯id

    private String newsTitle; // 手机用户 - 个人中心 --> 资讯 --> 我的评论 资讯标题

    public Integer getNewsId() {
        return newsId;
    }

    public void setNewsId(Integer newsId) {
        this.newsId = newsId;
    }

    public String getNewsTitle() {
        return newsTitle;
    }

    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTopicId() {
        return topicId;
    }

    public void setTopicId(Integer topicId) {
        this.topicId = topicId;
    }

    public String getTopicType() {
        return topicType;
    }

    public void setTopicType(String topicType) {
        this.topicType = topicType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFromUid() {
        return fromUid;
    }

    public void setFromUid(String fromUid) {
        this.fromUid = fromUid;
    }

    public String getCommentstate() {
        return commentstate;
    }

    public void setCommentstate(String commentstate) {
        this.commentstate = commentstate;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public List<news_reply> getReplayList() {
        return replayList;
    }

    public void setReplayList(List<news_reply> replayList) {
        this.replayList = replayList;
    }
}
