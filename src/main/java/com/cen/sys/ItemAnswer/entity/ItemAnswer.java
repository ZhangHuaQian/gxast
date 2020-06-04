package com.cen.sys.ItemAnswer.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
public class ItemAnswer{

    private Integer id; //
    private Integer uId; //用户id
    private String uName; //用户姓名
    private Integer itemBankId; //题目id
    private String uOption; //用户答案
    private String rOption; //正确答案
    private Integer result; //答题结果：0-错误，1-正确
    private Date startTime; //开始时间
    private Date endTime; //结束时间

    public ItemAnswer setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public ItemAnswer setUId(Integer uId) {
        this.uId = uId;
        return this;
    }
    public Integer getUId() {
        return uId;
    }
    public ItemAnswer setUName(String uName) {
        this.uName = uName;
        return this;
    }
    public String getUName() {
        return uName;
    }
    public ItemAnswer setItemBankId(Integer itemBankId) {
        this.itemBankId = itemBankId;
        return this;
    }
    public Integer getItemBankId() {
        return itemBankId;
    }
    public ItemAnswer setUOption(String uOption) {
        this.uOption = uOption;
        return this;
    }
    public String getUOption() {
        return uOption;
    }
    public ItemAnswer setROption(String rOption) {
        this.rOption = rOption;
        return this;
    }
    public String getROption() {
        return rOption;
    }
    public ItemAnswer setResult(Integer result) {
        this.result = result;
        return this;
    }
    public Integer getResult() {
        return result;
    }
    public ItemAnswer setStartTime(Date startTime) {
        this.startTime = startTime;
        return this;
    }
    public Date getStartTime() {
        return startTime;
    }
    public ItemAnswer setEndTime(Date endTime) {
        this.endTime = endTime;
        return this;
    }
    public Date getEndTime() {
        return endTime;
    }

}
