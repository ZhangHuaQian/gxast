package com.cen.NfkjXczxContestCode.dao;

import com.cen.common.BaseDao;
import com.cen.NfkjXczxContestCode.entity.NfkjXczxContestCode;

public interface NfkjXczxContestCodeMapper extends BaseDao<NfkjXczxContestCode> {

    //获取一条当天可用的兑奖码
    NfkjXczxContestCode selectOneTodayValidCode();
}