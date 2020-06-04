package com.cen.StxcContestReconrd.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-12-24
*/
public class StxcContestReconrd{

    private String id; //uuid
    private String uName; //用户姓名
    private String uId; //用户id
    private Integer itemId; //题目id
    private String uKey; //用户所选答案
    private String rightKey; //正确答案
    private Integer result; //答题结果：0-错误，1-正确
    private Date createTime; //答题时间
    private String code; //兑奖码
    private String openid;

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public StxcContestReconrd setId(String id) {
        this.id = id;
        return this;
    }
    public String getId() {
        return id;
    }
    public StxcContestReconrd setUName(String uName) {
        this.uName = uName;
        return this;
    }
    public String getUName() {
        return uName;
    }
    public StxcContestReconrd setUId(String uId) {
        this.uId = uId;
        return this;
    }
    public String getUId() {
        return uId;
    }
    public StxcContestReconrd setItemId(Integer itemId) {
        this.itemId = itemId;
        return this;
    }
    public Integer getItemId() {
        return itemId;
    }
    public StxcContestReconrd setUKey(String uKey) {
        this.uKey = uKey;
        return this;
    }
    public String getUKey() {
        return uKey;
    }
    public StxcContestReconrd setRightKey(String rightKey) {
        this.rightKey = rightKey;
        return this;
    }
    public String getRightKey() {
        return rightKey;
    }
    public StxcContestReconrd setResult(Integer result) {
        this.result = result;
        return this;
    }
    public Integer getResult() {
        return result;
    }
    public StxcContestReconrd setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }

}
