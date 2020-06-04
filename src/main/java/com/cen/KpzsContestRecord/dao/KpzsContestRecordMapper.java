package com.cen.KpzsContestRecord.dao;

import com.cen.common.BaseDao;
import com.cen.KpzsContestRecord.entity.KpzsContestRecord;
import org.apache.ibatis.annotations.Param;

public interface KpzsContestRecordMapper extends BaseDao<KpzsContestRecord> {

    KpzsContestRecord selectByUid(@Param("uId") String uId);
}