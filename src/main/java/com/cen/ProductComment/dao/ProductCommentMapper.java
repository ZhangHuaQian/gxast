package com.cen.ProductComment.dao;

import com.cen.common.BaseDao;
import com.cen.ProductComment.entity.ProductComment;

import java.util.List;

public interface ProductCommentMapper extends BaseDao<ProductComment> {

    ProductComment selectByOrderIdAndUid(ProductComment productComment);
    List<ProductComment> selectBypId(ProductComment productComment);
    int selectCountBypId(ProductComment productComment);
}