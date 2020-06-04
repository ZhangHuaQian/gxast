package com.cen.feedback.service.impl;

import com.cen.feedback.dao.FeedbackDao;
import com.cen.feedback.entity.Feedback;
import com.cen.feedback.service.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by pc on 2018/10/8.
 */
@Service
@Transactional
public class FeedbackServiceImpl implements FeedbackService {

    @Autowired
    FeedbackDao feedbackDao;


    @Override
    public int deleteByPrimaryKey(Integer id) {
        return feedbackDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Feedback record) {
        return feedbackDao.insert(record);
    }

    @Override
    public int insertSelective(Feedback record) {
        return feedbackDao.insertSelective(record);
    }

    @Override
    public Feedback selectByPrimaryKey(Integer id) {
        return feedbackDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Feedback record) {
        return feedbackDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(Feedback record) {
        return feedbackDao.updateByPrimaryKeyWithBLOBs(record);
    }

    @Override
    public int updateByPrimaryKey(Feedback record) {
        return feedbackDao.updateByPrimaryKey(record);
    }

    @Override
    public List<Feedback> selectList(Map<String, Object> pmap) {
        return feedbackDao.selectList(pmap);
    }

    @Override
    public int selectListCount(Map<String, Object> pmap) {
        return feedbackDao.selectListCount(pmap);
    }
}
