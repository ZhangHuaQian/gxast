package com.cen.common.task;

import com.cen.JDBC.JDBCUtils;
import com.cen.JDBC.New_jtyy;
import com.cen.JDBC.New_news;
import com.cen.JDBC.SelectDao;
import com.cen.JtyyForeign.entity.JtyyForeign;
import com.cen.JtyyForeign.jdbc.JtyyQuery;
import com.cen.JtyyForeign.service.JtyyForeignService;
import com.cen.NfkjwForeign.entity.NfkjwForeign;
import com.cen.NfkjwForeign.jdbc.NfkjwQuery;
import com.cen.NfkjwForeign.service.NfkjwForeignService;
import com.cen.common.cache.EHCacheUtil;
import com.cen.common.util.CommonUtil;
import com.cen.common.util.DateUtil;
import com.cen.common.util.GenerateRandomKeyUtil;
import com.cen.common.util.ImageDown;
import com.cen.jtyy.service.JtyyService;
import com.cen.material.Meterial;
import com.cen.material.Token;
import com.cen.news_xbsb.service.XbsbService;
import com.cen.nfkjw.entity.Nfkjw;
import com.cen.nfkjw.service.NfkjwService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.File;
import java.sql.SQLException;
import java.util.*;

/**
 * 定时任务调度中心
 * Created by cenguocheng on 2018/7/5.
 * 137544496@qq.com
 * cron 表达式生成器 http://qqe2.com/cron/index
 */

@Component("taskCenter")
public class TaskCenter{
    protected Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    NfkjwService nfkjwService;
    @Autowired
    JtyyService jtyyService;
    @Autowired
    XbsbService xbsbService;

    @Autowired
    private JtyyForeignService<JtyyForeign> jtyyForeignService;
    @Autowired
    private NfkjwForeignService<NfkjwForeign> nfkjwForeignService;
    @Value("${system.USER_PHOTO_RESOUREC}")
    private String target;
    /**
     * 定时任务
     * 0 0/3 * * * ? 每三分钟
     * 0/10 * * * * ? 每十秒
     * 0 0 0 1 /5 * ? 每5天
     * 0 0 22 * * ?   每天晚上10点触发
     */


    /*查询南方科技网接口1*/

