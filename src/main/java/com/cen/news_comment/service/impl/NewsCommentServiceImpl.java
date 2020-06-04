package com.cen.news_comment.service.impl;


import com.cen.news_comment.dao.NewsCommentDao;
import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class NewsCommentServiceImpl implements NewsCommentService {
    @Autowired
    private NewsCommentDao newsCommentDao;


    @Override
    public int deleteByPrimaryKey(Integer id) {
        return newsCommentDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(NewsComment record) {
        return newsCommentDao.insert(record);
    }

    @Override
    public int insertSelective(NewsComment record) {
        return newsCommentDao.insertSelective(record);
    }

    @Override
    public NewsComment selectByPrimaryKey(Integer id) {
        return newsCommentDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(NewsComment record) {
        return newsCommentDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(NewsComment record) {
        return newsCommentDao.updateByPrimaryKey(record);
    }

    @Override
    public List<NewsComment> selectallcomment(int newsid, int pageIndex, int pageSize) {
        return newsCommentDao.selectallcomment(newsid,pageIndex,pageSize);
    }

    @Override
    public List<NewsComment> selectCommentUserArticle(int newsid, int pageIndex, int pageSize) {
        return newsCommentDao.selectCommentUserArticle(newsid,pageIndex,pageIndex);
    }

    @Override
    public List<NewsComment> commentcount(int newsid) {
        return newsCommentDao.commentcount(newsid);
    }

    @Override
    public List<NewsComment> article_comment(Map<String, Object> paramMap) {
        return newsCommentDao.article_comment(paramMap);
    }

    @Override
    public List<NewsComment> article_comment_two(Map<String, Object> paramMap) {
        return newsCommentDao.article_comment_two(paramMap);
    }

    @Override
    public List<NewsComment> allcomment() {
        return newsCommentDao.allcomment();
    }

    @Override
    public int selectCommentCount(Map<String, Object> map) {
        return newsCommentDao.selectCommentCount(map);
    }

    @Override
    public List<NewsComment> selectList(Map<String, Object> map) {
        return newsCommentDao.selectList(map);
    }

    @Override
    public int selectListCount(Map<String, Object> map) {
        return newsCommentDao.selectListCount(map);
    }

    @Override
    public int deleteAllMcomment(int id) {
        return newsCommentDao.deleteAllMcomment(id);
    }

    @Override
    public List<NewsComment> selectCommentByNid(Map<String, Object> param) {
        return newsCommentDao.selectCommentByNid(param);
    }

}
