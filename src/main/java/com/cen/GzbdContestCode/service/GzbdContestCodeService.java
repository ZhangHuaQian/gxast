package com.cen.GzbdContestCode.service;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContestCode.entity.GzbdContestCode;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
public interface GzbdContestCodeService<GzbdContestCode> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(GzbdContestCode record);

    int insertSelective(GzbdContestCode record);

    GzbdContestCode selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(GzbdContestCode record);

    //int updateByPrimaryKey(GzbdContestCode record);

    List<GzbdContestCode> selectList(Map<String, Object> paramMap);

    //获取一条当天可用的兑奖码
    GzbdContestCode selectOneTodayValidCode();

}