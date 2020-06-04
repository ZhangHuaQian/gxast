package com.cen.news.service;

import java.util.List;
import java.util.Map;

import com.cen.news.entity.News;

public interface NewsService {
	int deleteByPrimaryKey(Integer id);

    int insert(News record);

    int insertSelective(News record);

    News selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(News record);

    int updateByPrimaryKey(News record);

	List<News> selectList(Map<String, Object> pmap);

	int selectListCount(Map<String, Object> pmap);

	List<News> selectNews(Map<String, Object> pmap);

    //浏览量
    int addPageview(News record);


    /*首页新闻类型*/
    List<News> selectNewsNum(Map<String, Object> map);

    /*手机端新闻与分类合并*/
    List<Map> selectNewsByType(Map<String, Object> map);


    /*
     * 根据用户id获取新闻中心、党建工作、政务公开的新闻
     * */
    List<News> selectByUid(Map<String,Object> param);

    /*
     * 根据用户id获取新闻中心、党建工作、政务公开的新闻新闻总数
     * */
    int selectCountByUid(Map<String,Object> param);



}
