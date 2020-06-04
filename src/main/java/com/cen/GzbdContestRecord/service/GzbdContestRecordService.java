package com.cen.GzbdContestRecord.service;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContestRecord.entity.GzbdContestRecord;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
public interface GzbdContestRecordService<GzbdContestRecord> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(GzbdContestRecord record);

    int insertSelective(GzbdContestRecord record);

    GzbdContestRecord selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(GzbdContestRecord record);

    //int updateByPrimaryKey(GzbdContestRecord record);

    List<GzbdContestRecord> selectList(Map<String, Object> paramMap);



}