package com.cen.appsite.news.controller;

import com.cen.JDBC.New_jtyy;
import com.cen.JDBC.New_news;
import com.cen.common.cache.EHCacheUtil;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.dictionary.entity.Dictionary;
import com.cen.dictionary.service.DictionaryService;
import com.cen.loopphoto.entity.Loopphoto;
import com.cen.loopphoto.service.LoopphotoService;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;
import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.news_reply.entity.news_reply;
import com.cen.news_reply.service.news_replyService;
import com.cen.praise.entity.Praise;
import com.cen.praise.service.PraiseService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.cen.upms.entity.Department;
import com.cen.upms.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;


@Controller
@RequestMapping(value="/appsite/phoneNews")
public class AppNewsController extends BaseController {
	@Autowired
	private NewsService newsService;
	@Autowired
	private DepartmentService DepartmentService;
	@Autowired
	private PraiseService praiseService;
	@Autowired
	private UserService userService;
	@Autowired
	private NewsCommentService newsCommentService;
	@Autowired
	private news_replyService news_replyService;
	@Autowired
	private DictionaryService DictionaryService;
	@Autowired
	private LoopphotoService LoopphotoService;

    /*查询新闻中心列表*/
	@RequestMapping(value = "/selectNewsList",  produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectNewsList( Integer newTypeId, Integer pageNum,String title,HttpServletRequest request, HttpServletResponse response, ModelMap map){
		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("newTypeId", newTypeId);
		pmap.put("title",title);
		List<News> list = newsService.selectList(pmap); //列表
		int count = newsService.selectListCount(pmap);//记录行数
		dmap.put("list", list);
		dmap.put("count", count);
		dmap.put("status",ReturnInfoType.SUCEEESS);
		dmap.put("msg","ok");
		return toJSONString(dmap);

	}
	/**
	 * 获取字典分类
	 * @return
	 */
	@RequestMapping(value = "/selectNewsDic",  produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectDictionary(HttpServletRequest request, HttpServletResponse response) {
		/*字典分类*/
		Map<String, Object> bmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		bmap.put("type","type_zx");
		List<Dictionary> dictionaries=DictionaryService.selectList(bmap);
		dmap.put("dicList",dictionaries);
		return toJSONString(dmap);
	}

	/**
	 * 根据id查找资讯以及浏览量
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/select",  produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectById(Integer id,Integer pageNum,Integer pageSize, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		/*查询已审核的*/
		Map<String, Object> amap = new HashMap<String, Object>();
		Map<String, Object> bmap = new HashMap<String, Object>();
		Map<String,Object> cmap = new HashMap<String,Object>();
		cmap.put("newsid",id);
		cmap.put("topic_type","xwzx");
		List<NewsComment> news_comment2=newsCommentService.article_comment(cmap);
		map.put("type","xwzx");
		map.put("comment_count", news_comment2.size());
		cmap.put("pageNum",(pageNum-1)*pageSize);
		cmap.put("pageSize",pageSize);
		List<NewsComment> news_comment=newsCommentService.article_comment(cmap);
		for(NewsComment newsComment:news_comment){
			User user1=userService.selectByPrimaryKey(newsComment.getFromUid());
			newsComment.setName(user1.getName());
			newsComment.setPhoto(user1.getPhoto());
		}
		//查询该评论下的回复
		for(int i=0;i<news_comment.size();i++){
			int reply_uid= news_comment.get(i).getId();
			bmap.put("reply_uid",reply_uid);
			bmap.put("type","xwzx");
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
			map.put("check",news_comment);

		}
		User user=getUser(request);
		if(user==null){
			map.put("code",ReturnInfoType.USER_NoFound);
		}else{
			Map<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("uid",user.getId());
			paramMap.put("newsid",id);
			paramMap.put("news_type","xwzx");
			List<Praise> praises= praiseService.findByUidAndNewsId(paramMap);
			if (praises.size()>0) {
				//return ReturnInfoType.FAIL;
				map.put("code",ReturnInfoType.SUCEEESS);
			}else {
				//return ReturnInfoType.SUCEEESS;
				map.put("code",ReturnInfoType.FAIL);
			}

			/*查询未审核的*/
			Map<String, Object> dmap = new HashMap<String, Object>();
			Map<String,Object> fmap = new HashMap<String,Object>();
			dmap.put("newsid",id);
			dmap.put("uid",user.getId());
			dmap.put("topic_type","xwzx");
			dmap.put("pageNum",pageNum);
			dmap.put("pageSize",pageSize);
			List<NewsComment> news_comment1=newsCommentService.article_comment_two(dmap);
			for(NewsComment newsComment:news_comment1){
				User user1=userService.selectByPrimaryKey(newsComment.getFromUid());
				newsComment.setName(user1.getName());
				newsComment.setPhoto(user1.getPhoto());
				map.put("uncheck",newsComment);
			}

		}
		News news=newsService.selectByPrimaryKey(id);
		map.put("list",news);
		map.put("status",ReturnInfoType.SUCEEESS);
		map.put("msg","ok");
		News news2  = new News();
		//浏览量
		news2.setId(id);
		if(news.getPage_view()==null){
			news.setPage_view(0);
		}
		news2.setPage_view(news.getPage_view()+1);

		newsService.updateByPrimaryKeySelective(news2);

		return toJSONString(map);
	}

	/**
	 * 根据id查找资讯返回页面
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/details", produces = "application/json;charset=utf-8")
	public String view(Integer id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		News news=newsService.selectByPrimaryKey(id);
		request.setAttribute("news",news);
		return "appsite/news/details";
	}

	/**
	 * 新闻中心点赞
	 * @param id
	 * @param news_type
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insertPraise",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String insertNewsPraise(Integer id,String news_type, HttpServletRequest request, HttpServletResponse response){
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
				praiseService.deleteByPrimaryKey( praise.get(0).getId());
				News news=newsService.selectByPrimaryKey(id);
				news.setPraise_view(news.getPraise_view()-1);
				newsService.updateByPrimaryKeySelective(news);
				map.put("news",news);
				map.put("status",ReturnInfoType.SUCEEESS);
				map.put("msg","ok");
				return toJSONString(map);

			}else{
				// 执行点赞
				Praise praise2 = new Praise();
				praise2.setNewsid(id);
				praise2.setUid(user.getId());
				praise2.setNews_type(news_type);
				praiseService.insertSelective(praise2);
				//添加记录
				News news=newsService.selectByPrimaryKey(id);
				news.setPraise_view(news.getPraise_view()+1);
				newsService.updateByPrimaryKeySelective(news);
				map.put("news",news);
				map.put("status",ReturnInfoType.SUCEEESS);
				map.put("msg","ok");
				return toJSONString(map);

			}
		}



	}
	/*查询新闻中心点赞*/
	@RequestMapping(value = "/selectNewsPraise",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectNewsPraise(Integer id,String news_type, HttpServletRequest request, HttpServletResponse response){
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
				return ReturnInfoType.FAIL;
			}else {
				return ReturnInfoType.SUCEEESS;
			}
		}

	}


