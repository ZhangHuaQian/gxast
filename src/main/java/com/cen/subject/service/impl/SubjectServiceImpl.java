package com.cen.subject.service.impl;

import com.cen.subject.dao.SubjectDao;
import com.cen.subject.entity.Subject;
import com.cen.subject.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class SubjectServiceImpl implements SubjectService {
    @Autowired
    SubjectDao subjectDao;
    @Override
    public int insertSelective(Subject record) {
        return subjectDao.insertSelective(record);
    }

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return subjectDao.deleteByPrimaryKey(id);
    }

    @Override
    public Subject selectByPrimaryKey(Integer id) {
        return subjectDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Subject record) {
        return subjectDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<Subject> selectList(Map<String, Object> pmap) {
        return subjectDao.selectList(pmap);
    }

    @Override
    public int selectListCount(Map<String, Object> pmap) {
        return subjectDao.selectListCount(pmap);
    }
}
