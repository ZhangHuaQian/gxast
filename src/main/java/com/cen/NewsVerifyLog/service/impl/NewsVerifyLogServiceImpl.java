package com.cen.NewsVerifyLog.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.NewsVerifyLog.service.NewsVerifyLogService;
import com.cen.NewsVerifyLog.dao.NewsVerifyLogMapper;
import com.cen.NewsVerifyLog.entity.NewsVerifyLog;

/**
* @author cframework
* @version V1.0 2020-03-17
*/
@Service
@Transactional
public class NewsVerifyLogServiceImpl implements NewsVerifyLogService<NewsVerifyLog> {

    @Autowired
    NewsVerifyLogMapper newsVerifyLogDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return newsVerifyLogDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return newsVerifyLogDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(NewsVerifyLog record){
    //    return newsVerifyLogDao.insert(record);
    //}

    @Override
    public int insertSelective(NewsVerifyLog record){
        return newsVerifyLogDao.insertSelective(record);
    }

    @Override
    public NewsVerifyLog selectByPrimaryKey(int id){
        return newsVerifyLogDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(NewsVerifyLog record){
        return newsVerifyLogDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(NewsVerifyLog record){
    //    return newsVerifyLogDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<NewsVerifyLog> selectList(Map<String, Object> paramMap) {
        return newsVerifyLogDao.selectList(paramMap);
    }

    @Override
    public List<Map<String, Object>> selectVerifyByNid(Integer nId, String nType) {
        return newsVerifyLogDao.selectVerifyByNid(nId,nType);
    }

}