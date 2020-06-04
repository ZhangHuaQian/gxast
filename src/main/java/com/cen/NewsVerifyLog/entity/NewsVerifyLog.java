package com.cen.NewsVerifyLog.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2020-03-17
*/
public class NewsVerifyLog{

    private Long id; //id
    private Integer newsId; //资讯id
    private String newsType; //资讯类型 新闻中心news 党建工作axhd 政务公开zzgk
    private Date createTime; //创建时间
    private String initiatorId; //发起人id
    private String receiverId; //受理人id
    private String status; //状态 
    private String remark; //备注

    public NewsVerifyLog setId(Long id) {
        this.id = id;
        return this;
    }
    public Long getId() {
        return id;
    }
    public NewsVerifyLog setNewsId(Integer newsId) {
        this.newsId = newsId;
        return this;
    }
    public Integer getNewsId() {
        return newsId;
    }
    public NewsVerifyLog setNewsType(String newsType) {
        this.newsType = newsType;
        return this;
    }
    public String getNewsType() {
        return newsType;
    }
    public NewsVerifyLog setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public NewsVerifyLog setInitiatorId(String initiatorId) {
        this.initiatorId = initiatorId;
        return this;
    }
    public String getInitiatorId() {
        return initiatorId;
    }
    public NewsVerifyLog setReceiverId(String receiverId) {
        this.receiverId = receiverId;
        return this;
    }
    public String getReceiverId() {
        return receiverId;
    }
    public NewsVerifyLog setStatus(String status) {
        this.status = status;
        return this;
    }
    public String getStatus() {
        return status;
    }
    public NewsVerifyLog setRemark(String remark) {
        this.remark = remark;
        return this;
    }
    public String getRemark() {
        return remark;
    }

}
