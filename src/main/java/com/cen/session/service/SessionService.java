package com.cen.session.service;

import com.cen.session.entity.Session;

import java.util.List;
import java.util.Map;

public interface SessionService {
    int deleteByPrimaryKey(Integer sid);

    int insert(Session record);

    int insertSelective(Session record);

    Session selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(Session record);

    int updateByPrimaryKey(Session record);

    List<Session> selectList(Map<String, Object>  pmap);

    int selectListCount(Map<String, Object> pmap);

    List<Session> selectAll();
}