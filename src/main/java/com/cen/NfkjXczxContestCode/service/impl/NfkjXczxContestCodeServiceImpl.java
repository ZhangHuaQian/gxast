package com.cen.NfkjXczxContestCode.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.NfkjXczxContestCode.service.NfkjXczxContestCodeService;
import com.cen.NfkjXczxContestCode.dao.NfkjXczxContestCodeMapper;
import com.cen.NfkjXczxContestCode.entity.NfkjXczxContestCode;

/**
* @author cframework
* @version V1.0 2020-01-20
*/
@Service
@Transactional
public class NfkjXczxContestCodeServiceImpl implements NfkjXczxContestCodeService<NfkjXczxContestCode> {

    @Autowired
    NfkjXczxContestCodeMapper nfkjXczxContestCodeDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return nfkjXczxContestCodeDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return nfkjXczxContestCodeDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(NfkjXczxContestCode record){
    //    return nfkjXczxContestCodeDao.insert(record);
    //}

    @Override
    public int insertSelective(NfkjXczxContestCode record){
        return nfkjXczxContestCodeDao.insertSelective(record);
    }

    @Override
    public NfkjXczxContestCode selectByPrimaryKey(int id){
        return nfkjXczxContestCodeDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(NfkjXczxContestCode record){
        return nfkjXczxContestCodeDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(NfkjXczxContestCode record){
    //    return nfkjXczxContestCodeDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<NfkjXczxContestCode> selectList(Map<String, Object> paramMap) {
        return nfkjXczxContestCodeDao.selectList(paramMap);
    }

    @Override
    public NfkjXczxContestCode selectOneTodayValidCode() {
        return nfkjXczxContestCodeDao.selectOneTodayValidCode();
    }

}