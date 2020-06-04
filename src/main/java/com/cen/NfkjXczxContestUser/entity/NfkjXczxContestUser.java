package com.cen.NfkjXczxContestUser.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2020-01-20
*/
public class NfkjXczxContestUser{

    private Integer id; //
    private String openid; //
    private Date createTime; //
    private Integer isLock; //是否锁定: 0-否，1-是

    public NfkjXczxContestUser setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public NfkjXczxContestUser setOpenid(String openid) {
        this.openid = openid;
        return this;
    }
    public String getOpenid() {
        return openid;
    }
    public NfkjXczxContestUser setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public NfkjXczxContestUser setIsLock(Integer isLock) {
        this.isLock = isLock;
        return this;
    }
    public Integer getIsLock() {
        return isLock;
    }

}
