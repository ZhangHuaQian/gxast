package com.cen.GzbdContestResult.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
public class GzbdContestResult {

    private Integer id; //
    private String uId; //用户openid
    private String uName; //用户昵称
    private Date createTime; //答题时间
    private String code; //兑奖编码
    private Integer result; //用户是否答对：0-否，1-是

    public Integer getResult() {
        return result;
    }

    public void setResult(Integer result) {
        this.result = result;
    }

    public GzbdContestResult setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public GzbdContestResult setUId(String uId) {
        this.uId = uId;
        return this;
    }
    public String getUId() {
        return uId;
    }
    public GzbdContestResult setUName(String uName) {
        this.uName = uName;
        return this;
    }
    public String getUName() {
        return uName;
    }
    public GzbdContestResult setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public GzbdContestResult setCode(String code) {
        this.code = code;
        return this;
    }
    public String getCode() {
        return code;
    }

}