	/*首页展示工作动态和时政要闻*/
	/**
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectNewsByType",  produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectNewsByType(Integer pageSize, HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		
		Integer[] index ={1,10,14,18};
		for(int i=0;i<index.length;i++){
            String type ="zy"+"_#0"+index[i];
            List<Loopphoto> loopphotoList=LoopphotoService.selectByType(type,3);
            dmap.put("list"+index[i], loopphotoList);
        }
		map.put("pageNum",0);
		map.put("pageSize",pageSize);
		map.put("newTypeId",21);
        List<News> list=newsService.selectList(map);
        map.put("newTypeId",22);
        List<News> list1=newsService.selectList(map);
		dmap.put("Dynamic", list);
        dmap.put("Week", list1);
        /*南方科技网*/
		List<New_news> jrtt =  (List<New_news>)EHCacheUtil.get("cen_crmjl","jrtt");//南方头条
		List<New_news> hqkb =  (List<New_news>)EHCacheUtil.get("cen_crmjl","hqkb");//行情快报
		List<New_news> zzyz =  (List<New_news>)EHCacheUtil.get("cen_crmjl","zzyz");//种植移植
		List<New_news> cfsj =  (List<New_news>)EHCacheUtil.get("cen_crmjl","cfsj");//创富商机
		List<New_news> gqxx =  (List<New_news>)EHCacheUtil.get("cen_crmjl","gqxx");//供求信息
		/*家庭医药*/
		List<New_jtyy> jkys =  (List<New_jtyy>)EHCacheUtil.get("cen_crmjl","jkys");
		List<New_jtyy> zjpy =  (List<New_jtyy>)EHCacheUtil.get("cen_crmjl","zjpy");
		List<New_jtyy> mytb =  (List<New_jtyy>)EHCacheUtil.get("cen_crmjl","mytb");
		List<New_jtyy> zcytk =  (List<New_jtyy>)EHCacheUtil.get("cen_crmjl","zcytk");
		/*南方科技网*/
		dmap.put("jrtt", jrtt);
		dmap.put("hqkb", hqkb);
		dmap.put("zzyz", zzyz);
		dmap.put("cfsj", cfsj);
		dmap.put("gqxx", gqxx);
		/*家庭医药*/
		dmap.put("jkys", jkys);
		dmap.put("zjpy",zjpy);
		dmap.put("mytb",mytb);
		dmap.put("zcytk",zcytk);

		dmap.put("status",ReturnInfoType.SUCEEESS);
		dmap.put("msg","ok");
		return toJSONString(dmap);
	}


	/**
	 * 用户提交评论
	 * @param request
	 * @param response
	 */

	@RequestMapping(value = "/commitcomment",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String commit_comment(Integer id,String content,HttpServletRequest request, HttpServletResponse response){
		User user=getUser(request);
		Map<String, Object> dmap = new HashMap<String, Object>();
		if (user==null) {
			return ReturnInfoType.ERROR;
		}else {
			NewsComment news_comment=new NewsComment();
			news_comment.setTopicId(id);
			news_comment.setTopicType("xwzx");
			news_comment.setContent(content);
			news_comment.setFromUid(user.getId());
			User user1=userService.selectByPrimaryKey(news_comment.getFromUid());
			news_comment.setName(user1.getName());
			news_comment.setPhoto(user1.getPhoto());
			news_comment.setCommentstate("0");//0表示未审核
			news_comment.setTime(new Date());
			int count=newsCommentService.insertSelective(news_comment);
			if(count>0){
				dmap.put("msg", "添加成功");
				dmap.put("status", ReturnInfoType.SUCEEESS);
			}else{
				dmap.put("msg", "添加失败");
				dmap.put("status", ReturnInfoType.ERROR);
			}
			return toJSONString(dmap);
		}
	}
	/**
	 * 提交回复
	 * @param request
	 * @param response
	 */

	@RequestMapping(value = "/news_reply",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String news_reply(Integer id,String content,HttpServletRequest request, HttpServletResponse response){
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
			news_reply.setType("xwzx");
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
	}








}
