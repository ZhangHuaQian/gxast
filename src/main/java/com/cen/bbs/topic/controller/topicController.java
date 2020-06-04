package com.cen.bbs.topic.controller;


import com.cen.ForumGrade.entity.ForumGrade;
import com.cen.ForumGrade.service.ForumGradeService;
import com.cen.ForumScoreDetail.entity.ForumScoreDetail;
import com.cen.ForumScoreDetail.service.ForumScoreDetailService;
import com.cen.ForumUserInfo.entity.ForumUserInfo;
import com.cen.ForumUserInfo.service.ForumUserInfoService;
import com.cen.bbs.comment.entity.Comment;
import com.cen.bbs.report.service.ReportService;
import com.cen.bbs.topic.entity.Topic;
import com.cen.bbs.topic.entity.Topicfloor;
import com.cen.bbs.topic.service.TopicService;
import com.cen.bbs.comment.service.CommentService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.common.util.StringUtils;
import com.cen.loopphoto.entity.Loopphoto;
import com.cen.loopphoto.service.LoopphotoService;
import com.cen.operateLog.annotation.UserOperate;
import com.cen.session.entity.Session;
import com.cen.session.service.SessionService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/topic")
public class topicController extends BaseController {


	@Autowired
	TopicService topicService;
	@Autowired
	LoopphotoService loopphotoService;
	@Autowired
	SessionService sessionService;
	@Autowired
	UserService userService;
	@Autowired
	CommentService commentService;
	@Autowired
	ReportService reportService;
	@Autowired
	private ForumUserInfoService<ForumUserInfo> forumUserInfoService;
	@Autowired
	private ForumGradeService<ForumGrade> forumGradeService;
	@Autowired
	private ForumScoreDetailService<ForumScoreDetail> forumScoreDetailService;

