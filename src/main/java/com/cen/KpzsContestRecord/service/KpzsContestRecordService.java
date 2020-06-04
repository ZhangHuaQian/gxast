package com.cen.KpzsContestRecord.service;

import java.util.List;
import java.util.Map;

import com.cen.KpzsContestRecord.entity.KpzsContestRecord;
import org.apache.ibatis.annotations.Param;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
public interface KpzsContestRecordService<KpzsContestRecord> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(KpzsContestRecord record);

    int insertSelective(KpzsContestRecord record);

    KpzsContestRecord selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(KpzsContestRecord record);

    //int updateByPrimaryKey(KpzsContestRecord record);

    List<KpzsContestRecord> selectList(Map<String, Object> paramMap);

    KpzsContestRecord selectByUid(@Param("uId") String uId);

}