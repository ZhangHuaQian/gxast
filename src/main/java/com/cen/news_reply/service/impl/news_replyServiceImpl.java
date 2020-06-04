package com.cen.news_reply.service.impl;

import com.cen.news_reply.dao.news_replyDao;
import com.cen.news_reply.entity.news_reply;
import com.cen.news_reply.service.news_replyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class news_replyServiceImpl implements news_replyService {
    @Autowired
    private news_replyDao news_replyDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return news_replyDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(news_reply record) {
        return news_replyDao.insert(record);
    }

    @Override
    public int insertSelective(news_reply record) {
        return news_replyDao.insertSelective(record);
    }

    @Override
    public news_reply selectByPrimaryKey(Integer id) {
        return news_replyDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(news_reply record) {
        return news_replyDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(news_reply record) {
        return news_replyDao.updateByPrimaryKey(record);
    }

    @Override
    public List<news_reply> select_replyId(Map<String, Object> map) {
        return news_replyDao.select_replyId(map);
    }
}
