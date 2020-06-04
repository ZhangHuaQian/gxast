package com.cen.sys.ItemWay.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
public class ItemWay{

    private Integer id; //
    private String name; //题型名称
    private Date createTeim; //创建时间

    public ItemWay setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public ItemWay setName(String name) {
        this.name = name;
        return this;
    }
    public String getName() {
        return name;
    }
    public ItemWay setCreateTeim(Date createTeim) {
        this.createTeim = createTeim;
        return this;
    }
    public Date getCreateTeim() {
        return createTeim;
    }

}
