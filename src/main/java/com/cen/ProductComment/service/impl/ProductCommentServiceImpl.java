package com.cen.ProductComment.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.ProductComment.service.ProductCommentService;
import com.cen.ProductComment.dao.ProductCommentMapper;
import com.cen.ProductComment.entity.ProductComment;

/**
* @author cframework
* @version V1.0 2020-01-07
*/
@Service
@Transactional
public class ProductCommentServiceImpl implements ProductCommentService<ProductComment> {

    @Autowired
    ProductCommentMapper productCommentDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return productCommentDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return productCommentDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(ProductComment record){
    //    return productCommentDao.insert(record);
    //}

    @Override
    public int insertSelective(ProductComment record){
        return productCommentDao.insertSelective(record);
    }

    @Override
    public ProductComment selectByPrimaryKey(int id){
        return productCommentDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ProductComment record){
        return productCommentDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(ProductComment record){
    //    return productCommentDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<ProductComment> selectList(Map<String, Object> paramMap) {
        return productCommentDao.selectList(paramMap);
    }

    @Override
    public ProductComment selectByOrderIdAndUid(ProductComment productComment) {
        return productCommentDao.selectByOrderIdAndUid(productComment);
    }

    @Override
    public List<ProductComment> selectBypId(ProductComment productComment) {
        return productCommentDao.selectBypId(productComment);
    }

    @Override
    public int selectCountBypId(ProductComment productComment) {
        return productCommentDao.selectCountBypId(productComment);
    }


}