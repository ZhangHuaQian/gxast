package com.cen.GzbdContestCode.dao;

import com.cen.common.BaseDao;
import com.cen.GzbdContestCode.entity.GzbdContestCode;

public interface GzbdContestCodeMapper extends BaseDao<GzbdContestCode> {

    //获取一条当天可用的兑奖码
    GzbdContestCode selectOneTodayValidCode();
}