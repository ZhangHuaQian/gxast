package com.cen.XczxContestCode.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.XczxContestCode.service.XczxContestCodeService;
import com.cen.XczxContestCode.dao.XczxContestCodeMapper;
import com.cen.XczxContestCode.entity.XczxContestCode;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
@Service
@Transactional
public class XczxContestCodeServiceImpl implements XczxContestCodeService<XczxContestCode> {

    @Autowired
    XczxContestCodeMapper xczxContetstCodeDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return xczxContetstCodeDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return xczxContetstCodeDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(XczxContestCode record){
    //    return xczxContetstCodeDao.insert(record);
    //}

    @Override
    public int insertSelective(XczxContestCode record){
        return xczxContetstCodeDao.insertSelective(record);
    }

    @Override
    public XczxContestCode selectByPrimaryKey(int id){
        return xczxContetstCodeDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(XczxContestCode record){
        return xczxContetstCodeDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(XczxContestCode record){
    //    return xczxContetstCodeDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<XczxContestCode> selectList(Map<String, Object> paramMap) {
        return xczxContetstCodeDao.selectList(paramMap);
    }

    @Override
    public XczxContestCode selectOneTodayValidCode() {
        return xczxContetstCodeDao.selectOneTodayValidCode();
    }

}