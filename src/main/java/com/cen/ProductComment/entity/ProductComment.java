package com.cen.ProductComment.entity;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2020-01-07
*/
public class ProductComment{

    private Integer id; //
    private String uId; //用户id
    private String uName; //用户姓名
    private String pId; //商品id
    private String orderId; //订单id
    private String comment; //评论内容
    private Integer productDescription; //宝贝与描述相符：1-5星
    private Integer serviceAttitude; //卖家的服务态度：1-极差，2-差，3-中等，4-好，5-极好
    private Integer deliverySpeed; //卖家发货的速度:    1-极慢，2-慢，3-中等，4-快，5-极快
    private Date createTime; //评论时间
    private Integer isDel; //是否删除:0-否，1-是
    private Integer verify; //审核状态：0-待审核，1-通过，2-不通过
    private Integer rank; //评论等级：1-好，2-中，3-差
    private Map<String,Object> user; //存放用户信息
    private String pName; //商品名称

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public Map<String, Object> getUser() {
        return user;
    }

    public void setUser(Map<String, Object> user) {
        this.user = user;
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }

    public Integer getVerify() {
        return verify;
    }

    public void setVerify(Integer verify) {
        this.verify = verify;
    }

    public ProductComment setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public ProductComment setUId(String uId) {
        this.uId = uId;
        return this;
    }
    public String getUId() {
        return uId;
    }
    public ProductComment setUName(String uName) {
        this.uName = uName;
        return this;
    }
    public String getUName() {
        return uName;
    }
    public ProductComment setPId(String pId) {
        this.pId = pId;
        return this;
    }
    public String getPId() {
        return pId;
    }
    public ProductComment setOrderId(String orderId) {
        this.orderId = orderId;
        return this;
    }
    public String getOrderId() {
        return orderId;
    }
    public ProductComment setComment(String comment) {
        this.comment = comment;
        return this;
    }
    public String getComment() {
        return comment;
    }
    public ProductComment setProductDescription(Integer productDescription) {
        this.productDescription = productDescription;
        return this;
    }
    public Integer getProductDescription() {
        return productDescription;
    }
    public ProductComment setServiceAttitude(Integer serviceAttitude) {
        this.serviceAttitude = serviceAttitude;
        return this;
    }
    public Integer getServiceAttitude() {
        return serviceAttitude;
    }
    public ProductComment setDeliverySpeed(Integer deliverySpeed) {
        this.deliverySpeed = deliverySpeed;
        return this;
    }
    public Integer getDeliverySpeed() {
        return deliverySpeed;
    }
    public ProductComment setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public ProductComment setIsDel(Integer isDel) {
        this.isDel = isDel;
        return this;
    }
    public Integer getIsDel() {
        return isDel;
    }

}
