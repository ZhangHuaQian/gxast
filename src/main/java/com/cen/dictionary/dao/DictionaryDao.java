package com.cen.dictionary.dao;

import java.util.List;
import java.util.Map;

import com.cen.dictionary.entity.Dictionary;
import com.cen.ucenter.entity.User;

public interface DictionaryDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Dictionary record);

    List<Dictionary> selectType();

    int insertSelective(Dictionary record);

    Dictionary selectByPrimaryKey(Integer id);

    Dictionary selectByValue(String value);

    Dictionary selectByName(String record);
    
    List<Dictionary> selectAll();
    
    /**
   	 * 分页查询
   	 * @param user
   	 * @return
   	 */
       List<Dictionary> selectList(Map<String, Object> map);

   	/**
   	 * 分页查询行数
   	 * @param map
   	 * @return
   	 */
   	int selectListCount(Map<String, Object> map);
       
    
    int updateByPrimaryKeySelective(Dictionary record);

    int updateByPrimaryKey(Dictionary record);

    /*根据类型查字典列表*/
    List<Dictionary> selectByType();
    
}