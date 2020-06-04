package com.cen.newsVerifty.service;

import java.util.List;
import java.util.Map;

/**
* @author cframework
* @version V1.0 2019-09-09
*/
public interface NewsVeriftyService<NewsVerifty> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(newsVerifty record);

    int insertSelective(NewsVerifty record);

    NewsVerifty selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(NewsVerifty record);

    //int updateByPrimaryKey(newsVerifty record);

    List<NewsVerifty> selectList(Map<String, Object> paramMap);

    int updateVerifyByNid(Map<String,Object> param);

}