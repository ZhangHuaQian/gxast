package com.cen.news_axhd.service;

import com.cen.news_axhd.entity.NewsAxhd;

import java.util.List;
import java.util.Map;

public interface NewsAxhdService {
	int deleteByPrimaryKey(Integer id);

    int insert(NewsAxhd record);

    int insertSelective(NewsAxhd record);

    NewsAxhd selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(NewsAxhd record);

    int updateByPrimaryKey(NewsAxhd record);
    
    List<NewsAxhd> selectList(Map<String, Object> pmap);

	int selectListCount(Map<String, Object> pmap);
	
	List<NewsAxhd> selectNews(Map<String, Object> pmap);
}
