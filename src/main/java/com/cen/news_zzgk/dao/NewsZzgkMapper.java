package com.cen.news_zzgk.dao;



import com.cen.news_zzgk.entity.NewsZzgk;

import java.util.List;
import java.util.Map;

public interface NewsZzgkMapper {
	int deleteByPrimaryKey(Integer id);

    int insert(NewsZzgk record);

    int insertSelective(NewsZzgk record);

    NewsZzgk selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(NewsZzgk record);

    int updateByPrimaryKey(NewsZzgk record);
    
    List<NewsZzgk> selectList(Map<String, Object> pmap);

	int selectListCount(Map<String, Object> pmap);
	
	List<NewsZzgk> selectNews(Map<String, Object> pmap);
}