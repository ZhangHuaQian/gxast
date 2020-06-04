package com.cen.XczxContestUser.service;

import java.util.List;
import java.util.Map;

import com.cen.XczxContestUser.entity.XczxContestUser;

/**
* @author cframework
* @version V1.0 2020-01-19
*/
public interface XczxContestUserService<XczxContestUser> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(XczxContestUser record);

    int insertSelective(XczxContestUser record);

    XczxContestUser selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(XczxContestUser record);

    //int updateByPrimaryKey(XczxContestUser record);

    List<XczxContestUser> selectList(Map<String, Object> paramMap);

    XczxContestUser selectByOpenid(String openid);

}