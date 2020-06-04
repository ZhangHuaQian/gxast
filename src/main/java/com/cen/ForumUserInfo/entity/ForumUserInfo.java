package com.cen.ForumUserInfo.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-12-27
*/
public class ForumUserInfo{

    private Integer id; //
    private String uId; //用户id
    private String uName; //用户名称
    private Integer uType; //用户类型:0-普通用户，1-vip用户
    private Integer score; //积分
    private String vipIcon; //vip图标
    private Date modifyTime; //修改时间

    public ForumUserInfo setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public ForumUserInfo setUId(String uId) {
        this.uId = uId;
        return this;
    }
    public String getUId() {
        return uId;
    }
    public ForumUserInfo setUName(String uName) {
        this.uName = uName;
        return this;
    }
    public String getUName() {
        return uName;
    }
    public ForumUserInfo setUType(Integer uType) {
        this.uType = uType;
        return this;
    }
    public Integer getUType() {
        return uType;
    }
    public ForumUserInfo setScore(Integer score) {
        this.score = score;
        return this;
    }
    public Integer getScore() {
        return score;
    }
    public ForumUserInfo setVipIcon(String vipIcon) {
        this.vipIcon = vipIcon;
        return this;
    }
    public String getVipIcon() {
        return vipIcon;
    }
    public ForumUserInfo setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
        return this;
    }
    public Date getModifyTime() {
        return modifyTime;
    }

}
