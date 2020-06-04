package com.cen.GzbdContestCode.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContestCode.service.GzbdContestCodeService;
import com.cen.GzbdContestCode.dao.GzbdContestCodeMapper;
import com.cen.GzbdContestCode.entity.GzbdContestCode;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
@Service
@Transactional
public class GzbdContestCodeServiceImpl implements GzbdContestCodeService<GzbdContestCode> {

    @Autowired
    GzbdContestCodeMapper gzbdContestCodeDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return gzbdContestCodeDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return gzbdContestCodeDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(GzbdContestCode record){
    //    return gzbdContestCodeDao.insert(record);
    //}

    @Override
    public int insertSelective(GzbdContestCode record){
        return gzbdContestCodeDao.insertSelective(record);
    }

    @Override
    public GzbdContestCode selectByPrimaryKey(int id){
        return gzbdContestCodeDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(GzbdContestCode record){
        return gzbdContestCodeDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(GzbdContestCode record){
    //    return gzbdContestCodeDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<GzbdContestCode> selectList(Map<String, Object> paramMap) {
        return gzbdContestCodeDao.selectList(paramMap);
    }

    @Override
    public GzbdContestCode selectOneTodayValidCode() {
        return gzbdContestCodeDao.selectOneTodayValidCode();
    }

}