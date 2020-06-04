package com.cen.bbs.report.dao;

import com.cen.bbs.report.entity.Report;

import java.util.List;
import java.util.Map;

public interface ReportDao {
    Report selectByPrimaryKey(Integer id);

    List<Report> selectList(Map<String, Object> map);

    int selectListCount(Map<String, Object> map);

    int deleteByPrimaryKey(Integer id);

    int insertSelective(Report record);

    int updateByPrimaryKeySelective(Report record);

    /*查询待处理的条数*/
    int selectReportCount(Map<String,Object> map);

    int deleteByTid(Integer topicId);

    int deleteByCid(Integer commentId);
}
