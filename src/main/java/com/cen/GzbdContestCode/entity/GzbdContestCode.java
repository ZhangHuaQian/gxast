package com.cen.GzbdContestCode.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
public class GzbdContestCode{

    private Integer id; //
    private String code; //兑奖编码
    private String validDate; //有效日期
    private Integer status; //使用状态：0-未使用，1-已使用

    public GzbdContestCode setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public GzbdContestCode setCode(String code) {
        this.code = code;
        return this;
    }
    public String getCode() {
        return code;
    }
    public GzbdContestCode setValidDate(String validDate) {
        this.validDate = validDate;
        return this;
    }
    public String getValidDate() {
        return validDate;
    }
    public GzbdContestCode setStatus(Integer status) {
        this.status = status;
        return this;
    }
    public Integer getStatus() {
        return status;
    }

}
