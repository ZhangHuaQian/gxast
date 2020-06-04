package com.cen.order.service;

import java.util.List;
import java.util.Map;

import com.cen.order.entity.order;

public interface orderService {
	int deleteByPrimaryKey(String id);

    int insert(order record);

    int insertSelective(order record);

    order selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(order record);

    int updateByPrimaryKey(order record);

	order selectByPid(String productId, String id);

	List<order> selectList(Map<String, Object> pmap);

    /**
     * 通过商户订单号查询订单
     * @param outTradeNo
     * @return
     */
    order selectByOutTradeNo(String outTradeNo);
}
