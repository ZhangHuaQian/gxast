package com.cen.praise.service;



import com.cen.praise.entity.Praise;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface PraiseService {
	
	int deleteByPrimaryKey(Integer id);

    int insert(Praise record);

    int insertSelective(Praise record);

    Praise selectByPrimaryKey(Integer id);
    
    /**
     * 分页查询
     * @param map
     * @return
     */
    List<Praise> selectList(Map<String, Object> map);
    
    /**
     * 分页查询行数
     * @param map
     * @return
     */
    int selectListCount(Map<String, Object> map);

    int updateByPrimaryKeySelective(Praise record);

    int updateByPrimaryKey(Praise record);

    //查询点赞
    List<Praise> findByUidAndNewsId(Map<String,Object> paramMap);

    List<Praise> findByAid(int newsid);

    List<Praise> findByIpByAid(String ip,int newsid);

    /*根据用户id和类型统计点赞数*/
    List<Map> countNews(Map<String,Object> map);
}
