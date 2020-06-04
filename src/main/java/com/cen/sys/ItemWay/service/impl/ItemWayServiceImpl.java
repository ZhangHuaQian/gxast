package com.cen.sys.ItemWay.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.sys.ItemWay.service.ItemWayService;
import com.cen.sys.ItemWay.dao.ItemWayMapper;
import com.cen.sys.ItemWay.entity.ItemWay;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
@Service
@Transactional
public class ItemWayServiceImpl implements ItemWayService<ItemWay> {

    @Autowired
    ItemWayMapper itemWayDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return itemWayDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return itemWayDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(ItemWay record){
    //    return itemWayDao.insert(record);
    //}

    @Override
    public int insertSelective(ItemWay record){
        return itemWayDao.insertSelective(record);
    }

    @Override
    public ItemWay selectByPrimaryKey(int id){
        return itemWayDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ItemWay record){
        return itemWayDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(ItemWay record){
    //    return itemWayDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<ItemWay> selectList(Map<String, Object> paramMap) {
        return itemWayDao.selectList(paramMap);
    }

}