package com.cen.newsVeriftyUser.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;

import com.cen.common.util.ResData;
import com.cen.news.entity.BaseNewsEntity;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;
import com.cen.newsVerifty.entity.VeriftyNewType;
import com.cen.newsVeriftyUser.entity.NewsVeriftyUser;
import com.cen.newsVeriftyUser.service.NewsVeriftyUserService;
import com.cen.news_axhd.entity.NewsAxhd;
import com.cen.news_axhd.service.NewsAxhdService;
import com.cen.news_zzgk.entity.NewsZzgk;
import com.cen.news_zzgk.service.NewsZzgkService;
import com.cen.ucenter.entity.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@RequestMapping("/newsVeriftyUser")
public class NewsVeriftyUserController extends BaseController {

    @Autowired
    NewsVeriftyUserService<NewsVeriftyUser> newsVeriftyUserService;
    @Autowired
    NewsService newsService;
    @Autowired
    NewsAxhdService newsAxhdService;
    @Autowired
    NewsZzgkService newsZzgkService;

    /**
    * 添加
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/insert",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String insert(NewsVeriftyUser newsVeriftyUser,HttpServletRequest request,HttpServletResponse response){
        int res = newsVeriftyUserService.insertSelective(newsVeriftyUser);
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
        int res = newsVeriftyUserService.deleteByPrimaryKey(id);
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
    public String update(NewsVeriftyUser newsVeriftyUser,HttpServletRequest request,HttpServletResponse response){
        int res = newsVeriftyUserService.updateByPrimaryKeySelective(newsVeriftyUser);
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
    public String select(String id,HttpServletRequest request,HttpServletResponse response){
        NewsVeriftyUser res = newsVeriftyUserService.selectByPrimaryKey(id);
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
    public String selectList(NewsVeriftyUser newsVeriftyUser,Integer pageNum,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> paramMap = MapUtils.beanToMap(newsVeriftyUser);
        // 此处查询需要自行编写
        PageHelper.startPage(getPageNum2(pageNum),pageSize);
        List<NewsVeriftyUser> lists = newsVeriftyUserService.selectList(paramMap);
        PageInfo<NewsVeriftyUser>  p2 = new PageInfo<NewsVeriftyUser>(lists);
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
     * 分页查询需要我一审的列表
     * 先去审核表news_verifty_user获取我没有处理的资讯id列表
     * 再通过这个列表去news表获取资讯列表返回给前端
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value="/selectMyFirstVeriftyList",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectMyFirstVeriftyList(BaseNewsEntity baseNewsEntity, Date date1, Date date2, Integer pageNum, HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        User user = getUser(request);


        //先去审核表news_verifty_user获取我没有处理的资讯id列表
        //获取指向我的以及 指向本部门但是没有指向任何人的
        NewsVeriftyUser newsVeriftyUser = new NewsVeriftyUser();
        newsVeriftyUser.setReceiverId(user.getId());
        newsVeriftyUser.setReceiverDepartmentId(Integer.valueOf(user.getDid()));
        newsVeriftyUser.setStatus("0");
        newsVeriftyUser.setProcess("资讯投递一审");
        Map<String, Object> newsVeriftyUserParamMap = MapUtils.beanToMap(newsVeriftyUser);
        newsVeriftyUserParamMap.put("start", date1);
        newsVeriftyUserParamMap.put("end", date2);
        PageHelper.startPage(getPageNum2(pageNum),pageSize);
        //获得待审核事务记录
        List<NewsVeriftyUser> newsVeriftyUsers = newsVeriftyUserService.selectCanVeriftyList(newsVeriftyUserParamMap);
        List<Map<String,Object>> newsIdsTypeMapList = new LinkedList<>();
        List<Map> lists = new LinkedList<>();
        //解析待审核事务，获得待审核资讯
        for(NewsVeriftyUser newsVeriftyUser1:newsVeriftyUsers){
            //Map<String,Object> newsIdsTypeMap = new HashMap<>();
            //newsIdsTypeMap.put("newsType",newsVeriftyUser1.getNewType());
            //newsIdsTypeMap.put("newsId",newsVeriftyUser1.getNewsId());
            //newsIdsTypeMapList.add(newsIdsTypeMap);
            Map<String,Object> map = new HashMap<>();
            switch (newsVeriftyUser1.getNewType()){
                case "news":
                    News news = newsService.selectByPrimaryKey(newsVeriftyUser1.getNewsId());
                    map = MapUtils.beanToMap(news);
                    map.put("newsType",VeriftyNewType.NEWS.type);
                    map.put("allTypeName",VeriftyNewType.NEWS.allTypeName);
                    lists.add(map);
                    break;
                case "axhd":
                    NewsAxhd newsAxhd = newsAxhdService.selectByPrimaryKey(newsVeriftyUser1.getNewsId());
                    map = MapUtils.beanToMap(newsAxhd);
                    map.put("newsType",VeriftyNewType.AXHD.type);
                    map.put("allTypeName",VeriftyNewType.AXHD.allTypeName);
                    lists.add(map);
                    break;
                case "zzgk":
                    NewsZzgk newsZzgk = newsZzgkService.selectByPrimaryKey(newsVeriftyUser1.getNewsId());
                    map = MapUtils.beanToMap(newsZzgk);
                    map.put("newsType",VeriftyNewType.ZZGK.type);
                    map.put("allTypeName",VeriftyNewType.ZZGK.allTypeName);
                    lists.add(map);
                    break;
            }
        }

        PageInfo<Map>  p2 = new PageInfo<Map>(lists);
        rMap.put("pageNum", p2.getPageNum()); //  当前页
        rMap.put("pages", p2.getPages()); //  总页数
        rMap.put("nextPage", p2.getNextPage()); // 下一页
        rMap.put("prePage", p2.getPrePage()); // 上一页
        rMap.put("data", p2.getList()); // 数据集合
        rMap.put("count", p2.getTotal()); // 总行数
        PageHelper.clearPage(); // 如果开启分页，必须调用清除
        return toJSONString(ResData.SUCCESS(rMap));
    }

    /**
     * 得需要改
     * 分页查询需要我二审的列表
     * 先去审核表news_verifty_user获取我没有处理的资讯id列表
     * 再通过这个列表去news表获取资讯列表返回给前端
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value="/selectMySecondVeriftyList",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectMySecondVeriftyList(BaseNewsEntity baseNewsEntity, Date date1, Date date2, Integer pageNum, HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        User user = getUser(request);


        //先去审核表news_verifty_user获取我没有处理的资讯id列表
        //获取指向我的以及 指向本部门但是没有指向任何人的
        NewsVeriftyUser newsVeriftyUser = new NewsVeriftyUser();
        newsVeriftyUser.setReceiverId(user.getId());
        newsVeriftyUser.setReceiverDepartmentId(Integer.valueOf(user.getDid()));
        newsVeriftyUser.setStatus("0");
        newsVeriftyUser.setProcess("资讯投递二审");
        Map<String, Object> newsVeriftyUserParamMap = MapUtils.beanToMap(newsVeriftyUser);
        // 此处查询需要自行编写
        newsVeriftyUserParamMap.put("start", date1);
        newsVeriftyUserParamMap.put("end", date2);
        //获得待审核事务记录
        List<NewsVeriftyUser> newsVeriftyUsers = newsVeriftyUserService.selectCanVeriftyList(newsVeriftyUserParamMap);
        List<Map> lists = new LinkedList<>();
        //解析待审核事务，获得待审核资讯
        for(NewsVeriftyUser newsVeriftyUser1:newsVeriftyUsers){
            Map<String,Object> map = new HashMap<>();
            switch (newsVeriftyUser1.getNewType()){
                case "news":
                    News news = newsService.selectByPrimaryKey(newsVeriftyUser1.getNewsId());
                    map = MapUtils.beanToMap(news);
                    map.put("newsType",VeriftyNewType.NEWS.type);
                    map.put("allTypeName",VeriftyNewType.NEWS.allTypeName);
                    lists.add(map);
                    break;
                case "axhd":
                    NewsAxhd newsAxhd = newsAxhdService.selectByPrimaryKey(newsVeriftyUser1.getNewsId());
                    map = MapUtils.beanToMap(newsAxhd);
                    map.put("newsType",VeriftyNewType.AXHD.type);
                    map.put("allTypeName",VeriftyNewType.AXHD.allTypeName);
                    lists.add(map);
                    break;
                case "zzgk":
                    NewsZzgk newsZzgk = newsZzgkService.selectByPrimaryKey(newsVeriftyUser1.getNewsId());
                    map = MapUtils.beanToMap(newsZzgk);
                    map.put("newsType",VeriftyNewType.ZZGK.type);
                    map.put("allTypeName",VeriftyNewType.ZZGK.allTypeName);
                    lists.add(map);
                    break;
            }
        }

        PageInfo<Map>  p2 = new PageInfo<Map>(lists);
        rMap.put("pageNum", p2.getPageNum()); //  当前页
        rMap.put("pages", p2.getPages()); //  总页数
        rMap.put("nextPage", p2.getNextPage()); // 下一页
        rMap.put("prePage", p2.getPrePage()); // 上一页
        rMap.put("data", p2.getList()); // 数据集合
        rMap.put("count", p2.getTotal()); // 总行数
        PageHelper.clearPage(); // 如果开启分页，必须调用清除
        return toJSONString(ResData.SUCCESS(rMap));
    }

}