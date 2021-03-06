package com.cen.news_zzgk.controller;

import com.cen.NewsVerifyLog.entity.NewsVerifyLog;
import com.cen.NewsVerifyLog.service.NewsVerifyLogService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.HttpUtil;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.loopphoto.entity.Loopphoto;
import com.cen.loopphoto.service.LoopphotoService;
import com.cen.newsVerifty.entity.NewsVerifty;
import com.cen.newsVerifty.entity.VeriftyNewType;
import com.cen.newsVerifty.service.NewsVeriftyService;
import com.cen.newsVeriftyUser.entity.NewsVeriftyUser;
import com.cen.newsVeriftyUser.service.NewsVeriftyUserService;
import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.news_zzgk.entity.NewsZzgk;
import com.cen.news_zzgk.service.NewsZzgkService;
import com.cen.operateLog.annotation.UserOperate;
import com.cen.praise.entity.Praise;
import com.cen.praise.service.PraiseService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.cen.upms.entity.Department;
import com.cen.upms.entity.Role;
import com.cen.upms.service.DepartmentService;
import com.cen.upms.service.RoleService;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * 添加新闻资讯
 * 政务公开
 */

@Controller
@RequestMapping("/sys/news_zzgk")
@Transactional
public class News_zzgkController extends BaseController {

	@Autowired
	private NewsZzgkService news_zzgkService;
	@Autowired
	private com.cen.upms.service.DepartmentService DepartmentService;
	@Autowired
	private PraiseService praiseService;
	@Autowired
	private UserService userService;
	@Autowired
	private NewsCommentService newsCommentService;
	@Autowired
	private RoleService roleService;
	@Autowired
	NewsVeriftyService<NewsVerifty> newsVeriftyService;
	@Autowired
	NewsVeriftyUserService<NewsVeriftyUser> newsVeriftyUserService;

	@Autowired
	LoopphotoService loopphotoService;
	@Autowired
	private NewsVerifyLogService<NewsVerifyLog> newsVerifyLogService;
	@Autowired
	private DepartmentService departmentService;

