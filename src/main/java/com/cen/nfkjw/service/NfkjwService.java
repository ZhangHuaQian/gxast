package com.cen.nfkjw.service;

import com.cen.nfkjw.entity.Nfkjw;

import java.util.List;
import java.util.Map;



/**
* @author cframework
* @version V1.0 2019-04-03
*/
public interface NfkjwService {

    int deleteByPrimaryKey(int id);

    int insertSelective(Nfkjw record);

    Nfkjw selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(Nfkjw record);

    List<Nfkjw> selectList(Map<String, Object> paramMap);

    int selectListCount(Map<String, Object> pmap);

    int batchInsert();

    Nfkjw selectByNid(int nid);

    List<Nfkjw> findByNid(Map<String,Object> map);
}