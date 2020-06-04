package com.cen.ForumScoreDetail.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-12-27
*/
public class ForumScoreDetail{

    private Long id; //
    private String uId; //用户id
    private String sFrom; //积分来源
    private Integer sValue; //积分值
    private Integer sessionId; //版块id
    private Integer tId; //帖子id
    private String relatedUserId; //相关用户id
    private Date createTime; //创建时间
    private Integer sType; //获取积分类型: 1-发帖成功,2-评论成功，3-帖子举报成功，4-评论举报成功，5-帖子被点赞，6-评论被点赞，7-帖子被举报，8-评论被举报

    public Integer getsType() {
        return sType;
    }

    public void setsType(Integer sType) {
        this.sType = sType;
    }

    public ForumScoreDetail setId(Long id) {
        this.id = id;
        return this;
    }
    public Long getId() {
        return id;
    }
    public ForumScoreDetail setUId(String uId) {
        this.uId = uId;
        return this;
    }
    public String getUId() {
        return uId;
    }
    public ForumScoreDetail setSFrom(String sFrom) {
        this.sFrom = sFrom;
        return this;
    }
    public String getSFrom() {
        return sFrom;
    }
    public ForumScoreDetail setSValue(Integer sValue) {
        this.sValue = sValue;
        return this;
    }
    public Integer getSValue() {
        return sValue;
    }
    public ForumScoreDetail setSessionId(Integer sessionId) {
        this.sessionId = sessionId;
        return this;
    }
    public Integer getSessionId() {
        return sessionId;
    }
    public ForumScoreDetail setTId(Integer tId) {
        this.tId = tId;
        return this;
    }
    public Integer getTId() {
        return tId;
    }
    public ForumScoreDetail setRelatedUserId(String relatedUserId) {
        this.relatedUserId = relatedUserId;
        return this;
    }
    public String getRelatedUserId() {
        return relatedUserId;
    }
    public ForumScoreDetail setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }

}