	/**
	 * 添加新闻资讯
	 * 政务公开
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(NewsZzgk news, String veriftyUser,HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> cmap = new HashMap<String, Object>();
		User user = getUser(request);
		if(!isEmpty(user)) {
			Department myDepartment = DepartmentService.selectByPrimaryKey(Integer.valueOf(user.getDid()));
			news.setCreateTime(new Date());
			news.setModifyTime(new Date());
			news.setIsDel(0);
			//news.setAuthor(getUser(request).getName());
			news.setUserId(getUser(request).getId());
			news.setNewsModule("news_zzgk");
			news.setVerifty("0");
			int result = news_zzgkService.insertSelective(news);

			//推荐图位
			if(news.getRecommend() != null && !news.getRecommend().equals("") && news.getRecommendImg() != null && !news.getRecommendImg().equals("")){
				Loopphoto loopphoto = new Loopphoto();
				loopphoto.setHeader(news.getTitle());
				loopphoto.setHtmlUrl(system_address+"web/news_zzgk/details/"+news.getId()+".html");
				loopphoto.setProjectImg(news.getRecommendImg());
				loopphoto.setCreateTime(new Date());
				loopphoto.setModifyTime(new Date());
				loopphoto.setType(news.getRecommend());
				loopphoto.setNewsType("news_zzgk");
				loopphoto.setNewsId(news.getId());
				loopphoto.setIsDel(0);
				loopphoto.setVerify(0); //状态设置为未审核
				int res = loopphotoService.insertSelective(loopphoto);
			}

			//审核信息记录
			verify(news, user, myDepartment, veriftyUser,"modify");

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

	// 敏感词检测
	@RequestMapping(value = "/TextAudit", method = RequestMethod.POST)
	@ResponseBody
	public String TextAudit(NewsZzgk news, HttpServletRequest request, HttpServletResponse response) {
		return com.cen.news.util.TextAudit.Text_Audit(news.getTitle() + news.getDescription() + news.getContent());
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
		NewsZzgk news = news_zzgkService.selectByPrimaryKey(id);

		//首页广告位
		Loopphoto loopphoto = loopphotoService.selectByNewsTypeAndNewsId("news_zzgk", news.getId());

		if(!isEmpty(news))

			if(loopphoto != null){
				news.setRecommend(loopphoto.getType());
				news.setRecommendImg(loopphoto.getProjectImg());
			}

			smap.put("news",news);

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
		NewsZzgk news = news_zzgkService.selectByPrimaryKey(id);
		request.setAttribute("news", news);

		//评论栏
		Map<String, Object> bmap = new HashMap<String, Object>();
		Map<String, Object> cmap = new HashMap<String, Object>();
		cmap.put("nId", id);
		cmap.put("nType","zzgk"); //新闻类型 -- 政务公开
		cmap.put("verify", "1");//审核通过
		List<NewsComment> comments = newsCommentService.selectCommentByNid(cmap);
		map.put("commentList", comments);

		//审核状态
		List<Map<String, Object>> rList = newsVerifyLogService.selectVerifyByNid(id,"zzgk");
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

		return "sys/news_zzgk/news";
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
	public String selectList(NewsZzgk news, Date start, Date end, Integer pageNum, HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();

		
		User user =getUser(request);
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

		List<NewsZzgk> list = news_zzgkService.selectList(pmap); // 列表
		int count = news_zzgkService.selectListCount(pmap); // 记录行数

		if (!isEmpty(list))
			dmap.put("list", list);
		dmap.put("count", count);
		return toJSONString(dmap);
	}

	/**
	 * 更新操作
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(Integer id, NewsZzgk news, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		news.setModifyTime(new Date());
		news.setId(id);
		int count = news_zzgkService.updateByPrimaryKeySelective(news);

		//推荐图位
		if(news.getRecommend() != null && !news.getRecommend().equals("") && news.getRecommendImg() != null && !news.getRecommendImg().equals("")){
			//1.先删除之前的数据
			loopphotoService.deleteByNewsTypeAndNewsId("news_zzgk",news.getId());
			//2.再插入新的数据
			Loopphoto loopphoto = new Loopphoto();
			loopphoto.setHeader(news.getTitle());
			loopphoto.setHtmlUrl(system_address+"web/news_zzgk/details/"+news.getId()+".html");
			loopphoto.setProjectImg(news.getRecommendImg());
			loopphoto.setCreateTime(new Date());
			loopphoto.setModifyTime(new Date());
			loopphoto.setType(news.getRecommend());
			loopphoto.setNewsType("news_zzgk");
			loopphoto.setNewsId(news.getId());
			loopphoto.setIsDel(0);
			int res = loopphotoService.insertSelective(loopphoto);
		}else{
			//没有选推荐位，则删除之前的数据
			loopphotoService.deleteByNewsTypeAndNewsId("news_zzgk",news.getId());
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
	public String modify(Integer id, NewsZzgk news, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		User user = getUser(request);
		Map<String, Object> umap = new HashMap<String, Object>();
		news.setModifyTime(new Date());
		news.setId(id);
		int count = news_zzgkService.updateByPrimaryKeySelective(news);

		//推荐图位
		if(news.getRecommend() != null && !news.getRecommend().equals("") && news.getRecommendImg() != null && !news.getRecommendImg().equals("")){
			//1.先删除之前的数据
			loopphotoService.deleteByNewsTypeAndNewsId("news_zzgk",news.getId());
			//2.再插入新的数据
			Loopphoto loopphoto = new Loopphoto();
			loopphoto.setHeader(news.getTitle());
			loopphoto.setHtmlUrl(system_address+"web/news_zzgk/details/"+news.getId()+".html");
			loopphoto.setProjectImg(news.getRecommendImg());
			loopphoto.setCreateTime(new Date());
			loopphoto.setModifyTime(new Date());
			loopphoto.setType(news.getRecommend());
			loopphoto.setNewsType("news_zzgk");
			loopphoto.setNewsId(news.getId());
			loopphoto.setIsDel(0);
			int res = loopphotoService.insertSelective(loopphoto);
		}else{
			//没有选推荐位，则删除之前的数据
			loopphotoService.deleteByNewsTypeAndNewsId("news_zzgk",news.getId());
		}

		//修改资讯后，重新执行审核操作
		//1.先将之前的审核结果改为“关闭”状态
		Map<String ,Object> param = new HashMap<>();
		param.put("nId",news.getId());
		param.put("nType","zzgk");
		param.put("verify",7);
		newsVeriftyService.updateVerifyByNid(param);

		//2.将资讯的审核状态改为待审核
		NewsZzgk news1 = new NewsZzgk();
		news1.setId(news.getId());
		news1.setVerifty("0");
		news_zzgkService.updateByPrimaryKeySelective(news1);

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
	private int verify(NewsZzgk news,User user,Department myDepartment,String veriftyUser,String operation){

		//保存操作记录
		NewsVerifty newsVerifty = new NewsVerifty();
		newsVerifty.setNewId(news.getId());
		newsVerifty.setNewType(VeriftyNewType.ZZGK.type);
		newsVerifty.setCreateTime(new Date());
		newsVerifty.setVerifty("0");
		newsVerifty.setProcess("资讯投递");
		newsVerifty.setReceiverId(user.getId());
		newsVerifty.setReceiver(user.getName());
		if (!isEmpty(myDepartment)) {
			newsVerifty.setReceiverDepartmentId(Integer.valueOf(myDepartment.getId()));
			newsVerifty.setReceiverDepartment(myDepartment.getName());
		}
		int res1 = newsVeriftyService.insertSelective(newsVerifty);

		//提交审核请求
		NewsVeriftyUser newsVeriftyUser = new NewsVeriftyUser();
		newsVeriftyUser.setNewsId(news.getId());
		newsVeriftyUser.setNewType(VeriftyNewType.ZZGK.type);
		newsVeriftyUser.setCreateTime(new Date());
		newsVeriftyUser.setInitiatorId(user.getId());
		newsVeriftyUser.setInitiator(user.getName());
		if (!isEmpty(myDepartment)) {
			newsVeriftyUser.setInitiatorDepartmentId(Integer.valueOf(myDepartment.getId()));
			newsVeriftyUser.setInitiatorDepartment(myDepartment.getName());
		}
		//如果没有指定审核人员
		if (isEmpty(veriftyUser)) {
			//ps:不指定谁来审核，而是同部门任何具备审核资格的都可以审核
			String did = user.getDid();
			Department veriftDepartment = DepartmentService.selectByPrimaryKey(Integer.valueOf(did));
			newsVeriftyUser.setReceiverDepartmentId(Integer.valueOf(veriftDepartment.getId()));
			newsVeriftyUser.setReceiverDepartment(veriftDepartment.getName());
		} else {
			User veriftor = userService.selectByPrimaryKey(veriftyUser);
			Department veriftDepartment = DepartmentService.selectByPrimaryKey(Integer.valueOf(veriftor.getDid()));
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
		newsVerifyLog.setNewsType(VeriftyNewType.ZZGK.type);
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
		NewsZzgk news = news_zzgkService.selectByPrimaryKey(id);
		request.setAttribute("news", news);
		return "sys/news_zzgk/edit";
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
		NewsZzgk news = news_zzgkService.selectByPrimaryKey(id);
		request.setAttribute("news", news);
		return "sys/news_zzgk/modify";
	}

	/**
	 * 根据id删除资讯
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(int id, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		NewsZzgk news = news_zzgkService.selectByPrimaryKey(id);
		news.setIsDel(1);// 假删除
		int result = news_zzgkService.updateByPrimaryKeySelective(news);
		newsCommentService.deleteAllMcomment(news.getId());

		//删除首页推荐位
		loopphotoService.deleteByNewsTypeAndNewsId("news_zzgk",news.getId());

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
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/likeuser",method = RequestMethod.POST)
	@ResponseBody
	public String like_user(int id,HttpServletRequest request, HttpServletResponse response){
		List<Praise> praises = praiseService.findByAid(id);
		List<User> users=new ArrayList<User>();
		for (int i = 0; i < praises.size(); i++) {
			User user= userService.selectByPrimaryKey(praises.get(i).getUid());
			users.add(user);
		}
		return toJSONString(users);
	}

	/**
	 * 返回文章点赞状态
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/articlelike",method = RequestMethod.POST)
	@ResponseBody
	public String articlelike(int id,HttpServletRequest request, HttpServletResponse response) {
		User user=getUser(request);
		if (user==null) {

			//获取ip地址
			String ip= HttpUtil.getIpAddr(request);
			List<Praise> praises= praiseService.findByIpByAid(ip, id);
			if (praises!=null&&praises.size()>=1) {
				return ReturnInfoType.FAIL;
			}else {
				return ReturnInfoType.SUCEEESS;
			}
		}else {
			/*List<Praise> praises= praiseService.findByUidAndNewsId(user.getId(), id);
			if (praises!=null&&praises.size()>=1) {
				return ReturnInfoType.FAIL;
			}else {
				return ReturnInfoType.SUCEEESS;
			}*/
			return ReturnInfoType.SUCEEESS;
		}
	}
	/**
	 * 点赞
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/like",method = RequestMethod.POST)
	@ResponseBody
	public String like(int id,HttpServletRequest request, HttpServletResponse response) {
		User user=getUser(request);

		if (user==null) {//如果用户不存在
			//获取ip地址
			String ip=HttpUtil.getIpAddr(request);
			System.out.println("ip:"+ip);
			List<Praise> praise= praiseService.findByIpByAid(ip, id);
			if (praise!=null&&praise.size()>=1) {//如果点过赞
				Praise praise1=praise.get(0);
				praiseService.deleteByPrimaryKey(praise1.getId());
				return ReturnInfoType.FAIL;
			}else {//如果没有点赞过
				Praise praise1 = new Praise();
				praise1.setNewsid(id);
				praise1.setIp(ip);
				praise1.setNews_type(request.getParameter("news_type"));
				praiseService.insertSelective(praise1);
				return ReturnInfoType.SUCEEESS;
			}
		}else {//如果已经登录
			/*String uid=user.getId();
			List<Praise> praises= praiseService.findByUidAndNewsId(uid, id);
			if (praises!=null&&praises.size()>=1) {
				Praise praise=praises.get(0);
				praiseService.deleteByPrimaryKey(praise.getId());
				return ReturnInfoType.FAIL;
			}else {
				Praise praise = new Praise();
				praise.setNewsid(id);
				praise.setUid(uid);
				praise.setNews_type(request.getParameter("news_type"));
				praiseService.insertSelective(praise);
				return ReturnInfoType.SUCEEESS;
			}*/
			return ReturnInfoType.SUCEEESS;
		}

	}
}
