package com.cen.XczxContestUser.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.XczxContestUser.service.XczxContestUserService;
import com.cen.XczxContestUser.dao.XczxContestUserMapper;
import com.cen.XczxContestUser.entity.XczxContestUser;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
@Service
@Transactional
public class XczxContestUserServiceImpl implements XczxContestUserService<XczxContestUser> {

    @Autowired
    XczxContestUserMapper xczxContestUserDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return xczxContestUserDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return xczxContestUserDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(XczxContestUser record){
    //    return xczxContestUserDao.insert(record);
    //}

    @Override
    public int insertSelective(XczxContestUser record){
        return xczxContestUserDao.insertSelective(record);
    }

    @Override
    public XczxContestUser selectByPrimaryKey(int id){
        return xczxContestUserDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(XczxContestUser record){
        return xczxContestUserDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(XczxContestUser record){
    //    return xczxContestUserDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<XczxContestUser> selectList(Map<String, Object> paramMap) {
        return xczxContestUserDao.selectList(paramMap);
    }

    @Override
    public XczxContestUser selectByOpenid(String openid) {
        return xczxContestUserDao.selectByOpenid(openid);
    }

}