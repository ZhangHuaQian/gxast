package com.cen.SubjectType.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-12-19
*/
public class SubjectType{

    private Integer id; //
    private String title; //专题名称
    private String introduction; //专题简介
    private String url; //专题链接
    private String image; //图片
    private String user; //创建用户
    private String userId; //创建用户id
    private Date createTime; //创建时间
    private Date modifyTime; //修改时间

    public SubjectType setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public SubjectType setTitle(String title) {
        this.title = title;
        return this;
    }
    public String getTitle() {
        return title;
    }
    public SubjectType setIntroduction(String introduction) {
        this.introduction = introduction;
        return this;
    }
    public String getIntroduction() {
        return introduction;
    }
    public SubjectType setUrl(String url) {
        this.url = url;
        return this;
    }
    public String getUrl() {
        return url;
    }
    public SubjectType setImage(String image) {
        this.image = image;
        return this;
    }
    public String getImage() {
        return image;
    }
    public SubjectType setUser(String user) {
        this.user = user;
        return this;
    }
    public String getUser() {
        return user;
    }
    public SubjectType setUserId(String userId) {
        this.userId = userId;
        return this;
    }
    public String getUserId() {
        return userId;
    }
    public SubjectType setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public SubjectType setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
        return this;
    }
    public Date getModifyTime() {
        return modifyTime;
    }

}
