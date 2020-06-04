package com.cen.XczxContestCode.service;

import com.cen.XczxContestCode.entity.XczxContestCode;

import java.util.List;
import java.util.Map;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
public interface XczxContestCodeService<XczxContetstCode> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(XczxContestCode record);

    int insertSelective(XczxContetstCode record);

    XczxContetstCode selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(XczxContetstCode record);

    //int updateByPrimaryKey(XczxContestCode record);

    List<XczxContetstCode> selectList(Map<String, Object> paramMap);

    //获取一条当天可用的兑奖码
    XczxContetstCode selectOneTodayValidCode();
}