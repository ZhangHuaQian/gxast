package com.cen.ForumUserInfo.dao;

import com.cen.common.BaseDao;
import com.cen.ForumUserInfo.entity.ForumUserInfo;
import org.apache.ibatis.annotations.Param;

public interface ForumUserInfoMapper extends BaseDao<ForumUserInfo> {
    ForumUserInfo selectByUid(@Param("uId") String uId);
    int updateByUid(ForumUserInfo forumUserInfo);
}