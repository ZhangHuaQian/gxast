package com.cen.news.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.cen.NewsVerifyLog.entity.NewsVerifyLog;
import com.cen.NewsVerifyLog.service.NewsVerifyLogService;
import com.cen.common.util.HttpUtil;

import com.cen.common.util.ResData;
import com.cen.loopphoto.entity.Loopphoto;
import com.cen.loopphoto.service.LoopphotoService;
import com.cen.news.entity.BaseNewsEntity;
import com.cen.newsVerifty.entity.NewsVerifty;
import com.cen.newsVerifty.entity.VeriftyNewType;
import com.cen.newsVerifty.service.NewsVeriftyService;
import com.cen.newsVeriftyUser.entity.NewsVeriftyUser;
import com.cen.newsVeriftyUser.service.NewsVeriftyUserService;
import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.news_reply.entity.news_reply;
import com.cen.news_reply.service.news_replyService;
import com.cen.operateLog.annotation.UserOperate;
import com.cen.praise.entity.Praise;
import com.cen.praise.service.PraiseService;
import com.cen.ucenter.service.UserService;
import com.cen.upms.entity.Role;
import com.cen.upms.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang.ObjectUtils.Null;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;
import com.cen.ucenter.entity.User;
import com.cen.upms.entity.Department;
import com.cen.upms.service.DepartmentService;
import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils.Text;

@Controller
@RequestMapping("/sys/news")
@Transactional
public class NewsController extends BaseController {
	public SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");

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
	DepartmentService departmentService;
	@Autowired
	NewsVeriftyService<NewsVerifty> newsVeriftyService;
	@Autowired
	NewsVeriftyUserService<NewsVeriftyUser> newsVeriftyUserService;
	@Autowired
	RoleService roleService;
	@Autowired
	LoopphotoService loopphotoService;
	@Autowired
	news_replyService newsReplyService;
	@Autowired
	private NewsVerifyLogService<NewsVerifyLog> newsVerifyLogService;

