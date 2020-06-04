package com.cen.NewsVerifyLog.service;

import java.util.List;
import java.util.Map;

import com.cen.NewsVerifyLog.entity.NewsVerifyLog;

/**
* @author cframework
* @version V1.0 2020-03-17
*/
public interface NewsVerifyLogService<NewsVerifyLog> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(NewsVerifyLog record);

    int insertSelective(NewsVerifyLog record);

    NewsVerifyLog selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(NewsVerifyLog record);

    //int updateByPrimaryKey(NewsVerifyLog record);

    List<NewsVerifyLog> selectList(Map<String, Object> paramMap);

    /*
     * 查询新闻的审核状态
     * */
    List<Map<String,Object>> selectVerifyByNid(Integer nId,String nType);

}