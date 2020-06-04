package com.cen.NfkjwForeign.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.NfkjwForeign.service.NfkjwForeignService;
import com.cen.NfkjwForeign.dao.NfkjwForeignMapper;
import com.cen.NfkjwForeign.entity.NfkjwForeign;

/**
* @author cframework
* @version V1.0 2020-05-15
*/
@Service
@Transactional
public class NfkjwForeignServiceImpl implements NfkjwForeignService<NfkjwForeign> {

    @Autowired
    NfkjwForeignMapper nfkjwForeignDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return nfkjwForeignDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return nfkjwForeignDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(NfkjwForeign record){
    //    return nfkjwForeignDao.insert(record);
    //}

    @Override
    public int insertSelective(NfkjwForeign record){
        return nfkjwForeignDao.insertSelective(record);
    }

    @Override
    public NfkjwForeign selectByPrimaryKey(int id){
        return nfkjwForeignDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(NfkjwForeign record){
        return nfkjwForeignDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(NfkjwForeign record){
    //    return nfkjwForeignDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<NfkjwForeign> selectList(Map<String, Object> paramMap) {
        return nfkjwForeignDao.selectList(paramMap);
    }

    /**
     * 查询最后一条插入的资讯id
     * @return
     */
    @Override
    public NfkjwForeign selectLastInsertId() {
        return nfkjwForeignDao.selectLastInsertId();
    }

}