package com.cen.loopphoto.service.serviceIpml;

import com.cen.loopphoto.dao.LoopphotoDao;
import com.cen.loopphoto.entity.Loopphoto;
import com.cen.loopphoto.service.LoopphotoService;
import com.cen.product.entity.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by pc on 2018/10/11.
 */
@Service
@Transactional
public class LoopphotoServiceImpl implements LoopphotoService {
    @Autowired
    private LoopphotoDao loopphotoDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return loopphotoDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Loopphoto record) {
        return loopphotoDao.insert(record);
    }

    @Override
    public int insertSelective(Loopphoto record) {
        return loopphotoDao.insertSelective(record);
    }

    @Override
    public Loopphoto selectByPrimaryKey(Integer id) {
        return loopphotoDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Loopphoto record) {
        return loopphotoDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Loopphoto record) {
        return loopphotoDao.updateByPrimaryKey(record);
    }

    @Override
    public List<Loopphoto> selectList(Map<String, Object> pmap) {
        return loopphotoDao.selectList(pmap);
    }

    @Override
    public List<Loopphoto> LoopSelectList(Map<String, Object> pmap) {
        return loopphotoDao.loopSelectList(pmap);
    }

    @Override
    public int selectListCount(Map<String, Object> pmap) {
        return loopphotoDao.selectListCount(pmap);
    }

    @Override
    public List<Loopphoto> selectByType(String type, int photozise) {
        return loopphotoDao.selectByType(type,photozise);
    }

    @Override
    public List<Loopphoto> selectByType2(String type) {
        return loopphotoDao.selectByType2(type);
    }

    @Override
    public Loopphoto selectByNewsTypeAndNewsId(String newsType, Integer newsId) {
        return loopphotoDao.selectByNewsTypeAndNewsId(newsType, newsId);
    }

    @Override
    public int deleteByNewsTypeAndNewsId(String newsType, Integer newsId) {
        return loopphotoDao.deleteByNewsTypeAndNewsId(newsType, newsId);
    }
}
