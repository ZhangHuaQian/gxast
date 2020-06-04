package com.cen.newsVerifty.entity;

import com.cen.common.entity.BaseEntity;

import java.util.Date;

/**
* @author cframework
* @version V1.0 2019-09-09
*/
public class NewsVerifty extends BaseEntity {

    private String id; //
    private Integer newId; //资讯id
    private String newType; //资讯类型 新闻中心news 党建工作axhd 政务公开zzgk
    private Date createTime; //流程时间
    private String receiverId; //受理人id
    private String receiver; //受理人
    private Integer receiverDepartmentId; //受理部门
    private String receiverDepartment; //受理部门
    private String process; //流程名称
    private String verifty; //流程状态 0未审核 1一审通过 2一审不通过 3二审通过 4二审不通过   后面的状态不一定用得到先设计着 5已发布  6退回 7关闭

    public void setId(String id) {
        this.id = id;
    }
    public String getId() {
        return id;
    }
    public void setNewId(Integer newId) {
        this.newId = newId;
    }
    public Integer getNewId() {
        return newId;
    }

    public String getNewType() {
        return newType;
    }

    public NewsVerifty setNewType(String newType) {
        this.newType = newType;
        return this;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public Date getCreateTime() {
        return createTime;
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
    public void setVerifty(String verifty) {
        this.verifty = verifty;
    }
    public String getVerifty() {
        return verifty;
    }

    @Override
    public String toString() {
        return "NewsVerifty{" +
                "id='" + id + '\'' +
                ", newId=" + newId +
                ", newType='" + newType + '\'' +
                ", createTime=" + createTime +
                ", receiverId='" + receiverId + '\'' +
                ", receiver='" + receiver + '\'' +
                ", receiverDepartmentId=" + receiverDepartmentId +
                ", receiverDepartment='" + receiverDepartment + '\'' +
                ", process='" + process + '\'' +
                ", verifty='" + verifty + '\'' +
                "} " + super.toString();
    }
}
