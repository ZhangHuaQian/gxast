package com.cen.web.news.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;

import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.news_reply.entity.news_reply;
import com.cen.news_reply.service.news_replyService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by cenguocheng on 2019/1/8.
 * 137544496@qq.com
 */
@Controller
@RequestMapping("/web/news")
public class WebNewsController extends BaseController {

    @Autowired
    private NewsService newsService;
    @Autowired
    private NewsCommentService newsCommentService;
   @Autowired
   private news_replyService news_replyService;
    @Autowired
    private UserService userService;

    /**
     * 分页查询资讯
     * @param news
     * @param pageNum
     * @return
     */
    @RequestMapping(value="selectList")
    @ResponseBody
    public String selectList(News news, @RequestParam(value="pageNum",defaultValue="1",required=false) Integer pageNum, Integer pageSize, Integer newTypeId) {

        Map<String, Object> pmap = new HashMap<String, Object>();
        news.setVerifty("5");
        pmap = MapUtils.beanToMap(news);
        pmap.put("pageNum", getStart(pageNum,pageSize));
        pmap.put("pageSize", getPageSize(pageSize));
        pmap.put("newTypeId",newTypeId);
        List<News> list = newsService.selectList(pmap); //列表
        Map<String,Object> rMap = new HashMap<>();
        int count = newsService.selectListCount(pmap);  //记录行数
        rMap.put("list", list);
        rMap.put("count", count);
        rMap.put("pageNum", pageNum);

        return toJSONString(rMap);
    }

    /**
     * 跳转资讯页面
     * @param news
     * @param pageNum
     * @param pageSize
     * @param newTypeId
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value="toNewsList")
    public String toNewsList(News news, @RequestParam(value="pageNum",defaultValue="1",required=false) Integer pageNum, Integer pageSize, Integer newTypeId, HttpServletRequest request,
                             HttpServletResponse response, ModelMap map) {

        Map<String, Object> pmap = new HashMap<String, Object>();
        news.setVerifty("5");
        pmap = MapUtils.beanToMap(news);
        pmap.put("pageNum", getPageNum(pageNum));
        pmap.put("pageSize", getPageSize(pageSize));
        pmap.put("newTypeId",newTypeId);
        List<News> list = newsService.selectList(pmap); //列表
        int count = newsService.selectListCount(pmap);  //记录行数
//        System.out.println(list);
//        map.put("list", list);
        map.put("count", count);
        map.put("pageNum", pageNum);

        return "web/news/newsList";
    }



    /**
     * 查询资讯详情
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value="details/{id}")
    public String details(@PathVariable Integer id, HttpServletRequest request,
                          HttpServletResponse response, ModelMap map) {

        News news = newsService.selectByPrimaryKey(id);

        map.put("news", news);
        News news2  = new News();
        //浏览量
        news2.setId(id);
        if(news.getPage_view()==null){
            news.setPage_view(0);
        }
        news2.setPage_view(news.getPage_view()+1);
        
        newsService.updateByPrimaryKeySelective(news2);
        return "/web/news/details";

    }

    /**
     * 查询资讯详情
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value="webdetails/{id}")
    public String webdetails(@PathVariable Integer id, HttpServletRequest request,
                          HttpServletResponse response, ModelMap map) {

        News news = newsService.selectByPrimaryKey(id);

        map.put("news", news);
        News news2  = new News();
        //浏览量
        news2.setId(id);
        if(news.getPage_view()==null){
            news.setPage_view(0);
        }
        news2.setPage_view(news.getPage_view()+1);

        newsService.updateByPrimaryKeySelective(news2);
        return "/web/news/webdetails";

    }


    /*首页展示工作动态*/
    /**
     * @param
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value = "/selectNewsNum", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectNewsNum(Integer newTypeId,Integer pageNum,Integer pageSize,HttpServletRequest request, HttpServletResponse response, ModelMap map) {

        Map<String, Object> dmap = new HashMap<String, Object>();
        map.put("newTypeId",newTypeId);
        map.put("pageNum", (pageNum-1)*pageSize);
        map.put("pageSize", pageSize);
        List<News> news=newsService.selectNewsNum(map);
        dmap.put("list", news);
        return toJSONString(dmap);
    }



    /**
     * 返回登录状态
     * @param request
     * @param response
     * @return
     */

    @RequestMapping(value = "/islogin",method = RequestMethod.POST)
    @ResponseBody
    public String islogin(HttpServletRequest request, HttpServletResponse response) {
        User user=getUser(request);

        if (user==null) {
            return ReturnInfoType.ERROR;
        }else {
            return ReturnInfoType.SUCEEESS;
        }

    }


    /**
     * 提交评论
     * @param request
     * @param response
     */

