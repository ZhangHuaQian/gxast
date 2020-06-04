package com.cen.ProductCollect.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.ProductCollect.service.ProductCollectService;
import com.cen.ProductCollect.dao.ProductCollectMapper;
import com.cen.ProductCollect.entity.ProductCollect;

/**
* @author cframework
* @version V1.0 2020-01-08
*/
@Service
@Transactional
public class ProductCollectServiceImpl implements ProductCollectService<ProductCollect> {

    @Autowired
    ProductCollectMapper productCollectDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return productCollectDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return productCollectDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(ProductCollect record){
    //    return productCollectDao.insert(record);
    //}

    @Override
    public int insertSelective(ProductCollect record){
        return productCollectDao.insertSelective(record);
    }

    @Override
    public ProductCollect selectByPrimaryKey(int id){
        return productCollectDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ProductCollect record){
        return productCollectDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<ProductCollect> selectList(Map<String, Object> paramMap) {
        return productCollectDao.selectList(paramMap);
    }

    @Override
    public List<ProductCollect> selectListByUid(String uId) {
        return productCollectDao.selectListByUid(uId);
    }

    @Override
    public ProductCollect selectByUidAndPid(String uId, String pId) {
        return productCollectDao.selectByUidAndPid(uId,pId);
    }

}