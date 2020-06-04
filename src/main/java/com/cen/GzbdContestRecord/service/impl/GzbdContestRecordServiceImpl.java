package com.cen.GzbdContestRecord.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContestRecord.service.GzbdContestRecordService;
import com.cen.GzbdContestRecord.dao.GzbdContestRecordMapper;
import com.cen.GzbdContestRecord.entity.GzbdContestRecord;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
@Service
@Transactional
public class GzbdContestRecordServiceImpl implements GzbdContestRecordService<GzbdContestRecord> {

    @Autowired
    GzbdContestRecordMapper gzbdContestRecordDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return gzbdContestRecordDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return gzbdContestRecordDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(GzbdContestRecord record){
    //    return gzbdContestRecordDao.insert(record);
    //}

    @Override
    public int insertSelective(GzbdContestRecord record){
        return gzbdContestRecordDao.insertSelective(record);
    }

    @Override
    public GzbdContestRecord selectByPrimaryKey(int id){
        return gzbdContestRecordDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(GzbdContestRecord record){
        return gzbdContestRecordDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(GzbdContestRecord record){
    //    return gzbdContestRecordDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<GzbdContestRecord> selectList(Map<String, Object> paramMap) {
        return gzbdContestRecordDao.selectList(paramMap);
    }

}