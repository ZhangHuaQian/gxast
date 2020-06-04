package com.cen.GzbdContestUser.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
public class GzbdContestUser {

    private Integer id; //
    private String openid; //
    private Date createTime; //
    private Integer isLock; //是否锁定: 0-否，1-是

    public GzbdContestUser setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public GzbdContestUser setOpenid(String openid) {
        this.openid = openid;
        return this;
    }
    public String getOpenid() {
        return openid;
    }
    public GzbdContestUser setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public GzbdContestUser setIsLock(Integer isLock) {
        this.isLock = isLock;
        return this;
    }
    public Integer getIsLock() {
        return isLock;
    }

}
