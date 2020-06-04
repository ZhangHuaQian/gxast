package com.cen.NfkjwForeign.dao;

import com.cen.common.BaseDao;
import com.cen.NfkjwForeign.entity.NfkjwForeign;

public interface NfkjwForeignMapper extends BaseDao<NfkjwForeign> {

    /**
     * 查询最后一条插入的资讯id
     * @return
     */
    NfkjwForeign selectLastInsertId();
}