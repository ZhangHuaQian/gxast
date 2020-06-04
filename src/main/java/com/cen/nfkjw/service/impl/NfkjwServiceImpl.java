package com.cen.nfkjw.service.impl;

import com.cen.JDBC.New_news;
import com.cen.common.cache.EHCacheUtil;
import com.cen.nfkjw.dao.NfkjwMapper;
import com.cen.nfkjw.entity.Nfkjw;
import com.cen.nfkjw.service.NfkjwService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
* @author cframework
* @version V1.0 2019-04-03
*/
@Service
@Transactional
public class NfkjwServiceImpl implements NfkjwService {

    @Autowired
    NfkjwMapper nfkjwDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return nfkjwDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insertSelective(Nfkjw record){
        return nfkjwDao.insertSelective(record);
    }

    @Override
    public Nfkjw selectByPrimaryKey(int id){
        return nfkjwDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Nfkjw record){
        return nfkjwDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<Nfkjw> selectList(Map<String, Object> paramMap) {
        return nfkjwDao.selectList(paramMap);
    }

    @Override
    public int selectListCount(Map<String, Object> pmap) {
        return nfkjwDao.selectListCount(pmap);
    }

    @Override
    public int batchInsert() {
        int num=0;
        Map<String, Object> pmap = new HashMap<String, Object>();

        try{
            List<New_news> jrtt =  (List<New_news>) EHCacheUtil.get("cen_crmjl","jrtt");
            List<New_news> hqkb =  (List<New_news>)EHCacheUtil.get("cen_crmjl","hqkb");
            List<New_news> zzyz =  (List<New_news>)EHCacheUtil.get("cen_crmjl","zzyz");
            List<New_news> cfsj =  (List<New_news>)EHCacheUtil.get("cen_crmjl","cfsj");
            List<New_news> gqxx =  (List<New_news>)EHCacheUtil.get("cen_crmjl","gqxx");
            //如果不存在则添加
            if(nfkjwDao.selectListCount(pmap)==0){
                for (int i = 0; i < jrtt.size(); i++) {

                        Nfkjw nfkjw=new Nfkjw();
                        nfkjw.setTitle(jrtt.get(i).getTitle());
                        nfkjw.setDescription(jrtt.get(i).getDescription());
                        nfkjw.setContent(jrtt.get(i).getContent());
                        nfkjw.setNewTypeId(5);
                        nfkjw.setNewsCover(String.valueOf(jrtt.get(i).getCatid()));
                        //编辑者
                        nfkjw.setEditor(jrtt.get(i).getUsername());
                        nfkjw.setUrl(jrtt.get(i).getUrl());
                        nfkjw.setCreateTime(jrtt.get(i).getInputtime());
                        nfkjw.setIsDel(0);
                        nfkjw.setNid(jrtt.get(i).getId());
                        nfkjw.setOrignfrom(jrtt.get(i).getOrignfrom().replaceAll("|0",""));
                        nfkjwDao.insertSelective(nfkjw);

                    }




                    for (int j = 0; j < hqkb.size(); j++) {

                            Nfkjw nfkjw=new Nfkjw();
                            nfkjw.setTitle(hqkb.get(j).getTitle());
                            nfkjw.setDescription(hqkb.get(j).getDescription());
                            nfkjw.setContent(hqkb.get(j).getContent());
                            nfkjw.setNewTypeId(6);
                            nfkjw.setNewsCover(String.valueOf(hqkb.get(j).getCatid()));
                            nfkjw.setEditor(hqkb.get(j).getUsername());
                            nfkjw.setUrl(hqkb.get(j).getUrl());
                            nfkjw.setCreateTime(hqkb.get(j).getInputtime());
                            nfkjw.setIsDel(0);
                            nfkjw.setNid(hqkb.get(j).getId());
                            nfkjw.setOrignfrom(hqkb.get(j).getOrignfrom().replaceAll("|0",""));
                            nfkjwDao.insertSelective(nfkjw);


                    }
                    for (int k = 0; k < zzyz.size(); k++) {

                            Nfkjw nfkjw=new Nfkjw();
                            nfkjw.setTitle(zzyz.get(k).getTitle());
                            nfkjw.setDescription(zzyz.get(k).getDescription());
                            nfkjw.setContent(zzyz.get(k).getContent());
                            nfkjw.setNewTypeId(7);
                            nfkjw.setNewsCover(String.valueOf(zzyz.get(k).getCatid()));
                            nfkjw.setEditor(zzyz.get(k).getUsername());
                            nfkjw.setUrl(zzyz.get(k).getUrl());
                            nfkjw.setCreateTime(zzyz.get(k).getInputtime());
                            nfkjw.setIsDel(0);
                            nfkjw.setNid(zzyz.get(k).getId());
                            nfkjw.setOrignfrom(zzyz.get(k).getOrignfrom().replaceAll("|0",""));
                            nfkjwDao.insertSelective(nfkjw);


                    }
                    for (int l = 0; l < cfsj.size(); l++) {

                            Nfkjw nfkjw=new Nfkjw();
                            nfkjw.setTitle(cfsj.get(l).getTitle());
                            nfkjw.setDescription(cfsj.get(l).getDescription());
                            nfkjw.setContent(cfsj.get(l).getContent());
                            nfkjw.setNewTypeId(8);
                            nfkjw.setNewsCover(String.valueOf(cfsj.get(l).getCatid()));
                            nfkjw.setEditor(cfsj.get(l).getUsername());
                            nfkjw.setUrl(cfsj.get(l).getUrl());
                            nfkjw.setCreateTime(cfsj.get(l).getInputtime());
                            nfkjw.setIsDel(0);
                            nfkjw.setNid(cfsj.get(l).getId());
                        nfkjw.setOrignfrom(cfsj.get(l).getOrignfrom().replaceAll("|0",""));
                            nfkjwDao.insertSelective(nfkjw);


                    }
                    for (int m = 0; m < gqxx.size(); m++) {

                            Nfkjw nfkjw=new Nfkjw();
                            nfkjw.setTitle(gqxx.get(m).getTitle());
                            nfkjw.setDescription(gqxx.get(m).getDescription());
                            nfkjw.setContent(gqxx.get(m).getContent());
                            nfkjw.setNewTypeId(9);
                            nfkjw.setNewsCover(String.valueOf(gqxx.get(m).getCatid()));
                            nfkjw.setEditor(gqxx.get(m).getUsername());
                            nfkjw.setUrl(gqxx.get(m).getUrl());
                            nfkjw.setCreateTime(gqxx.get(m).getInputtime());
                            nfkjw.setIsDel(0);
                            nfkjw.setNid(gqxx.get(m).getId());
                            nfkjw.setOrignfrom(gqxx.get(m).getOrignfrom().replaceAll("|0",""));
                            int res=nfkjwDao.insertSelective(nfkjw);
                            num +=res;


                    }

               }



        }catch (Exception e){
            e.printStackTrace();
        }
        return num;
    }

    @Override
    public Nfkjw selectByNid(int nid) {
        return nfkjwDao.selectByNid(nid);
    }

    @Override
    public List<Nfkjw> findByNid(Map<String, Object> map) {
        return nfkjwDao.findByNid(map);
    }

}