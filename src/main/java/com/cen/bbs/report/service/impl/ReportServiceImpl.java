package com.cen.bbs.report.service.impl;


import com.cen.bbs.report.dao.ReportDao;
import com.cen.bbs.report.entity.Report;
import com.cen.bbs.report.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;


/**
* @author cframework
* @version V1.0 2019-03-26
*/
@Service
@Transactional
public class ReportServiceImpl implements ReportService {
    @Autowired
    private ReportDao reportDao;


    @Override
    public Report selectByPrimaryKey(Integer id) {
        return reportDao.selectByPrimaryKey(id);
    }

    @Override
    public List<Report> selectList(Map<String, Object> map) {
        return reportDao.selectList(map);
    }

    @Override
    public int selectListCount(Map<String, Object> map) {
        return reportDao.selectListCount(map);
    }

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return reportDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insertSelective(Report record) {
        return reportDao.insertSelective(record);
    }

    @Override
    public int updateByPrimaryKeySelective(Report record) {
        return reportDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int selectReportCount(Map<String,Object> map) {
        return reportDao.selectReportCount(map);
    }

    @Override
    public int deleteByTid(Integer topicId) {
        return reportDao.deleteByTid(topicId);
    }

    @Override
    public int deleteByCid(Integer commentId) {
        return reportDao.deleteByCid(commentId);
    }

}