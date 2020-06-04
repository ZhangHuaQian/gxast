package com.cen.newsVerifty.service.impl;

import com.cen.newsVerifty.dao.NewsVeriftyMapper;
import com.cen.newsVerifty.entity.NewsVerifty;
import com.cen.newsVerifty.service.NewsVeriftyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
* @author cframework
* @version V1.0 2019-09-09
*/
@Service
@Transactional
public class NewsVeriftyServiceImpl implements NewsVeriftyService<NewsVerifty> {

    @Autowired
    NewsVeriftyMapper newsVeriftyDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return newsVeriftyDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return newsVeriftyDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(newsVerifty record){
    //    return newsVeriftyDao.insert(record);
    //}

    @Override
    public int insertSelective(NewsVerifty record){
        return newsVeriftyDao.insertSelective(record);
    }

    @Override
    public NewsVerifty selectByPrimaryKey(int id){
        return newsVeriftyDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(NewsVerifty record){
        return newsVeriftyDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(newsVerifty record){
    //    return newsVeriftyDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<NewsVerifty> selectList(Map<String, Object> paramMap) {
        return newsVeriftyDao.selectList(paramMap);
    }

    @Override
    public int updateVerifyByNid(Map<String, Object> param) {
        return newsVeriftyDao.updateVerifyByNid(param);
    }

}