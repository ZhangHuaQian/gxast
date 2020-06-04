package com.cen.KpzsContestUser.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.KpzsContestUser.service.KpzsContestUserService;
import com.cen.KpzsContestUser.dao.KpzsContestUserMapper;
import com.cen.KpzsContestUser.entity.KpzsContestUser;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
@Service
@Transactional
public class KpzsContestUserServiceImpl implements KpzsContestUserService<KpzsContestUser> {

    @Autowired
    KpzsContestUserMapper kpzsContestUserDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return kpzsContestUserDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return kpzsContestUserDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(KpzsContestUser record){
    //    return kpzsContestUserDao.insert(record);
    //}

    @Override
    public int insertSelective(KpzsContestUser record){
        return kpzsContestUserDao.insertSelective(record);
    }

    @Override
    public KpzsContestUser selectByPrimaryKey(int id){
        return kpzsContestUserDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(KpzsContestUser record){
        return kpzsContestUserDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(KpzsContestUser record){
    //    return kpzsContestUserDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<KpzsContestUser> selectList(Map<String, Object> paramMap) {
        return kpzsContestUserDao.selectList(paramMap);
    }

    @Override
    public KpzsContestUser selectByOpenid(String openid) {
        return kpzsContestUserDao.selectByOpenid(openid);
    }

}