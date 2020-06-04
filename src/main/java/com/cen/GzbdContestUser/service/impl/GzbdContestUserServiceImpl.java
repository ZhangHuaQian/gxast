package com.cen.GzbdContestUser.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContestUser.service.GzbdContestUserService;
import com.cen.GzbdContestUser.dao.GzbdContestUserMapper;
import com.cen.GzbdContestUser.entity.GzbdContestUser;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
@Service
@Transactional
public class GzbdContestUserServiceImpl implements GzbdContestUserService<GzbdContestUser> {

    @Autowired
    GzbdContestUserMapper gzbdContestUserDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return gzbdContestUserDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return gzbdContestUserDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(GzbdContestUser record){
    //    return gzbdContestUserDao.insert(record);
    //}

    @Override
    public int insertSelective(GzbdContestUser record){
        return gzbdContestUserDao.insertSelective(record);
    }

    @Override
    public GzbdContestUser selectByPrimaryKey(int id){
        return gzbdContestUserDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(GzbdContestUser record){
        return gzbdContestUserDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(GzbdContestUser record){
    //    return gzbdContestUserDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<GzbdContestUser> selectList(Map<String, Object> paramMap) {
        return gzbdContestUserDao.selectList(paramMap);
    }

    @Override
    public GzbdContestUser selectByOpenid(String openid) {
        return gzbdContestUserDao.selectByOpenid(openid);
    }

    @Override
    public int lockUser(String openid, Integer lock) {
        return gzbdContestUserDao.lockUser(openid,lock);
    }


}