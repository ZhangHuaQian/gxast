package com.cen.NewsVerifyLog.dao;

import com.cen.common.BaseDao;
import com.cen.NewsVerifyLog.entity.NewsVerifyLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface NewsVerifyLogMapper extends BaseDao<NewsVerifyLog> {

    /*
     * 查询新闻的审核状态
     * */
    List<Map<String,Object>> selectVerifyByNid(@Param("nId") Integer nId, @Param("nType")String nType);
}