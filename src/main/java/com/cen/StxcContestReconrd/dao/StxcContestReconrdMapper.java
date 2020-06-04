package com.cen.StxcContestReconrd.dao;

import com.cen.common.BaseDao;
import com.cen.StxcContestReconrd.entity.StxcContestReconrd;
import org.apache.ibatis.annotations.Param;

public interface StxcContestReconrdMapper extends BaseDao<StxcContestReconrd> {

    StxcContestReconrd selectByUid(@Param("uId") String uId);
}