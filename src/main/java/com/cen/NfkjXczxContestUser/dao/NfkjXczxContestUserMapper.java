package com.cen.NfkjXczxContestUser.dao;

import com.cen.common.BaseDao;
import com.cen.NfkjXczxContestUser.entity.NfkjXczxContestUser;
import org.apache.ibatis.annotations.Param;

public interface NfkjXczxContestUserMapper extends BaseDao<NfkjXczxContestUser> {

    NfkjXczxContestUser selectByOpenid(@Param("openid") String openid);
}