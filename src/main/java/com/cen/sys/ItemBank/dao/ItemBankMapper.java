package com.cen.sys.ItemBank.dao;

import com.cen.common.BaseDao;
import com.cen.sys.ItemBank.entity.ItemBank;

import java.util.List;
import java.util.Map;

public interface ItemBankMapper extends BaseDao<ItemBank> {

    List<ItemBank> selectAll(Map<String,Object> param);
}