package com.cen.iproll.dao;

import java.util.List;
import java.util.Map;

import com.cen.iproll.entity.IpRoll;

public interface iprollDao {
    int deleteByPrimaryKey(Integer id);

    int insert(IpRoll record);

    int insertSelective(IpRoll record);

    IpRoll selectByPrimaryKey(Integer id);
    
    List<IpRoll> selectList(Map<String, Object> map);
    
    int selectListCount(Map<String, Object> map);
    
    IpRoll selectByIp(String ip);

    int updateByPrimaryKeySelective(IpRoll record);

    int updateByPrimaryKey(IpRoll record);
}