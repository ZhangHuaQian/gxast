package com.cen.newsVeriftyUser.entity;

import com.cen.common.entity.BaseEntity;

import java.util.Date;

/**
* @author cframework
* @version V1.0 2019-09-09
*/
public class NewsVeriftyUser extends BaseEntity {

    private String uuid; //uuid
    private Integer newsId; //资讯id
    private String newType; //资讯类型 新闻中心news 党建工作axhd 政务公开zzgk
    private Date createTime; //创建时间
    private String initiatorId; //发起人id
    private String initiator; //发起人
    private Integer initiatorDepartmentId; //发起人部门id
    private String initiatorDepartment; //发起人部门
    private String receiverId; //受理人id
    private String receiver; //受理人
    private Integer receiverDepartmentId; //受理人部门id
    private String receiverDepartment; //受理人部门
    private String process; //流程
    private String status; //状态  0未审核 1所在部门通过 2所在部门不通过 3递交至市局未处理 4市级通过 5市级不通过 6递交至市局领导 7市局领导通过 8市局领导不通过 9关闭 10市局下发  11 所在部门下发 12物品下发  13物品确认
    private String remark;//备注

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
    public String getUuid() {
        return uuid;
    }
    public void setNewsId(Integer newsId) {
        this.newsId = newsId;
    }
    public Integer getNewsId() {
        return newsId;
    }

    public String getNewType() {
        return newType;
    }

    public NewsVeriftyUser setNewType(String newType) {
        this.newType = newType;
        return this;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setInitiatorId(String initiatorId) {
        this.initiatorId = initiatorId;
    }
    public String getInitiatorId() {
        return initiatorId;
    }
    public void setInitiator(String initiator) {
        this.initiator = initiator;
    }
    public String getInitiator() {
        return initiator;
    }
    public void setInitiatorDepartmentId(Integer initiatorDepartmentId) {
        this.initiatorDepartmentId = initiatorDepartmentId;
    }
    public Integer getInitiatorDepartmentId() {
        return initiatorDepartmentId;
    }
    public void setInitiatorDepartment(String initiatorDepartment) {
        this.initiatorDepartment = initiatorDepartment;
    }
    public String getInitiatorDepartment() {
        return initiatorDepartment;
    }
    public void setReceiverId(String receiverId) {
        this.receiverId = receiverId;
    }
    public String getReceiverId() {
        return receiverId;
    }
    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }
    public String getReceiver() {
        return receiver;
    }
    public void setReceiverDepartmentId(Integer receiverDepartmentId) {
        this.receiverDepartmentId = receiverDepartmentId;
    }
    public Integer getReceiverDepartmentId() {
        return receiverDepartmentId;
    }
    public void setReceiverDepartment(String receiverDepartment) {
        this.receiverDepartment = receiverDepartment;
    }
    public String getReceiverDepartment() {
        return receiverDepartment;
    }
    public void setProcess(String process) {
        this.process = process;
    }
    public String getProcess() {
        return process;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getStatus() {
        return status;
    }
    public String getRemark() {
        return remark;
    }

    public NewsVeriftyUser setRemark(String remark) {
        this.remark = remark;
        return this;
    }
}
