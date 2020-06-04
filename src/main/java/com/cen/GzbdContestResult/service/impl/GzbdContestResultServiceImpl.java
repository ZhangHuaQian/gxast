package com.cen.GzbdContestResult.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContestResult.service.GzbdContestResultService;
import com.cen.GzbdContestResult.dao.GzbdContestResultMapper;
import com.cen.GzbdContestResult.entity.GzbdContestResult;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
@Service
@Transactional
public class GzbdContestResultServiceImpl implements GzbdContestResultService<GzbdContestResult> {

    @Autowired
    GzbdContestResultMapper gzbdContestResultDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return gzbdContestResultDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return gzbdContestResultDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(GzbdContestResult record){
    //    return gzbdContestResultDao.insert(record);
    //}

    @Override
    public int insertSelective(GzbdContestResult record){
        return gzbdContestResultDao.insertSelective(record);
    }

    @Override
    public GzbdContestResult selectByPrimaryKey(int id){
        return gzbdContestResultDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(GzbdContestResult record){
        return gzbdContestResultDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(GzbdContestResult record){
    //    return gzbdContestResultDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<GzbdContestResult> selectList(Map<String, Object> paramMap) {
        return gzbdContestResultDao.selectList(paramMap);
    }

    @Override
    public GzbdContestResult selectByUid(String uId) {
        return gzbdContestResultDao.selectByUid(uId);
    }

    @Override
    public List<GzbdContestResult> selectListByUid(String uId) {
        return gzbdContestResultDao.selectListByUid(uId);
    }

}