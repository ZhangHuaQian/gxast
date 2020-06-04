package com.cen.NfkjXczxContestUser.service;

import java.util.List;
import java.util.Map;

import com.cen.NfkjXczxContestUser.entity.NfkjXczxContestUser;

/**
* @author cframework
* @version V1.0 2020-01-20
*/
public interface NfkjXczxContestUserService<NfkjXczxContestUser> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(NfkjXczxContestUser record);

    int insertSelective(NfkjXczxContestUser record);

    NfkjXczxContestUser selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(NfkjXczxContestUser record);

    //int updateByPrimaryKey(NfkjXczxContestUser record);

    List<NfkjXczxContestUser> selectList(Map<String, Object> paramMap);

    NfkjXczxContestUser selectByOpenid(String openid);

}