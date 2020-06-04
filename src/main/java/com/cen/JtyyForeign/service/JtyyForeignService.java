package com.cen.JtyyForeign.service;

import java.util.List;
import java.util.Map;

import com.cen.JtyyForeign.entity.JtyyForeign;

/**
* @author cframework
* @version V1.0 2020-05-14
*/
public interface JtyyForeignService<JtyyForeign> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(JtyyForeign record);

    int insertSelective(JtyyForeign record);

    JtyyForeign selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(JtyyForeign record);

    //int updateByPrimaryKey(JtyyForeign record);

    List<JtyyForeign> selectList(Map<String, Object> paramMap);

    /**
     * 查询最后一条插入的资讯id
     * @return
     */
    com.cen.JtyyForeign.entity.JtyyForeign selectLastInsertId();

    /**
     * 通过栏目id 查询资讯
     * @param cIds
     * @param num
     */
    List<JtyyForeign> selectByColumnId(String[] cIds, Integer num);

    /**
     * 一周排行
     * @return
     */
    List<JtyyForeign> selectRanking();

}