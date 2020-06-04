package com.cen.news_xbsb.dao;


import com.cen.news_xbsb.entity.Xbsb;

import java.util.List;
import java.util.Map;

public interface XbsbDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Xbsb record);

    int insertSelective(Xbsb record);

    Xbsb selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Xbsb record);

    int updateByPrimaryKey(Xbsb record);
    
    List<Xbsb> selectList(Map<String, Object> pmap);

	int selectListCount(Map<String, Object> pmap);
	
	List<Xbsb> selectNews(Map<String, Object> pmap);

	/*手机端新闻与分类合并*/
    List<Map> selectNewsByType(Map<String, Object> map);


}