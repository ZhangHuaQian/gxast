package com.cen.StxcContestUser.dao;

import com.cen.common.BaseDao;
import com.cen.StxcContestUser.entity.StxcContestUser;
import org.apache.ibatis.annotations.Param;

public interface StxcContestUserMapper extends BaseDao<StxcContestUser> {

    StxcContestUser selectByOpenid(@Param("openid") String openid);
}