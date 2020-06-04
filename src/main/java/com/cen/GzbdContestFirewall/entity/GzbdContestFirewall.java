package com.cen.GzbdContestFirewall.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2020-02-06
*/
public class GzbdContestFirewall {

    private String id; //uuid
    private String openid; //微信openid
    private Date createTime; //创建时间

    public GzbdContestFirewall setId(String id) {
        this.id = id;
        return this;
    }
    public String getId() {
        return id;
    }
    public GzbdContestFirewall setOpenid(String openid) {
        this.openid = openid;
        return this;
    }
    public String getOpenid() {
        return openid;
    }
    public GzbdContestFirewall setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }

}
