package com.cen.loopphoto.service;

import com.cen.loopphoto.entity.Loopphoto;

import java.util.List;
import java.util.Map;

/**
 * Created by pc on 2018/10/11.
 */
public interface LoopphotoService {
    int deleteByPrimaryKey(Integer id);

    int insert(Loopphoto record);

    int insertSelective(Loopphoto record);

    Loopphoto selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Loopphoto record);

    int updateByPrimaryKey(Loopphoto record);

    List<Loopphoto> selectList(Map<String ,Object>  pmap);  //列表LoopSelectList

    List<Loopphoto> LoopSelectList(Map<String ,Object>  pmap);  //列表

    int selectListCount(Map<String ,Object> pmap);  //列表数

    List<Loopphoto> selectByType(String type1,int photozise);

    List<Loopphoto> selectByType2(String type);

    Loopphoto selectByNewsTypeAndNewsId(String newsType, Integer newsId);

    int deleteByNewsTypeAndNewsId(String newsType, Integer newsId);
}
