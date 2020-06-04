package com.cen.sys.ItemBank.entity;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
public class ItemBank{

    private Integer id; //
    private Integer itemTypeId; //分类id
    private String itemType; //分类名称
    private Integer itemWayId; //题型id
    private String itemWay; //题型名称
    private String content; //题目内容
    private String options; //选项内容
    private String rightKeyId; //选择题正确选项id
    private String analysis; //答案解析

    public ItemBank setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public ItemBank setItemTypeId(Integer itemTypeId) {
        this.itemTypeId = itemTypeId;
        return this;
    }
    public Integer getItemTypeId() {
        return itemTypeId;
    }
    public ItemBank setItemType(String itemType) {
        this.itemType = itemType;
        return this;
    }
    public String getItemType() {
        return itemType;
    }
    public ItemBank setItemWayId(Integer itemWayId) {
        this.itemWayId = itemWayId;
        return this;
    }
    public Integer getItemWayId() {
        return itemWayId;
    }
    public ItemBank setItemWay(String itemWay) {
        this.itemWay = itemWay;
        return this;
    }
    public String getItemWay() {
        return itemWay;
    }
    public ItemBank setContent(String content) {
        this.content = content;
        return this;
    }
    public String getContent() {
        return content;
    }
    public ItemBank setOptions(String options) {
        this.options = options;
        return this;
    }
    public String getOptions() {
        return options;
    }
    public ItemBank setRightKeyId(String rightKeyId) {
        this.rightKeyId = rightKeyId;
        return this;
    }
    public String getRightKeyId() {
        return rightKeyId;
    }
    public ItemBank setAnalysis(String analysis) {
        this.analysis = analysis;
        return this;
    }
    public String getAnalysis() {
        return analysis;
    }

}
