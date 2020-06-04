package com.cen.GzbdContestResult.dao;

import com.cen.common.BaseDao;
import com.cen.GzbdContestResult.entity.GzbdContestResult;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GzbdContestResultMapper extends BaseDao<GzbdContestResult> {

    GzbdContestResult selectByUid(@Param("uId") String uId);
   List<GzbdContestResult> selectListByUid(@Param("uId") String uId);
}