package com.cen.GzbdContestFirewall.service;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContestFirewall.entity.GzbdContestFirewall;

/**
* @author cframework
* @version V1.0 2020-02-06
*/
public interface GzbdContestFirewallService<GzbdContestFirewall> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(GzbdContestFirewall record);

    int insertSelective(GzbdContestFirewall record);

    GzbdContestFirewall selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(GzbdContestFirewall record);

    //int updateByPrimaryKey(GzbdContestFirewall record);

    List<GzbdContestFirewall> selectList(Map<String, Object> paramMap);

    List<GzbdContestFirewall> selectByOpenid(String openid);

}