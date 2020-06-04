package com.cen.NfkjXczxContestCode.service;

import java.util.List;
import java.util.Map;

import com.cen.NfkjXczxContestCode.entity.NfkjXczxContestCode;

/**
* @author cframework
* @version V1.0 2020-01-20
*/
public interface NfkjXczxContestCodeService<NfkjXczxContestCode> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(NfkjXczxContestCode record);

    int insertSelective(NfkjXczxContestCode record);

    NfkjXczxContestCode selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(NfkjXczxContestCode record);

    //int updateByPrimaryKey(NfkjXczxContestCode record);

    List<NfkjXczxContestCode> selectList(Map<String, Object> paramMap);

    //获取一条当天可用的兑奖码
    NfkjXczxContestCode selectOneTodayValidCode();

}