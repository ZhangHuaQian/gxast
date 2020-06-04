package com.cen.ForumGrade.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.ForumGrade.service.ForumGradeService;
import com.cen.ForumGrade.dao.ForumGradeMapper;
import com.cen.ForumGrade.entity.ForumGrade;

/**
* @author cframework
* @version V1.0 2019-12-27
*/
@Service
@Transactional
public class ForumGradeServiceImpl implements ForumGradeService<ForumGrade> {

    @Autowired
    ForumGradeMapper forumGradeDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return forumGradeDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return forumGradeDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(ForumGrade record){
    //    return forumGradeDao.insert(record);
    //}

    @Override
    public int insertSelective(ForumGrade record){
        return forumGradeDao.insertSelective(record);
    }

    @Override
    public ForumGrade selectByPrimaryKey(int id){
        return forumGradeDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ForumGrade record){
        return forumGradeDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(ForumGrade record){
    //    return forumGradeDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<ForumGrade> selectList(Map<String, Object> paramMap) {
        return forumGradeDao.selectList(paramMap);
    }

    @Override
    public ForumGrade selectByScore(Integer score) {
        return forumGradeDao.selectByScore(score);
    }

    @Override
    public ForumGrade selectByForumUserId(String uId) {
        return forumGradeDao.selectByForumUserId(uId);
    }

}