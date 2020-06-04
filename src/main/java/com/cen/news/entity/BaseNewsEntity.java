package com.cen.news.entity;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.Date;

public class BaseNewsEntity {
    private Integer id;

    private Integer newTypeId;

    private String title;

    private String description;

    private String userId;

    private String author;

    private String content;

    private Integer isDel;

    private Integer status;

    private Date modifyTime;

    private Date createTime;

    private String newsCover;

    private String file;

    private Integer page_view;

    private Integer praise_view;

    private  String orignfrom;

    private String editor;

    private String originUrl;

    private String recommend; //推荐图位位置

    private String recommendImg;//推荐图位图片

    @JSONField(serialize=true)
    private String verifty;


    public String getRecommend() {
        return recommend;
    }

    public void setRecommend(String recommend) {
        this.recommend = recommend;
    }

    public String getRecommendImg() {
        return recommendImg;
    }

    public void setRecommendImg(String recommendImg) {
        this.recommendImg = recommendImg;
    }

    public Integer getPage_view() {
        return page_view;
    }

    public void setPage_view(Integer page_view) {
        this.page_view = page_view;
    }

    public Integer getPraise_view() {
        return praise_view;
    }

    public void setPraise_view(Integer praise_view) {
        this.praise_view = praise_view;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNewTypeId() {
        return newTypeId;
    }

    public void setNewTypeId(Integer newTypeId) {
        this.newTypeId = newTypeId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author == null ? null : author.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getIsDel() {
        return isDel;
    }

    public void setIsDel(Integer isDel) {
        this.isDel = isDel;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getNewsCover() {
        return newsCover;
    }

    public void setNewsCover(String newsCover) {
        this.newsCover = newsCover == null ? null : newsCover.trim();
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public String getOrignfrom() {
        return orignfrom;
    }

    public void setOrignfrom(String orignfrom) {
        this.orignfrom = orignfrom;
    }

    public String getEditor() {
        return editor;
    }

    public void setEditor(String editor) {
        this.editor = editor;
    }

    public String getOriginUrl() {
        return originUrl;
    }

    public void setOriginUrl(String originUrl) {
        this.originUrl = originUrl;
    }

    public String getVerifty() {
        return verifty;
    }

    public BaseNewsEntity setVerifty(String verifty) {
        this.verifty = verifty;
        return this;
    }
}
