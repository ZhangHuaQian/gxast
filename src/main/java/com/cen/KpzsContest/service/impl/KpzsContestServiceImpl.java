package com.cen.KpzsContest.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.KpzsContest.service.KpzsContestService;
import com.cen.KpzsContest.dao.KpzsContestMapper;
import com.cen.KpzsContest.entity.KpzsContest;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
@Service
@Transactional
public class KpzsContestServiceImpl implements KpzsContestService<KpzsContest> {

    @Autowired
    KpzsContestMapper kpzsContestDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return kpzsContestDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return kpzsContestDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(KpzsContest record){
    //    return kpzsContestDao.insert(record);
    //}

    @Override
    public int insertSelective(KpzsContest record){
        return kpzsContestDao.insertSelective(record);
    }

    @Override
    public KpzsContest selectByPrimaryKey(int id){
        return kpzsContestDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(KpzsContest record){
        return kpzsContestDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(KpzsContest record){
    //    return kpzsContestDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<KpzsContest> selectList(Map<String, Object> paramMap) {
        return kpzsContestDao.selectList(paramMap);
    }

}