package com.cen.GzbdContestFirewall.dao;

import com.cen.common.BaseDao;
import com.cen.GzbdContestFirewall.entity.GzbdContestFirewall;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GzbdContestFirewallMapper extends BaseDao<GzbdContestFirewall> {

    List<GzbdContestFirewall> selectByOpenid(@Param("openid") String openid);
}