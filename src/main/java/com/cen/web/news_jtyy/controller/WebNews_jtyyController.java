package com.cen.web.news_jtyy.controller;

import com.cen.JtyyForeign.entity.JtyyForeign;
import com.cen.JtyyForeign.service.JtyyForeignService;
import com.cen.common.cache.EHCacheUtil;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ResData;
import com.cen.common.util.ReturnInfoType;

import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.news_reply.entity.news_reply;
import com.cen.jtyy.entity.Jtyy;
import com.cen.jtyy.service.JtyyService;
import com.cen.news_xbsb.entity.Xbsb;
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

@Controller
@RequestMapping("/web/jtyy")
public class WebNews_jtyyController extends BaseController {
    @Autowired
    JtyyService jtyyService;
    @Autowired
    private PraiseService praiseService;
    @Autowired
    private UserService userService;
    @Autowired
    private com.cen.news_reply.service.news_replyService news_replyService;
    @Autowired
    private NewsCommentService newsCommentService;

    @Autowired
    private JtyyForeignService<JtyyForeign> jtyyForeignService;


    /**
     * 通过栏目id 查询资讯
     * @param cIds
     * @param num
     * @return
     */
    @RequestMapping(value = "/selectByCid", method = RequestMethod.POST)
    @ResponseBody
    public String selectByColumnId(String[] cIds,Integer num){
        //先从缓存中获取，缓存中存在则从数据库获取
        List<JtyyForeign> list = (List<JtyyForeign>) EHCacheUtil.get(ReturnInfoType.FOREIGN_NEWS, "jtty_" + cIds[0]);
        if(list == null){
            list = jtyyForeignService.selectByColumnId(cIds, num);
            EHCacheUtil.put(ReturnInfoType.FOREIGN_NEWS,"jtty_"+cIds[0],list);
        }
        return ResData.SUCCESS(list).toString();
    }

    /**
     * 一周排行
     * @return
     */
    @RequestMapping(value = "/ranking", method = RequestMethod.POST)
    @ResponseBody
    public String selectHot(){
        List<JtyyForeign> list = jtyyForeignService.selectRanking();
        return ResData.SUCCESS(list).toString();
    }




    /*******************************************************************************************************/


    /**
     * 分页查询资讯
     * @param pageNum
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value="selectList")
    public String selectList(Jtyy jtyy, @RequestParam(value="pageNum",defaultValue="1",required=false) Integer pageNum, Integer newTypeId, HttpServletRequest request,
                             HttpServletResponse response, ModelMap map) {

        Map<String, Object> pmap = new HashMap<String, Object>();

        pmap = MapUtils.beanToMap(jtyy);
        pmap.put("pageNum", getPageNum(pageNum));
        pmap.put("pageSize", pageSize);
        pmap.put("newTypeId",newTypeId);
        List<Jtyy> list = jtyyService.selectList(pmap); //列表
        int count = jtyyService.selectListCount(pmap);  //记录行数

        map.put("list", list);
        map.put("count", count);
        map.put("pageNum", (pageNum));
        return "/web/news_jtyy/selectList";
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
        Jtyy news = jtyyService.selectByPrimaryKey(id);
        map.put("news", news);
        Jtyy news2=new Jtyy();
        //浏览量
        news2.setId(id);
        if(news.getPageView()==null){
            news.setPageView(0);
        }
        news2.setPageView(news.getPageView()+1);
        jtyyService.updateByPrimaryKeySelective(news2);
        return "/web/news_jtyy/details";
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
                int count=praiseService.deleteByPrimaryKey( praise.get(0).getId());
                Jtyy news_jtyy=jtyyService.selectByPrimaryKey(id);
                news_jtyy.setPraiseView(news_jtyy.getPraiseView()-1);
                jtyyService.updateByPrimaryKeySelective(news_jtyy);
                map.put("news_jtyy",news_jtyy);
                return toJSONString(map);

            }else{
                // 执行点赞
                Praise praise2 = new Praise();
                praise2.setNewsid(id);
                praise2.setUid(user.getId());
                praise2.setNews_type(news_type);
                praiseService.insertSelective(praise2);
                //添加记录
                Jtyy news_jtyy=jtyyService.selectByPrimaryKey(id);
                news_jtyy.setPraiseView(news_jtyy.getPraiseView()+1);
                jtyyService.updateByPrimaryKeySelective(news_jtyy);
                map.put("news_jtyy",news_jtyy);
                return toJSONString(map);

            }
        }



    }
    //查询点赞
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




}




