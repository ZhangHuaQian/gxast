package com.cen.Message.service;

import com.cen.Message.entity.Message;

import java.util.List;
import java.util.Map;

/**
* @author cframework
* @version V1.0 2019-01-31
*/
public interface MessageService {

    int deleteByPrimaryKey(int id);

    int insert(Message record);

    int insertSelective(Message record);

    Message selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(Message record);

    int updateByPrimaryKey(Message record);

    List<Map> getMyPrivateMessage(Map record);


   String sendMessage(Message message, String[] recIds);

    List<Map> getMyMessage(Map record);

}