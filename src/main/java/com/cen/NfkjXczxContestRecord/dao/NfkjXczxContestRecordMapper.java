package com.cen.NfkjXczxContestRecord.dao;

import com.cen.common.BaseDao;
import com.cen.NfkjXczxContestRecord.entity.NfkjXczxContestRecord;
import org.apache.ibatis.annotations.Param;

public interface NfkjXczxContestRecordMapper extends BaseDao<NfkjXczxContestRecord> {

    NfkjXczxContestRecord selectByUid(@Param("uId") String uId);
}