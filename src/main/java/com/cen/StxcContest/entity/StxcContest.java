package com.cen.StxcContest.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2019-12-24
*/
public class StxcContest{

    private Integer id; //
    private String item; //题目
    private String optionA; //选项a
    private String optionB; //选项b
    private String rightKey; //正确答案

    public StxcContest setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public StxcContest setItem(String item) {
        this.item = item;
        return this;
    }
    public String getItem() {
        return item;
    }
    public StxcContest setOptionA(String optionA) {
        this.optionA = optionA;
        return this;
    }
    public String getOptionA() {
        return optionA;
    }
    public StxcContest setOptionB(String optionB) {
        this.optionB = optionB;
        return this;
    }
    public String getOptionB() {
        return optionB;
    }
    public StxcContest setRightKey(String rightKey) {
        this.rightKey = rightKey;
        return this;
    }
    public String getRightKey() {
        return rightKey;
    }

}
