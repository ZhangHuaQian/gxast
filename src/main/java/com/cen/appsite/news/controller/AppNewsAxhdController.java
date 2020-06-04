package com.cen.appsite.news.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.dictionary.entity.Dictionary;
import com.cen.dictionary.service.DictionaryService;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;
import com.cen.news_axhd.entity.NewsAxhd;
import com.cen.news_axhd.service.NewsAxhdService;
import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.news_reply.entity.news_reply;
import com.cen.news_reply.service.news_replyService;
import com.cen.praise.entity.Praise;
import com.cen.praise.service.PraiseService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.cen.upms.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value="/appsite/phoneNewsAxhd")
public class AppNewsAxhdController extends BaseController {
	@Autowired
	private NewsAxhdService news_axhdService ;
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



    /*查询党建工作列表*/
	@RequestMapping(value = "/selectNewsAxhdList",  produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectNewsAxhdList( Integer newTypeId, Integer pageNum,String title,HttpServletRequest request, HttpServletResponse response, ModelMap map){
		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("newTypeId", newTypeId);
		pmap.put("title",title);
		List<NewsAxhd> list = news_axhdService.selectList(pmap); //列表
		int count = news_axhdService.selectListCount(pmap);//记录行数
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
		bmap.put("type","type_axhd");
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
	public String selectById(Integer id,Integer pageNum,Integer pageSize,HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		/*查询已审核的评论*/
		Map<String, Object> amap = new HashMap<String, Object>();
		Map<String, Object> bmap = new HashMap<String, Object>();
		Map<String,Object> cmap = new HashMap<String,Object>();
		cmap.put("newsid",id);
		cmap.put("topic_type","djgz");
		List<NewsComment> news_comment2=newsCommentService.article_comment(cmap);
		map.put("comment_count", news_comment2.size());
		map.put("type","djgz");
		cmap.put("pageNum",(pageNum-1)*pageSize);
		cmap.put("pageSize",pageSize);
		List<NewsComment> news_comment=newsCommentService.article_comment(cmap);
		for(NewsComment newsComment:news_comment){
			User user1=userService.selectByPrimaryKey(newsComment.getFromUid());
			newsComment.setName(user1.getName());
			newsComment.setPhoto(user1.getPhoto());
		}
		for(int i=0;i<news_comment.size();i++){
			int reply_uid= news_comment.get(i).getId();
			bmap.put("reply_uid",reply_uid);
			bmap.put("type","djgz");
			List<news_reply> news_replies=news_replyService.select_replyId(bmap);
			for(news_reply news_reply:news_replies){
				User user1=userService.selectByPrimaryKey(news_reply.getUid());
				news_reply.setName(user1.getName());
				news_reply.setPhoto(user1.getPhoto());
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
			paramMap.put("news_type","djgz");
			List<Praise> praises= praiseService.findByUidAndNewsId(paramMap);
			if (praises.size()>0) {
				map.put("code",ReturnInfoType.SUCEEESS);
			}else {
				map.put("code",ReturnInfoType.FAIL);
			}
			/*查询未审核的评论*/
			Map<String, Object> dmap = new HashMap<String, Object>();
			Map<String,Object> fmap = new HashMap<String,Object>();
			dmap.put("newsid",id);
			dmap.put("uid",user.getId());
			dmap.put("topic_type","djgz");
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
		NewsAxhd news_axhd=news_axhdService.selectByPrimaryKey(id);
		map.put("list",news_axhd);
		map.put("status",ReturnInfoType.SUCEEESS);
		map.put("msg","ok");
		NewsAxhd news_axhd2  = new NewsAxhd();
		//浏览量
		news_axhd2.setId(id);
		if(news_axhd.getPage_view()==null){
			news_axhd.setPage_view(0);
		}
		news_axhd2.setPage_view(news_axhd.getPage_view()+1);

		news_axhdService.updateByPrimaryKeySelective(news_axhd2);

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
		NewsAxhd news_axhd=news_axhdService.selectByPrimaryKey(id);
		request.setAttribute("news_axhd",news_axhd);
		return "appsite/news_axhd/details";
	}

	/**
	 * 党建工作点赞
	 * @param id
	 * @param news_type
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insertPraise",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String insertNewsAxhdPraise(Integer id,String news_type, HttpServletRequest request, HttpServletResponse response){
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
				NewsAxhd news_axhd=news_axhdService.selectByPrimaryKey(id);
				news_axhd.setPraise_view(news_axhd.getPraise_view()-1);
				news_axhdService.updateByPrimaryKeySelective(news_axhd);
				map.put("news_axhd",news_axhd);
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
				NewsAxhd news_axhd=news_axhdService.selectByPrimaryKey(id);
				news_axhd.setPraise_view(news_axhd.getPraise_view()+1);
				news_axhdService.updateByPrimaryKeySelective(news_axhd);
				map.put("news_axhd",news_axhd);
				map.put("status",ReturnInfoType.SUCEEESS);
				map.put("msg","ok");
				return toJSONString(map);

			}
		}



	}
	/*查询党建工作点赞*/
	@RequestMapping(value = "/selectNewsAxhdPraise",produces = "application/json;charset=utf-8")
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


	/**
	 * 提交评论
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
			news_comment.setTopicType("djgz");
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
			news_reply.setType("djgz");
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