    @RequestMapping(value = "/commitcomment",method = RequestMethod.POST,produces = "application/json; charset=utf-8")
    @ResponseBody
    public String commit_comment(String topic_type,HttpServletRequest request, HttpServletResponse response){
        User user=getUser(request);
        int id=Integer.valueOf(request.getParameter("id"));
        String content=request.getParameter("content");

//        System.out.println(content);
        if (user==null) {
            return ReturnInfoType.ERROR;
        }else {
            NewsComment news_comment=new NewsComment();
            news_comment.setTopicId(id);
            news_comment.setTopicType(topic_type);
            news_comment.setContent(content);
            news_comment.setFromUid(user.getId());
            User user1=userService.selectByPrimaryKey(news_comment.getFromUid());
            news_comment.setName(user1.getName());
            news_comment.setPhoto(user1.getPhoto());
            news_comment.setCommentstate("0");//0表示未审核
            news_comment.setTime(new Date());
            newsCommentService.insertSelective(news_comment);
            return ReturnInfoType.SUCEEESS;
        }
    }

    /**
     * 查询已审核的
     * @param id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/comment",method = RequestMethod.POST)
    @ResponseBody
    public String comment(int id,String topic_type,HttpServletRequest request, HttpServletResponse response) {
        User user=getUser(request);
        //查询评论已审核的
            Map<String, Object> map = new HashMap<String, Object>();
            Map<String,Object> paramMap = new HashMap<String,Object>();
            Map<String, Object> amap = new HashMap<String, Object>();
            Map<String, Object> bmap = new HashMap<String, Object>();

            paramMap.put("newsid",id);
            //paramMap.put("from_uid",user.getId());
            paramMap.put("topic_type",topic_type);
            List<NewsComment> news_comment=newsCommentService.article_comment(paramMap);
          for(NewsComment newsComment:news_comment){
               User user1=userService.selectByPrimaryKey(newsComment.getFromUid());
               newsComment.setName(user1.getName());
               newsComment.setPhoto(user1.getPhoto());
           }
            //查询该评论下的回复
            for(int i=0;i<news_comment.size();i++){
                int reply_uid= news_comment.get(i).getId();
                bmap.put("reply_uid",reply_uid);
                bmap.put("type",topic_type);
               // bmap.put("uid",user.getId());
                List<news_reply> news_replies=news_replyService.select_replyId(bmap);
                for(news_reply news_reply:news_replies){
                   User user1=userService.selectByPrimaryKey(news_reply.getUid());
                   news_reply.setName(user1.getName());
                   news_reply.setPhoto(user1.getPhoto());
                    NewsComment newsComment=newsCommentService.selectByPrimaryKey(news_reply.getReply_uid());
                    User user2=userService.selectByPrimaryKey(newsComment.getFromUid());
                    news_reply.setUsername(user2.getName());
                }
                news_comment.get(i).setReplayList(news_replies);
                amap.put("news_comment",news_comment);

            }
            return toJSONString(amap);

    }

    /**
     * 查询未审核的
     * @param id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/comment_two",method = RequestMethod.POST)
    @ResponseBody
    public String comment_two(int id,String topic_type,HttpServletRequest request, HttpServletResponse response) {
        User user=getUser(request);
        if(user==null){
            return ReturnInfoType.ERROR;
        }else{
            Map<String, Object> map = new HashMap<String, Object>();
            Map<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("newsid",id);
            paramMap.put("uid",user.getId());
            paramMap.put("topic_type",topic_type);
            List<NewsComment> news_comment=newsCommentService.article_comment_two(paramMap);
            for(NewsComment newsComment:news_comment){
                User user1=userService.selectByPrimaryKey(newsComment.getFromUid());
                newsComment.setName(user1.getName());
                newsComment.setPhoto(user1.getPhoto());
            }
            return toJSONString(news_comment);
        }

    }



    /**
     * 提交回复
     * @param request
     * @param response
     */

    @RequestMapping(value = "/news_reply",method = RequestMethod.POST)
    @ResponseBody
    public String news_reply(Integer id,String type, String content,HttpServletRequest request, HttpServletResponse response){
        User user=getUser(request);
        Map<String, Object> cmap = new HashMap<String, Object>();

        if (user==null) {
            return ReturnInfoType.ERROR;
        }else {
            news_reply news_reply=new news_reply();
            news_reply.setUid(user.getId());
            news_reply.setContent(content);
            news_reply.setTime(new Date());
            news_reply.setReply_uid(id);

            news_reply.setType(type);
            User user1=userService.selectByPrimaryKey(news_reply.getUid());
            news_reply.setName(user1.getName());
            news_reply.setPhoto(user1.getPhoto());
            NewsComment newsComment=newsCommentService.selectByPrimaryKey(news_reply.getReply_uid());
            User user2=userService.selectByPrimaryKey(newsComment.getFromUid());
            news_reply.setUsername(user2.getName());

            int result=news_replyService.insertSelective(news_reply);
            if (result == 1) {
                cmap.put("msg", "添加成功");
                cmap.put("status", ReturnInfoType.SUCEEESS);

            } else {
                cmap.put("msg", "添加失败");
                cmap.put("status", ReturnInfoType.FAIL);

            }
            return toJSONString(cmap);
        }
       // return toJSONString(cmap);
    }





}
