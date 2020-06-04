package com.cen.KpzsContestRecord.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.KpzsContestRecord.service.KpzsContestRecordService;
import com.cen.KpzsContestRecord.dao.KpzsContestRecordMapper;
import com.cen.KpzsContestRecord.entity.KpzsContestRecord;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
@Service
@Transactional
public class KpzsContestRecordServiceImpl implements KpzsContestRecordService<KpzsContestRecord> {

    @Autowired
    KpzsContestRecordMapper kpzsContestRecordDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return kpzsContestRecordDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return kpzsContestRecordDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(KpzsContestRecord record){
    //    return kpzsContestRecordDao.insert(record);
    //}

    @Override
    public int insertSelective(KpzsContestRecord record){
        return kpzsContestRecordDao.insertSelective(record);
    }

    @Override
    public KpzsContestRecord selectByPrimaryKey(int id){
        return kpzsContestRecordDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(KpzsContestRecord record){
        return kpzsContestRecordDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(KpzsContestRecord record){
    //    return kpzsContestRecordDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<KpzsContestRecord> selectList(Map<String, Object> paramMap) {
        return kpzsContestRecordDao.selectList(paramMap);
    }

    @Override
    public KpzsContestRecord selectByUid(String uId) {
        return kpzsContestRecordDao.selectByUid(uId);
    }

}