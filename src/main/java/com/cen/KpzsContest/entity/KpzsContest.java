package com.cen.KpzsContest.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
public class KpzsContest{

    private Integer id; //
    private String item; //题目
    private String optionA; //选项a
    private String optionB; //选项b
    private String optionC; //选项c
    private String optionD; //选项d
    private String rightKey; //正确答案

    public KpzsContest setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public KpzsContest setItem(String item) {
        this.item = item;
        return this;
    }
    public String getItem() {
        return item;
    }
    public KpzsContest setOptionA(String optionA) {
        this.optionA = optionA;
        return this;
    }
    public String getOptionA() {
        return optionA;
    }
    public KpzsContest setOptionB(String optionB) {
        this.optionB = optionB;
        return this;
    }
    public String getOptionB() {
        return optionB;
    }
    public KpzsContest setOptionC(String optionC) {
        this.optionC = optionC;
        return this;
    }
    public String getOptionC() {
        return optionC;
    }
    public KpzsContest setOptionD(String optionD) {
        this.optionD = optionD;
        return this;
    }
    public String getOptionD() {
        return optionD;
    }
    public KpzsContest setRightKey(String rightKey) {
        this.rightKey = rightKey;
        return this;
    }
    public String getRightKey() {
        return rightKey;
    }

}
