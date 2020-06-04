package com.cen.ForumGrade.dao;

import com.cen.common.BaseDao;
import com.cen.ForumGrade.entity.ForumGrade;
import org.apache.ibatis.annotations.Param;

public interface ForumGradeMapper extends BaseDao<ForumGrade> {

    /*根据积分查询*/
    ForumGrade selectByScore(@Param("score") Integer score);

    /*
       根据用户id查询
    */
    ForumGrade selectByForumUserId(@Param("uId") String uId);
}