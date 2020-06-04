package com.cen.newsVeriftyUser.service;

import com.cen.newsVeriftyUser.entity.NewsVeriftyUser;
import com.cen.news_comment.entity.NewsComment;

import java.util.List;
import java.util.Map;

/**
* @author cframework
* @version V1.0 2019-09-09
*/
public interface NewsVeriftyUserService<NewsVeriftyUser> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(newsVeriftyUser record);

    int insertSelective(NewsVeriftyUser record);

    NewsVeriftyUser selectByPrimaryKey(String uuid);

    int updateByPrimaryKeySelective(NewsVeriftyUser record);

    //int updateByPrimaryKey(newsVeriftyUser record);

    List<NewsVeriftyUser> selectList(Map<String, Object> paramMap);

    /**
     * 获取我可以审批的
     * @param paramMap
     * @return
     */
    List<NewsVeriftyUser> selectCanVeriftyList(Map<String,Object> paramMap);

    /*
     * 通过新闻id获取审核批列表
     * */
    List<NewsVeriftyUser> selectByNid(Map<String,Object> paramMap);

}