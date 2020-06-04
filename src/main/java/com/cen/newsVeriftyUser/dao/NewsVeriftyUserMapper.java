package com.cen.newsVeriftyUser.dao;

import com.cen.common.BaseDao;
import com.cen.newsVeriftyUser.entity.NewsVeriftyUser;

import java.util.List;
import java.util.Map;

public interface NewsVeriftyUserMapper extends BaseDao<NewsVeriftyUser> {

    NewsVeriftyUser selectByPrimaryKey(String uuid);

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