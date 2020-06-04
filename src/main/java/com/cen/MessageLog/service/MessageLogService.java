package com.cen.MessageLog.service;

import com.cen.MessageLog.entity.MessageLog;

import java.util.List;
import java.util.Map;

/**
* @author cframework
* @version V1.0 2019-01-31
*/
public interface MessageLogService {

    int deleteByPrimaryKey(int id);

    int insert(MessageLog record);

    int insertSelective(MessageLog record);

    MessageLog selectByPrimaryKey(int id);

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