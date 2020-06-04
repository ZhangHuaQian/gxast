package com.cen.newsVerifty.controller;

import com.cen.NewsVerifyLog.entity.NewsVerifyLog;
import com.cen.NewsVerifyLog.service.NewsVerifyLogService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ResData;
import com.cen.common.util.ReturnInfoType;
import com.cen.dictionary.service.DictionaryService;
import com.cen.loopphoto.entity.Loopphoto;
import com.cen.loopphoto.service.LoopphotoService;
import com.cen.news.entity.BaseNewsEntity;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;
import com.cen.newsVerifty.entity.NewsVerifty;
import com.cen.newsVerifty.entity.VeriftyNewType;
import com.cen.newsVerifty.service.NewsVeriftyService;
import com.cen.newsVeriftyUser.entity.NewsVeriftyUser;
import com.cen.newsVeriftyUser.service.NewsVeriftyUserService;
import com.cen.news_axhd.entity.NewsAxhd;
import com.cen.news_axhd.service.NewsAxhdService;
import com.cen.news_zzgk.entity.NewsZzgk;
import com.cen.news_zzgk.service.NewsZzgkService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.cen.upms.entity.Department;
import com.cen.upms.service.DepartmentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional
@Controller
@RequestMapping("/newsVerifty")
public class NewsVeriftyController extends BaseController {
    public SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    NewsVeriftyService<NewsVerifty> newsVeriftyService;
    @Autowired
    NewsVeriftyUserService<NewsVeriftyUser> newsVeriftyUserService;
    @Autowired
    NewsService newsService;
    @Autowired
    NewsZzgkService newsZzgkService;
    @Autowired
    NewsAxhdService newsAxhdService;
    @Autowired
    DepartmentService departmentService;
    @Autowired
    UserService userService;
    @Autowired
    DictionaryService dictionaryService;

    @Autowired
    LoopphotoService loopphotoService;
    @Autowired
    private NewsVerifyLogService<NewsVerifyLog> newsVerifyLogService;


