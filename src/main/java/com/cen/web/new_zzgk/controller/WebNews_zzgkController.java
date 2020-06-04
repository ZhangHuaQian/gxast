package com.cen.web.new_zzgk.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;

import com.cen.common.util.ReturnInfoType;

import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.news_reply.entity.news_reply;
import com.cen.news_reply.service.news_replyService;
import com.cen.news_zzgk.entity.NewsZzgk;
import com.cen.news_zzgk.service.NewsZzgkService;
import com.cen.praise.entity.Praise;
import com.cen.praise.service.PraiseService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by cenguocheng on 2019/1/8.
 * 137544496@qq.com
 */
@Controller
@RequestMapping("/web/news_zzgk")
public class WebNews_zzgkController extends BaseController {

    @Autowired
    private NewsZzgkService news_zzgkService ;
    @Autowired
    private PraiseService praiseService;
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
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value="selectList")
    public String selectList(NewsZzgk news, @RequestParam(value="pageNum",defaultValue="1",required=false) Integer pageNum,Integer newTypeId, HttpServletRequest request,
                             HttpServletResponse response, ModelMap map) {

        Map<String, Object> pmap = new HashMap<String, Object>();
        news.setVerifty("5");
        pmap = MapUtils.beanToMap(news);
        pmap.put("pageNum", getPageNum(pageNum));
        pmap.put("pageSize", pageSize);
        pmap.put("newTypeId",newTypeId);
        List<NewsZzgk> list = news_zzgkService.selectList(pmap); //列表
        int count = news_zzgkService.selectListCount(pmap);  //记录行数

        map.put("list", list);
        map.put("count", count);
        map.put("pageNum", (pageNum));
        return "/web/news_zzgk/selectList";
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
        NewsZzgk news = news_zzgkService.selectByPrimaryKey(id);
        map.put("news", news);
        NewsZzgk news2=new NewsZzgk();
        //浏览量
        news2.setId(id);
        if(news.getPage_view()==null){
            news.setPage_view(0);
        }
        news2.setPage_view(news.getPage_view()+1);
        news_zzgkService.updateByPrimaryKeySelective(news2);
        return "/web/news_zzgk/details";
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
        NewsZzgk news = news_zzgkService.selectByPrimaryKey(id);
        map.put("news", news);
        NewsZzgk news2=new NewsZzgk();
        //浏览量
        news2.setId(id);
        if(news.getPage_view()==null){
            news.setPage_view(0);
        }
        news2.setPage_view(news.getPage_view()+1);
        news_zzgkService.updateByPrimaryKeySelective(news2);
        return "/web/news_zzgk/webdetails";
    }

    /**
     * 点赞
     * @param id
     * @param news_type
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "insert",method= RequestMethod.POST)
    @ResponseBody
    public String insert(int id,String news_type, HttpServletRequest request, HttpServletResponse response){
        User user=getUser(request);

        if(user==null){//如果用户不存在
            return ReturnInfoType.ERROR;
        }else{
            Map<String, Object> map = new HashMap<String, Object>();
            Map<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("uid",user.getId());
            paramMap.put("newsid",id);
            paramMap.put("news_type",news_type);
            List<Praise> praise = praiseService.findByUidAndNewsId(paramMap);//找到这条记录
            if(praise.size()>0){
                //取消点赞
                praiseService.deleteByPrimaryKey(praise.get(0).getId());
                NewsZzgk news_zzgk=news_zzgkService.selectByPrimaryKey(id);
                news_zzgk.setPraise_view(news_zzgk.getPraise_view()-1);
                news_zzgkService.updateByPrimaryKeySelective(news_zzgk);
                map.put("news_zzgk",news_zzgk);
                return toJSONString(map);

            }else{
                // 执行点赞
                Praise praise2 = new Praise();
                praise2.setNewsid(id);
                praise2.setUid(user.getId());
                praise2.setNews_type(news_type);
                praiseService.insertSelective(praise2);
                //添加记录
                NewsZzgk news_zzgk=news_zzgkService.selectByPrimaryKey(id);
                news_zzgk.setPraise_view(news_zzgk.getPraise_view()+1);
                news_zzgkService.updateByPrimaryKeySelective(news_zzgk);
                map.put("news_zzgk",news_zzgk);
                return toJSONString(map);

            }
        }



    }

    @RequestMapping(value = "select",method= RequestMethod.POST)
    @ResponseBody
    public String select(int id,String news_type, HttpServletRequest request, HttpServletResponse response){
        User user=getUser(request);
        if(user==null){
            return ReturnInfoType.ERROR;
        }else{
            Map<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("uid",user.getId());
            paramMap.put("newsid",id);
            paramMap.put("news_type",news_type);
            List<Praise> praises= praiseService.findByUidAndNewsId(paramMap);
            if (praises.size()>0) {
                return ReturnInfoType.SUCEEESS;
            }else {
                return ReturnInfoType.FAIL;
            }
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
     * 返回该文章的全部评论的用户列表
     * @param
     * @param request
     * @param response
     * @return
     */
   /* @RequestMapping(value = "/comment_user",method = RequestMethod.POST)
    @ResponseBody
    public String comment_user(int id,HttpServletRequest request, HttpServletResponse response) {

        User user=getUser(request);
        List<news_comment> comments=news_commentService.article_comment(id);
        List<User> users=new ArrayList<User>();
        for (int i = 0; i < comments.size(); i++) {
            user=userService.selectByPrimaryKey(comments.get(i).getFromUid());
            users.add(user);
        }
        return toJSONString(users);
    }*/

    /**
     * 提交回复
     * @param request
     * @param response
     */

    @RequestMapping(value = "/news_reply",method = RequestMethod.POST)
    @ResponseBody
    public String news_reply(int id,String type,HttpServletRequest request, HttpServletResponse response){
        User user=getUser(request);
        String content=request.getParameter("content");
        Map<String, Object> cmap = new HashMap<String, Object>();
//        System.out.println(content);
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
    }





}
