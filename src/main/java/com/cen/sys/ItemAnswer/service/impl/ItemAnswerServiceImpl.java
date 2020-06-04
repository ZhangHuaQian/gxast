package com.cen.sys.ItemAnswer.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.sys.ItemAnswer.service.ItemAnswerService;
import com.cen.sys.ItemAnswer.dao.ItemAnswerMapper;
import com.cen.sys.ItemAnswer.entity.ItemAnswer;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
@Service
@Transactional
public class ItemAnswerServiceImpl implements ItemAnswerService<ItemAnswer> {

    @Autowired
    ItemAnswerMapper itemAnswerDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return itemAnswerDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return itemAnswerDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(ItemAnswer record){
    //    return itemAnswerDao.insert(record);
    //}

    @Override
    public int insertSelective(ItemAnswer record){
        return itemAnswerDao.insertSelective(record);
    }

    @Override
    public ItemAnswer selectByPrimaryKey(int id){
        return itemAnswerDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ItemAnswer record){
        return itemAnswerDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(ItemAnswer record){
    //    return itemAnswerDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<ItemAnswer> selectList(Map<String, Object> paramMap) {
        return itemAnswerDao.selectList(paramMap);
    }

    @Override
    public List<ItemAnswer> selectByUid(Integer uId) {
        return itemAnswerDao.selectByUid(uId);
    }

    @Override
    public int insertList(List<ItemAnswer> list) {
        return itemAnswerDao.insertList(list);
    }

}