	/**
	 * 添加新闻资讯
	 *
	 * @param
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(News news, String veriftyUser,HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> cmap = new HashMap<String, Object>();
		User user = getUser(request);
		if(!isEmpty(user)){
			Department myDepartment = departmentService.selectByPrimaryKey(Integer.valueOf(user.getDid()));
			news.setCreateTime(new Date());
			news.setModifyTime(new Date());
			news.setIsDel(0);
			//news.setAuthor(getUser(request).getName());
			news.setNewsModule("news");
			news.setUserId(user.getId());
			news.setVerifty("0");
			int result = newsService.insertSelective(news);

			//推荐图位
			if(news.getRecommend() != null && !news.getRecommend().equals("") && news.getRecommendImg() != null && !news.getRecommendImg().equals("")){
				Loopphoto loopphoto = new Loopphoto();
				loopphoto.setHeader(news.getTitle());
				loopphoto.setHtmlUrl(system_address+"web/news/details/"+news.getId()+".html");
				loopphoto.setProjectImg(news.getRecommendImg());
				loopphoto.setCreateTime(new Date());
				loopphoto.setModifyTime(new Date());
				loopphoto.setType(news.getRecommend());
				loopphoto.setNewsType("news");
				loopphoto.setNewsId(news.getId());
				loopphoto.setIsDel(0);
				loopphoto.setVerify(0); //状态设置为未审核
				int res = loopphotoService.insertSelective(loopphoto);
			}

			//审核操作
			verify(news, user, myDepartment, veriftyUser,"insert");

			if (result == 1) {
				cmap.put("msg", "资讯投稿成功");
				cmap.put("status", ReturnInfoType.SUCEEESS);

			} else {
				cmap.put("msg", "资讯投稿失败");
				cmap.put("status", ReturnInfoType.FAIL);

			}
			return toJSONString(cmap);
		}else {
			cmap.put("msg", "请先登录");
			cmap.put("status", ReturnInfoType.FAIL);
			return toJSONString(cmap);
		}
	}

	/**
	 * 更新操作
	 *
	 * @param
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(Integer id, News news, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		User user = getUser(request);
		Map<String, Object> umap = new HashMap<String, Object>();
		news.setModifyTime(new Date());
		news.setId(id);
		int count = newsService.updateByPrimaryKeySelective(news);
		//推荐图位
		if(news.getRecommend() != null && !news.getRecommend().equals("") && news.getRecommendImg() != null && !news.getRecommendImg().equals("")){
			//1.先删除之前的数据
			loopphotoService.deleteByNewsTypeAndNewsId("news",news.getId());
			//2.再插入新的数据
			Loopphoto loopphoto = new Loopphoto();
			loopphoto.setHeader(news.getTitle());
			loopphoto.setHtmlUrl(system_address+"web/news/details/"+news.getId()+".html");
			loopphoto.setProjectImg(news.getRecommendImg());
			loopphoto.setCreateTime(new Date());
			loopphoto.setModifyTime(new Date());
			loopphoto.setType(news.getRecommend());
			loopphoto.setNewsType("news");
			loopphoto.setNewsId(news.getId());
			loopphoto.setIsDel(0);
			int res = loopphotoService.insertSelective(loopphoto);
		}else{
			//没有选推荐位，则删除之前的数据
			loopphotoService.deleteByNewsTypeAndNewsId("news",news.getId());
		}

		if (count == 1) {
			umap.put("msg", "更新成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "更新失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}

	/**
	 * 重新提交操作，资讯重新审核
	 *
	 * @param
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	@ResponseBody
	public String modify(Integer id, News news, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		User user = getUser(request);
		Map<String, Object> umap = new HashMap<String, Object>();
		news.setModifyTime(new Date());
		news.setId(id);
		int count = newsService.updateByPrimaryKeySelective(news);

		//推荐图位
		if(news.getRecommend() != null && !news.getRecommend().equals("") && news.getRecommendImg() != null && !news.getRecommendImg().equals("")){
			//1.先删除之前的数据
			loopphotoService.deleteByNewsTypeAndNewsId("news",news.getId());
			//2.再插入新的数据
			Loopphoto loopphoto = new Loopphoto();
			loopphoto.setHeader(news.getTitle());
			loopphoto.setHtmlUrl(system_address+"web/news/details/"+news.getId()+".html");
			loopphoto.setProjectImg(news.getRecommendImg());
			loopphoto.setCreateTime(new Date());
			loopphoto.setModifyTime(new Date());
			loopphoto.setType(news.getRecommend());
			loopphoto.setNewsType("news");
			loopphoto.setNewsId(news.getId());
			loopphoto.setIsDel(0);
			int res = loopphotoService.insertSelective(loopphoto);
		}else{
			//没有选推荐位，则删除之前的数据
			loopphotoService.deleteByNewsTypeAndNewsId("news",news.getId());
		}

		//修改资讯后，重新执行审核操作
		//1.先将之前的审核结果改为“关闭”状态
		Map<String ,Object> param = new HashMap<>();
		param.put("nId",news.getId());
		param.put("nType","news");
		param.put("verify",7);
		newsVeriftyService.updateVerifyByNid(param);

		//2.将资讯的审核状态改为待审核
		News news1 = new News();
		news1.setId(news.getId());
		news1.setVerifty("0");
		newsService.updateByPrimaryKeySelective(news1);

		//3.审核表重新插入新的审核相关数据
		Department myDepartment = departmentService.selectByPrimaryKey(Integer.valueOf(user.getDid()));
		verify(news, user, myDepartment, null,"modify");

		if (count == 1) {
			umap.put("msg", "更新成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "更新失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}

	/**
	 * 审核数据
	 * @param news
	 * @param user
	 * @param myDepartment
	 * @param veriftyUser
	 * @return
	 */
	private int verify(News news,User user,Department myDepartment,String veriftyUser,String operation){
		//保存操作记录
		NewsVerifty newsVerifty = new NewsVerifty();
		newsVerifty.setNewId(news.getId());
		newsVerifty.setNewType(VeriftyNewType.NEWS.type);
		newsVerifty.setCreateTime(new Date());
		newsVerifty.setVerifty("0");
		newsVerifty.setProcess("资讯投递");
		newsVerifty.setReceiverId(user.getId());
		newsVerifty.setReceiver(user.getName());
		if(!isEmpty(myDepartment)){
			newsVerifty.setReceiverDepartmentId(Integer.valueOf(myDepartment.getId()));
			newsVerifty.setReceiverDepartment(myDepartment.getName());
		}
		int res1 = newsVeriftyService.insertSelective(newsVerifty);

		//提交审核请求
		NewsVeriftyUser newsVeriftyUser = new NewsVeriftyUser();
		newsVeriftyUser.setNewsId(news.getId());
		newsVeriftyUser.setNewType(VeriftyNewType.NEWS.type);
		newsVeriftyUser.setCreateTime(new Date());
		newsVeriftyUser.setInitiatorId(user.getId());
		newsVeriftyUser.setInitiator(user.getName());
		if(!isEmpty(myDepartment)) {
			newsVeriftyUser.setInitiatorDepartmentId(Integer.valueOf(myDepartment.getId()));
			newsVeriftyUser.setInitiatorDepartment(myDepartment.getName());
		}
		//如果没有指定审核人员
		if(isEmpty(veriftyUser)){
			//ps:不指定谁来审核，而是同部门任何具备审核资格的都可以审核
			String did = user.getDid();
			Department veriftDepartment = departmentService.selectByPrimaryKey(Integer.valueOf(did));
			newsVeriftyUser.setReceiverDepartmentId(Integer.valueOf(veriftDepartment.getId()));
			newsVeriftyUser.setReceiverDepartment(veriftDepartment.getName());
		}else {
			User veriftor = userService.selectByPrimaryKey(veriftyUser);
			Department veriftDepartment = departmentService.selectByPrimaryKey(Integer.valueOf(veriftor.getDid()));
			newsVeriftyUser.setReceiverId(veriftor.getId());
			newsVeriftyUser.setReceiver(veriftor.getName());
			newsVeriftyUser.setReceiverDepartmentId(Integer.valueOf(veriftDepartment.getId()));
			newsVeriftyUser.setReceiverDepartment(veriftDepartment.getName());
		}
		newsVeriftyUser.setProcess("资讯投递一审");
		newsVeriftyUser.setStatus("0");
		int res2 = newsVeriftyUserService.insertSelective(newsVeriftyUser);

		//保存操作记录
		NewsVerifyLog newsVerifyLog = new NewsVerifyLog();
		newsVerifyLog.setNewsId(news.getId());
		newsVerifyLog.setNewsType(VeriftyNewType.NEWS.type);
		newsVerifyLog.setCreateTime(new Date());
		newsVerifyLog.setInitiatorId(user.getId());
		if(operation.equals("insert")){
			newsVerifyLog.setStatus("资讯投递，等待审核");
		}else if(operation.equals("modify")) {
			newsVerifyLog.setStatus("资讯重新编辑，等待重新审核");
		}
		newsVerifyLogService.insertSelective(newsVerifyLog);

		return res1 + res2;
	}



