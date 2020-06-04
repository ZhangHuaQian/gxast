package com.cen.newsVerifty.dao;

import com.cen.common.BaseDao;
import com.cen.newsVerifty.entity.NewsVerifty;

import java.util.Map;

public interface NewsVeriftyMapper extends BaseDao<NewsVerifty> {

    int updateVerifyByNid(Map<String,Object> param);
}