    /**
    * 添加
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/insert",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String insert(NewsVerifty newsVerifty,HttpServletRequest request,HttpServletResponse response){
        int res = newsVeriftyService.insertSelective(newsVerifty);
        return res>=1?ResData.SUCCESS().toString():ResData.FAIL().toString();
    }

    /**
    * 删除
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/delete",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String delete(Integer id,HttpServletRequest request,HttpServletResponse response){
        int res = newsVeriftyService.deleteByPrimaryKey(id);
        return res>=1?ResData.SUCCESS().toString():ResData.FAIL().toString();
    }

    /**
    * 更新
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/update",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String update(NewsVerifty newsVerifty,HttpServletRequest request,HttpServletResponse response){
        int res = newsVeriftyService.updateByPrimaryKeySelective(newsVerifty);
        return res>=1?ResData.SUCCESS().toString():ResData.FAIL().toString();
    }

    /**
    * 查询
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/select",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String select(Integer id,HttpServletRequest request,HttpServletResponse response){
        NewsVerifty res = newsVeriftyService.selectByPrimaryKey(id);
        return ResData.SUCCESS(res).toString();
    }

    /**
    * 分页查询列表
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/selectList",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectList(NewsVerifty newsVerifty,Integer pageNum,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> paramMap = MapUtils.beanToMap(newsVerifty);
        // 此处查询需要自行编写
        PageHelper.startPage(getPageNum2(pageNum),pageSize);
        List<NewsVerifty> lists = newsVeriftyService.selectList(paramMap);
        PageInfo<NewsVerifty>  p2 = new PageInfo<NewsVerifty>(lists);
        rMap.put("pageNum", p2.getPageNum()); //  当前页
        rMap.put("pages", p2.getPages()); //  总页数
        rMap.put("nextPage", p2.getNextPage()); // 下一页
        rMap.put("prePage", p2.getPrePage()); // 上一页
        rMap.put("data", p2.getList()); // 数据集合
        rMap.put("count", p2.getTotal()); // 总行数
        PageHelper.clearPage(); // 如果开启分页，必须调用清除
        return ResData.SUCCESS(rMap).toString();
    }

    /**
     * 跳转一审页面
     *
     * @param id
     * @param newsType 资讯类型
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/toFirstVerifty", method = RequestMethod.GET)
    public String toFirstVerifty(Integer id,String newsType, HttpServletRequest request, HttpServletResponse response) {
        BaseNewsEntity news = new BaseNewsEntity();
        switch (newsType){
            case "news":
                news = newsService.selectByPrimaryKey(id);
                request.setAttribute("typename", VeriftyNewType.NEWS.typename);
                request.setAttribute("newTypeValue", dictionaryService.selectByValue(news.getNewTypeId().toString()).getName());
                break;
            case "axhd":
                news = newsAxhdService.selectByPrimaryKey(id);
                request.setAttribute("typename", VeriftyNewType.AXHD.typename);
                request.setAttribute("newTypeValue", dictionaryService.selectByValue(news.getNewTypeId().toString()).getName());
                break;
            case "zzgk":
                news = newsZzgkService.selectByPrimaryKey(id);
                request.setAttribute("typename", VeriftyNewType.ZZGK.typename);
                request.setAttribute("newTypeValue", dictionaryService.selectByValue(news.getNewTypeId().toString()).getName());
                break;
        }
        request.setAttribute("news", news);
        request.setAttribute("newsType", newsType);
        request.setAttribute("createTime", format2.format(news.getCreateTime()));
        return "sys/newVerifty/firstVerifty";
    }

    /**
     * 资讯一审处理，需要做如下几个工作：
     * 1.更改资讯的审核状态
     * 2.记录操作结果
     * 3.把作者的投递设为已处理，并创建一条审核记录，写入审核评语，发给对应的人
     * @param id  资讯id
     * @param verifty  审批结果
     * @param remark  批注
     * @param request
     * @param verifty2User 二审人员id
     * @return
     */
    @RequestMapping(value = "/firstVerifty",method = RequestMethod.POST)
    @ResponseBody
    public String firstVerifty(Integer id,String newsType,String verifty,String remark,String verifty2User,HttpServletRequest request){
        Map rMap = new HashMap();
        try{
            User user = getUser(request);
            if(!isEmpty(user)){
                Department myDepartment = departmentService.selectByPrimaryKey(Integer.valueOf(user.getDid()));
                int result1,result2,result3,result4 = 0;
                switch (newsType){
                    case "news":
                        News news = new News();
                        news.setId(id);
                        news.setVerifty(verifty);
                        result1 = newsService.updateByPrimaryKeySelective(news);
                        break;
                    case "axhd":
                        NewsAxhd newsAxhd = new NewsAxhd();
                        newsAxhd.setId(id);
                        newsAxhd.setVerifty(verifty);
                        result1 = newsAxhdService.updateByPrimaryKeySelective(newsAxhd);
                        break;
                    case "zzgk":
                        NewsZzgk newsZzgk = new NewsZzgk();
                        newsZzgk.setId(id);
                        newsZzgk.setVerifty(verifty);
                        result1 = newsZzgkService.updateByPrimaryKeySelective(newsZzgk);
                        break;
                    default:
                        rMap.put("msg", "资讯一审失败，资讯类型不支持");
                        rMap.put("status", ReturnInfoType.FAIL);
                        return toJSONString(rMap);
                }
                NewsVerifty newsVerifty = new NewsVerifty();
                newsVerifty.setNewId(id);
                newsVerifty.setNewType(newsType);
                newsVerifty.setCreateTime(new Date());
                newsVerifty.setReceiverId(user.getId());
                newsVerifty.setReceiver(user.getName());
                newsVerifty.setReceiverDepartmentId(Integer.valueOf(myDepartment.getId()));
                newsVerifty.setReceiverDepartment(myDepartment.getName());
                newsVerifty.setProcess("资讯一审");
                newsVerifty.setVerifty(verifty);
                result2 = newsVeriftyService.insertSelective(newsVerifty);

                //把我审核的设为已处理
                NewsVeriftyUser newsVeriftyUser = new NewsVeriftyUser();
                newsVeriftyUser.setNewsId(id);
                newsVeriftyUser.setNewType(newsType);
                newsVeriftyUser.setReceiverId(user.getId());
                newsVeriftyUser.setReceiverDepartmentId(Integer.valueOf(user.getDid()));
                newsVeriftyUser.setStatus("0");
                List<NewsVeriftyUser> newsVeriftyUsers = newsVeriftyUserService.selectCanVeriftyList(MapUtils.beanToMap(newsVeriftyUser));
                NewsVeriftyUser newsVeriftyUser1 = newsVeriftyUsers.get(0);

                //将所有状态为0的全部设为1
                if(newsVeriftyUsers.size()>0){
                    for(NewsVeriftyUser nvu : newsVeriftyUsers) {
                        nvu.setStatus("1");
                        nvu.setReceiver(user.getName());
                        nvu.setReceiverId(user.getId());
                        result3 = newsVeriftyUserService.updateByPrimaryKeySelective(nvu);
                    }
                }

                //新加一条发给二审或者作者的事务
                NewsVeriftyUser newsVeriftyUser2 = new NewsVeriftyUser();
                newsVeriftyUser2.setNewsId(id);
                newsVeriftyUser2.setNewType(newsType);
                newsVeriftyUser2.setCreateTime(new Date());
                newsVeriftyUser2.setInitiatorId(user.getId());
                newsVeriftyUser2.setInitiator(user.getName());
                if(!isEmpty(myDepartment)) {
                    newsVeriftyUser2.setInitiatorDepartmentId(Integer.valueOf(myDepartment.getId()));
                    newsVeriftyUser2.setInitiatorDepartment(myDepartment.getName());
                }


                //保存操作记录
                NewsVerifyLog newsVerifyLog = new NewsVerifyLog();
                newsVerifyLog.setNewsId(id);
                newsVerifyLog.setNewsType(newsType);
                newsVerifyLog.setCreateTime(new Date());
                newsVerifyLog.setReceiverId(user.getId());

                //1通过 6回驳
                if(verifty.equals("1")){
                    //发给二审
                    User veriftor2 = new User();
                    //如果没有指定审核人员
                    if(isEmpty(verifty2User)){

                        //ps:不指定谁来审核，而是同部门任何具备审核资格的都可以审核
                        String did = user.getDid();
                        Department verift2Department = departmentService.selectByPrimaryKey(Integer.valueOf(did));
                        newsVeriftyUser2.setReceiverDepartmentId(Integer.valueOf(verift2Department.getId()));
                        newsVeriftyUser2.setReceiverDepartment(verift2Department.getName());
                    }else {
                        veriftor2 = userService.selectByPrimaryKey(verifty2User);
                        Department veriftDepartment = departmentService.selectByPrimaryKey(Integer.valueOf(veriftor2.getDid()));
                        newsVeriftyUser2.setReceiverId(veriftor2.getId());
                        newsVeriftyUser2.setReceiver(veriftor2.getName());
                        newsVeriftyUser2.setReceiverDepartmentId(Integer.valueOf(veriftDepartment.getId()));
                        newsVeriftyUser2.setReceiverDepartment(veriftDepartment.getName());
                    }
                    newsVeriftyUser2.setProcess("资讯投递二审");
                    newsVeriftyUser2.setStatus("0");
                    newsVeriftyUser2.setRemark(remark);

                    newsVerifyLog.setStatus("一审通过，等待二审");
                    newsVerifyLog.setRemark(remark);
                }else {
                    //发给作者
                    newsVeriftyUser2.setReceiverId(newsVeriftyUser1.getInitiatorId());
                    newsVeriftyUser2.setReceiver(newsVeriftyUser1.getInitiator());
                    newsVeriftyUser2.setReceiverDepartmentId(newsVeriftyUser1.getInitiatorDepartmentId());
                    newsVeriftyUser2.setReceiverDepartment(newsVeriftyUser1.getInitiatorDepartment());
                    newsVeriftyUser2.setProcess("资讯回退");
                    newsVeriftyUser2.setStatus("0");
                    newsVeriftyUser2.setRemark(remark);

                    newsVerifyLog.setStatus("一审不通过，资讯回退");
                    newsVerifyLog.setRemark(remark);
                }
                result4 = newsVeriftyUserService.insertSelective(newsVeriftyUser2);
                newsVerifyLogService.insertSelective(newsVerifyLog);

                if (result1*result2*result4 == 0) {
                    rMap.put("msg", "资讯一审失败");
                    rMap.put("status", ReturnInfoType.FAIL);
                } else {
                    rMap.put("msg", "资讯一审成功");
                    rMap.put("status", ReturnInfoType.SUCEEESS);
                }
                return toJSONString(rMap);
            }else {
                rMap.put("msg", "请先登录");
                rMap.put("status", ReturnInfoType.FAIL);
                return toJSONString(rMap);
            }
        }catch (Exception e){
            e.printStackTrace();
            rMap.put("status", ReturnInfoType.ERROR);
            rMap.put("msg", "exception:" + e.getClass() + "," + e.getMessage()); //  错误信息
            return toJSONString(rMap);
        }
    }


