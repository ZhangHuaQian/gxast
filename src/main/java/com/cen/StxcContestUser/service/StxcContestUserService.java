package com.cen.StxcContestUser.service;

import java.util.List;
import java.util.Map;

import com.cen.StxcContestUser.entity.StxcContestUser;

/**
* @author cframework
* @version V1.0 2019-12-26
*/
public interface StxcContestUserService<StxcContestUser> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(StxcContestUser record);

    int insertSelective(StxcContestUser record);

    StxcContestUser selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(StxcContestUser record);

    //int updateByPrimaryKey(StxcContestUser record);

    List<StxcContestUser> selectList(Map<String, Object> paramMap);

    StxcContestUser selectByOpenid(String openid);

}