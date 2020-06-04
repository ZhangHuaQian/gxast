package com.cen.ForumGrade.service;

import java.util.List;
import java.util.Map;

import com.cen.ForumGrade.entity.ForumGrade;

/**
* @author cframework
* @version V1.0 2019-12-27
*/
public interface ForumGradeService<ForumGrade> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(ForumGrade record);

    int insertSelective(ForumGrade record);

    ForumGrade selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(ForumGrade record);

    //int updateByPrimaryKey(ForumGrade record);

    List<ForumGrade> selectList(Map<String, Object> paramMap);

    /*根据积分查询*/
    ForumGrade selectByScore(Integer score);

    /*
   根据用户id查询
*/
    ForumGrade selectByForumUserId(String uId);

}