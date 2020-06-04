package com.cen.StxcContestReconrd.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.StxcContestReconrd.service.StxcContestReconrdService;
import com.cen.StxcContestReconrd.dao.StxcContestReconrdMapper;
import com.cen.StxcContestReconrd.entity.StxcContestReconrd;

/**
* @author cframework
* @version V1.0 2019-12-24
*/
@Service
@Transactional
public class StxcContestReconrdServiceImpl implements StxcContestReconrdService<StxcContestReconrd> {

    @Autowired
    StxcContestReconrdMapper stxcContestReconrdDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return stxcContestReconrdDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return stxcContestReconrdDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(StxcContestReconrd record){
    //    return stxcContestReconrdDao.insert(record);
    //}

    @Override
    public int insertSelective(StxcContestReconrd record){
        return stxcContestReconrdDao.insertSelective(record);
    }

    @Override
    public StxcContestReconrd selectByPrimaryKey(int id){
        return stxcContestReconrdDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(StxcContestReconrd record){
        return stxcContestReconrdDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(StxcContestReconrd record){
    //    return stxcContestReconrdDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<StxcContestReconrd> selectList(Map<String, Object> paramMap) {
        return stxcContestReconrdDao.selectList(paramMap);
    }

    @Override
    public StxcContestReconrd selectByUid(String uId) {
        return stxcContestReconrdDao.selectByUid(uId);
    }

}