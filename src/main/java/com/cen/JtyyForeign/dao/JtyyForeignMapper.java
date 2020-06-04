package com.cen.JtyyForeign.dao;

import com.cen.common.BaseDao;
import com.cen.JtyyForeign.entity.JtyyForeign;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface JtyyForeignMapper extends BaseDao<JtyyForeign> {

    /**
     * 查询最后一条插入的资讯id
     * @return
     */
    JtyyForeign selectLastInsertId();

    /**
     * 通过栏目id 查询资讯
     * @param cIds
     * @param num
     */
    List<JtyyForeign> selectByColumnId(@Param("list") String[] cIds, @Param("num")Integer num);

    /**
     * 一周排行
     * @return
     */
    List<JtyyForeign> selectRanking();
}