package com.cen.GzbdContestFirewall.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContestFirewall.service.GzbdContestFirewallService;
import com.cen.GzbdContestFirewall.dao.GzbdContestFirewallMapper;
import com.cen.GzbdContestFirewall.entity.GzbdContestFirewall;

/**
* @author cframework
* @version V1.0 2020-02-06
*/
@Service
@Transactional
public class GzbdContestFirewallServiceImpl implements GzbdContestFirewallService<GzbdContestFirewall> {

    @Autowired
    GzbdContestFirewallMapper gzbdContestFirewallDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return gzbdContestFirewallDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return gzbdContestFirewallDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(GzbdContestFirewall record){
    //    return gzbdContestFirewallDao.insert(record);
    //}

    @Override
    public int insertSelective(GzbdContestFirewall record){
        return gzbdContestFirewallDao.insertSelective(record);
    }

    @Override
    public GzbdContestFirewall selectByPrimaryKey(int id){
        return gzbdContestFirewallDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(GzbdContestFirewall record){
        return gzbdContestFirewallDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(GzbdContestFirewall record){
    //    return gzbdContestFirewallDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<GzbdContestFirewall> selectList(Map<String, Object> paramMap) {
        return gzbdContestFirewallDao.selectList(paramMap);
    }

    @Override
    public List<GzbdContestFirewall> selectByOpenid(String openid) {
        return gzbdContestFirewallDao.selectByOpenid(openid);
    }

}