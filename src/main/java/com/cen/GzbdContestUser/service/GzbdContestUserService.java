package com.cen.GzbdContestUser.service;

import java.util.List;
import java.util.Map;

import com.cen.GzbdContestUser.entity.GzbdContestUser;

/**
* @author cframework
* @version V1.0 2020-02-03
*/
public interface GzbdContestUserService<GzbdContestUser> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(GzbdContestUser record);

    int insertSelective(GzbdContestUser record);

    GzbdContestUser selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(GzbdContestUser record);

    //int updateByPrimaryKey(GzbdContestUser record);

    List<GzbdContestUser> selectList(Map<String, Object> paramMap);

    GzbdContestUser selectByOpenid(String openid);

    int lockUser(String openid,Integer lock);

}