package com.cen.GzbdContestUser.dao;

import com.cen.common.BaseDao;
import com.cen.GzbdContestUser.entity.GzbdContestUser;
import org.apache.ibatis.annotations.Param;

public interface GzbdContestUserMapper extends BaseDao<GzbdContestUser> {

    GzbdContestUser selectByOpenid(@Param("openid") String openid);

    int lockUser(@Param("openid") String openid,@Param("lock") Integer lock);
}