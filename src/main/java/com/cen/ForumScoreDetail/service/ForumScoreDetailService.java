package com.cen.ForumScoreDetail.service;

import java.util.List;
import java.util.Map;

import com.cen.ForumScoreDetail.entity.ForumScoreDetail;

/**
* @author cframework
* @version V1.0 2019-12-27
*/
public interface ForumScoreDetailService<ForumScoreDetail> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(ForumScoreDetail record);

    int insertSelective(ForumScoreDetail record);

    ForumScoreDetail selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(ForumScoreDetail record);

    //int updateByPrimaryKey(ForumScoreDetail record);

    List<ForumScoreDetail> selectList(Map<String, Object> paramMap);

}