package com.cen.code.dao;

import com.cen.code.entity.code;

public interface codeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(code record);

    int insertSelective(code record);

    code selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(code record);

    int updateByPrimaryKey(code record);
    
    code selectByCode(String code);

	code selectByPassword(String password);
}