package com.cen.SubjectType.service;

import java.util.List;
import java.util.Map;

import com.cen.SubjectType.entity.SubjectType;

/**
* @author cframework
* @version V1.0 2019-12-19
*/
public interface SubjectTypeService<SubjectType> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(SubjectType record);

    int insertSelective(SubjectType record);

    SubjectType selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(SubjectType record);

    //int updateByPrimaryKey(SubjectType record);

    List<SubjectType> selectList(Map<String, Object> paramMap);

}