	/**
	 * 用户发布帖子
	 *
	 * @param
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(Topic topic,String ValidateCode, String userid, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> cmap = new HashMap<String, Object>();
		//图片的验证码
		String text=(String)request.getSession().getAttribute(ReturnInfoType.VALIDATECODE);
		if(!text.equalsIgnoreCase(ValidateCode.trim())){
			cmap.put("msg", "验证码错误");
			cmap.put("status", ReturnInfoType.VALIDATECodeERROR);
		}else{
			if(topic.getContent().length()>0){
				topic.setCreateTime(new Date());
				topic.setUpdateTime(new Date());
				topic.setUid(userid);
				topic.setNid(1);
				topic.setIsDel(0);
				topic.setStatus(1);
				int result=topicService.insertSelective(topic);
				if(result==1){
					cmap.put("msg", "发布成功");
					cmap.put("status", ReturnInfoType.SUCEEESS);
				}else{
					cmap.put("msg", "发布失败");
					cmap.put("status", ReturnInfoType.FAIL);
				}
			}else {
				cmap.put("status", ReturnInfoType.USER_EXIST_ERROR);
			}

		}

		return toJSONString(cmap);
	}



	/**
	 * 查询所有地址
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectList", method = RequestMethod.GET)
	@ResponseBody
	public String selectList(String userid, int pageNum, HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("userid", userid);
		List<Topic> topicList=topicService.selectList( pmap);

		dmap.put("list", topicList);
		dmap.put("count", topicList.size());
		return toJSONString(dmap);
	}
	/**
	 * 查询用户默认地址
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/getuserTopic", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String getuserTopic(int userid,HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> dmap = new HashMap<String, Object>();
		//Topic topic=topicService.getuserTopic(userid);
		//dmap.put("Topic", Topic);
		return toJSONString(dmap);
	}
	/**
	 * 查询用户默认地址
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectIsTop", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectIsTop(HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> dmap = new HashMap<String, Object>();
		//dmap.put("uid",getUser(request).getId());
//		List<Objects> topiclist=topicService.selectIsTop(dmap);
		List<Map<String, Object>> maps = topicService.selectIsTop2(dmap);

		//查询用户等级
		for(Map<String ,Object> m : maps){
			ForumGrade forumGrade = forumGradeService.selectByForumUserId((String) m.get("id"));
			ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid((String) m.get("id"));
			m.put("forumGradeIcon",forumGrade.getPhoto());
			m.put("userType",forumUserInfo.getUType());
		}

//		if(!isEmpty(topiclist))dmap.put("list", topiclist);
		if(!isEmpty(maps))
			dmap.put("list", maps);
		return toJSONString(dmap);
	}
	/**
	 *
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/checkVip", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String checkVip(int id,HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String,Object> rMap = new HashMap<>();
		Topic topic=topicService.selectByPrimaryKey(id);
		Session session = sessionService.selectByPrimaryKey(Integer.valueOf(topic.getSsession()));
		//vip版块
		if(session.getType().equals(1)){
			User user2 = getUser(request);
			if(user2 == null){
				rMap.put("msg","查看vip帖子请先登录哦!");
				rMap.put("status",0);
				return toJSONString(rMap);
			}else{
				ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid(user2.getId());
				if(forumUserInfo == null || forumUserInfo.getUType().equals(0)){
					rMap.put("msg","您还不是vip用户，不可查看vip帖子哦!");
					rMap.put("status",0);
					return toJSONString(rMap);
				}
			}
		}
		return toJSONString(rMap);
	}

	/**
	 * 帖子详情
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/details", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
	public String getdetails(int id,HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Topic topic=topicService.selectByPrimaryKey(id);

		//获取帖子评论数
		Map<String,Object> param = new HashMap<>();
		param.put("tid", id);
		param.put("verify",1); //1-审核通过
		int count = commentService.selectBytidCount(param); // 审核通过的评论数
		topic.setComment(count);

		Session session = sessionService.selectByPrimaryKey(Integer.valueOf(topic.getSsession()));
		//vip版块
		if(session.getType().equals(1)){
			User user2 = getUser(request);
			if(user2 == null){
				//用户未登录，不返回数据
				return null;
			}else{
				ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid(user2.getId());
				if(forumUserInfo == null || forumUserInfo.getUType().equals(0)){
					//用户不是vip，不返回数据
					return null;
				}
			}
		}

		User user=userService.selectByPrimaryKey(topic.getUid());
		//论坛等级图标
		ForumGrade forumGrade = forumGradeService.selectByForumUserId(user.getId());
		if(forumGrade != null){
			user.setForumGradeIcon(forumGrade.getPhoto());
		}

		//论坛用户信息
		ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid(user.getId());
		if(forumUserInfo != null){
			user.setIsVip(forumUserInfo.getUType());
			user.setVipUserIcon(forumUserInfo.getVipIcon());
		}


		if(topic.getClickNum()==null){
			topic.setClickNum(1);
		}else{
			topic.setClickNum(topic.getClickNum()+1);
		}
		int a=topicService.updateByPrimaryKey(topic);
		List<Topic> topicList=topicService.selectBycommentnum();
		for(Topic t : topicList){
			Session session1 = sessionService.selectByPrimaryKey(Integer.valueOf(t.getSsession()));
			t.setType(session1.getType());
		}

		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("tid", id);
		List<Comment> commentList = commentService.selectBytid(pmap);// 获取所有楼层的评论

		request.setAttribute("topicList",topicList);
//		request.setAttribute("commentList",commentList);
		request.setAttribute("topic",topic);
		request.setAttribute("user",user);
		return "web/bbs/details";
	}

	/**
	 * 用户中心编辑，自己发布的帖子
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/ucenterupdate", method = RequestMethod.GET)
	public String ucenterupdate(int id,HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Topic topic=topicService.selectByPrimaryKey(id);
		request.setAttribute("topic",topic);
		return "web/user/bbs/ucenterupdate";
	}


	@RequestMapping(value="/updateTopicStatus",method = RequestMethod.GET)
	@ResponseBody
	@Transactional
	public  String updateStatus(Topic topic,HttpServletRequest request,HttpServletResponse response){

		Map<String,Object> tmap=new HashMap<>();

		int count=topicService.updateByPrimaryKeySelective(topic);

		//审核通过
		if(topic.getStatus().equals(0)){

			Map<String,Object> param = new HashMap<>();
			param.put("uId",topic.getUid());
			param.put("tId",topic.getTid());
			param.put("sType",1);
			List<ForumScoreDetail> list = forumScoreDetailService.selectList(param);
			if(list.size()==0){
				//插入一条积分获取记录
				Topic topic1 = topicService.selectByPrimaryKey(topic.getTid());
				ForumScoreDetail fsd = new ForumScoreDetail();
				fsd.setUId(topic1.getUid());
				fsd.setSFrom("发帖成功，+"+ ReturnInfoType.TOPIC +"分");
				fsd.setSValue(ReturnInfoType.TOPIC);
				fsd.setSessionId(Integer.valueOf(topic1.getSsession()));
				fsd.setTId(topic1.getTid());
				fsd.setCreateTime(new Date());
				fsd.setsType(1);
				forumScoreDetailService.insertSelective(fsd);

				//积分加3
				ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid(topic1.getUid());
				forumUserInfo.setScore(forumUserInfo.getScore()+ReturnInfoType.TOPIC);
				forumUserInfo.setModifyTime(new Date());
				forumUserInfoService.updateByPrimaryKeySelective(forumUserInfo);
			}
		}


		if(count==1){
			tmap.put("msg","更新成功");
			tmap.put("status",ReturnInfoType.SUCEEESS);
		}else{
			tmap.put("msg","更新失败");
			tmap.put("status",ReturnInfoType.FAIL);
		}
		return toJSONString(tmap);
	}

	/**
	 * 查询用户发布的帖子
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectmytopic", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectmytopic(String userid,int pageNum, HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("userid", userid);
		List<Topic> topic=topicService.selectmytopic(pmap);
		int count = topicService.selectListCount(pmap);  //记录行数
		dmap.put("list", topic);
		dmap.put("count", count);
		return toJSONString(dmap);
	}
	/**
	 * 查询用户发布的所有帖子
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectAlltopicForCheck", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectAlltopicForCheck(int pageNum,String sname,String sprofile,String userid, HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("sprofile", sprofile);
		pmap.put("sname", sname);
		pmap.put("userid", userid);
		List<Topic> list=topicService.selectAlltopicForCheck(pmap);
		if(list.size()>0){
			for (Topic topic : list){
				Session session = sessionService.selectByPrimaryKey(Integer.valueOf(topic.getSsession()));
				topic.setsSessionName(session.getSname());
			}
		}
		int countoflimit =topicService.countoflimit(pmap);
		int count = topicService.selectListCount(pmap);  //记录行数
		dmap.put("list", list);
		dmap.put("countoflimit", countoflimit);//
		dmap.put("count", count);
		return toJSONString(dmap);
	}
	/**
	 * 查询用户发布的帖子
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/innitsession", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String innitsession(HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		List<Session> session=sessionService.selectAll();
		dmap.put("list", session);
		return toJSONString(dmap);
	}
	/**
	 * 查询评论活跃的用户
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/rubackUser", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String rubackUser(HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		List<Objects> objectsList=commentService.rubackUser();
		dmap.put("list", objectsList);
		return toJSONString(dmap);
	}
	/**
	 * 按评论数量查出最热十条
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectBycommentnum", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectBycommentnum(HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		List<Topic> topic=topicService.selectBycommentnum();
		for(Topic t : topic){
			Session session = sessionService.selectByPrimaryKey(Integer.valueOf(t.getSsession()));
			t.setType(session.getType());
		}
		dmap.put("list", topic);
		return toJSONString(dmap);
	}
	/**
	 * 前台分页查询帖子
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectAlltopic", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectAlltopic(int pageNum,String ssession,String title, HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("ssession", ssession);
		pmap.put("title",title);
		//pmap.put("uid", getUser(request).getId());
//		List<Objects> topic=topicService.selectAlltopic(pmap);

		//置顶帖子集合
		List<Map<String, Object>> isTopList = topicService.selectIsTop2(dmap);
		List<Map<String, Object>> maps = topicService.selectAlltopic2(pmap);
		List<Map<String, Object>> removeIsTopList = new ArrayList<>();

//		for(Map<String ,Object> m : maps){
		for(int i = 0; i < maps.size(); i++){
			Map<String ,Object> m = maps.get(i);
			ForumGrade forumGrade = forumGradeService.selectByForumUserId((String) m.get("id"));
			ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid((String) m.get("id"));
			m.put("forumGradeIcon",forumGrade.getPhoto());
			m.put("userType",forumUserInfo.getUType());

			//查询置顶的帖子
			for (Map<String ,Object> isTop : isTopList){
				if(m.get("tid").equals(isTop.get("tid"))){
					removeIsTopList.add(m);
				}
			}
		}
		//去除置顶的帖子
		maps.removeAll(removeIsTopList);

		int count = topicService.selectAlltopicCount(pmap);  //记录行数
		if(count > 0 && removeIsTopList.size()>0){
			count = count - removeIsTopList.size();
		}
		dmap.put("list", maps);
		dmap.put("count", count);
		return toJSONString(dmap);
	}
	/**
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@UserOperate(moduleName="轮播图",option = "更新轮播图")
	@RequestMapping(value="/selectadvphoto",method=RequestMethod.POST)
	@ResponseBody
	public String selectadvphoto(String phototype,int photozise,int photonum,HttpServletRequest request,HttpServletResponse response,ModelMap map){
		Map<String, Object> umap = new HashMap<String, Object>();
        /*int count = loopphotoService.updateByPrimaryKeySelective(loopphoto);*/
		for(int i=1;i<=photonum;i++){
			 String type =phototype+"_#0"+i;
			List<Loopphoto> loopphotoList=loopphotoService.selectByType(type,photozise);
			String list="list"+i;
			umap.put(list, loopphotoList);
		}
		umap.put("status", ReturnInfoType.SUCEEESS);
		return toJSONString(umap);
	}


	/**
	 * 根据id删除apk
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
		Topic rr=topicService.selectByPrimaryKey(id);
		int result = topicService.deleteByPrimaryKey(id);
		int aa=commentService.deleteAllMcomment(rr.getTid());
		int b=reportService.deleteByTid(rr.getTid());
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
	 * 置顶帖子更新操作
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/isTop", method = RequestMethod.POST)
	@ResponseBody
	public String isTop(int id, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Topic rr=topicService.selectByPrimaryKey(id);
		rr.setIsTop(1);
		try{
			if(rr.getStatus()==0){
				int result = topicService.updateByPrimaryKey(rr);
				if (result == 1) {
					umap.put("msg", "置顶成功");
					umap.put("status", ReturnInfoType.SUCEEESS);
				} else {
					umap.put("msg", "置顶失败");
					umap.put("status", ReturnInfoType.FAIL);
				}
			}else {
				umap.put("msg","帖子未审核");
				umap.put("status",ReturnInfoType.ERROR);
			}
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("帖子未审核");
		}

		return toJSONString(umap);
	}
	/**
	 * 置顶帖子更新操作
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/notTop", method = RequestMethod.POST)
	@ResponseBody
	public String notTop(int id, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Topic rr=topicService.selectByPrimaryKey(id);
		rr.setIsTop(0);
		int result = topicService.updateByPrimaryKey(rr);
		try{
			if(rr.getStatus()==0){
				if (result == 1) {
					umap.put("msg", "已取消置顶");
					umap.put("status", ReturnInfoType.SUCEEESS);
				} else {
					umap.put("msg", "取消置顶失败");
					umap.put("status", ReturnInfoType.FAIL);
				}
			}else {
				umap.put("msg","帖子未审核");
				umap.put("status",ReturnInfoType.ERROR);
			}
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("帖子未审核");
		}


		return toJSONString(umap);
	}

	/**
	 * 跳转update更新页面
	 * @param id
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/toupdate", method = RequestMethod.GET)
	@ResponseBody
	public String toupdate(int id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Topic topic = topicService.selectByPrimaryKey(id);
		umap.put("topic", topic);
		return toJSONString(umap);
	}
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(int id, Topic topic, HttpServletRequest request, HttpServletResponse response,
						 ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		topic.setTid(id);
		topic.setIsDel(0);
		topic.setStatus(1);
		topic.setNid(1);
		/*topic.setTopic(Topic.getProvince()+Topic.getCity()+Topic.getArea());*/
		int count = topicService.updateByPrimaryKeySelective(topic);
		if (count == 1) {
			umap.put("msg", "更新成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "更新失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
	@RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
	@ResponseBody
	public String updateStatus(int id,  HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Topic topic=topicService.selectByPrimaryKey(id);
		topic.setStatus(0);
		int count = topicService.updateByPrimaryKeySelective(topic);
		if (count == 1) {
			umap.put("msg", "更新成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "更新失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
	@RequestMapping(value = "/report", method = RequestMethod.POST)
	@ResponseBody
	/*举报帖子*/
	public String report(int id,int report,  HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Topic topic=topicService.selectByPrimaryKey(id);
		topic.setReport(report);
		int count = topicService.updateByPrimaryKeySelective(topic);
		if (count == 1) {
			umap.put("msg", "举报成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "举报失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
}
