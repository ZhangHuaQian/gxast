package com.cen.news_reply.dao;



import com.cen.news_reply.entity.news_reply;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface news_replyDao {
    int deleteByPrimaryKey(Integer id);

    int insert(news_reply record);

    int insertSelective(news_reply record);

    news_reply selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(news_reply record);

    int updateByPrimaryKey(news_reply record);

    //查询回复
    List<news_reply> select_replyId(Map<String,Object> map);


}