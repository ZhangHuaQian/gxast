package com.cen.address.service;

import com.cen.address.entity.Address;

import java.util.List;
import java.util.Map;

public interface AddressService {
    int deleteByPrimaryKey(String id);

    int insert(Address record);

    int insertSelective(Address record);

    Address selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Address record);

    int updateByPrimaryKey(Address record);

    List<Address> selectList(Map<String, Object> pmap);
    int updateState(String userid);
    Address getuserAddress(String  userid);
}