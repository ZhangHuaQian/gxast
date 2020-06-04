package com.cen.KpzsContest.service;

import java.util.List;
import java.util.Map;

import com.cen.KpzsContest.entity.KpzsContest;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
public interface KpzsContestService<KpzsContest> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(KpzsContest record);

    int insertSelective(KpzsContest record);

    KpzsContest selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(KpzsContest record);

    //int updateByPrimaryKey(KpzsContest record);

    List<KpzsContest> selectList(Map<String, Object> paramMap);

}