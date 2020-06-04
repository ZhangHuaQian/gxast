package com.cen.feedback.service;

import com.cen.feedback.entity.Feedback;

import java.util.Map;
import java.util.List;


public interface FeedbackService {

    int deleteByPrimaryKey(Integer id);

    int insert(Feedback record);

    int insertSelective(Feedback record);

    Feedback selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Feedback record);

    int updateByPrimaryKeyWithBLOBs(Feedback record);

    int updateByPrimaryKey(Feedback record);

    List<Feedback> selectList(Map<String, Object> pmap);  //列表
    int selectListCount(Map<String, Object> pmap);  //列表数

}
