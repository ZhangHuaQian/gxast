package com.cen.bbs.topic.service.serviceImpl;

import com.cen.bbs.topic.dao.TopicDao;
import com.cen.bbs.topic.entity.Topic;
import com.cen.bbs.topic.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
@Transactional
public class TopicServiceImpl implements TopicService {


    @Autowired
    TopicDao topicDao;

    @Override
    public int deleteByPrimaryKey(Integer tid) {
        return topicDao.deleteByPrimaryKey(tid);
    }

    @Override
    public int insert(Topic record) {
        return topicDao.insert(record);
    }

    @Override
    public int insertSelective(Topic record) {
        return topicDao.insertSelective(record);
    }

    @Override
    public Topic selectByPrimaryKey(Integer tid) {
        return topicDao.selectByPrimaryKey(tid);
    }

    @Override
    public int updateByPrimaryKeySelective(Topic record) {
        return topicDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(Topic record) {
        return topicDao.updateByPrimaryKeyWithBLOBs(record);
    }

    @Override
    public int updateByPrimaryKey(Topic record) {
        return topicDao.updateByPrimaryKey(record);
    }

    @Override
    public Topic getuserTopic(String userid) {
        return topicDao.getuserTopic(userid);
    }

    @Override
    public List<Topic> selectAlltopicForCheck(Map<String, Object> map) {
        return topicDao.selectAlltopicForCheck(map);
    }

    @Override
    public int countoflimit(Map<String, Object> map) {
        return topicDao.countoflimit(map);
    }

    @Override
    public List<Topic> selectmytopic(Map<String, Object> map) {
        return topicDao.selectmytopic(map);
    }

    @Override
    public int selectListCount(Map<String, Object> pmap) {
        return topicDao.selectListCount(pmap);
    }

    @Override
    public List<Topic> selectList(Map<String, Object> pmap) {
        return topicDao.selectList(pmap);
    }

    @Override
    public List<Objects> selectAlltopic(Map<String, Object> pmap) {
        return topicDao.selectAlltopic(pmap);
    }

    @Override
    public List<Map<String, Object>> selectAlltopic2(Map<String, Object> pmap) {
        return topicDao.selectAlltopic2(pmap);
    }

    @Override
    public int selectAlltopicCount(Map<String, Object> pmap) {
        return topicDao.selectAlltopicCount(pmap);
    }

    @Override
    public List<Topic> selectBycommentnum() {
        return topicDao.selectBycommentnum();
    }

    @Override
    public List<Objects> selectIsTop(Map<String, Object> pmap) {
        return topicDao.selectIsTop(pmap);
    }

    @Override
    public List<Map<String, Object>> selectIsTop2(Map<String, Object> pmap) {
        return topicDao.selectIsTop2(pmap);
    }
}