package com.cen.StxcContestReconrd.service;

import java.util.List;
import java.util.Map;

import com.cen.StxcContestReconrd.entity.StxcContestReconrd;

/**
* @author cframework
* @version V1.0 2019-12-24
*/
public interface StxcContestReconrdService<StxcContestReconrd> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(StxcContestReconrd record);

    int insertSelective(StxcContestReconrd record);

    StxcContestReconrd selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(StxcContestReconrd record);

    //int updateByPrimaryKey(StxcContestReconrd record);

    List<StxcContestReconrd> selectList(Map<String, Object> paramMap);

    StxcContestReconrd selectByUid(String uId);

}