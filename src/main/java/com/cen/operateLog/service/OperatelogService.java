package com.cen.operateLog.service;

import java.util.List;
import java.util.Map;

import com.cen.operateLog.entity.Operatelog;

public interface OperatelogService {
	
	int deleteByPrimaryKey(Integer id);

    int insert(Operatelog record);

    int insertSelective(Operatelog record);

    Operatelog selectByPrimaryKey(Integer id);
    
    /**
     * 分页查询
     * @param map
     * @return
     */
    List<Operatelog> selectList(Map<String, Object> map);
    
    /**
     * 分页查询行数
     * @param map
     * @return
     */
    int selectListCount(Map<String, Object> map);

    int updateByPrimaryKeySelective(Operatelog record);

    int updateByPrimaryKey(Operatelog record);

}
