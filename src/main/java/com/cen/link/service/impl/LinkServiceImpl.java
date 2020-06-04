package com.cen.link.service.impl;

import com.cen.link.dao.LinkDao;
import com.cen.link.entity.Link;
import com.cen.link.service.LinkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class LinkServiceImpl implements LinkService {
    @Autowired
    LinkDao linkDao;
    @Override
    public Link selectByPrimaryKey(Integer id) {
        return linkDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Link record) {
        return linkDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<Link> selectList(Map<String, Object> pMap) {
        return linkDao.selectList(pMap);
    }

    @Override
    public int selectListCount(Map<String, Object> pmap) {
        return linkDao.selectListCount(pmap);
    }

    @Override
    public int insertSelective(Link record) {
        return linkDao.insertSelective(record);
    }

    @Override
    public int deleteByPrimaryKey(int id) {
        return linkDao.deleteByPrimaryKey(id);
    }

    @Override
    public List<Link> selectreturn(Map<String, Object> sMap) {
        return linkDao.selectreturn(sMap);
    }


}
