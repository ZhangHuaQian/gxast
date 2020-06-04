package com.cen.ProductComment.service;

import java.util.List;
import java.util.Map;

import com.cen.ProductComment.entity.ProductComment;

/**
* @author cframework
* @version V1.0 2020-01-07
*/
public interface ProductCommentService<ProductComment> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(ProductComment record);

    int insertSelective(ProductComment record);

    ProductComment selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(ProductComment record);

    //int updateByPrimaryKey(ProductComment record);

    List<ProductComment> selectList(Map<String, Object> paramMap);

    ProductComment selectByOrderIdAndUid(ProductComment productComment);

    List<ProductComment> selectBypId(ProductComment productComment);

    int selectCountBypId(ProductComment productComment);

}