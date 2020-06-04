package com.cen.XczxContestRecord.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.XczxContestRecord.service.XczxContestRecordService;
import com.cen.XczxContestRecord.dao.XczxContestRecordMapper;
import com.cen.XczxContestRecord.entity.XczxContestRecord;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
@Service
@Transactional
public class XczxContestRecordServiceImpl implements XczxContestRecordService<XczxContestRecord> {

    @Autowired
    XczxContestRecordMapper xczxContestRecordDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return xczxContestRecordDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return xczxContestRecordDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(XczxContestRecord record){
    //    return xczxContestRecordDao.insert(record);
    //}

    @Override
    public int insertSelective(XczxContestRecord record){
        return xczxContestRecordDao.insertSelective(record);
    }

    @Override
    public XczxContestRecord selectByPrimaryKey(int id){
        return xczxContestRecordDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(XczxContestRecord record){
        return xczxContestRecordDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(XczxContestRecord record){
    //    return xczxContestRecordDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<XczxContestRecord> selectList(Map<String, Object> paramMap) {
        return xczxContestRecordDao.selectList(paramMap);
    }

    @Override
    public XczxContestRecord selectByUid(String uId) {
        return xczxContestRecordDao.selectByUid(uId);
    }

}