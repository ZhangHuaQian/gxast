package com.cen.XczxContestRecord.service;

import java.util.List;
import java.util.Map;

import com.cen.XczxContestRecord.entity.XczxContestRecord;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
public interface XczxContestRecordService<XczxContestRecord> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(XczxContestRecord record);

    int insertSelective(XczxContestRecord record);

    XczxContestRecord selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(XczxContestRecord record);

    //int updateByPrimaryKey(XczxContestRecord record);

    List<XczxContestRecord> selectList(Map<String, Object> paramMap);

    XczxContestRecord selectByUid(String uId);

}