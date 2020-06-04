package com.cen.JtyyForeign.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

import com.cen.JtyyForeign.service.JtyyForeignService;
import com.cen.JtyyForeign.dao.JtyyForeignMapper;
import com.cen.JtyyForeign.entity.JtyyForeign;

/**
* @author cframework
* @version V1.0 2020-05-14
*/
@Service
@Transactional
public class JtyyForeignServiceImpl implements JtyyForeignService<JtyyForeign> {

    @Autowired
    JtyyForeignMapper jtyyForeignDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return jtyyForeignDao.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteLogicByIds(String ids){
        return jtyyForeignDao.deleteLogicByIds(ids);
    }

    //@Override
    //public int insert(JtyyForeign record){
    //    return jtyyForeignDao.insert(record);
    //}

    @Override
    public int insertSelective(JtyyForeign record){
        return jtyyForeignDao.insertSelective(record);
    }

    @Override
    public JtyyForeign selectByPrimaryKey(int id){
        return jtyyForeignDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(JtyyForeign record){
        return jtyyForeignDao.updateByPrimaryKeySelective(record);
    }

    //@Override
    //public int updateByPrimaryKey(JtyyForeign record){
    //    return jtyyForeignDao.updateByPrimaryKey(record);
    //}

    @Override
    public List<JtyyForeign> selectList(Map<String, Object> paramMap) {
        return jtyyForeignDao.selectList(paramMap);
    }

    /**
     * 查询最后一条插入的资讯id
     * @return
     */
    @Override
    public JtyyForeign selectLastInsertId() {
        return jtyyForeignDao.selectLastInsertId();
    }

    /**
     * 通过栏目id 查询资讯
     * @param cIds
     * @param num
     */
    @Override
    public List<JtyyForeign> selectByColumnId(String[] cIds, Integer num) {
        return jtyyForeignDao.selectByColumnId(cIds, num);
    }

    /**
     * 一周排行
     * @return
     */
    @Override
    public List<JtyyForeign> selectRanking() {
        return jtyyForeignDao.selectRanking();
    }

}