package com.cen.bbs.toconmment.dao;

import com.cen.bbs.toconmment.entity.Toconmment;

import java.util.List;
import java.util.Map;

public interface ToconmmentDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Toconmment record);

    int insertSelective(Toconmment record);

    Toconmment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Toconmment record);

    int updateByPrimaryKeyWithBLOBs(Toconmment record);

    int updateByPrimaryKey(Toconmment record);

    List<Toconmment> selectAllTocomment(Map<String ,Object> pmap);
}