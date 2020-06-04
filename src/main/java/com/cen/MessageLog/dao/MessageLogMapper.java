package com.cen.MessageLog.dao;

import com.cen.MessageLog.entity.MessageLog;

import java.util.List;
import java.util.Map;

public interface MessageLogMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(MessageLog record);

    int insertSelective(MessageLog record);

    MessageLog selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(MessageLog record);

    int updateByPrimaryKey(MessageLog record);


    /**
     * 批量插入
     * @param messageLog
     * @return
     */
    int insertBatch(List<MessageLog> messageLog);


    /*设置成已读*/
    int updateStatueByIDID(MessageLog record);

    MessageLog selectAll(int messageId);

}