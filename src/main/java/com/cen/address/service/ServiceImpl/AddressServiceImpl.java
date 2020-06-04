package com.cen.address.service.ServiceImpl;

import com.cen.address.dao.AddressDao;
import com.cen.address.entity.Address;
import com.cen.address.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class AddressServiceImpl implements AddressService {
    @Autowired
    AddressDao addressDao;

    @Override
    public int deleteByPrimaryKey(String id) {
        return addressDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Address record) {
        return addressDao.insert(record);
    }

    @Override
    public int insertSelective(Address record) {
        return addressDao.insertSelective(record);
    }

    @Override
    public Address selectByPrimaryKey(String id) {
        return addressDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Address record) {
        return addressDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Address record) {
        return addressDao.updateByPrimaryKey(record);
    }

    @Override
    public List<Address> selectList(Map<String, Object> pmap) {
        return addressDao.selectList(pmap);
    }

    @Override
    public int updateState(String userid) {
        return addressDao.updateState(userid);
    }

    @Override
    public Address getuserAddress(String userid) {
        return addressDao.getuserAddress(userid);
    }
}