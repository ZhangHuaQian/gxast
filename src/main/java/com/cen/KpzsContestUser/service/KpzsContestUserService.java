package com.cen.KpzsContestUser.service;

import java.util.List;
import java.util.Map;

import com.cen.KpzsContestUser.entity.KpzsContestUser;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
public interface KpzsContestUserService<KpzsContestUser> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(KpzsContestUser record);

    int insertSelective(KpzsContestUser record);

    KpzsContestUser selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(KpzsContestUser record);

    //int updateByPrimaryKey(KpzsContestUser record);

    List<KpzsContestUser> selectList(Map<String, Object> paramMap);

    KpzsContestUser selectByOpenid(String openid);

}