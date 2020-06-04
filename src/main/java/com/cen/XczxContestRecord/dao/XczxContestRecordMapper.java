package com.cen.XczxContestRecord.dao;

import com.cen.common.BaseDao;
import com.cen.XczxContestRecord.entity.XczxContestRecord;
import org.apache.ibatis.annotations.Param;

public interface XczxContestRecordMapper extends BaseDao<XczxContestRecord> {
    XczxContestRecord selectByUid(@Param("uId") String uId);
}