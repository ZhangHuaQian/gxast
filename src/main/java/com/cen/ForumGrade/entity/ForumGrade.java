package com.cen.ForumGrade.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-12-27
*/
public class ForumGrade{

    private Integer id; //
    private String name; //等级名称
    private String photo; //等级头像
    private Integer score; //所需积分
    private Date createTime; //创建时间
    private Integer status; //状态：0-使用，1-停用

    public ForumGrade setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public ForumGrade setName(String name) {
        this.name = name;
        return this;
    }
    public String getName() {
        return name;
    }
    public ForumGrade setPhoto(String photo) {
        this.photo = photo;
        return this;
    }
    public String getPhoto() {
        return photo;
    }
    public ForumGrade setScore(Integer score) {
        this.score = score;
        return this;
    }
    public Integer getScore() {
        return score;
    }
    public ForumGrade setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public ForumGrade setStatus(Integer status) {
        this.status = status;
        return this;
    }
    public Integer getStatus() {
        return status;
    }

}
