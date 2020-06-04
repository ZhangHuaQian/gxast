package com.cen.session.service.serviceImpl;

import com.cen.session.dao.SessionDao;
import com.cen.session.entity.Session;
import com.cen.session.service.SessionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by pc on 2019/1/17.
 */
@Transactional
@Service
public class SessionServiceImpl implements SessionService {
    @Autowired
    SessionDao sessionDao;

    @Override
    public int deleteByPrimaryKey(Integer sid) {
        return sessionDao.deleteByPrimaryKey(sid);
    }

    @Override
    public int insert(Session record) {
        return sessionDao.insert(record);
    }

    @Override
    public int insertSelective(Session record) {
        return sessionDao.insertSelective(record);
    }

    @Override
    public Session selectByPrimaryKey(Integer sid) {
        return sessionDao.selectByPrimaryKey(sid);
    }

    @Override
    public int updateByPrimaryKeySelective(Session record) {
        return sessionDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Session record) {
        return sessionDao.updateByPrimaryKey(record);
    }

    @Override
    public List<Session> selectList(Map<String, Object> pmap) {
        return sessionDao.selectList(pmap);
    }

    @Override
    public int selectListCount(Map<String, Object> pmap) {
        return sessionDao.selectListCount(pmap);
    }

    @Override
    public List<Session> selectAll() {
        return sessionDao.selectAll();
    }
}
