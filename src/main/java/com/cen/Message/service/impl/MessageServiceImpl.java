package com.cen.Message.service.impl;

import com.alibaba.fastjson.JSON;
import com.cen.Message.dao.MessageMapper;
import com.cen.MessageLog.dao.MessageLogMapper;
import com.cen.MessageLog.entity.MessageLog;
import com.cen.common.util.ReturnInfoType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.Message.service.MessageService;

import com.cen.Message.entity.Message;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
* @author cframework
* @version V1.0 2019-01-31
*/
@Service
@Transactional
public class MessageServiceImpl implements MessageService {

    @Autowired
    MessageMapper messageMapper;
    @Autowired
    MessageLogMapper messageLogMapper;

    @Override
    public int deleteByPrimaryKey(int id){
        return messageMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Message record){
        return messageMapper.insert(record);
    }

    @Override
    public int insertSelective(Message record){
        return messageMapper.insertSelective(record);
    }

    @Override
    public Message selectByPrimaryKey(int id){
        return messageMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Message record){
        return messageMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Message record){
        return messageMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<Map> getMyPrivateMessage(Map record) {
        return messageMapper.getMyPrivateMessage(record);
    }


    public String sendMessage(Message message, String[] recIds) {
        Map<String,Object> map = new HashMap<>();
        int flag = 0;
        switch (message.getType()){
            case "Private":
                insertSelective(message);
                List<MessageLog> messageLogs = new LinkedList<>();
                for(String i:recIds){
                    MessageLog messageLog = new MessageLog();
                    messageLog.setMessageid(message.getId());
                    messageLog.setRecid(i);
                    messageLog.setStatue("0");
                    messageLogs.add(messageLog);
                }

                flag = messageLogMapper.insertBatch(messageLogs);
                break;
            case "Public":
                flag = insertSelective(message);
                break;
            case "Global":
                flag = insertSelective(message);
                break;
        }
        if(flag >= 1){
            map.put("msg", "发送成功");
            map.put("status", ReturnInfoType.SUCEEESS);
        }else{
            map.put("msg", "发送失败");
            map.put("status", ReturnInfoType.FAIL);
        }
        return JSON.toJSONString(map);
    }

    @Override
    public List<Map> getMyMessage(Map record) {
        return messageMapper.getMyMessage(record);
    }


}