package com.cen.news_xbsb.service.impl;

import com.cen.common.cache.EHCacheUtil;
import com.cen.common.util.CommonUtil;
import com.cen.material.Meterial;
import com.cen.material.Token;
import com.cen.news_xbsb.dao.XbsbDao;
import com.cen.news_xbsb.entity.Xbsb;
import com.cen.news_xbsb.service.XbsbService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class XbsbServiceImpl implements XbsbService {

    @Autowired
    XbsbDao xbsbDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return xbsbDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Xbsb record) {
        return xbsbDao.insert(record);
    }

    @Override
    public int insertSelective(Xbsb record) {
        return xbsbDao.insertSelective(record);
    }

    @Override
    public Xbsb selectByPrimaryKey(Integer id) {
        return xbsbDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Xbsb record) {
        return xbsbDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Xbsb record) {
        return xbsbDao.updateByPrimaryKey(record);
    }

    @Override
    public List<Xbsb> selectList(Map<String, Object> pmap) {
        return xbsbDao.selectList(pmap);
    }

    @Override
    public int selectListCount(Map<String, Object> pmap) {
        return xbsbDao.selectListCount(pmap);
    }

    @Override
    public List<Xbsb> selectNews(Map<String, Object> pmap) {
        return xbsbDao.selectNews(pmap);
    }

    @Override
    public List<Map> selectNewsByType(Map<String, Object> map) {
        return xbsbDao.selectNewsByType(map);
    }

    @Override
    public int batchInsert() {
        int num=0;
       /* Map<String, Object> pmap = new HashMap<String, Object>();
        try{
            Token token = CommonUtil.getToken("wxd87e11112721e484","057be37b8c3268393bd3b01334ef7a5c");//获取接口访问凭证access_token
            List<Meterial> ywdgy = CommonUtil.getMeterial(token.getAccessToken(),"news",0,7);//调用获取素材列表的方法
            List<Meterial> zwlmd = CommonUtil.getMeterial(token.getAccessToken(),"news",8,7);//调用获取素材列表的方法
            List<Meterial> sxxqs = CommonUtil.getMeterial(token.getAccessToken(),"news",15,7);//调用获取素材列表的方法
            if(xbsbDao.selectListCount(pmap)==0){
                for(int i=0;i<ywdgy.size();i++){
                    Xbsb xbsb=new Xbsb();
                    xbsb.setTitle(ywdgy.get(i).getTitle());
                    xbsb.setAuthor(ywdgy.get(i).getAuthor());
                    xbsb.setUrl(ywdgy.get(i).getUrl());
                    xbsb.setContent(ywdgy.get(i).getContent());
                    xbsb.setDescription(ywdgy.get(i).getDigest());
                    xbsb.setNewTypeId(15);
                    xbsb.setIsDel(0);
                    xbsbDao.insertSelective(xbsb);
                }
                for(int i=0;i<zwlmd.size();i++){
                    Xbsb xbsb=new Xbsb();
                    xbsb.setTitle(zwlmd.get(i).getTitle());
                    xbsb.setAuthor(zwlmd.get(i).getAuthor());
                    xbsb.setUrl(zwlmd.get(i).getUrl());
                    xbsb.setContent(zwlmd.get(i).getContent());
                    xbsb.setDescription(zwlmd.get(i).getDigest());
                    xbsb.setNewTypeId(16);
                    xbsb.setIsDel(0);
                    xbsbDao.insertSelective(xbsb);
                }
                for(int i=0;i<sxxqs.size();i++){
                    Xbsb xbsb=new Xbsb();
                    xbsb.setTitle(sxxqs.get(i).getTitle());
                    xbsb.setAuthor(sxxqs.get(i).getAuthor());
                    xbsb.setUrl(sxxqs.get(i).getUrl());
                    xbsb.setContent(sxxqs.get(i).getContent());
                    xbsb.setDescription(sxxqs.get(i).getDigest());
                    xbsb.setNewTypeId(17);
                    xbsb.setIsDel(0);
                    int res=xbsbDao.insertSelective(xbsb);
                    num +=res;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }*/
        return num;
    }
}
