package com.cen.MessageLog.service.impl;

import com.cen.MessageLog.dao.MessageLogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.MessageLog.service.MessageLogService;

import com.cen.MessageLog.entity.MessageLog;

import java.util.List;
import java.util.Map;

/**
* @author cframework
* @version V1.0 2019-01-31
*/
@Service
@Transactional
public class MessageLogServiceImpl implements MessageLogService {

    @Autowired
    MessageLogMapper messageLogMapper;

    @Override
    public int deleteByPrimaryKey(int id){
        return messageLogMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(MessageLog record){
        return messageLogMapper.insert(record);
    }

    @Override
    public int insertSelective(MessageLog record){
        return messageLogMapper.insertSelective(record);
    }

    @Override
    public MessageLog selectByPrimaryKey(int id){
        return messageLogMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(MessageLog record){
        return messageLogMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(MessageLog record){
        return messageLogMapper.updateByPrimaryKey(record);
    }
   /*批量插入*/
    @Override
    public int insertBatch(List<MessageLog> messageLog) {
        return messageLogMapper.insertBatch(messageLog);
    }
    /*设置为已读*/
    @Override
    public int updateStatueByIDID(MessageLog record) {
        return messageLogMapper.updateStatueByIDID(record);
    }

    @Override
    public MessageLog selectAll(int messageId) {
        return messageLogMapper.selectAll(messageId);
    }

}