package com.cen.SubjectType.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.SubjectType.service.SubjectTypeService;
import com.cen.SubjectType.dao.SubjectTypeMapper;
import com.cen.SubjectType.entity.SubjectType;

/**
* @author cframework
* @version V1.0 2019-12-19
*/
@Service
@Transactional
public class SubjectTypeServiceImpl implements SubjectTypeService<SubjectType> {

    @Autowired
    SubjectTypeMapper subjectTypeDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return subjectTypeDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return subjectTypeDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(SubjectType record){
    //    return subjectTypeDao.insert(record);
    //}

    @Override
    public int insertSelective(SubjectType record){
        return subjectTypeDao.insertSelective(record);
    }

    @Override
    public SubjectType selectByPrimaryKey(int id){
        return subjectTypeDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(SubjectType record){
        return subjectTypeDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(SubjectType record){
    //    return subjectTypeDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<SubjectType> selectList(Map<String, Object> paramMap) {
        return subjectTypeDao.selectList(paramMap);
    }

}