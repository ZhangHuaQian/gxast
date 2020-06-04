package com.cen.NfkjXczxContestRecord.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.NfkjXczxContestRecord.service.NfkjXczxContestRecordService;
import com.cen.NfkjXczxContestRecord.dao.NfkjXczxContestRecordMapper;
import com.cen.NfkjXczxContestRecord.entity.NfkjXczxContestRecord;

/**
* @author cframework
* @version V1.0 2020-01-20
*/
@Service
@Transactional
public class NfkjXczxContestRecordServiceImpl implements NfkjXczxContestRecordService<NfkjXczxContestRecord> {

    @Autowired
    NfkjXczxContestRecordMapper nfkjXczxContestRecordDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return nfkjXczxContestRecordDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return nfkjXczxContestRecordDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(NfkjXczxContestRecord record){
    //    return nfkjXczxContestRecordDao.insert(record);
    //}

    @Override
    public int insertSelective(NfkjXczxContestRecord record){
        return nfkjXczxContestRecordDao.insertSelective(record);
    }

    @Override
    public NfkjXczxContestRecord selectByPrimaryKey(int id){
        return nfkjXczxContestRecordDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(NfkjXczxContestRecord record){
        return nfkjXczxContestRecordDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(NfkjXczxContestRecord record){
    //    return nfkjXczxContestRecordDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<NfkjXczxContestRecord> selectList(Map<String, Object> paramMap) {
        return nfkjXczxContestRecordDao.selectList(paramMap);
    }

    @Override
    public NfkjXczxContestRecord selectByUid(String uId) {
        return nfkjXczxContestRecordDao.selectByUid(uId);
    }

}