package com.cen.KpzsContestCode.dao;

import com.cen.common.BaseDao;
import com.cen.KpzsContestCode.entity.KpzsContestCode;

public interface KpzsContestCodeMapper extends BaseDao<KpzsContestCode> {

    //获取一条当天可用的兑奖码
    KpzsContestCode selectOneTodayValidCode();
}