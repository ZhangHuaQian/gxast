package com.cen.loopphoto.dao;

import com.cen.loopphoto.entity.Loopphoto;
import com.cen.product.entity.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface LoopphotoDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Loopphoto record);

    int insertSelective(Loopphoto record);

    Loopphoto selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Loopphoto record);

    int updateByPrimaryKey(Loopphoto record);

    List<Loopphoto> selectList(Map<String ,Object> pmap);  //列表LoopSelectList
    List<Loopphoto> loopSelectList(Map<String ,Object> pmap);//根据类型查询图片列表
    int selectListCount(Map<String ,Object> pmap);  //列表数

    List<Loopphoto> selectByType(@Param("type") String type, @Param("photozise")int photozise);

    List<Loopphoto> selectByType2(@Param("type") String type);

    Loopphoto selectByNewsTypeAndNewsId(@Param("newsType") String newsType, @Param("newsId") Integer newsId);

    int deleteByNewsTypeAndNewsId(@Param("newsType") String newsType, @Param("newsId") Integer newsId);

}