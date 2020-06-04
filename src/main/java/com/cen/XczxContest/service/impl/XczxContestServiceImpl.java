package com.cen.XczxContest.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.XczxContest.service.XczxContestService;
import com.cen.XczxContest.dao.XczxContestMapper;
import com.cen.XczxContest.entity.XczxContest;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
@Service
@Transactional
public class XczxContestServiceImpl implements XczxContestService<XczxContest> {

    @Autowired
    XczxContestMapper xczxContestDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return xczxContestDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return xczxContestDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(XczxContest record){
    //    return xczxContestDao.insert(record);
    //}

    @Override
    public int insertSelective(XczxContest record){
        return xczxContestDao.insertSelective(record);
    }

    @Override
    public XczxContest selectByPrimaryKey(int id){
        return xczxContestDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(XczxContest record){
        return xczxContestDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(XczxContest record){
    //    return xczxContestDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<XczxContest> selectList(Map<String, Object> paramMap) {
        return xczxContestDao.selectList(paramMap);
    }

}