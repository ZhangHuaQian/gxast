package com.cen.ForumUserInfo.service;

import java.util.List;
import java.util.Map;

import com.cen.ForumUserInfo.entity.ForumUserInfo;

/**
* @author cframework
* @version V1.0 2019-12-27
*/
public interface ForumUserInfoService<ForumUserInfo> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(ForumUserInfo record);

    int insertSelective(ForumUserInfo record);

    ForumUserInfo selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(ForumUserInfo record);

    //int updateByPrimaryKey(ForumUserInfo record);

    List<ForumUserInfo> selectList(Map<String, Object> paramMap);

    ForumUserInfo selectByUid(String uId);

    int updateByUid(ForumUserInfo forumUserInfo);

}