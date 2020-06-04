package com.cen.StxcContest.service;

import java.util.List;
import java.util.Map;

import com.cen.StxcContest.entity.StxcContest;

/**
* @author cframework
* @version V1.0 2019-12-24
*/
public interface StxcContestService<StxcContest> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(StxcContest record);

    int insertSelective(StxcContest record);

    StxcContest selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(StxcContest record);

    //int updateByPrimaryKey(StxcContest record);

    List<StxcContest> selectList(Map<String, Object> paramMap);

}