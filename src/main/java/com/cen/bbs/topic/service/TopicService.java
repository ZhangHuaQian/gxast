package com.cen.bbs.topic.service;

import com.cen.bbs.topic.entity.Topic;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public interface TopicService {
    int deleteByPrimaryKey(Integer tid);

    int insert(Topic record);

    int insertSelective(Topic record);

    Topic selectByPrimaryKey(Integer tid);

    int updateByPrimaryKeySelective(Topic record);

    int updateByPrimaryKeyWithBLOBs(Topic record);

    int updateByPrimaryKey(Topic record);

    Topic getuserTopic(String userid);

    List<Topic> selectAlltopicForCheck(Map<String, Object> map);
    int countoflimit(Map<String, Object> map);

    List<Topic> selectmytopic(Map<String, Object> map);

    int selectListCount(Map<String, Object> pmap);

    List<Topic>  selectList(Map<String, Object> pmap);

    List<Objects> selectAlltopic(Map<String, Object> pmap);

    List<Map<String,Object>> selectAlltopic2(Map<String, Object> pmap);

    int selectAlltopicCount(Map<String, Object> pmap);

    List<Topic> selectBycommentnum();

    List<Objects> selectIsTop(Map<String, Object> pmap);

    List<Map<String,Object>> selectIsTop2(Map<String, Object> pmap);


}