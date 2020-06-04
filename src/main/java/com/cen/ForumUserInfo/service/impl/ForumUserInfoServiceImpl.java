package com.cen.ForumUserInfo.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.ForumUserInfo.service.ForumUserInfoService;
import com.cen.ForumUserInfo.dao.ForumUserInfoMapper;
import com.cen.ForumUserInfo.entity.ForumUserInfo;

/**
* @author cframework
* @version V1.0 2019-12-27
*/
@Service
@Transactional
public class ForumUserInfoServiceImpl implements ForumUserInfoService<ForumUserInfo> {

    @Autowired
    ForumUserInfoMapper forumUserInfoDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return forumUserInfoDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return forumUserInfoDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(ForumUserInfo record){
    //    return forumUserInfoDao.insert(record);
    //}

    @Override
    public int insertSelective(ForumUserInfo record){
        return forumUserInfoDao.insertSelective(record);
    }

    @Override
    public ForumUserInfo selectByPrimaryKey(int id){
        return forumUserInfoDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ForumUserInfo record){
        return forumUserInfoDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(ForumUserInfo record){
    //    return forumUserInfoDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<ForumUserInfo> selectList(Map<String, Object> paramMap) {
        return forumUserInfoDao.selectList(paramMap);
    }

    @Override
    public ForumUserInfo selectByUid(String uId) {
        return forumUserInfoDao.selectByUid(uId);
    }

    @Override
    public int updateByUid(ForumUserInfo forumUserInfo) {
        return forumUserInfoDao.updateByUid(forumUserInfo);
    }


}