package com.cen.Message.dao;

import com.cen.Message.entity.Message;

import java.util.List;
import java.util.Map;

public interface MessageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Message record);

    int insertSelective(Message record);

    Message selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Message record);

    int updateByPrimaryKey(Message record);

    List<Map> getMyPrivateMessage(Map record);

    List<Map> getMyMessage(Map record);

}