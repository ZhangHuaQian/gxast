package com.cen.sys.ItemType.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.sys.ItemType.service.ItemTypeService;
import com.cen.sys.ItemType.dao.ItemTypeMapper;
import com.cen.sys.ItemType.entity.ItemType;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
@Service
@Transactional
public class ItemTypeServiceImpl implements ItemTypeService<ItemType> {

    @Autowired
    ItemTypeMapper itemTypeDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return itemTypeDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return itemTypeDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(ItemType record){
    //    return itemTypeDao.insert(record);
    //}

    @Override
    public int insertSelective(ItemType record){
        return itemTypeDao.insertSelective(record);
    }

    @Override
    public ItemType selectByPrimaryKey(int id){
        return itemTypeDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ItemType record){
        return itemTypeDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(ItemType record){
    //    return itemTypeDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<ItemType> selectList(Map<String, Object> paramMap) {
        return itemTypeDao.selectList(paramMap);
    }

}