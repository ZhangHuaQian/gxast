package com.cen.sys.ItemType.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
public class ItemType{

    private Integer id; //id
    private String itemType; //题目类型
    private Date createTime; //创建时间

    public ItemType setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public ItemType setItemType(String itemType) {
        this.itemType = itemType;
        return this;
    }
    public String getItemType() {
        return itemType;
    }
    public ItemType setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }

}
