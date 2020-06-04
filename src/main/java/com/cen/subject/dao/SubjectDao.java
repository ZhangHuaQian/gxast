package com.cen.subject.dao;


import com.cen.subject.entity.Subject;

import java.util.List;
import java.util.Map;

public interface SubjectDao {
    int insertSelective(Subject record);

    int deleteByPrimaryKey(Integer id);

    Subject selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Subject record);

    List<Subject> selectList(Map<String, Object> pmap);

    int selectListCount(Map<String, Object> pmap);
}
