package com.cen.NfkjXczxContest.service;

import java.util.List;
import java.util.Map;

import com.cen.NfkjXczxContest.entity.NfkjXczxContest;

/**
* @author cframework
* @version V1.0 2020-01-20
*/
public interface NfkjXczxContestService<NfkjXczxContest> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(NfkjXczxContest record);

    int insertSelective(NfkjXczxContest record);

    NfkjXczxContest selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(NfkjXczxContest record);

    //int updateByPrimaryKey(NfkjXczxContest record);

    List<NfkjXczxContest> selectList(Map<String, Object> paramMap);

}