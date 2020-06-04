package com.cen.nfkjw.dao;


import com.cen.nfkjw.entity.Nfkjw;

import java.util.List;
import java.util.Map;

public interface NfkjwMapper {
    int deleteByPrimaryKey(int id);

    int insertSelective(Nfkjw record);

    Nfkjw selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(Nfkjw record);

    List<Nfkjw> selectList(Map<String, Object> paramMap);

    int selectListCount(Map<String, Object> pmap);

    Nfkjw selectByNid(int nid);

    List<Nfkjw> findByNid(Map<String,Object> map);
}