    /**
     * 跳转二审页面
     * 一审批注在news_verifty_user中
     * @param id
     * @param newsType 资讯类型
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/toSecondVerifty", method = RequestMethod.GET)
    public String toSecondVerifty(Integer id, String newsType, HttpServletRequest request, HttpServletResponse response) {
        User user = getUser(request);
        BaseNewsEntity news = new BaseNewsEntity();
        switch (newsType){
            case "news":
                news = newsService.selectByPrimaryKey(id);
                request.setAttribute("typename", VeriftyNewType.NEWS.typename);
                request.setAttribute("newTypeValue", dictionaryService.selectByValue(news.getNewTypeId().toString()).getName());
                break;
            case "axhd":
                news = newsAxhdService.selectByPrimaryKey(id);
                request.setAttribute("typename", VeriftyNewType.AXHD.typename);
                request.setAttribute("newTypeValue", dictionaryService.selectByValue(news.getNewTypeId().toString()).getName());
                break;
            case "zzgk":
                news = newsZzgkService.selectByPrimaryKey(id);
                request.setAttribute("typename", VeriftyNewType.ZZGK.typename);
                request.setAttribute("newTypeValue", dictionaryService.selectByValue(news.getNewTypeId().toString()).getName());
                break;
        }

        NewsVeriftyUser newsVeriftyUser = new NewsVeriftyUser();
        newsVeriftyUser.setNewsId(id);
        newsVeriftyUser.setNewType(newsType);
        newsVeriftyUser.setReceiverId(user.getId());
        newsVeriftyUser.setReceiverDepartmentId(Integer.valueOf(user.getDid()));
        newsVeriftyUser.setStatus("0");
        newsVeriftyUser.setProcess("资讯投递二审");
        List<NewsVeriftyUser> newsVeriftyUsers = newsVeriftyUserService.selectCanVeriftyList(MapUtils.beanToMap(newsVeriftyUser));
        if(newsVeriftyUsers.size()>0) {
            NewsVeriftyUser newsVeriftyUser1 = newsVeriftyUsers.get(0);
            request.setAttribute("newsVeriftyUser", newsVeriftyUser1);
        }
        request.setAttribute("newsType", newsType);
        request.setAttribute("news", news);
        request.setAttribute("createTime", format2.format(news.getCreateTime()));
        return "sys/newVerifty/secondVerifty";
    }

    /**
     * 资讯二审处理，需要做如下几个工作：
     * 1.更改资讯的审核状态
     * 2.记录操作结果
     * 3.把作者的投递设为已处理，并创建一条审核记录，写入审核评语，发给对应的人
     * @param id  资讯id
     * @param verifty  审批结果
     * @param remark  批注
     * @param request
     * @param verifty2User 二审人员id
     * @return
     */
    @RequestMapping(value = "/secondVerifty",method = RequestMethod.POST)
    @ResponseBody
    public String secondVerifty(Integer id,String newsType,String verifty,String remark,String nvuId,String verifty2User,HttpServletRequest request){
        Map rMap = new HashMap();
        try {
            User user = getUser(request);
            if(!isEmpty(user)) {
                Department myDepartment = departmentService.selectByPrimaryKey(Integer.valueOf(user.getDid()));
                int result1,result2,result3,result4 = 0;

                News news = null;
                NewsAxhd newsAxhd = null;
                NewsZzgk newsZzgk = null;

                BaseNewsEntity newsEntity = new BaseNewsEntity();
                switch (newsType){
                    case "news":
                        news = newsService.selectByPrimaryKey(id);
                        //news.setId(id);
                        news.setVerifty(verifty);
                        result1 = newsService.updateByPrimaryKeySelective(news);
                        newsEntity = news;
                        break;
                    case "axhd":
                        newsAxhd = newsAxhdService.selectByPrimaryKey(id);
                        //newsAxhd.setId(id);
                        newsAxhd.setVerifty(verifty);
                        result1 = newsAxhdService.updateByPrimaryKeySelective(newsAxhd);
                        newsEntity = newsAxhd;
                        break;
                    case "zzgk":
                        newsZzgk = newsZzgkService.selectByPrimaryKey(id);
                        //newsZzgk.setId(id);
                        newsZzgk.setVerifty(verifty);
                        result1 = newsZzgkService.updateByPrimaryKeySelective(newsZzgk);
                        newsEntity = newsZzgk;
                        break;
                    default:
                        rMap.put("msg", "资讯二审失败，资讯类型不支持");
                        rMap.put("status", ReturnInfoType.FAIL);
                        return toJSONString(rMap);
                }

                NewsVerifty newsVerifty = new NewsVerifty();
                newsVerifty.setNewId(id);
                newsVerifty.setNewType(newsType);
                newsVerifty.setCreateTime(new Date());
                newsVerifty.setReceiverId(user.getId());
                newsVerifty.setReceiver(user.getName());
                newsVerifty.setReceiverDepartmentId(Integer.valueOf(myDepartment.getId()));
                newsVerifty.setReceiverDepartment(myDepartment.getName());
                newsVerifty.setProcess("资讯二审");
                newsVerifty.setVerifty(verifty);
                result2 = newsVeriftyService.insertSelective(newsVerifty);

                //事务更新为已处理
                NewsVeriftyUser newsVeriftyUser = new NewsVeriftyUser();
                newsVeriftyUser.setUuid(nvuId);
                newsVeriftyUser.setReceiver(user.getName());
                newsVeriftyUser.setReceiverId(user.getId());
                newsVeriftyUser.setStatus("1");
                result3 = newsVeriftyUserService.updateByPrimaryKeySelective(newsVeriftyUser);


                //添加一条发给作者的事务
                NewsVeriftyUser newsVeriftyUser2 = new NewsVeriftyUser();
                newsVeriftyUser2.setNewsId(id);
                newsVeriftyUser2.setNewType(newsType);
                newsVeriftyUser2.setCreateTime(new Date());
                newsVeriftyUser2.setInitiatorId(user.getId());
                newsVeriftyUser2.setInitiator(user.getName());
                if (!isEmpty(myDepartment)) {
                    newsVeriftyUser2.setInitiatorDepartmentId(Integer.valueOf(myDepartment.getId()));
                    newsVeriftyUser2.setInitiatorDepartment(myDepartment.getName());
                }
                User author = userService.selectByPrimaryKey(newsEntity.getUserId());
                Department veriftDepartment = departmentService.selectByPrimaryKey(Integer.valueOf(author.getDid()));
                newsVeriftyUser2.setReceiverId(author.getId());
                newsVeriftyUser2.setReceiver(author.getName());
                newsVeriftyUser2.setReceiverDepartmentId(Integer.valueOf(veriftDepartment.getId()));
                newsVeriftyUser2.setReceiverDepartment(veriftDepartment.getName());
                newsVeriftyUser2.setStatus("0");
                newsVeriftyUser2.setRemark(remark);

                //保存操作记录
                NewsVerifyLog newsVerifyLog = new NewsVerifyLog();
                newsVerifyLog.setNewsId(id);
                newsVerifyLog.setNewsType(newsType);
                newsVerifyLog.setCreateTime(new Date());
                newsVerifyLog.setReceiverId(user.getId());

                //5通过 6回驳
                if (verifty.equals("5")) {
                    newsVeriftyUser2.setProcess("二审通过");

                    newsVerifyLog.setStatus("二审通过");
                    newsVerifyLog.setRemark(remark);

                    //推荐图位 新闻中心
                    if(newsType.equals("news")){
                        Loopphoto loopphoto = loopphotoService.selectByNewsTypeAndNewsId("news", id);
                        if(loopphoto != null){
                            loopphoto.setVerify(1); //审核通过
                            loopphoto.setModifyTime(new Date());
                            int i = loopphotoService.updateByPrimaryKeySelective(loopphoto);
                        }
                    }
                    //推荐图位 党建工作  NewsAxhd newsAxhd = null;
                    else if(newsType.equals("axhd")){
                        Loopphoto loopphoto = loopphotoService.selectByNewsTypeAndNewsId("news_axhd", id);
                        if(loopphoto != null){
                            loopphoto.setVerify(1); //审核通过
                            loopphoto.setModifyTime(new Date());
                            int i = loopphotoService.updateByPrimaryKeySelective(loopphoto);
                        }
                    }
                    //推荐图位 政务公开  NewsZzgk newsZzgk = null;
                    else if(newsType.equals("zzgk") && newsZzgk.getRecommend() != null && !newsZzgk.getRecommend().equals("") && newsZzgk.getRecommendImg() != null && !newsZzgk.getRecommendImg().equals("")){
                        Loopphoto loopphoto = loopphotoService.selectByNewsTypeAndNewsId("news_zzgk", id);
                        if(loopphoto != null){
                            loopphoto.setVerify(1); //审核通过
                            loopphoto.setModifyTime(new Date());
                            int i = loopphotoService.updateByPrimaryKeySelective(loopphoto);
                        }
                    }

                } else {
                    newsVeriftyUser2.setProcess("资讯回退");

                    newsVerifyLog.setStatus("二审不通过，资讯回退");
                    newsVerifyLog.setRemark(remark);
                }
                result4 = newsVeriftyUserService.insertSelective(newsVeriftyUser2);
                newsVerifyLogService.insertSelective(newsVerifyLog);
                if (result1*result2*result3*result4 == 0) {
                    rMap.put("msg", "资讯二审失败");
                    rMap.put("status", ReturnInfoType.FAIL);
                } else {
                    rMap.put("msg", "资讯二审成功");
                    rMap.put("status", ReturnInfoType.SUCEEESS);
                }
                return toJSONString(rMap);
            }else {
                rMap.put("msg", "请先登录");
                rMap.put("status", ReturnInfoType.FAIL);
                return toJSONString(rMap);
            }
        }catch (Exception e){
            e.printStackTrace();
            rMap.put("status", ReturnInfoType.ERROR);
            rMap.put("msg", "exception:" + e.getClass() + "," + e.getMessage()); //  错误信息
            return toJSONString(rMap);
        }
    }

}