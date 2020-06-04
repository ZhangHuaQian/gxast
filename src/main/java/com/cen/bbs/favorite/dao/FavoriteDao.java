package com.cen.bbs.favorite.dao;

import com.cen.bbs.favorite.entity.Favorite;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FavoriteDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Favorite record);

    int insertSelective(Favorite record);

    Favorite selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Favorite record);

    int updateByPrimaryKey(Favorite record);

    List<Favorite> selectByTid(@Param("tid") int tid, @Param("userid") String userid);

    List<Favorite> selectByCid(@Param("userid")String userid,@Param("tid") int tid,@Param("cid") int cid);
}