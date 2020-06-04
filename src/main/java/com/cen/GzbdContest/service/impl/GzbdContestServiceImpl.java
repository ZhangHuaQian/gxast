package com.cen.GzbdContest.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContest.service.GzbdContestService;
import com.cen.GzbdContest.dao.GzbdContestMapper;
import com.cen.GzbdContest.entity.GzbdContest;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
@Service
@Transactional
public class GzbdContestServiceImpl implements GzbdContestService<GzbdContest> {

    @Autowired
    GzbdContestMapper gzbdContestDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return gzbdContestDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return gzbdContestDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(GzbdContest record){
    //    return gzbdContestDao.insert(record);
    //}

    @Override
    public int insertSelective(GzbdContest record){
        return gzbdContestDao.insertSelective(record);
    }

    @Override
    public GzbdContest selectByPrimaryKey(int id){
        return gzbdContestDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(GzbdContest record){
        return gzbdContestDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(GzbdContest record){
    //    return gzbdContestDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<GzbdContest> selectList(Map<String, Object> paramMap) {
        return gzbdContestDao.selectList(paramMap);
    }

}