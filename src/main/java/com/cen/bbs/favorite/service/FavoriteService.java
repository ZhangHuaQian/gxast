package com.cen.bbs.favorite.service;

import com.cen.bbs.favorite.entity.Favorite;

import java.util.List;

public interface FavoriteService {
    int deleteByPrimaryKey(Integer id);

    int insert(Favorite record);

    int insertSelective(Favorite record);

    Favorite selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Favorite record);

    int updateByPrimaryKey(Favorite record);

    List<Favorite> selectByTid(int tid,String userid);

    List<Favorite> selectByCid(String userid,int tid,int cid);

}