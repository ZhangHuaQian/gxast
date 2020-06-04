package com.cen.GzbdContest.service;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContest.entity.GzbdContest;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
public interface GzbdContestService<GzbdContest> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(GzbdContest record);

    int insertSelective(GzbdContest record);

    GzbdContest selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(GzbdContest record);

    //int updateByPrimaryKey(GzbdContest record);

    List<GzbdContest> selectList(Map<String, Object> paramMap);

}