package com.cen.StxcContestCode.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.StxcContestCode.service.StxcContestCodeService;
import com.cen.StxcContestCode.dao.StxcContestCodeMapper;
import com.cen.StxcContestCode.entity.StxcContestCode;

/**
* @author cframework
* @version V1.0 2019-12-24
*/
@Service
@Transactional
public class StxcContestCodeServiceImpl implements StxcContestCodeService<StxcContestCode> {

    @Autowired
    StxcContestCodeMapper stxcContestCodeDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return stxcContestCodeDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return stxcContestCodeDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(StxcContestCode record){
    //    return stxcContestCodeDao.insert(record);
    //}

    @Override
    public int insertSelective(StxcContestCode record){
        return stxcContestCodeDao.insertSelective(record);
    }

    @Override
    public StxcContestCode selectByPrimaryKey(int id){
        return stxcContestCodeDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(StxcContestCode record){
        return stxcContestCodeDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(StxcContestCode record){
    //    return stxcContestCodeDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<StxcContestCode> selectList(Map<String, Object> paramMap) {
        return stxcContestCodeDao.selectList(paramMap);
    }

    @Override
    public StxcContestCode selectOneTodayValidCode() {
        return stxcContestCodeDao.selectOneTodayValidCode();
    }

}