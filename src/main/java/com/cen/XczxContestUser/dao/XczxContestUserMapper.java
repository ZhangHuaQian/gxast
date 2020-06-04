package com.cen.XczxContestUser.dao;

import com.cen.common.BaseDao;
import com.cen.XczxContestUser.entity.XczxContestUser;
import org.apache.ibatis.annotations.Param;

public interface XczxContestUserMapper extends BaseDao<XczxContestUser> {

    XczxContestUser selectByOpenid(@Param("openid") String openid);
}