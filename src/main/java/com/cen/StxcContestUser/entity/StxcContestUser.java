package com.cen.StxcContestUser.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-12-26
*/
public class StxcContestUser{

    private Integer id; //
    private String openid; //
    private Date createTime; //
    private Integer isLock; //是否锁定: 0-否，1-是

    public StxcContestUser setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public StxcContestUser setOpenid(String openid) {
        this.openid = openid;
        return this;
    }
    public String getOpenid() {
        return openid;
    }
    public StxcContestUser setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public StxcContestUser setIsLock(Integer isLock) {
        this.isLock = isLock;
        return this;
    }
    public Integer getIsLock() {
        return isLock;
    }

}
