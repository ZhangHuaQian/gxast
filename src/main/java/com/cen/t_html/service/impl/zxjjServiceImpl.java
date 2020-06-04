package com.cen.t_html.service.impl;

import com.cen.t_html.dao.ZxjjDao;
import com.cen.t_html.entity.ZXJJ;
import com.cen.t_html.service.ZxjjService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class zxjjServiceImpl implements ZxjjService {
    @Autowired
    ZxjjDao zxjjDao;
    @Override
    public ZXJJ selectByPrimaryKey(Integer id) {
        return zxjjDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ZXJJ record) {
        return zxjjDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<ZXJJ> selectreturn(Map<String, Object> sMap) {
        return zxjjDao.selectreturn(sMap);
    }
}
