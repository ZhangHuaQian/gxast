package com.cen.NfkjXczxContest.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2020-01-20
*/
public class NfkjXczxContest{

    private Integer id; //
    private String item; //题目
    private String optionA; //选项a
    private String optionB; //选项b
    private String optionC; //选项c
    private String optionD; //选项d
    private String rightKey; //正确答案

    public NfkjXczxContest setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public NfkjXczxContest setItem(String item) {
        this.item = item;
        return this;
    }
    public String getItem() {
        return item;
    }
    public NfkjXczxContest setOptionA(String optionA) {
        this.optionA = optionA;
        return this;
    }
    public String getOptionA() {
        return optionA;
    }
    public NfkjXczxContest setOptionB(String optionB) {
        this.optionB = optionB;
        return this;
    }
    public String getOptionB() {
        return optionB;
    }
    public NfkjXczxContest setOptionC(String optionC) {
        this.optionC = optionC;
        return this;
    }
    public String getOptionC() {
        return optionC;
    }
    public NfkjXczxContest setOptionD(String optionD) {
        this.optionD = optionD;
        return this;
    }
    public String getOptionD() {
        return optionD;
    }
    public NfkjXczxContest setRightKey(String rightKey) {
        this.rightKey = rightKey;
        return this;
    }
    public String getRightKey() {
        return rightKey;
    }

}