    @Scheduled(cron = "0 0/55 * * * ?")
    public void c1() {
        SelectDao selectDao=new SelectDao();
        Map map = new HashMap();
        try {
            List<New_news> jrtt=selectDao.selectData("1","99");
            if(jrtt.size()>0){
                EHCacheUtil.put("cen_crmjl","jrtt",jrtt );//首页的今日头条
            }

            List<New_news> hqkb=selectDao.selectData("11","99");
            if(hqkb.size()>0){
                EHCacheUtil.put("cen_crmjl","hqkb",hqkb );//首页的行情快报
            }


            /*种植和养殖合并list*/
            List<New_news> zzyz=selectDao.selectData1("5","99");
            List<New_news> zzyz1=selectDao.selectData1("6","99");
            List<New_news> zzyz2=new ArrayList<New_news>();
            zzyz1.addAll(zzyz);
            zzyz2.addAll(zzyz1);
            if(zzyz.size()>0){
                EHCacheUtil.put("cen_crmjl","zzyz",zzyz2 );//首页的种植养殖
            }



            List<New_news> cfsj=selectDao.selectData("12","99");
            if(cfsj.size()>0){
                EHCacheUtil.put("cen_crmjl","cfsj",cfsj );//首页的创富商机
            }


            List<New_news> gqxx=selectDao.selectData("9","99");
            if(gqxx.size()>0){
                EHCacheUtil.put("cen_crmjl","gqxx",gqxx );//首页的供求信息
            }

            List<New_news> yxkx=selectDao.selectData("2","99");
            if(yxkx.size()>0){
                EHCacheUtil.put("cen_crmjl","yxkx",yxkx );//首页的一线快讯
            }
            List<New_news> zjmdm=selectDao.selectData("3","99");
            if(zjmdm.size()>0){
                EHCacheUtil.put("cen_crmjl","zjmdm",zjmdm );//首页的专家面对面
            }

            List<New_news> nftt=selectDao.selectData("20","99");
            if(nftt.size()>0){
                EHCacheUtil.put("cen_crmjl","nftt",nftt );//首页的南方头条
            }


           /*南方科技网广告图*/
            List<New_news> yxkxList=selectDao.selectData2("2");
            if(yxkxList.size()>0){
                EHCacheUtil.put("cen_crmjl","yxkxList",yxkxList);//广告位一线快讯
            }

            /*南方科技网广告图*/
            List<New_news> zjmdmList=selectDao.selectData2("3");
            if(zjmdmList.size()>0){
                EHCacheUtil.put("cen_crmjl","zjmdmList",zjmdmList);//广告位专家面对面
            }

            /*查询家庭医药接口*/
           List<New_jtyy> myzx=selectDao.selectData3("21");
            if(myzx.size()>0){
                EHCacheUtil.put("cen_crmjl","myzx",myzx );//名医在线
            }
            List<New_jtyy> yyzd=selectDao.selectData3("29");
            if(yyzd.size()>0){
                EHCacheUtil.put("cen_crmjl","yyzd",yyzd );//健康医药的用药之道
            }
            List<New_jtyy> klys=selectDao.selectData3("44");
            if(klys.size()>0){
                EHCacheUtil.put("cen_crmjl","klys",klys );//快乐养生
            }
            List<New_jtyy> tbch=selectDao.selectData3("12");
            if(tbch.size()>0){
                EHCacheUtil.put("cen_crmjl","tbch",tbch );//特别策划
            }

            List<New_jtyy> yzphb=selectDao.selectData3("8");
            if(yzphb.size()>0){
                EHCacheUtil.put("cen_crmjl","yzphb",yzphb );//一周排行榜
            }

            List<New_jtyy> jttt=selectDao.selectData3("9");
            if(jttt.size()>0){
                EHCacheUtil.put("cen_crmjl","jttt",jttt );//一周排行榜
            }


            /*家庭医药广告位*/


            //左边
            List<New_jtyy> new_jtyyList1=selectDao.selectData4("8");
            if(new_jtyyList1.size()>0){
                EHCacheUtil.put("cen_crmjl","new_jtyyList1",new_jtyyList1);
            }

            List<New_jtyy> new_jtyyList2=selectDao.selectData4("21");
            if(new_jtyyList2.size()>0){
                EHCacheUtil.put("cen_crmjl","new_jtyyList2",new_jtyyList2);
            }
            List<New_jtyy> new_jtyyList3=selectDao.selectData4("29");
            if(new_jtyyList3.size()>0){
                EHCacheUtil.put("cen_crmjl","new_jtyyList3",new_jtyyList3);
            }
            List<New_jtyy> new_jtyyList4=selectDao.selectData4("44");
            if(new_jtyyList4.size()>0){
                EHCacheUtil.put("cen_crmjl","new_jtyyList4",new_jtyyList4);
            }
            List<New_jtyy> new_jtyyList5=selectDao.selectData4("12");
            if(new_jtyyList5.size()>0){
                EHCacheUtil.put("cen_crmjl","new_jtyyList5",new_jtyyList5);
            }






            logger.info("从公众号获取小博士报文章开始........................................................................................");
            List<Meterial> xbsbJZ = new ArrayList<>();
            try{
                Token token = CommonUtil.getToken("wxd87e11112721e484","057be37b8c3268393bd3b01334ef7a5c");//获取接口访问凭证access_token
                xbsbJZ = CommonUtil.getMeterial(token.getAccessToken(),"news",0,100);//调用获取素材列表的方法
            }catch (Exception e){
                logger.error(e.getMessage());
            }
            if(xbsbJZ.size()>0){
                //过虑标题长度小于5的文章
                sub(xbsbJZ);
                EHCacheUtil.put("cen_crmjl","xbsbJZ",xbsbJZ);
            }

            logger.info("从公众号获取大众科普文章开始........................................................................................");
            List<Meterial> dzkpJZ = new ArrayList<>();
            try{
                Token token1 = CommonUtil.getToken1("wx2b2577b751d92b3a","9aadd2d21c8b0c1978d86091393ecc13");//获取接口访问凭证access_token
                dzkpJZ = CommonUtil.getMeterial1(token1.getAccessToken(),"news",0,100);//调用获取素材列表的方法
            }catch (Exception e){
                logger.error(e.getMessage());
            }

            if(dzkpJZ.size()>0){
                //过虑标题长度小于5的文章
                sub(dzkpJZ);
                EHCacheUtil.put("cen_crmjl","dzkpJZ",dzkpJZ);
            }

            logger.info("从公众号获取南方农事文章开始........................................................................................");
            List<Meterial> nfnzJZ = new ArrayList<>();
            try{
                Token token2 = CommonUtil.getToken_nz("wx59f75167d6d25ea4","96197650c8039f1c7fefabeedca5c694");//获取接口访问凭证access_token
                nfnzJZ = CommonUtil.getMeterial_nz(token2.getAccessToken(),"news",0,100);//调用获取素材列表的方法
            }catch (Exception e){
                logger.error(e.getMessage());
            }

            if(nfnzJZ.size()>0){
                //过虑标题长度小于5的文章
                sub(nfnzJZ);
                EHCacheUtil.put("cen_crmjl","nfnzJZ",nfnzJZ);
            }

            logger.info("从公众号获取南方科技报文章开始........................................................................................");
            List<Meterial> nfkjbJZ = new ArrayList<>();
            try {
                Token token3 = CommonUtil.getToken_nf("wxe6afcd7ee6561e99","bb1f06891567cbb4a67ebc3b9475fce7");//获取接口访问凭证access_token
                nfkjbJZ = CommonUtil.getMeterial_nf(token3.getAccessToken(),"news",0,100);//调用获取素材列表的方法
            }catch (Exception e){
                logger.error(e.getMessage());
            }
            if(nfkjbJZ.size()>0){
                //过虑标题长度小于5的文章
                sub(nfkjbJZ);
                EHCacheUtil.put("cen_crmjl","nfkjbJZ",nfkjbJZ);
            }

            //南方科技网入库
            //nfkjwService.batchInsert();

            //家庭医药入库
            //jtyyService.batchInsert();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try{
                /*关闭全部事务*/
                JDBCUtils.close(selectDao.conn, selectDao.ps, selectDao.rs);
            }catch (SQLException e){
                e.printStackTrace();
            }
        }

//        System.err.println("----------------------------- 定时调度");
    }

    /*设置前端登录后台系统js传输加密密钥*/
    //每天凌晨1点执行一次：0 0 1 * * ?
    @Scheduled(cron = "0 0 1 * * ?")
    public void getKey(){
        String key = GenerateRandomKeyUtil.getRandomKey(16);
        EHCacheUtil.put("encryptKey","key",key );
    }

    public List<Meterial> sub(List<Meterial> list){
        List<Meterial> removeList = new ArrayList<>();
        for(int i = 0; i<list.size(); i++){
            if(list.get(i).getTitle().length() <=10){
                removeList.add(list.get(i));
            }
        }
        list.removeAll(removeList);
        return list;
    }


    /**
     * 同步“家庭医药”资讯到本地数据库
     * 每天晚上10点触发
     *   0/10 * * * * ?
     */
    @Scheduled(cron = "0 0 22 * * ?")
    public void syncJtyyNews() throws Exception {

//        名医在线所有子模块 13,19,20,21
//        健康医药所有子模块 25,26,27,29,30
//        快乐养生所有子模块 42,43,44,45,46,47,49
//        特别策划 12
//        焦点关注部分子模块 8,9

        //栏目id
        String catids = "13,19,20,21,25,26,27,29,30,42,43,44,45,46,47,49,12,8,9";
        //获取最后一条插入的资讯 id
        JtyyForeign jtyyForeign1 = jtyyForeignService.selectLastInsertId();
        if(jtyyForeign1 == null){
            jtyyForeign1 = new JtyyForeign();
            jtyyForeign1.setId(0);
        }
        List<JtyyForeign> result = JtyyQuery.query(catids ,jtyyForeign1.getId());
        if(result.size() > 0){
            String dateDirs = DateUtil.getThisSysTimeYMD_FILE();
            // 判断路径是否存在/创建
            File basePath = new File(target + dateDirs);
            if (!basePath.exists()) {
                basePath.mkdirs();
            }

            for(JtyyForeign jtyyForeign : result){
                String photo = jtyyForeign.getPhoto();
                // 下载图片到本地服务器
                if (photo != null && !photo.equals("")){
                    String resource = "http://www.jtyy.com" + photo;
                    String fileName = dateDirs + photo.substring(photo.lastIndexOf("/")+1);
                    ImageDown.download(resource, target + fileName);
                    jtyyForeign.setPhoto(fileName);
                }
                jtyyForeignService.insertSelective(jtyyForeign);
            }
        }
    }

    /**
     * 同步“南方科技网”资讯到本地数据库
     * 每天晚上11点触发
     *   0/10 * * * * ?
     */
    @Scheduled(cron = "0 0 23 * * ?")
    public void syncNfkjbNews() throws Exception {
         /*
        1, 首页的今日要闻
        2, 首页的一线快讯
        3, 首页的专家面对面
        5,6, 首页的种植养殖
        9, 首页的供求信息
        11, 首页的行情快报
        12, 首页的创富商机
        20, 首页的南方头条
         */

        //栏目id
        String catids = "1,2,3,5,6,9,11,12,20";
        //获取最后一条插入的资讯 id
        NfkjwForeign nfkjwForeign = nfkjwForeignService.selectLastInsertId();
        if(nfkjwForeign == null){
            nfkjwForeign = new NfkjwForeign();
            nfkjwForeign.setId(0);
        }
        List<NfkjwForeign> result = NfkjwQuery.query(catids ,nfkjwForeign.getId());
        if(result.size() > 0){
            String dateDirs = DateUtil.getThisSysTimeYMD_FILE();
            // 判断路径是否存在/创建
            File basePath = new File(target + dateDirs);
            if (!basePath.exists()) {
                basePath.mkdirs();
            }

            for(NfkjwForeign nfkjw : result){
                String photo = nfkjw.getPhoto();

                // 下载图片到本地服务器
                if (photo != null && !photo.equals("")){
                    String fileName = dateDirs + photo.substring(photo.lastIndexOf("/")+1);
                    ImageDown.download( photo, target + fileName);
                    nfkjw.setPhoto(fileName);
                }
                //修改资讯内容中的图片路径并下载到本地服务器
                String temp = nfkjw.getContent();
                List<String> imgStr = ImageDown.getImgStr(temp);
                if(imgStr.size() > 0){
                    String src = "";
                    String fileName = "";
                    for (int i=0; i<imgStr.size(); i++){
                        src = imgStr.get(i);
                        fileName = dateDirs + src.substring(src.lastIndexOf("/")+1);
                        ImageDown.download( src , target + fileName);
                        temp = temp.replace(src, "/uploadFiles/photo" + fileName);
                    }
                }
                nfkjw.setContent(temp);
                nfkjwForeignService.insertSelective(nfkjw);
            }
        }
    }


}
