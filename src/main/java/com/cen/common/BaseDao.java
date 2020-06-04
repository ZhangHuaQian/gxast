package com.cen.common;

import java.util.List;
import java.util.Map;

public interface BaseDao<T> {

    T selectByPrimaryKey(Integer id);

    int deleteByPrimaryKey(Integer id);

    int deleteLogicByIds(String ids);

    int insertSelective(T t);

    int updateByPrimaryKeySelective(T t);

    List<T> selectList(Map<String,Object> paramMap);

}
