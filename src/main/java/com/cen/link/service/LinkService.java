package com.cen.link.service;


import com.cen.link.entity.Link;

import java.util.List;
import java.util.Map;

public interface LinkService {
    Link selectByPrimaryKey(Integer id);
    int updateByPrimaryKeySelective(Link record);
    List<Link> selectList(Map<String, Object> pMap);
    int selectListCount(Map<String, Object> pmap);
    int insertSelective(Link record);
    int deleteByPrimaryKey(int id);
    List<Link> selectreturn(Map<String,Object> sMap);
}
