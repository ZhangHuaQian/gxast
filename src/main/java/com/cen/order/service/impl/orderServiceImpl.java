package com.cen.order.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.order.dao.orderMapper;
import com.cen.order.entity.order;
import com.cen.order.service.orderService;

@Service
@Transactional
public class orderServiceImpl implements orderService{

	@Autowired
	orderMapper orderMapper;

	@Override
	public int deleteByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return orderMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(order record) {
		// TODO Auto-generated method stub
		return orderMapper.insert(record);
	}

	@Override
	public int insertSelective(order record) {
		// TODO Auto-generated method stub
		return orderMapper.insertSelective(record);
	}

	@Override
	public order selectByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return orderMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(order record) {
		// TODO Auto-generated method stub
		return orderMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(order record) {
		// TODO Auto-generated method stub
		return orderMapper.updateByPrimaryKey(record);
	}

	@Override
	public order selectByPid(String productId, String id) {
		// TODO Auto-generated method stub
		return orderMapper.selectByPid(productId,id);
	}

	@Override
	public List<order> selectList(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return orderMapper.selectList(pmap);
	}

	/**
	 * 通过商户订单号查询订单
	 * @param outTradeNo
	 * @return
	 */
	@Override
	public order selectByOutTradeNo(String outTradeNo) {
		return orderMapper.selectByOutTradeNo(outTradeNo);
	}

}
