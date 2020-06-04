package com.cen.bbs.favorite.service.FavoriteServiceImpl;

import com.cen.bbs.favorite.dao.FavoriteDao;
import com.cen.bbs.favorite.entity.Favorite;
import com.cen.bbs.favorite.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class FavoriteServiceImpl implements FavoriteService{

    @Autowired
    FavoriteDao favoriteDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return favoriteDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Favorite record) {
        return favoriteDao.insert(record);
    }

    @Override
    public int insertSelective(Favorite record) {
        return favoriteDao.insertSelective(record);
    }

    @Override
    public Favorite selectByPrimaryKey(Integer id) {
        return favoriteDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Favorite record) {
        return favoriteDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Favorite record) {
        return favoriteDao.updateByPrimaryKey(record);
    }

    @Override
    public List<Favorite> selectByTid(int tid, String userid) {
        return favoriteDao.selectByTid(tid,userid);
    }

    @Override
    public List<Favorite> selectByCid(String userid, int tid, int cid) {
        return favoriteDao.selectByCid(userid,tid,cid);
    }
}