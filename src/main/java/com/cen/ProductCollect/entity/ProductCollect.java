package com.cen.ProductCollect.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2020-01-08
*/
public class ProductCollect{

    private Integer id; //
    private String uId; //用户id
    private String pId; //商品id
    private Date createTime; //收藏时间

    public ProductCollect setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public ProductCollect setUId(String uId) {
        this.uId = uId;
        return this;
    }
    public String getUId() {
        return uId;
    }
    public ProductCollect setPId(String pId) {
        this.pId = pId;
        return this;
    }
    public String getPId() {
        return pId;
    }
    public ProductCollect setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }

}
