package com.cen.ucenter.controller;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.cen.ForumUserInfo.entity.ForumUserInfo;
import com.cen.ForumUserInfo.service.ForumUserInfoService;
import com.cen.JDBC.New_jtyy;
import com.cen.JDBC.New_news;
import com.cen.JDBC.SelectDao;
import com.cen.appsite.service.AppsiteService;
import com.cen.appsite.user.dto.PhoneCheckCode;
import com.cen.appsite.wechat.util.ConfigUtil;
import com.cen.appsite.wxpay.controller.getIp;
import com.cen.bbs.comment.entity.Comment;
import com.cen.bbs.comment.service.CommentService;
import com.cen.bbs.toconmment.service.ToconmmentService;
import com.cen.code.entity.code;
import com.cen.code.service.CodeService;
import com.cen.common.cache.EHCacheUtil;
import com.cen.common.controller.BaseController;
import com.cen.common.task.InitSystemUtil;
import com.cen.common.task.TaskCenter;
import com.cen.common.util.*;
import com.cen.jtyy.service.JtyyService;
import com.cen.loopphoto.entity.Loopphoto;
import com.cen.loopphoto.service.LoopphotoService;
import com.cen.material.Meterial;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;
import com.cen.news_axhd.entity.NewsAxhd;
import com.cen.news_axhd.service.NewsAxhdService;
import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.news_xbsb.entity.Xbsb;
import com.cen.news_xbsb.service.XbsbService;
import com.cen.news_zzgk.entity.NewsZzgk;
import com.cen.news_zzgk.service.NewsZzgkService;
import com.cen.nfkjw.service.NfkjwService;
import com.cen.operateLog.annotation.UserOperate;
import com.cen.product.entity.Product;
import com.cen.product.entity.specifications;
import com.cen.product.service.ProductService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.cen.ucenter.util.JwtToken;
import com.cen.ucenter.util.JwtUtil;
import com.cen.ucenter.util.SysTokenUtil;
import com.cen.upms.entity.Role;
import com.cen.upms.service.RoleService;
import com.cen.upms.shiro.ShiroUtils;
import com.cen.xbsbs.entity.xbsbs;
import com.cen.xbsbs.service.xbsbsService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jpay.ext.kit.PaymentKit;
import com.jpay.ext.kit.StrKit;
import com.jpay.vo.AjaxResult;
import com.jpay.weixin.api.WxPayApi;
import com.jpay.weixin.api.WxPayApiConfig;
import com.jpay.weixin.api.WxPayApiConfigKit;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

//import javax.xml.ws.Response;
//import sun.invoke.empty.Empty;


/**
 * 用户登录
 *
 * @author cenguocheng
 * 2018-4-1
 */
@Controller
@RequestMapping(value = "/")
public class LoginController extends BaseController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private AppsiteService appsiteService;
    @Autowired
    private LoopphotoService loopphotoService;
    @Autowired
    private NewsService newsService;
    @Autowired
    private XbsbService xbsbService;
    @Autowired
    private NfkjwService nfkjwService;
    @Autowired
    private JtyyService jtyyService;
    @Autowired
    private ProductService productService;
    @Autowired
    private NewsAxhdService news_axhdService;
    @Autowired
    private CodeService codeService;
    @Autowired
    private xbsbsService xbsbsService;

    @Autowired
    private NewsZzgkService news_zzgkService;
    @Autowired
    private ForumUserInfoService<ForumUserInfo> forumUserInfoService;
    @Autowired
    NewsCommentService newsCommentService;
    @Autowired
    private CommentService commentService;
    @Autowired
    ToconmmentService toconmmentService;


    // @Autowired
    // private WxPayBean wxPayBean;
    //
