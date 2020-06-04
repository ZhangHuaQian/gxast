package com.cen.XczxContest.service;

import java.util.List;
import java.util.Map;

import com.cen.XczxContest.entity.XczxContest;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
public interface XczxContestService<XczxContest> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(XczxContest record);

    int insertSelective(XczxContest record);

    XczxContest selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(XczxContest record);

    //int updateByPrimaryKey(XczxContest record);

    List<XczxContest> selectList(Map<String, Object> paramMap);

}