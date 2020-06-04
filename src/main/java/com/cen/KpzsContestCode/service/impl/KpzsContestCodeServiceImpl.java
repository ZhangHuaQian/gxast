package com.cen.KpzsContestCode.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.KpzsContestCode.service.KpzsContestCodeService;
import com.cen.KpzsContestCode.dao.KpzsContestCodeMapper;
import com.cen.KpzsContestCode.entity.KpzsContestCode;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
@Service
@Transactional
public class KpzsContestCodeServiceImpl implements KpzsContestCodeService<KpzsContestCode> {

    @Autowired
    KpzsContestCodeMapper kpzsContestCodeDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return kpzsContestCodeDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return kpzsContestCodeDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(KpzsContestCode record){
    //    return kpzsContestCodeDao.insert(record);
    //}

    @Override
    public int insertSelective(KpzsContestCode record){
        return kpzsContestCodeDao.insertSelective(record);
    }

    @Override
    public KpzsContestCode selectByPrimaryKey(int id){
        return kpzsContestCodeDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(KpzsContestCode record){
        return kpzsContestCodeDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(KpzsContestCode record){
    //    return kpzsContestCodeDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<KpzsContestCode> selectList(Map<String, Object> paramMap) {
        return kpzsContestCodeDao.selectList(paramMap);
    }

    @Override
    public KpzsContestCode selectOneTodayValidCode() {
        return kpzsContestCodeDao.selectOneTodayValidCode();
    }

}