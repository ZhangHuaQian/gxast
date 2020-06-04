package com.cen.StxcContestCode.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-12-24
*/
public class StxcContestCode{

    private Integer id; //
    private String code; //兑奖编码
    private String validDate; //有效日期
    private Integer status; //使用状态：0-未使用，1-已使用

    public StxcContestCode setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public StxcContestCode setCode(String code) {
        this.code = code;
        return this;
    }
    public String getCode() {
        return code;
    }
    public StxcContestCode setValidDate(String validDate) {
        this.validDate = validDate;
        return this;
    }
    public String getValidDate() {
        return validDate;
    }
    public StxcContestCode setStatus(Integer status) {
        this.status = status;
        return this;
    }
    public Integer getStatus() {
        return status;
    }

}