	//敏感词检测
	@RequestMapping(value = "/TextAudit", method = RequestMethod.POST)
	@ResponseBody
	public String TextAudit(News news, HttpServletRequest request, HttpServletResponse response) {
		String string = com.cen.news.util.TextAudit.Text_Audit(news.getTitle() + news.getDescription() + news.getContent());
		System.out.println(string);
		return string;
	}


	/**
	 * 根据id查找资讯
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(int id, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		News news = newsService.selectByPrimaryKey(id);

		//首页广告位
        Loopphoto loopphoto = loopphotoService.selectByNewsTypeAndNewsId("news", news.getId());

        if (!isEmpty(news))
            if(loopphoto != null){
                news.setRecommend(loopphoto.getType());
                news.setRecommendImg(loopphoto.getProjectImg());
            }
			smap.put("news", news);

		return toJSONString(smap);
	}

	/**
	 * 后台查看资讯详情
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/news", method = RequestMethod.GET)
	public String view(int id, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		News news = newsService.selectByPrimaryKey(id);
		request.setAttribute("news", news);

		//评论栏
		Map<String, Object> bmap = new HashMap<String, Object>();
		Map<String, Object> cmap = new HashMap<String, Object>();
		cmap.put("nId", id);
		cmap.put("nType","xwzx"); //新闻类型 -- 新闻中心资讯
		cmap.put("verify", "1");//审核通过
		List<NewsComment> comments = newsCommentService.selectCommentByNid(cmap);
		map.put("commentList", comments);

		//审核状态
		List<Map<String, Object>> rList = newsVerifyLogService.selectVerifyByNid(id,"news");
		for(Map<String, Object> map2 : rList){
			if(map2.get("initiator_id") != null){
				map2.put("initiator",map2.get("name"));
			}else if(map2.get("receiver_id") != null){
				map2.put("receiver",map2.get("name"));
			}
			map2.remove("name");
			//返回的 Timestamp 日期后面多一个 .0
			String create_time = map2.get("create_time").toString();
			map2.put("create_time",create_time.substring(0,create_time.length()-2));
		}
		map.put("verify", rList);

		return "sys/news/news";
	}

	/**
	 * 分页查询我投稿的列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/selectMyList",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectMyList(News news,Date date1, Date date2,Integer pageNum,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> rMap = new HashMap<String, Object>();
		User user = getUser(request);
		news.setUserId(user.getId());
//		Map<String, Object> paramMap = MapUtils.beanToMap(news);
		Map<String, Object> paramMap = new HashMap<>();
		// 此处查询需要自行编写
		if(news.getTitle() != null && !news.getTitle().equals("")){
			paramMap.put("title", news.getTitle());
		}
		if(news.getVerifty() != null && !news.getVerifty().equals("")){
			paramMap.put("verifty", news.getVerifty());
		}
		if(news.getNewsModule() != null && !news.getNewsModule().equals("")){
			paramMap.put("newsModule", news.getNewsModule());
		}
		paramMap.put("uId", user.getId());
		paramMap.put("startTime", date1);
		paramMap.put("endTime", date2);
		PageHelper.startPage(getPageNum2(pageNum),pageSize);
		List<News> lists = newsService.selectByUid(paramMap);
		PageInfo<News> p2 = new PageInfo<News>(lists);
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
	 * 分页查询所有资讯
	 *
	 * @param news
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectList", method = RequestMethod.GET)
	@ResponseBody
	public String selectList(News news, Date start, Date end, Integer pageNum, HttpServletRequest request,
							 HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();

		User user = getUser(request);
		String did = user.getDid();//获取当前用户的部门id
		// 查询用户角色
		List<Role> roles = roleService.selectByUid(user.getId());
		String power = roles.get(0).getPower();
		List<String> powers = Stream.of("role_super","role_system").collect(Collectors.toList());
		if(powers.contains(power)){
			List<Department> departments = DepartmentService.selectByThisUser(did);
			List<Integer> deList =new ArrayList<Integer>();
			for (int i = 0; i < departments.size(); i++) {
				deList.add(Integer.valueOf(departments.get(i).getId()));
			}
			pmap.put("departments", deList);
			pmap.put("did", user.getDid());
			news.setVerifty("5");
		}else {
//			news.setUserId(user.getId());
			pmap.put("did", user.getDid());
			news.setVerifty("5");
		}
		pmap = MapUtils.beanToMap(news);

		pmap.put("start", start);
		pmap.put("end", end);
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);

		List<News> list = newsService.selectList(pmap); //列表
		int count = newsService.selectListCount(pmap);  //记录行数

		if (!isEmpty(list)) dmap.put("list", list);
		dmap.put("count", count);
		dmap.put("pagecurr", getPageNum(pageNum) + 1);
		return toJSONString(dmap);
	}

	/**
	 * 跳转编辑页面 - 资讯未审核时
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/toupdate", method = RequestMethod.GET)
	public String toupdate(int id, HttpServletRequest request, HttpServletResponse response) {
		News news = newsService.selectByPrimaryKey(id);
		request.setAttribute("news", news);
		return "sys/news/edit";
	}

	/**
	 * 跳转编辑重新编辑页面 - 资讯审核后，重新编辑提交，
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/toModify", method = RequestMethod.GET)
	public String toModify(int id, HttpServletRequest request, HttpServletResponse response) {
		News news = newsService.selectByPrimaryKey(id);
		request.setAttribute("news", news);
		return "sys/news/modify";
	}

	/**
	 * 根据id删除资讯
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @param
	 * @return
	 */
	@UserOperate(moduleName = "新闻中心", option = "删除新闻中心信息")
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(int id, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		News news = newsService.selectByPrimaryKey(id);
		news.setIsDel(1);//假删除
		int result = newsService.updateByPrimaryKeySelective(news);
		newsCommentService.deleteAllMcomment(news.getId());

		//删除首页推荐位
        loopphotoService.deleteByNewsTypeAndNewsId("news",news.getId());
		if (result == 1) {
			umap.put("msg", "删除成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "删除失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}

	/**
	 * 日期转化器
	 *
	 * @param binder
	 */
	@InitBinder
	public void transferToDate(WebDataBinder binder) {
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
	}
	/**
	 * 返回全部点赞该文章的用户
	 * @param
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/likeuser",method = RequestMethod.POST)
	@ResponseBody
	public String like_user(int newsid,HttpServletRequest request, HttpServletResponse response){
		List<Praise> praises = praiseService.findByAid(newsid);
		List<User> users=new ArrayList<User>();
		for (int i = 0; i < praises.size(); i++) {
			User user= userService.selectByPrimaryKey(praises.get(i).getUid());
			users.add(user);
		}
		return toJSONString(users);
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

	@RequestMapping(value = "/commitcomment",method = RequestMethod.POST)
	@ResponseBody
	public String commit_comment(int newsid,HttpServletRequest request, HttpServletResponse response){
		User user=getUser(request);
		if (user==null) {
			return ReturnInfoType.ERROR;
		}else {
			NewsComment news_comment=new NewsComment();
			news_comment.setTopicId(newsid);
			//news_comment.setTopicType(praiseService.selectByPrimaryKey(newsid).getNews_type());
			news_comment.setContent(request.getParameter("content"));
			news_comment.setFromUid(user.getId());
			news_comment.setCommentstate("0");//0表示未审核
			news_comment.setTime(new Date());
			newsCommentService.insert(news_comment);

			return ReturnInfoType.SUCEEESS;
		}
	}

	/**
	 * 返回该文章的全部评论
	 * @param newsid
	 * @param request
	 * @param response
	 * @return
	 */
	/*@RequestMapping(value = "/comment",method = RequestMethod.POST)
	@ResponseBody
	public String comment(int newsid,HttpServletRequest request, HttpServletResponse response) {

		List<news_comment> news_comment=news_commentService.article_comment(newsid);
		return JSON.toJSONString(news_comment);
	}*/
	/**
	 * 返回该文章的全部评论的用户列表
	 * @param newsid
	 * @param request
	 * @param response
	 * @return
	 */
	/*@RequestMapping(value = "/comment_user",method = RequestMethod.POST)
	@ResponseBody
	public String comment_user(int newsid,HttpServletRequest request, HttpServletResponse response) {

	    User user=getUser(request);
		List<news_comment> comments=news_commentService.article_comment(newsid);
		List<User> users=new ArrayList<User>();
		for (int i = 0; i < comments.size(); i++) {
			user=userService.selectByPrimaryKey(comments.get(i).getFromUid());
			users.add(user);
		}
		return JSON.toJSONString(users);
	}*/








	
}
