package com.cen.StxcContest.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.StxcContest.service.StxcContestService;
import com.cen.StxcContest.dao.StxcContestMapper;
import com.cen.StxcContest.entity.StxcContest;

/**
* @author cframework
* @version V1.0 2019-12-24
*/
@Service
@Transactional
public class StxcContestServiceImpl implements StxcContestService<StxcContest> {

    @Autowired
    StxcContestMapper stxcContestDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return stxcContestDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return stxcContestDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(StxcContest record){
    //    return stxcContestDao.insert(record);
    //}

    @Override
    public int insertSelective(StxcContest record){
        return stxcContestDao.insertSelective(record);
    }

    @Override
    public StxcContest selectByPrimaryKey(int id){
        return stxcContestDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(StxcContest record){
        return stxcContestDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(StxcContest record){
    //    return stxcContestDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<StxcContest> selectList(Map<String, Object> paramMap) {
        return stxcContestDao.selectList(paramMap);
    }

}