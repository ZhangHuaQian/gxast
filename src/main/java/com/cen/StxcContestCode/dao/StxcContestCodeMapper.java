package com.cen.StxcContestCode.dao;

import com.cen.common.BaseDao;
import com.cen.StxcContestCode.entity.StxcContestCode;

public interface StxcContestCodeMapper extends BaseDao<StxcContestCode> {

    //获取一条当天可用的兑奖码
    StxcContestCode selectOneTodayValidCode();
}