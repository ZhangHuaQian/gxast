package com.cen.sys.ItemBank.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.sys.ItemBank.service.ItemBankService;
import com.cen.sys.ItemBank.dao.ItemBankMapper;
import com.cen.sys.ItemBank.entity.ItemBank;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
@Service
@Transactional
public class ItemBankServiceImpl implements ItemBankService<ItemBank> {

    @Autowired
    ItemBankMapper itemBankDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return itemBankDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return itemBankDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(ItemBank record){
    //    return itemBankDao.insert(record);
    //}

    @Override
    public int insertSelective(ItemBank record){
        return itemBankDao.insertSelective(record);
    }

    @Override
    public ItemBank selectByPrimaryKey(int id){
        return itemBankDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ItemBank record){
        return itemBankDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(ItemBank record){
    //    return itemBankDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<ItemBank> selectList(Map<String, Object> paramMap) {
        return itemBankDao.selectList(paramMap);
    }

    @Override
    public List<ItemBank> selectAll(Map<String, Object> param) {
        return itemBankDao.selectAll(param);
    }

}