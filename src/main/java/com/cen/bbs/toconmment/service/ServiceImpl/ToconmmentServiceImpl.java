package com.cen.bbs.toconmment.service.ServiceImpl;

import com.cen.bbs.toconmment.dao.ToconmmentDao;
import com.cen.bbs.toconmment.entity.Toconmment;
import com.cen.bbs.toconmment.service.ToconmmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by pc on 2019/1/25.
 */
@Service
@Transactional
public class ToconmmentServiceImpl implements ToconmmentService {

    @Autowired
    ToconmmentDao  toconmmentDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return toconmmentDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Toconmment record) {
        return toconmmentDao.insert(record);
    }

    @Override
    public int insertSelective(Toconmment record) {
        return toconmmentDao.insertSelective(record);
    }

    @Override
    public Toconmment selectByPrimaryKey(Integer id) {
        return toconmmentDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Toconmment record) {
        return toconmmentDao.updateByPrimaryKeySelective(record);
    }



    @Override
    public int updateByPrimaryKey(Toconmment record) {
        return toconmmentDao.updateByPrimaryKey(record);
    }

    @Override
    public List<Toconmment> selectAllTocomment(Map<String, Object> pmap) {
        return toconmmentDao.selectAllTocomment(pmap);
    }
}
