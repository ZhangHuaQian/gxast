package com.cen.news_comment.dao;



import com.cen.news_comment.entity.NewsComment;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface NewsCommentDao {
    int deleteByPrimaryKey(Integer id);

    int insert(NewsComment record);

    int insertSelective(NewsComment record);

    NewsComment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(NewsComment record);

    int updateByPrimaryKey(NewsComment record);
    
    List<NewsComment> selectallcomment(@Param("newsid") int newsid, @Param("pageIndex") int pageIndex, @Param("pageSize") int pageSize);
    
    List<NewsComment> selectCommentUserArticle(@Param("newsid") int newsid, @Param("pageIndex") int pageIndex, @Param("pageSize") int pageSize);
    
    List<NewsComment> commentcount(@Param("newsid") int newsid);

    //查询已审核
    List<NewsComment> article_comment(Map<String,Object> paramMap);

    //查询未审核
    List<NewsComment> article_comment_two(Map<String,Object> paramMap);

    List<NewsComment> allcomment();

    /*查询未审核的评论的数量*/
    int selectCommentCount(Map<String,Object> map);


    //列表
    List<NewsComment> selectList(Map<String, Object> map);

    int selectListCount(Map<String, Object> map);


    int deleteAllMcomment(int id);

//    根据新闻id 获取新闻评论
    List<NewsComment> selectCommentByNid(Map<String,Object> param);



}