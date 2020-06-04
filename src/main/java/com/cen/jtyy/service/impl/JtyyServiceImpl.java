package com.cen.jtyy.service.impl;

import com.cen.JDBC.New_jtyy;
import com.cen.common.cache.EHCacheUtil;
import com.cen.jtyy.dao.JtyyMapper;
import com.cen.jtyy.entity.Jtyy;
import com.cen.jtyy.service.JtyyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



/**
* @author cframework
* @version V1.0 2019-04-03
*/
@Service
@Transactional
public class JtyyServiceImpl implements JtyyService {

    @Autowired
    JtyyMapper jtyyDao;

    @Override
    public int deleteByPrimaryKey(int id){
        return jtyyDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insertSelective(Jtyy record){
        return jtyyDao.insertSelective(record);
    }

    @Override
    public Jtyy selectByPrimaryKey(Integer id){
        return jtyyDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Jtyy record){
        return jtyyDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<Jtyy> selectList(Map<String, Object> paramMap) {
        return jtyyDao.selectList(paramMap);
    }

    @Override
    public int selectListCount(Map<String, Object> pmap) {
        return jtyyDao.selectListCount(pmap);
    }

    @Override
    public int batchInsert() {
        int num=0;
        Map<String, Object> pmap = new HashMap<String, Object>();

        try{
            List<New_jtyy> jkys =  (List<New_jtyy>) EHCacheUtil.get("cen_crmjl","jkys");
            List<New_jtyy> zjpy =  (List<New_jtyy>)EHCacheUtil.get("cen_crmjl","zjpy");
            List<New_jtyy> mytb =  (List<New_jtyy>)EHCacheUtil.get("cen_crmjl","mytb");
            List<New_jtyy> zcytk =  (List<New_jtyy>)EHCacheUtil.get("cen_crmjl","zcytk");
            //如果不存在则添加
            if(jtyyDao.selectListCount(pmap)==0){
                for(int i=0;i<jkys.size();i++){
                    Jtyy jtyy=new Jtyy();
                    jtyy.setTitle(jkys.get(i).getTitle());
                    jtyy.setAuthor(jkys.get(i).getUsername());
                    jtyy.setCreateTime(jkys.get(i).getCreate_time());
                    jtyy.setIsDel(0);
                    jtyy.setNewTypeId(10);
                    jtyy.setUrl("http://www.jtyy.com/shiwenxinzhi/"+jkys.get(i).getCid()+".html");
                    jtyy.setDescription(jkys.get(i).getZhaiyao());
                    jtyy.setContent(jkys.get(i).getContent());
                    jtyyDao.insertSelective(jtyy);

                }
                for(int j=0;j<zjpy.size();j++){
                    Jtyy jtyy=new Jtyy();
                    jtyy.setTitle(zjpy.get(j).getTitle());
                    jtyy.setAuthor(zjpy.get(j).getUsername());
                    jtyy.setCreateTime(zjpy.get(j).getCreate_time());
                    jtyy.setIsDel(0);
                    jtyy.setNewTypeId(11);
                    jtyy.setUrl("http://www.jtyy.com/shiwenxinzhi/"+zjpy.get(j).getCid()+".html");
                    jtyy.setDescription(zjpy.get(j).getZhaiyao());
                    jtyy.setContent(zjpy.get(j).getContent());
                    jtyyDao.insertSelective(jtyy);
                }
                for(int k=0;k<mytb.size();k++){
                    Jtyy jtyy=new Jtyy();
                    jtyy.setTitle(mytb.get(k).getTitle());
                    jtyy.setAuthor(mytb.get(k).getUsername());
                    jtyy.setCreateTime(mytb.get(k).getCreate_time());
                    jtyy.setIsDel(0);
                    jtyy.setNewTypeId(12);
                    jtyy.setUrl("http://www.jtyy.com/shiwenxinzhi/"+mytb.get(k).getCid()+".html");
                    jtyy.setDescription(mytb.get(k).getZhaiyao());
                    jtyy.setContent(mytb.get(k).getContent());
                    jtyyDao.insertSelective(jtyy);
                }
                for(int l=0;l<zcytk.size();l++){
                    Jtyy jtyy=new Jtyy();
                    jtyy.setTitle(zcytk.get(l).getTitle());
                    jtyy.setAuthor(zcytk.get(l).getUsername());
                    jtyy.setCreateTime(zcytk.get(l).getCreate_time());
                    jtyy.setIsDel(0);
                    jtyy.setNewTypeId(13);
                    jtyy.setUrl("http://www.jtyy.com/shiwenxinzhi/"+zcytk.get(l).getCid()+".html");
                    jtyy.setDescription(zcytk.get(l).getZhaiyao());
                    jtyy.setContent(zcytk.get(l).getContent());
                    int res=jtyyDao.insertSelective(jtyy);
                    num +=res;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return num;
    }

}