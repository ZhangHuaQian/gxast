package com.cen.StxcContestUser.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.StxcContestUser.service.StxcContestUserService;
import com.cen.StxcContestUser.dao.StxcContestUserMapper;
import com.cen.StxcContestUser.entity.StxcContestUser;

/**
* @author cframework
* @version V1.0 2019-12-26
*/
@Service
@Transactional
public class StxcContestUserServiceImpl implements StxcContestUserService<StxcContestUser> {

    @Autowired
    StxcContestUserMapper stxcContestUserDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return stxcContestUserDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return stxcContestUserDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(StxcContestUser record){
    //    return stxcContestUserDao.insert(record);
    //}

    @Override
    public int insertSelective(StxcContestUser record){
        return stxcContestUserDao.insertSelective(record);
    }

    @Override
    public StxcContestUser selectByPrimaryKey(int id){
        return stxcContestUserDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(StxcContestUser record){
        return stxcContestUserDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(StxcContestUser record){
    //    return stxcContestUserDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<StxcContestUser> selectList(Map<String, Object> paramMap) {
        return stxcContestUserDao.selectList(paramMap);
    }

    @Override
    public StxcContestUser selectByOpenid(String openid) {
        return stxcContestUserDao.selectByOpenid(openid);
    }

}