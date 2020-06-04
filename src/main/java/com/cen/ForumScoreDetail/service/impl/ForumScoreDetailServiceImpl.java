package com.cen.ForumScoreDetail.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.ForumScoreDetail.service.ForumScoreDetailService;
import com.cen.ForumScoreDetail.dao.ForumScoreDetailMapper;
import com.cen.ForumScoreDetail.entity.ForumScoreDetail;

/**
* @author cframework
* @version V1.0 2019-12-27
*/
@Service
@Transactional
public class ForumScoreDetailServiceImpl implements ForumScoreDetailService<ForumScoreDetail> {

    @Autowired
    ForumScoreDetailMapper forumScoreDetailDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return forumScoreDetailDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return forumScoreDetailDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(ForumScoreDetail record){
    //    return forumScoreDetailDao.insert(record);
    //}

    @Override
    public int insertSelective(ForumScoreDetail record){
        return forumScoreDetailDao.insertSelective(record);
    }

    @Override
    public ForumScoreDetail selectByPrimaryKey(int id){
        return forumScoreDetailDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ForumScoreDetail record){
        return forumScoreDetailDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(ForumScoreDetail record){
    //    return forumScoreDetailDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<ForumScoreDetail> selectList(Map<String, Object> paramMap) {
        return forumScoreDetailDao.selectList(paramMap);
    }

}