//    private Logger log = LoggerFactory.getLogger(this.getClass());
//    private AjaxResult result = new AjaxResult();
//    private static final String appID = ConfigUtil.APPID;
//    private static final String secret = ConfigUtil.APP_SECRET;
//    private static final String mchID = "1280490401";
//    private static final String partnerKey = "a3dgas3D45he06sF6H3NN01484s45135";
//    private String notify_url = "http://www.gxkpcb.com/wx/pay_notify";

    //松贤微信支付测试
    private Logger log = LoggerFactory.getLogger(this.getClass());
    private static final String appID = "wx7200c9ff960a6b41";
    private static final String secret = "ad391e1f93da555e5a341aea2c5899c6";
    private static final String mchID = "1280490401";
    private static final String partnerKey = "a3dgas3D45he06sF6H3NN01484s45135";
    private String notify_url = "http://www.gxkpcb.com/wx/pay_notify";

    public static WxPayApiConfig getApiConfig() {
        return WxPayApiConfig.New().setAppId(appID).setMchId(mchID).setPaternerKey(partnerKey)
                .setPayModel(WxPayApiConfig.PayModel.BUSINESSMODEL);
    }

    /**
     * 登录处理
     *
     * @param request
     * @param user
     * @return
     */
    public ResData loginHandle(User user, boolean isToken, HttpServletRequest request, HttpServletResponse response) {
        //Map<String, Object> rMap = new HashMap<String, Object>();
        UsernamePasswordToken token = new UsernamePasswordToken(user.getLoginname(), user.getPassword());
        //token.setRememberMe(true);
        Subject currentUser = SecurityUtils.getSubject();
        ResData resData = new ResData(Status.LOGIN_FAIL.status, Status.LOGIN_FAIL.msg);

        //登录黑名单限制
        String CLIENT_IP = HttpUtil.getIpAddr(request);
        if (CLIENT_IP == null || InitSystemUtil.ipRollList.contains(CLIENT_IP)) {
            return new ResData(Status.IP_LOCK.status, Status.IP_LOCK.msg);
        }


        try {
            currentUser.login(token);
            Map<String,Object> rMap = new HashMap<>();
            JwtToken jwtToken = null;
            if(isToken) {
                String tokenVal = new JwtUtil().createToken(user.getLoginname(), ReturnInfoType.TokenExpiryDate); // 生成 token
                Cookie cookie = new Cookie(ReturnInfoType.cen_xczhapp_token, tokenVal);
                //cookie.setMaxAge(ReturnInfoType.TokenExpiryDate);//设置cookie的生命周期/单位:秒
                cookie.setPath("/");
                //cookie.setDomain("localhost");
                response.addCookie(cookie); // cookie 方式实现
                response.setHeader(ReturnInfoType.cen_xczhapp_token, tokenVal); //header 方式实现
                EHCacheUtil.put(ReturnInfoType.cen_xczhapp_token, tokenVal, user); // 刷新缓存

                jwtToken = new JwtToken(tokenVal,ReturnInfoType.TokenExpiryDate);
                rMap = MapUtils.beanToMap(jwtToken);
            }
            // 查询用户角色
            User user2 = userService.selectByLoginName(user.getLoginname());
            List<Role> roles = roleService.selectByUid(user2.getId());
            if(roles.size()>0)rMap.put("roles",roles.get(0).getPower());
            rMap.put("userID",user2.getId());

            return ResData.SUCCESS(rMap);
        } catch (UnknownAccountException uae) {
            //uae.printStackTrace();
        } catch (IncorrectCredentialsException ice) {
            ice.printStackTrace();
        } catch (LockedAccountException lae) {
            return new ResData(Status.USER_LOCK.status, Status.USER_LOCK.msg);
        } catch (ExcessiveAttemptsException eae) {
            eae.printStackTrace();
        } catch (AuthenticationException ae) {
            ae.printStackTrace();
        }

        return resData;
    }

    /**
     * 访问首页
     */
    @UserOperate(moduleName = "访问首页")
    @RequestMapping(value = "/", produces = "application/json;charset=utf-8")
    public String innitIdex(HttpServletRequest request, HttpServletResponse response, Map map) {
        TaskCenter taskCenter = new TaskCenter();
        taskCenter.c1();
        SelectDao selectDao = new SelectDao();
        /*Map<String, Object> umap = new HashMap<String, Object>();*/
        /*int count = loopphotoService.updateByPrimaryKeySelective(loopphoto);*/
        Loopphoto koopphoto = new Loopphoto();
        koopphoto.setHtmlUrl("#");
        koopphoto.setProjectImg("404.jpg");
        koopphoto.setId(1);
        koopphoto.setCreateTime(new Date());
        koopphoto.setHeader("未上传图片");



        List<Integer> newsIdList = new ArrayList<>();
        List<Integer> axhdIdList = new ArrayList<>();
        List<Integer> zzgkIdList = new ArrayList<>();

        //首页后台添加广告位
        for (int i = 1; i <= 8; i++) {

//            "zy_01"
//            "zy_02"
//            "zy_03"
//            "zy_04"
//            "zy_05"
//            "zy_06"
//            "zy_07"
            String type = i<10?"zy_#0"+i:"zy_#"+i;
            String list = i<10?"zy_0"+i:"zy_"+i;
            List<Loopphoto> loopphotoList = loopphotoService.selectByType2(type);

            if(loopphotoList.size()>0){
//                if(loopphotoList.get(0).getNewsType() != null && loopphotoList.get(0).getNewsType().equals("news")){
//                    //如果广告位上存放新闻中心的新闻，则记录该新闻的id
//                    newsIdList.add(loopphotoList.get(0).getNewsId());
//                }else if(loopphotoList.get(0).getNewsType() != null && loopphotoList.get(0).getNewsType().equals("news_axhd")){
//                    //如果广告位上存放党建工作的新闻，则记录该新闻的id
//                    axhdIdList.add(loopphotoList.get(0).getNewsId());
//                }else if(loopphotoList.get(0).getNewsType() != null && loopphotoList.get(0).getNewsType().equals("news_zzgk")){
//                    //如果广告位上存放政务公开的新闻，则记录该新闻的id
//                    zzgkIdList.add(loopphotoList.get(0).getNewsId());
//                }
            }
            map.put(list, loopphotoList);
        }



        Map<String, Object> qmap = new HashMap<String, Object>();
        qmap.put("pageNum", getPageNum(1));
        qmap.put("pageSize", 30);
        qmap.put("verifty","5");
        map.put("verifty","5");


        /* 新闻中心、党建工作、政务公开 三类新闻合并 start */

        List<News> list3 = newsService.selectList(qmap); // 新闻中心
        List<NewsAxhd> list = news_axhdService.selectList(map); // 党建工作
        List<NewsZzgk> news_zzgks = news_zzgkService.selectList(qmap);//政务公开
        List listAll = new ArrayList();
        List listAll2 = new ArrayList();
        listAll2.add("");   //为了下文使用listAll2.set(0,?)不报空指针;

        SimpleDateFormat sf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

        //新闻中心
        newsFor :for (int i = 0; i < list3.size(); i++) {

//            if(newsIdList.size()>0){
//                //如果广告位中有“新闻中心”的新闻，则该新闻不加入到首页的新闻列表中
//                for(Integer id : newsIdList){
//                    int id2 = list3.get(i).getId();
//                    String title = list3.get(i).getTitle();
//                    if(list3.get(i).getId().equals(id)){
//                        continue newsFor;
//                    }
//                }
//            }

            listAll.add(list3.get(i));
        }

        //党建工作
        axhdFor:for (int i = 0; i < list.size(); i++) {

//            if(axhdIdList.size()>0){
//                //如果广告位中有“党建工作”的新闻，则该新闻不加入到首页的新闻列表中
//                for(Integer id : axhdIdList){
//                    if(list.get(i).getId().equals(id)){
//                        continue axhdFor;
//                    }
//                }
//            }

            listAll.add(list.get(i));
        }

        //政务公开
        zzgkFor:for (int i = 0; i < news_zzgks.size(); i++) {

//            if(zzgkIdList.size()>0){
//                //如果广告位中有“政务公开”的新闻，则该新闻不加入到首页的新闻列表中
//                for(Integer id : zzgkIdList){
//                    if(news_zzgks.get(i).getId().equals(id)){
//                        continue zzgkFor;
//                    }
//                }
//            }

            listAll.add(news_zzgks.get(i));
        }

        News news = null;
        NewsAxhd news_axhd = null;
        NewsZzgk news_zzgk = null;

        for (int i = 0; i < listAll.size(); i++) {
            Date date1 = new Date();
            Date date2 = new Date();
            int index = i;

            if (listAll.get(i) instanceof News) {
                news = (News) listAll.get(i);
                date1 = news.getModifyTime();
            } else if (listAll.get(i) instanceof NewsAxhd) {
                news_axhd = (NewsAxhd) listAll.get(i);
                date1 = news_axhd.getModifyTime();
            } else if (listAll.get(i) instanceof NewsZzgk) {
                news_zzgk = (NewsZzgk) listAll.get(i);
                date1 = news_zzgk.getModifyTime();
            }
            for (int j = i+1; j < listAll.size(); j++) {

                if (listAll.get(j) instanceof News) {
                    news = (News) listAll.get(j);
                    date2= news.getModifyTime();
                } else if (listAll.get(j) instanceof NewsAxhd) {
                    news_axhd = (NewsAxhd) listAll.get(j);
                    date2 = news_axhd.getModifyTime();
                } else if (listAll.get(j) instanceof NewsZzgk) {
                    news_zzgk = (NewsZzgk) listAll.get(j);
                    date2 = news_zzgk.getModifyTime();
                }
                if(date1.compareTo(date2)<0){
                    index = j;
                    date1 = date2;
                }
            }

            listAll2.set(0,listAll.get(i));
            listAll.set(i,listAll.get(index));
            listAll.set(index,listAll2.get(0));
        }

        for (int i=0;i<listAll.size();i++){
            if(listAll.get(i) instanceof News){
                news = (News)listAll.get(i);
            }else if(listAll.get(i) instanceof NewsAxhd){
                news_axhd = (NewsAxhd)listAll.get(i);
            }else if(listAll.get(i) instanceof NewsZzgk){
                news_zzgk = (NewsZzgk)listAll.get(i);
            }
        }


//        map.put("news", list3);
//        map.put("news_axhd", list);
//        map.put("news_zzgks", news_zzgks);
        map.put("listAll", listAll);

        /* 新闻中心、党建工作、政务公开 三类新闻合并 end */


        /*南方科技网*/
        List<New_news> jrtt = (List<New_news>) EHCacheUtil.get("cen_crmjl", "jrtt");
        List<New_news> hqkb = (List<New_news>) EHCacheUtil.get("cen_crmjl", "hqkb");
        List<New_news> zzyz = (List<New_news>) EHCacheUtil.get("cen_crmjl", "zzyz");
        List<New_news> cfsj = (List<New_news>) EHCacheUtil.get("cen_crmjl", "cfsj");
        List<New_news> gqxx = (List<New_news>) EHCacheUtil.get("cen_crmjl", "gqxx");
        List<New_news> yxkx = (List<New_news>) EHCacheUtil.get("cen_crmjl", "yxkx");
        List<New_news> zjmdm = (List<New_news>) EHCacheUtil.get("cen_crmjl", "zjmdm");
        List<New_news> nftt = (List<New_news>) EHCacheUtil.get("cen_crmjl", "nftt");


        map.put("hqkb", hqkb);
        map.put("jrtt", jrtt);
        map.put("zzyz", zzyz);
        map.put("cfsj", cfsj);
        map.put("gqxx", gqxx);
        map.put("yxkx", yxkx);
        map.put("zjmdm", zjmdm);
        map.put("nftt", nftt);


        List<New_news> yxkxList = (List<New_news>) EHCacheUtil.get("cen_crmjl", "yxkxList");
        List<New_news> zjmdmList = (List<New_news>) EHCacheUtil.get("cen_crmjl", "zjmdmList");
        map.put("yxkxList", yxkxList);
        map.put("zjmdmList", zjmdmList);



        /*家庭医药*/
        List<New_jtyy> myzx = (List<New_jtyy>) EHCacheUtil.get("cen_crmjl", "myzx");
        List<New_jtyy> yyzd = (List<New_jtyy>) EHCacheUtil.get("cen_crmjl", "yyzd");
        List<New_jtyy> klys = (List<New_jtyy>) EHCacheUtil.get("cen_crmjl", "klys");
        List<New_jtyy> tbch = (List<New_jtyy>) EHCacheUtil.get("cen_crmjl", "tbch");
        List<New_jtyy> yzphb = (List<New_jtyy>) EHCacheUtil.get("cen_crmjl", "yzphb");
        List<New_jtyy> jttt = (List<New_jtyy>) EHCacheUtil.get("cen_crmjl", "jttt");

        map.put("myzx", myzx);
        map.put("yyzd", yyzd);
        map.put("klys", klys);
        map.put("tbch", tbch);
        map.put("yzphb", yzphb);
        map.put("jttt", jttt);

        /*家庭医药广告位*/
        List<New_jtyy> new_jtyyList1 = (List<New_jtyy>) EHCacheUtil.get("cen_crmjl", "new_jtyyList1");
        List<New_jtyy> new_jtyyList2 = (List<New_jtyy>) EHCacheUtil.get("cen_crmjl", "new_jtyyList2");
        List<New_jtyy> new_jtyyList3 = (List<New_jtyy>) EHCacheUtil.get("cen_crmjl", "new_jtyyList3");
        List<New_jtyy> new_jtyyList4 = (List<New_jtyy>) EHCacheUtil.get("cen_crmjl", "new_jtyyList4");
        List<New_jtyy> new_jtyyList5 = (List<New_jtyy>) EHCacheUtil.get("cen_crmjl", "new_jtyyList5");

        map.put("new_jtyyList1", new_jtyyList1);
        map.put("new_jtyyList2", new_jtyyList2);
        map.put("new_jtyyList3", new_jtyyList3);
        map.put("new_jtyyList4", new_jtyyList4);
        map.put("new_jtyyList5", new_jtyyList5);





        /*小博士报*/
        Map<String, Object> amap = new HashMap<String, Object>();
        amap.put("newTypeId", 14);
        List<Xbsb> kptd = xbsbService.selectList(amap);//科普天地
        Map<String, Object> bmap = new HashMap<String, Object>();
        bmap.put("newTypeId", 15);
        List<Xbsb> ywdgy = xbsbService.selectList(bmap);//语文大观园
        Map<String, Object> cmap = new HashMap<String, Object>();
        cmap.put("newTypeId", 16);
        List<Xbsb> zwlmd = xbsbService.selectList(cmap);//作文乐满地
        Map<String, Object> dmap = new HashMap<String, Object>();
        dmap.put("newTypeId", 17);
        List<Xbsb> sxxqns = xbsbService.selectList(dmap);//数学小巧能手
        map.put("kptd", kptd);
        map.put("ywdgy", ywdgy);
        map.put("zwlmd", zwlmd);
        map.put("sxxqns", sxxqns);


        List<Meterial> xbsbJZ = (List<Meterial>) EHCacheUtil.get("cen_crmjl", "xbsbJZ");
        map.put("xbsbJZ", xbsbJZ);

        List<Meterial> dzkpJZ = (List<Meterial>) EHCacheUtil.get("cen_crmjl", "dzkpJZ");
        map.put("dzkpJZ", dzkpJZ);

        List<Meterial> nfnzJZ = (List<Meterial>) EHCacheUtil.get("cen_crmjl", "nfnzJZ");

        map.put("nfnzJZ", nfnzJZ);

        List<Meterial> nfkjbJZ = (List<Meterial>) EHCacheUtil.get("cen_crmjl", "nfkjbJZ");

        map.put("nfkjbJZ", nfkjbJZ);

        HashMap<String, Object> pmap = new HashMap<>();

        pmap.put("up", 1);
        pmap.put("switch", 1);
        pmap.put("name", null);
        pmap.put("pageNum", 0);
        pmap.put("pageSize", 10);
        pmap.put("browse", 1);
        List<Product> list2 = productService.selectList(pmap);  //列表

        map.put("recommend", list2);

        map.put("status", ReturnInfoType.SUCEEESS);
        return "index";
    }


    /**
     * 后台用户登录
     */
    @UserOperate(moduleName = "用户登录")
    @ResponseBody
    @RequestMapping(value = "/login", produces = "application/json;charset=utf-8")
    public String login(HttpServletRequest request, User user, HttpServletResponse response) {

        String loginname = request.getParameter("loginname");
        String password = request.getParameter("password");
        String key = (String) EHCacheUtil.get("encryptKey", "key");
        try {
            user.setLoginname(AesUtil.aesDecrypt(loginname, key));
            user.setPassword(AesUtil.aesDecrypt(password, key));
        } catch (Exception e) {
            e.printStackTrace();
        }
        String tokenID = MD5Tools.stringToMD5(user.getLoginname() + System.currentTimeMillis()); // 生产token
        ResData resData = loginHandle(user, true, request, response);
        HashMap<String, Object> map = (HashMap<String, Object>) resData.getData();
        System.out.println(request.getSession().getAttribute(ReturnInfoType.USER_SESSION_NAME));
        User user1 = (User) request.getSession().getAttribute(ReturnInfoType.USER_SESSION_NAME);
        if (resData.getStatus().equals(ReturnInfoType.SUCEEESS)) {
            if (map.get("roles").equals("role_system") || map.get("roles").equals("role_super")||map.get("roles").equals("role_simple")) {
                return toJSONString(resData);
            }else {
                //没有后台登录权限的执行登出操作
                logout(request);
                resData.setStatus(ReturnInfoType.FAIL);
//                resData.setMsg("权限不足");
                resData.setMsg("用户名或密码错误"); //做模糊化提示处理
            }
        }else {
            resData.setStatus(ReturnInfoType.FAIL);
            resData.setMsg("账号或密码错误");
        }
        return toJSONString(resData);

    }

    /**
     * 获取后台js传输加密key
     *
     * @return
     */
    @RequestMapping("/getKey")
    @ResponseBody
    public String getKey() {
        EHCacheUtil.get("encryptKey");
        String key = (String) EHCacheUtil.get("encryptKey", "key");
        if (key == null) {
            String key2 = GenerateRandomKeyUtil.getRandomKey(16);
            EHCacheUtil.put("encryptKey", "key", key2);
            key = key2;
        }
        Map rMap = new HashMap();
        rMap.put("key", key);
        return ResData.SUCCESS(rMap).toString();
    }

    /**
     * 网站用户登录
     */
    @ResponseBody
    @RequestMapping(value = "/login_two", produces = "application/json;charset=utf-8")
    public String login_two(String ValidateCode, HttpServletRequest request, User user, HttpServletResponse response) {
        String tokenID = MD5Tools.stringToMD5(user.getLoginname() + System.currentTimeMillis()); // 生产token
        ResData resData = null;

        String loginname = request.getParameter("loginname");
        String password = request.getParameter("password");
        String key = (String) EHCacheUtil.get("encryptKey", "key");
        try {
            user.setLoginname(AesUtil.aesDecrypt(loginname, key));
            user.setPassword(AesUtil.aesDecrypt(password, key));
        } catch (Exception e) {
            e.printStackTrace();
        }

        //图片的验证码
        String text = (String) request.getSession().getAttribute(ReturnInfoType.VALIDATECODE);
        if (!text.equalsIgnoreCase(ValidateCode.trim())) {
            //rMap.put("msg", "验证码错误");
            //rMap.put("status", ReturnInfoType.VALIDATECodeERROR);
            resData = new ResData(Status.VALIDATECodeERROR.status, Status.VALIDATECodeERROR.msg);
        } else {
            resData = loginHandle(user, true, request, response);
        }
        return toJSONString(resData);
    }

    /**
     * 手机用户 --> 个人信息
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getUserInfo", produces = "application/json;charset=utf-8")
    public String getUserInfo(HttpServletRequest request){
        Map<String,Object> rMap = new HashMap<>();
        User user = getUser(request);
        if(user == null){
            rMap.put("msg","请先登录");
            rMap.put("status",ReturnInfoType.FAIL);
            return toJSONString(rMap);
        }
        user = userService.selectByPrimaryKey(user.getId());
        User user1 = new User();
        user1.setId(user.getId());
        user1.setLoginname(user.getLoginname());
        user1.setName(user.getName());
        user1.setPhonenum(user.getPhonenum());
        rMap.put("user",user1);
        rMap.put("status",ReturnInfoType.SUCEEESS);
        return toJSONString(rMap);
    }

    /**
     * 用户登出
     */
    @RequestMapping(value = "/logout")
    @ResponseBody
    public String logout(HttpServletRequest request) {
        ShiroUtils.logout();

        String token = SysTokenUtil.getToken(request);
        EHCacheUtil.remove(ReturnInfoType.cen_xczhapp_token, token); //从缓存清除

        C c = new C("ok", ReturnInfoType.SUCEEESS);
        return toJSONString(c);
    }

    /**
     * 发送手机验证码
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/sendPhoneCheckCodeRegUser", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String sendPhoneCheckCode(PhoneCheckCode phoneCheckCode, HttpServletRequest request, HttpServletResponse response) {

        User user = null;
        if(phoneCheckCode.getPhone() != null && !phoneCheckCode.getPhone().equals("")){
            user = userService.selectByLoginName(phoneCheckCode.getPhone()); // 查询用户是否存在
        }
        if (user != null) {
            return toJSONString(new C("用户已存在", ReturnInfoType.USER_EXIST_ERROR));
        }

        C c = new C();
        phoneCheckCode.setBath(IdUtil.RandomNumber(6), HttpUtil.getIpAddr(request), "regUser");
        PhoneCheckCode result = appsiteService.sendPhoneCheckCode(phoneCheckCode); // 发送手机短信

        //发送成功
        if (result.getStatus().equals(ReturnInfoType.SUCEEESS)) {
            String cacheKey = phoneCheckCode.getPhone() + phoneCheckCode.getType();
            EHCacheUtil.put(ReturnInfoType.cen_xczhapp_phone_code, cacheKey, phoneCheckCode); // 写入缓存
        }

        c.setStatus(result.getStatus());
        c.setMsg(result.getReturnMsg());
        return toJSONString(c);
    }

    /**
     * 用户注册 (网页端)
     */
    @ResponseBody
    @RequestMapping(value = "/register", produces = "application/json;charset=utf-8")
    @Transactional
    public String register(User user, PhoneCheckCode pcc, HttpServletRequest request) {
        String cacheKey = user.getPhonenum() + "regUser";

        PhoneCheckCode pccCache = (PhoneCheckCode) EHCacheUtil.get(ReturnInfoType.cen_xczhapp_phone_code, cacheKey);
        if (pccCache == null) {
            return toJSONString(new C("验证码错误", ReturnInfoType.VALIDATECodeERROR));
        } else if (!pcc.getCheckCode().equals(pccCache.getCheckCode())) {
            //错误次数大于5次
            if (pccCache.getSendNum() >= 5) {
                EHCacheUtil.remove(ReturnInfoType.cen_xczhapp_phone_code, cacheKey); // 从缓存删除
            } else {
                pccCache.setSendNum(pccCache.getSendNum() + 1);
                EHCacheUtil.put(ReturnInfoType.cen_xczhapp_phone_code, cacheKey, pccCache); // 写入缓存
            }
            return toJSONString(new C("验证码错误", ReturnInfoType.VALIDATECodeERROR));
        }

        String[] roleIds = {system_regUserDefaultRoleIds}; // 默认为 手机端普通用户
        Map<String, Object> rMap = new HashMap<String, Object>();
        User u = userService.selectByLoginName(user.getPhonenum().trim()); //根据用户名查询
        if (isEmpty(u)) {
            user.setIsDel(0);
            user.setCreatedate(new Date()); //设置注册时间
            user.setPhoto("default_user.jpg");// 默认头像
            user.setUsertype("1"); // 普通手机用户
            //user.setPhonenum(user.getLoginname());  // 默认用登录手机号为绑定手机
            user.setLoginname(user.getPhonenum());
            user.setName(user.getPhonenum());
            user.setPassword(MD5Tools.generate(user.getPassword()));// 密码MD5转码
            int ret = userService.register(roleIds, user);

            //存到论坛用户信息表
            ForumUserInfo forumUserInfo = new ForumUserInfo();
            forumUserInfo.setUId(user.getId());
            forumUserInfo.setUName(user.getName());
            forumUserInfo.setModifyTime(new Date());
            int fRes = forumUserInfoService.insertSelective(forumUserInfo);

            if (fRes + ret >= 3) {
                rMap.put("msg", "注册成功");
                rMap.put("status", ReturnInfoType.SUCEEESS);
            } else {
                rMap.put("msg", "注册失败");
                rMap.put("status", ReturnInfoType.FAIL);
            }
        } else {
            rMap.put("msg", "用户名已存在");
            rMap.put("status", ReturnInfoType.USER_EXIST_ERROR);
        }
        return toJSONString(rMap);
    }

    /**
     * 用户注册 (手机端)
     */
    @ResponseBody
    @RequestMapping(value = "/regUser", produces = "application/json;charset=utf-8")
    public String regUser(User user, PhoneCheckCode pcc, HttpServletRequest request) {

        String cacheKey = user.getLoginname() + "regUser";
        PhoneCheckCode pccCache = (PhoneCheckCode) EHCacheUtil.get(ReturnInfoType.cen_xczhapp_phone_code, cacheKey);
        if (pccCache == null) {
            return toJSONString(new C("验证码错误", ReturnInfoType.VALIDATECodeERROR));
        } else if (!pcc.getCheckCode().equals(pccCache.getCheckCode())) {
            //错误次数大于5次
            if (pccCache.getSendNum() >= 5) {
                EHCacheUtil.remove(ReturnInfoType.cen_xczhapp_phone_code, cacheKey); // 从缓存删除
            } else {
                pccCache.setSendNum(pccCache.getSendNum() + 1);
                EHCacheUtil.put(ReturnInfoType.cen_xczhapp_phone_code, cacheKey, pccCache); // 写入缓存
            }
            return toJSONString(new C("验证码错误", ReturnInfoType.VALIDATECodeERROR));
        }

        String[] roleIds = {system_regUserDefaultRoleIds}; // 默认为 手机端普通用户
        Map<String, Object> rMap = new HashMap<String, Object>();
        User u = userService.selectByLoginName(user.getLoginname().trim()); //根据用户名查询
        if (isEmpty(u)) {
            user.setIsDel(0);
            user.setCreatedate(new Date()); //设置注册时间
            user.setPhoto("default_user.jpg");// 默认头像
            user.setUsertype("1"); // 普通手机用户
            user.setPhonenum(user.getLoginname());  // 默认用登录手机号为绑定手机
            user.setPassword(MD5Tools.generate(user.getPassword()));// 密码MD5转码
            int ret = userService.register(roleIds, user);
            if (ret >= 2) {
                rMap.put("msg", "注册成功");
                rMap.put("status", ReturnInfoType.SUCEEESS);
            } else {
                rMap.put("msg", "注册失败");
                rMap.put("status", ReturnInfoType.FAIL);
            }
        } else {
            rMap.put("msg", "用户名已存在");
            rMap.put("status", ReturnInfoType.USER_EXIST_ERROR);
        }
        return toJSONString(rMap);
    }

    /**
     * 用户登录(手机端)
     *
     * @param request
     * @param user
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/androidLogin", produces = "application/json;charset=utf-8")
    public String androidLogin(User user, HttpServletRequest request, HttpServletResponse response) {
        String tokenID = MD5Tools.stringToMD5(user.getLoginname() + System.currentTimeMillis()); // 生产token
        ResData resData = loginHandle(user, true, request, response);
        HashMap<String, Object> map = (HashMap<String, Object>) resData.getData();
        // 登录成功 , 将登录信息保存到缓存中
        if (resData.getStatus().equals(ReturnInfoType.SUCEEESS)) {
            map.put("expires_in", ReturnInfoType.TokenExpiryDate);// 令牌有效期
            map.put(ReturnInfoType.cen_xczhapp_token, tokenID);//给手机端返回令牌
            return toJSONString(ResData.SUCCESS(map));
        }else {
            resData.setStatus(ReturnInfoType.FAIL);
            resData.setMsg("账号或密码错误");
            return toJSONString(resData);
        }

    }

    /**
     * 更新用户昵称(网页端)
     *
     * @param request
     * @param user
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/updateName", produces = "application/json;charset=utf-8")
    public String update(User user, HttpServletRequest request, HttpServletResponse response) {
        User uu = getUser(request);
        uu.setName(user.getName());
        int a = userService.updateByPrimaryKeySelective(uu);
        Map<String, Object> rMap = new HashMap<>();
        if (a == 1) {
            rMap.put("msg", "更新成功");
            rMap.put("status", "1");
            User user1 = new User();
            user1.setName(uu.getName());
            rMap.put("user",user1);
            request.setAttribute(ReturnInfoType.USER_SESSION_NAME,uu);
        } else {
            rMap.put("msg", "系统拒绝你的更新请求");
            rMap.put("status", "0");
        }

        return toJSONString(rMap);
    }

    /**
     * 更新头像信息
     *
     * @param request
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/updateheaderphoto", produces = "application/json;charset=utf-8")
    public String updateheaderphoto(String id, String url, HttpServletRequest request, HttpServletResponse response) {
        User uu = userService.selectByPrimaryKey(id);
        uu.setPhoto(url);
        int a = userService.updateByPrimaryKeySelective(uu);
        Map<String, Object> rMap = new HashMap<>();
        if (a == 1) {
            rMap.put("msg", "更新成功");
            rMap.put("status", "1");
        } else {
            rMap.put("msg", "系统拒绝你的更新请求");
            rMap.put("status", "0");
        }

        return toJSONString(rMap);
    }


    /**
     * 发送手机验证码--更新手机号(网页端)
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/sendPhoneCheckCodeUpdatePhone", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String sendPhoneCheckCodeUpdatePhone(PhoneCheckCode phoneCheckCode, HttpServletRequest request, HttpServletResponse response) {

        C c = new C();
        phoneCheckCode.setBath(IdUtil.RandomNumber(6), HttpUtil.getIpAddr(request), "updatePhone");
        PhoneCheckCode result = appsiteService.sendPhoneCheckCodeUpdatePhone(phoneCheckCode); // 发送手机短信

        //发送成功
        if (result.getStatus().equals(ReturnInfoType.SUCEEESS)) {
            String cacheKey = phoneCheckCode.getPhone() + phoneCheckCode.getType();
            EHCacheUtil.put(ReturnInfoType.update_phone_code, cacheKey, phoneCheckCode); // 写入缓存
        }

        c.setStatus(result.getStatus());
        c.setMsg(result.getReturnMsg());
        return toJSONString(c);
    }

    /**
     * 更新手机号(网页端)
     *
     * @param request
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/updatePhone", produces = "application/json;charset=utf-8")
    public String updatePhone(String phone, String code, HttpServletRequest request, HttpServletResponse response) {

        String cacheKey = phone + "updatePhone";
        PhoneCheckCode pccCache = (PhoneCheckCode) EHCacheUtil.get(ReturnInfoType.update_phone_code, cacheKey);
        if (pccCache == null) {
            return toJSONString(new C("验证码错误", ReturnInfoType.VALIDATECodeERROR));
        } else if (!code.equals(pccCache.getCheckCode())) {
            //错误次数大于5次
            if (pccCache.getSendNum() >= 5) {
                EHCacheUtil.remove(ReturnInfoType.update_phone_code, cacheKey); // 从缓存删除
            } else {
                pccCache.setSendNum(pccCache.getSendNum() + 1);
                EHCacheUtil.put(ReturnInfoType.update_phone_code, cacheKey, pccCache); // 写入缓存
            }
            return toJSONString(new C("验证码错误", ReturnInfoType.VALIDATECodeERROR));
        }

        User user = getUser(request);
        User user1 = new User();
        user1.setId(user.getId());
        user1.setPhonenum(phone);
        user1.setLoginname(phone);
        int a = userService.updateByPrimaryKeySelective(user1);
        Map<String, Object> rMap = new HashMap<>();
        if (a == 1) {
            rMap.put("msg", "更新成功");
            rMap.put("status", "1");
        } else {
            rMap.put("msg", "更新失败");
            rMap.put("status", "0");
        }

        return toJSONString(rMap);
    }

    /**
     * 个人中心 --> 资讯 --> 我的评论(网页端)
     * @param newsComment
     * @param pageNum
     * @param request
     * @param response
     * @return
     * @throws ParseException
     */
    @RequestMapping(value="/myNewsCommentList", method = RequestMethod.GET)
    @ResponseBody
    public  String selectList(NewsComment newsComment, Integer pageNum, HttpServletRequest request, HttpServletResponse response)throws ParseException {
        Map<String, Object> pmap = new HashMap<String, Object>();
        Map<String, Object> rMap = new HashMap<String, Object>();

        User user = getUser(request);
        if(user == null){
            rMap.put("msg","未登录");
            rMap.put("status", ReturnInfoType.FAIL);
            return toJSONString(rMap);
        }
        pmap = MapUtils.beanToMap(newsComment);
        pmap.put("pageNum", getPageNum(pageNum));
        pmap.put("pageSize", pageSize);
        pmap.put("fromUid", user.getId());
        //1.查询出我评论过的资讯
        List<NewsComment> list=newsCommentService.selectList(pmap);
        //2.根据资讯id获取资讯信息
        if (list.size()>0){
            for(NewsComment nc : list)
                if (nc.getTopicType().equals("xwzx")) { //新闻中心
                    News news = newsService.selectByPrimaryKey(nc.getTopicId());
                    nc.setNewsId(news.getId());
                    nc.setNewsTitle(news.getTitle());
                } else if (nc.getTopicType().equals("djgz")) { //党建工作
                    NewsAxhd newsAxhd = news_axhdService.selectByPrimaryKey(nc.getTopicId());
                    nc.setNewsId(newsAxhd.getId());
                    nc.setNewsTitle(newsAxhd.getTitle());
                } else if (nc.getTopicType().equals("zzgk")) { // 政务公开
                    NewsZzgk newsZzgk = news_zzgkService.selectByPrimaryKey(nc.getTopicId());
                    nc.setNewsId(newsZzgk.getId());
                    nc.setNewsTitle(newsZzgk.getTitle());
                }
        }
        //3.获取总条数
        int count=newsCommentService.selectListCount(pmap);

        if (!isEmpty(list)) rMap.put("list", list);
        rMap.put("count", count);
        rMap.put("msg","");
        rMap.put("code",0);
        return toJSONString(rMap);
    }

    /**
     * 个人中心 --> 资讯 --> 我的评论 删除评论
     * @param newsComment
     * @param request
     * @param response
     * @return
     * @throws ParseException
     */
    @RequestMapping(value="/deleteMyNewsComment", method = RequestMethod.POST)
    @ResponseBody
    public  String deleteMyNewsComment(NewsComment newsComment, HttpServletRequest request, HttpServletResponse response)throws ParseException {

        Map<String, Object> rMap = new HashMap<>();

        User user = getUser(request);
        if(user == null){
            rMap.put("msg","未登录");
            rMap.put("status", ReturnInfoType.FAIL);
            return toJSONString(rMap);
        }
        int res = newsCommentService.deleteByPrimaryKey(newsComment.getId());
        if(res > 0){
            rMap.put("msg","删除成功");
            rMap.put("status", ReturnInfoType.SUCEEESS);
        }else{
            rMap.put("msg","删除失败");
            rMap.put("status", ReturnInfoType.FAIL);
        }

        return toJSONString(rMap);
    }

    /**
     * 个人中心 --> 论坛 --> 我的评论(网页端)
     * @param pageNum
     * @param request
     * @param response
     * @return
     * @throws ParseException
     */
    @RequestMapping(value="/myForumCommentList", method = RequestMethod.GET)
    @ResponseBody
    public  String myForumCommentList(Integer pageNum, HttpServletRequest request, HttpServletResponse response)throws ParseException {

        Map<String, Object> rMap = new HashMap<String, Object>();

        User user = getUser(request);
        if(user == null){
            rMap.put("msg","未登录");
            rMap.put("status", ReturnInfoType.FAIL);
            return toJSONString(rMap);
        }

        // 此处查询需要自行编写
        com.github.pagehelper.PageHelper.startPage(getPageNum2(pageNum),pageSize);
        //lists 的数据为表t_comment和表t_toconmment的总合
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("uId",user.getId());
        List<Comment> lists = commentService.selectList(param);
        PageInfo<Comment> p2 = new PageInfo<Comment>(lists);
        rMap.put("pageNum", p2.getPageNum()); //  当前页
        rMap.put("pages", p2.getPages()); //  总页数
        rMap.put("nextPage", p2.getNextPage()); // 下一页
        rMap.put("prePage", p2.getPrePage()); // 上一页
        rMap.put("data", p2.getList()); // 数据集合
        rMap.put("count", p2.getTotal()); // 总行数
        PageHelper.clearPage(); // 如果开启分页，必须调用清除

        return toJSONString(rMap);
    }

    /**
     *  个人中心 --> 论坛 --> 我的评论 删除 (网页端)
     * @param comment
     * @return
     */
    @RequestMapping(value = "/deleteMyForumComment",method = RequestMethod.POST)
    @ResponseBody
    public String delete(Comment comment){
        Map<String,Object> rMap = new HashMap<>();
        //pid为空则为评论表的数据，不为空则为回复表的数据
        int res = 0;
        if (comment.getPid() == null){
            res = commentService.deleteByPrimaryKey(comment.getId());
        }else{
            res = toconmmentService.deleteByPrimaryKey(comment.getId());
        }
        if(res>0){
            rMap.put("msg","操作成功");
            rMap.put("status",1);
        }else{
            rMap.put("msg","操作失败");
            rMap.put("status",0);
        }
        return toJSONString(rMap);
    }

    /**
     * 公众号支付(小博士报订阅调用此接口)
     */
    @RequestMapping(value = "/gzhPay", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String webPay(xbsbs xbsb, HttpServletRequest request, HttpServletResponse response) {
        HashMap<String, Object> cmap = new HashMap<>();
        System.out.println("----- pay start-----");
        System.out.println("xbsb  === "+xbsb.toString());
        String order_info = "";// 订单信息 商品名称及数量
        // String jsonstr =
        // "[{\"pid\":\"b2bb81f813ef11e99250309c23895828\",\"id_\":1,\"num\":2},{\"id\":\"d11b710413e711e99250309c23895828\",\"id_\":1,\"num\":3}]";
        Boolean flag = false;

        String code = xbsb.getPassword();// 兑换码
        System.out.println(code);
        if (code != null && !code.equals("")) {
            code code2 = codeService.selectByPassword(code);
            if (code2 == null) {
                cmap.put("msg", "兑换码错误");
                cmap.put("status", ReturnInfoType.FAIL);
                return toJSONString(cmap);
            }
            if (code2.getStatus() == 1) {
                cmap.put("msg", "兑换码已经使用过");
                cmap.put("status", ReturnInfoType.FAIL);
                return toJSONString(cmap);
            } else {
                flag = true;
            }
        }

        List<Object> list = JSONObject.parseArray(xbsb.getGoods(), Object.class);
        BigDecimal total = new BigDecimal(0);// 总价初始化
        try {
            for (int i = 0; i < list.size(); i++) {
                JSONObject data = JSONObject.parseObject(list.get(i).toString());
                String id = data.getString("pid");
                String id_ = data.getString("id_");
                Integer num = data.getInteger("num");
                System.out.println(id + " " + id_ + " " + num);
                Product product = productService.selectByPrimaryKey(id);
                List<specifications> List = JSON.parseArray(product.getSpecifications(), specifications.class);
                for (int j = 0; j < List.size(); j++) {
                    specifications specifications = List.get(j);
//                    System.out.println("******11----------  id_ = " + id_);
//                    System.out.println("******22---------- specifications id_ = " + specifications.getId_());
                    if (id_.equals((specifications.getId_() + ""))) {
                        order_info += specifications.getName() + "x" + num + " ";// 订单信息
                        // 商品名称及数量
                        total = total.add(
                                specifications.getPrice().multiply(new BigDecimal(num).multiply(new BigDecimal(100))));// 总价
                        break;
                    }
                }
            }
        } catch (Exception e) {
            Map<String, Object> map = new HashMap<>();
            map.put("status", ReturnInfoType.FAIL);
            map.put("msg", "参数错误");
            return toJSONString(map);
        }

        System.out.println(" -------- 总价 = "+ total);
        xbsb.setIsover(0);
        xbsb.setCreatetime(new Date());
        xbsb.setCode(order_info);
        if (flag) {// 如果使用了兑换码则扣除100元
            total = total.subtract(new BigDecimal("10000"));
            BigDecimal wxtotal = total.divide(new BigDecimal(100));
            xbsb.setCode(" 兑换码支付:100元,微信支付:" + wxtotal + "元," + order_info);
        } else {
            BigDecimal wxtotal = total.divide(new BigDecimal(100));
            xbsb.setCode(" 微信支付:" + wxtotal + "元," + order_info);
        }
        xbsbsService.insert(xbsb);// 添加待支付订单
        BigInteger order_total = total.toBigInteger();// 最终价格
        System.out.println(" -------- 最终价格 = "+ order_total);
        //获取用户的code
        String code1 = request.getParameter("code");
        System.out.println("--------------获取用户的code = "+code1);
        //openid
        String openId = null;
        try {
            List<Object> list1 = accessToken(code1);
            openId = list1.get(1).toString();
        } catch (IOException e) {
            Map<String, Object> map = new HashMap<>();
            map.put("status", ReturnInfoType.FAIL);
            map.put("msg", "openid获取错误");
            return toJSONString(map);
        }
        //openid可以通过网页授权获取存到session中从而获取，IJPay是这样做的，我是另一种方式
		 /*openId，采用 网页授权获取 access_token API：SnsAccessTokenApi获取
		String openId = (String) request.getSession().getAttribute("openId");*/
        System.out.println("--------------获取 openId = "+openId);
        System.out.println("--------------获取 (body length)order_info = "+order_info);
        if (StrKit.isBlank(openId)) {
            Map<String, Object> map = new HashMap<>();
            map.put("status", ReturnInfoType.FAIL);
            map.put("msg", "openid获取错误");
            return toJSONString(map);
        }
        String ip = getIp.getIpAddr2(request);
        WxPayApiConfigKit.putApiConfig(getApiConfig());
        Map<String, String> params = WxPayApiConfigKit.getWxPayApiConfig()
                .setAttach(xbsb.getId() + "")
//                .setBody(order_info)      //微信支付body最大长度为128，当order_info超过128时支付会报错
                .setBody("小博士报订阅")  //暂时用此来代替 order_info 字符串，解决多个商品一起下单时order_info长度超过128字符
                .setOpenId(openId)
                .setSpbillCreateIp(ip)
                .setTotalFee(order_total.toString())
                .setTradeType(WxPayApi.TradeType.JSAPI)
                .setNotifyUrl(notify_url)
                .setOutTradeNo(String.valueOf(System.currentTimeMillis()))
                .build();
        String xmlResult = WxPayApi.pushOrder(false, params);
        log.info(xmlResult);
        Map<String, String> resultMap = PaymentKit.xmlToMap(xmlResult);

        String return_code = resultMap.get("return_code");
        String return_msg = resultMap.get("return_msg");
        if (!PaymentKit.codeIsOK(return_code)) {
            Map<String, Object> map = new HashMap<>();
            map.put("status", ReturnInfoType.FAIL);
            map.put("msg", "参数获取错误");
            return toJSONString(map);
        }
        String result_code = resultMap.get("result_code");
        if (!PaymentKit.codeIsOK(result_code)) {
            Map<String, Object> map = new HashMap<>();
            map.put("status", ReturnInfoType.FAIL);
            map.put("msg", "参数获取错误");
            return toJSONString(map);
        }
        // 以下字段在return_code 和result_code都为SUCCESS的时候有返回
        String prepay_id = resultMap.get("prepay_id");
        String timeStamp = String.valueOf(System.currentTimeMillis() / 1000);
        String nonce_str = String.valueOf(System.currentTimeMillis());
        String packages = "prepay_id=" + prepay_id;
        Map<String, String> packageParams = new HashMap<String, String>();
        packageParams.put("appId", appID);
        packageParams.put("timeStamp", timeStamp);
        packageParams.put("nonceStr", nonce_str);
        packageParams.put("package", "prepay_id=" + prepay_id);
        packageParams.put("signType", "MD5");
        String packageSign = PaymentKit.createSign(packageParams, WxPayApiConfigKit.getWxPayApiConfig().getPaternerKey());
        packageParams.put("paySign", packageSign);
        //下面可以通过Map传入参数获取json字符串，其形式和上面一样，传到前台可以转为json形式再用，也是一个不错的方式，可以参考IJPay
		/*Map<String, String> packageParams = PaymentKit.prepayIdCreateSign(prepay_id);
		String jsonStr = JSON.toJSONString(packageParams);
		mv.addObject("jsonStr",jsonStr);*/
		/*mv.addObject("appid",  appID);
		mv.addObject("timeStamp", timeStamp);
		mv.addObject("nonceStr", nonce_str);
		mv.addObject("packageValue", packages);
		mv.addObject("paySign", packageSign);
		mv.addObject("success","ok");
		mv.setViewName("pay");*/
        Map<String, Object> map = new HashMap<>();
        map.put("ip", ip);
        map.put("data", packageParams);
        map.put("status", ReturnInfoType.SUCEEESS);
        map.put("msg", "");
        return toJSONString(map);
    }

    /**
     * 通过微信用户的code换取网页授权access_token
     *
     * @return
     * @throws IOException
     * @throws
     */
    public List<Object> accessToken(String code) throws IOException {
        List<Object> list = new ArrayList<Object>();
        String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="
                + appID + "&secret=" + secret + "&code=" + code + "&grant_type=authorization_code";
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);
        HttpResponse res = client.execute(post);
        if (res.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
            HttpEntity entity = res.getEntity();
            String str = EntityUtils.toString(entity, "utf-8");
            ObjectMapper mapper = new ObjectMapper();
            Map<String, Object> jsonOb = mapper.readValue(str, Map.class);
            list.add(jsonOb.get("access_token"));
            list.add(jsonOb.get("openid"));
        }
        return list;
    }
}
