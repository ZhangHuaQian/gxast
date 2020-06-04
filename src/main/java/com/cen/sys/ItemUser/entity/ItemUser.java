package com.cen.sys.ItemUser.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;
import com.sun.imageio.plugins.common.I18N;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
public class ItemUser{

    private Integer id; //
    private String sName; //学生姓名
    private Integer sAge; //学生年龄
    private String tName; //指导老师姓名
    private String tTel; //指导老师电话
    private String school; //学校
    private String sClass; //班级
    private String address; //联系地址
    private Date createTime; //创建时间
    private Integer score; //答题分数

    public ItemUser setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public ItemUser setSName(String sName) {
        this.sName = sName;
        return this;
    }
    public String getSName() {
        return sName;
    }
    public ItemUser setSAge(Integer sAge) {
        this.sAge = sAge;
        return this;
    }
    public Integer getSAge() {
        return sAge;
    }
    public ItemUser setTName(String tName) {
        this.tName = tName;
        return this;
    }
    public String getTName() {
        return tName;
    }
    public ItemUser setTTel(String tTel) {
        this.tTel = tTel;
        return this;
    }
    public String getTTel() {
        return tTel;
    }
    public ItemUser setSchool(String school) {
        this.school = school;
        return this;
    }
    public String getSchool() {
        return school;
    }
    public ItemUser setSClass(String sClass) {
        this.sClass = sClass;
        return this;
    }
    public String getSClass() {
        return sClass;
    }
    public ItemUser setAddress(String address) {
        this.address = address;
        return this;
    }
    public String getAddress() {
        return address;
    }
    public ItemUser setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
}
