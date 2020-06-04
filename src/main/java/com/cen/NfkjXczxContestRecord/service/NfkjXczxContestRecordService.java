package com.cen.NfkjXczxContestRecord.service;

import java.util.List;
import java.util.Map;

import com.cen.NfkjXczxContestRecord.entity.NfkjXczxContestRecord;

/**
* @author cframework
* @version V1.0 2020-01-20
*/
public interface NfkjXczxContestRecordService<NfkjXczxContestRecord> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(NfkjXczxContestRecord record);

    int insertSelective(NfkjXczxContestRecord record);

    NfkjXczxContestRecord selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(NfkjXczxContestRecord record);

    //int updateByPrimaryKey(NfkjXczxContestRecord record);

    List<NfkjXczxContestRecord> selectList(Map<String, Object> paramMap);

    NfkjXczxContestRecord selectByUid(String uId);

}