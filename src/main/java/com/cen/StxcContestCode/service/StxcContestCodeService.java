package com.cen.StxcContestCode.service;

import java.util.List;
import java.util.Map;

import com.cen.StxcContestCode.entity.StxcContestCode;

/**
* @author cframework
* @version V1.0 2019-12-24
*/
public interface StxcContestCodeService<StxcContestCode> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(StxcContestCode record);

    int insertSelective(StxcContestCode record);

    StxcContestCode selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(StxcContestCode record);

    //int updateByPrimaryKey(StxcContestCode record);

    List<StxcContestCode> selectList(Map<String, Object> paramMap);

    //获取一条当天可用的兑奖码
    StxcContestCode selectOneTodayValidCode();

}