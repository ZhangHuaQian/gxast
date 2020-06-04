package com.cen.NfkjXczxContestUser.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.NfkjXczxContestUser.service.NfkjXczxContestUserService;
import com.cen.NfkjXczxContestUser.dao.NfkjXczxContestUserMapper;
import com.cen.NfkjXczxContestUser.entity.NfkjXczxContestUser;

/**
* @author cframework
* @version V1.0 2020-01-20
*/
@Service
@Transactional
public class NfkjXczxContestUserServiceImpl implements NfkjXczxContestUserService<NfkjXczxContestUser> {

    @Autowired
    NfkjXczxContestUserMapper nfkjXczxContestUserDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return nfkjXczxContestUserDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return nfkjXczxContestUserDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(NfkjXczxContestUser record){
    //    return nfkjXczxContestUserDao.insert(record);
    //}

    @Override
    public int insertSelective(NfkjXczxContestUser record){
        return nfkjXczxContestUserDao.insertSelective(record);
    }

    @Override
    public NfkjXczxContestUser selectByPrimaryKey(int id){
        return nfkjXczxContestUserDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(NfkjXczxContestUser record){
        return nfkjXczxContestUserDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(NfkjXczxContestUser record){
    //    return nfkjXczxContestUserDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<NfkjXczxContestUser> selectList(Map<String, Object> paramMap) {
        return nfkjXczxContestUserDao.selectList(paramMap);
    }

    @Override
    public NfkjXczxContestUser selectByOpenid(String openid) {
        return nfkjXczxContestUserDao.selectByOpenid(openid);
    }

}