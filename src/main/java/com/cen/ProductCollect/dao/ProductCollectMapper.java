package com.cen.ProductCollect.dao;

import com.cen.common.BaseDao;
import com.cen.ProductCollect.entity.ProductCollect;
import com.cen.product.entity.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductCollectMapper extends BaseDao<ProductCollect> {

    List<ProductCollect> selectListByUid(@Param("uId") String uId);

    ProductCollect selectByUidAndPid(@Param("uId") String uId, @Param("pId") String pId);
}