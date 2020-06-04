package com.cen.sys.ItemUser.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.sys.ItemUser.service.ItemUserService;
import com.cen.sys.ItemUser.dao.ItemUserMapper;
import com.cen.sys.ItemUser.entity.ItemUser;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
@Service
@Transactional
public class ItemUserServiceImpl implements ItemUserService<ItemUser> {

    @Autowired
    ItemUserMapper itemUserDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return itemUserDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return itemUserDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(ItemUser record){
    //    return itemUserDao.insert(record);
    //}

    @Override
    public int insertSelective(ItemUser record){
        return itemUserDao.insertSelective(record);
    }

    @Override
    public ItemUser selectByPrimaryKey(int id){
        return itemUserDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ItemUser record){
        return itemUserDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(ItemUser record){
    //    return itemUserDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<ItemUser> selectList(Map<String, Object> paramMap) {
        return itemUserDao.selectList(paramMap);
    }

    @Override
    public ItemUser selectByUnameAndTnameAndTtel(Map<String, Object> param) {
        return itemUserDao.selectByUnameAndTnameAndTtel(param);
    }

}