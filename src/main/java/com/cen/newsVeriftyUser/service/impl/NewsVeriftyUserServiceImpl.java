package com.cen.newsVeriftyUser.service.impl;

import com.cen.newsVeriftyUser.dao.NewsVeriftyUserMapper;
import com.cen.newsVeriftyUser.entity.NewsVeriftyUser;
import com.cen.newsVeriftyUser.service.NewsVeriftyUserService;
import com.cen.news_comment.entity.NewsComment;
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
public class NewsVeriftyUserServiceImpl implements NewsVeriftyUserService<NewsVeriftyUser> {

    @Autowired
    NewsVeriftyUserMapper newsVeriftyUserDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return newsVeriftyUserDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return newsVeriftyUserDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(newsVeriftyUser record){
    //    return newsVeriftyUserDao.insert(record);
    //}

    @Override
    public int insertSelective(NewsVeriftyUser record){
        return newsVeriftyUserDao.insertSelective(record);
    }

    @Override
    public NewsVeriftyUser selectByPrimaryKey(String uuid){
        return newsVeriftyUserDao.selectByPrimaryKey(uuid);
    }

    @Override
    public int updateByPrimaryKeySelective(NewsVeriftyUser record){
        return newsVeriftyUserDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(newsVeriftyUser record){
    //    return newsVeriftyUserDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<NewsVeriftyUser> selectList(Map<String, Object> paramMap) {
        return newsVeriftyUserDao.selectList(paramMap);
    }

    /**
     * 获取我可以审批的
     *
     * @param paramMap
     * @return
     */
    @Override
    public List<NewsVeriftyUser> selectCanVeriftyList(Map<String, Object> paramMap) {
        return newsVeriftyUserDao.selectCanVeriftyList(paramMap);
    }

    @Override
    public List<NewsVeriftyUser> selectByNid(Map<String, Object> paramMap) {
        return newsVeriftyUserDao.selectByNid(paramMap);
    }

}