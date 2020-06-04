package com.cen.GzbdContestResult.service;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContestResult.entity.GzbdContestResult;
import org.apache.ibatis.annotations.Param;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
public interface GzbdContestResultService<GzbdContestResult> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(GzbdContestResult record);

    int insertSelective(GzbdContestResult record);

    GzbdContestResult selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(GzbdContestResult record);

    //int updateByPrimaryKey(GzbdContestResult record);

    List<GzbdContestResult> selectList(Map<String, Object> paramMap);

    GzbdContestResult selectByUid(String uId);

    List<com.cen.GzbdContestResult.entity.GzbdContestResult> selectListByUid(@Param("uId") String uId);

}