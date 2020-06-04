package com.cen.KpzsContestCode.service;

import java.util.List;
import java.util.Map;

import com.cen.KpzsContestCode.entity.KpzsContestCode;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
public interface KpzsContestCodeService<KpzsContestCode> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(KpzsContestCode record);

    int insertSelective(KpzsContestCode record);

    KpzsContestCode selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(KpzsContestCode record);

    //int updateByPrimaryKey(KpzsContestCode record);

    List<KpzsContestCode> selectList(Map<String, Object> paramMap);

    //获取一条当天可用的兑奖码
    KpzsContestCode selectOneTodayValidCode();

}