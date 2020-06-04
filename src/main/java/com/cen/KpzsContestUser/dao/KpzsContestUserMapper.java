package com.cen.KpzsContestUser.dao;

import com.cen.common.BaseDao;
import com.cen.KpzsContestUser.entity.KpzsContestUser;
import org.apache.ibatis.annotations.Param;

public interface KpzsContestUserMapper extends BaseDao<KpzsContestUser> {

    KpzsContestUser selectByOpenid(@Param("openid") String openid);
}