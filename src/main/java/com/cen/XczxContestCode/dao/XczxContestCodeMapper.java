package com.cen.XczxContestCode.dao;

import com.cen.XczxContestCode.entity.XczxContestCode;
import com.cen.common.BaseDao;

public interface XczxContestCodeMapper extends BaseDao<XczxContestCode> {

    //获取一条当天可用的兑奖码
    XczxContestCode selectOneTodayValidCode();
}