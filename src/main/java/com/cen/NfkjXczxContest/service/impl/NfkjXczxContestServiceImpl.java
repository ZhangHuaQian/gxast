package com.cen.NfkjXczxContest.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.NfkjXczxContest.service.NfkjXczxContestService;
import com.cen.NfkjXczxContest.dao.NfkjXczxContestMapper;
import com.cen.NfkjXczxContest.entity.NfkjXczxContest;

/**
* @author cframework
* @version V1.0 2020-01-20
*/
@Service
@Transactional
public class NfkjXczxContestServiceImpl implements NfkjXczxContestService<NfkjXczxContest> {

    @Autowired
    NfkjXczxContestMapper nfkjXczxContestDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return nfkjXczxContestDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return nfkjXczxContestDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(NfkjXczxContest record){
    //    return nfkjXczxContestDao.insert(record);
    //}

    @Override
    public int insertSelective(NfkjXczxContest record){
        return nfkjXczxContestDao.insertSelective(record);
    }

    @Override
    public NfkjXczxContest selectByPrimaryKey(int id){
        return nfkjXczxContestDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(NfkjXczxContest record){
        return nfkjXczxContestDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(NfkjXczxContest record){
    //    return nfkjXczxContestDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<NfkjXczxContest> selectList(Map<String, Object> paramMap) {
        return nfkjXczxContestDao.selectList(paramMap);
    }

}