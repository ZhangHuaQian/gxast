package com.cen.appsite.bbs.controller;

import com.cen.bbs.comment.entity.Comment;
import com.cen.bbs.comment.service.CommentService;
import com.cen.bbs.favorite.entity.Favorite;
import com.cen.bbs.favorite.service.FavoriteService;
import com.cen.bbs.toconmment.entity.Toconmment;
import com.cen.bbs.toconmment.service.ToconmmentService;
import com.cen.bbs.topic.entity.Topic;
import com.cen.bbs.topic.entity.Topicfloor;
import com.cen.bbs.topic.service.TopicService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.session.entity.Session;
import com.cen.session.service.SessionService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
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
@RequestMapping(value = "/appsite/bbs")
public class AppBbsController extends BaseController {

	@Autowired
	TopicService topicService;
	@Autowired
	UserService userService;
	@Autowired
	SessionService sessionService;
	@Autowired
	CommentService commentService;
	@Autowired
	ToconmmentService toconmmentService;
	@Autowired
	FavoriteService FavoriteService;

	/**
	 * 分页查询帖子
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectAlltopic", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectAlltopic(int pageNum, String ssession, HttpServletRequest request, HttpServletResponse response,
			ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("ssession", ssession);// 帖子所属板块
		List<Objects> topic = topicService.selectAlltopic(pmap);
		int count = topicService.selectAlltopicCount(pmap); // 记录行数
		dmap.put("list", topic);
		dmap.put("count", count);
		return toJSONString(dmap);
	}

	/**
	 * 帖子详情的上部分点赞
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/likeit",method=RequestMethod.GET)
	@ResponseBody
	public String likeit(int tid,HttpServletRequest request,
							  HttpServletResponse response, ModelMap map) {
		User user=getUser(request);
		if(user==null){//如果用户不存在
			return ReturnInfoType.ERROR;
		}else{
			Map<String, Object> pmap = new HashMap<String, Object>();
			Map<String, Object> dmap = new HashMap<String, Object>();
			List<Favorite> flist=FavoriteService.selectByTid(tid,user.getId());
			if(flist.size()>0){
				int a=FavoriteService.deleteByPrimaryKey(flist.get(0).getId());
				Topic topic=topicService.selectByPrimaryKey(tid);
				topic.setLikeNum(topic.getLikeNum()-1);
				topicService.updateByPrimaryKey(topic);
				dmap.put("status", ReturnInfoType.SUCEEESS);
				dmap.put("likeNum", topic.getLikeNum());
			}else {
				Favorite favorite=new Favorite();
				favorite.setCreateTime(new Date());
				favorite.setUid(user.getId());
				favorite.setTid(tid);
				favorite.setStyle(1);
				int a=FavoriteService.insertSelective(favorite);
				Topic topic=topicService.selectByPrimaryKey(tid);
				topic.setLikeNum(topic.getLikeNum()+1);
				topicService.updateByPrimaryKey(topic);
				dmap.put("status", ReturnInfoType.SUCEEESS);
				dmap.put("likeNum", topic.getLikeNum());
			}
			return toJSONString(dmap);
		}

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
	@RequestMapping(value = "/details", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String details(Integer id, Integer pageNum, Integer pageSize, HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {
		Map<String, Object> dmap = new HashMap<String, Object>();
		Topic topic = topicService.selectByPrimaryKey(id);
		User user = userService.selectByPrimaryKey(topic.getUid());
		dmap.put("user", user);
		if (topic.getClickNum() == null) {
			topic.setClickNum(1);
		} else {
			topic.setClickNum(topic.getClickNum() + 1);
		}
		int a = topicService.updateByPrimaryKey(topic);
		List<Topic> topicList = topicService.selectBycommentnum();

		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("tid", id);// 帖子id
		List<Comment> commentList = commentService.selectBytid(pmap);// 获取所有楼层的评论
		int count = commentService.selectBytidCount(pmap); // 记录行数
		List<Topicfloor> topiclist = new ArrayList<Topicfloor>();// 封装楼层类
																	// 评论对象user
																	// 评论comment
																	// 楼层toconmment
		for (Comment cc : commentList) {
			user = userService.selectByPrimaryKey(cc.getUid());// 获取楼层层主个人信息
			Map<String, Object> selmap = new HashMap<String, Object>();
			selmap.put("tid", id);
			selmap.put("cid", cc.getId());
			List<Toconmment> toconmmentList = toconmmentService.selectAllTocomment(selmap);// 获取楼层所有的子评论
			for (int i = 0; i < toconmmentList.size(); i++) {
				User user2 = userService.selectByPrimaryKey(toconmmentList.get(i).getUserId());
				toconmmentList.get(i).setUserPhoto(user2.getPhoto());
			}
			Topicfloor tf = new Topicfloor();
			cc.setUserPhoto(user.getPhoto());
			cc.setUserName(user.getName());
			tf.setComment(cc);
			tf.setUser(user);
			tf.setToconmmentList(toconmmentList);
			topiclist.add(tf);
		}
		dmap.put("topiclist", topiclist);// 回复列表

		dmap.put("topic", topic);
		return toJSONString(dmap);
	}

	/**
	 * 发布帖子
	 *
	 * @param
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insert", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String insert(Topic topic,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> cmap = new HashMap<String, Object>();
		User user = getUser(request);
		topic.setTitle(topic.getTitle());
		topic.setContent(topic.getContent());
		topic.setSsession(topic.getSsession());
		topic.setCreateTime(new Date());
		topic.setUpdateTime(new Date());
		topic.setUid(user.getId());
		topic.setNid(1);
		topic.setIsDel(0);
		topic.setStatus(1);
		int result = topicService.insertSelective(topic);
		if (result == 1) {
			cmap.put("msg", "发布帖子成功");
			cmap.put("status", ReturnInfoType.SUCEEESS);

		} else {
			cmap.put("msg", "发布帖子失败");
			cmap.put("status", ReturnInfoType.FAIL);

		}

		return toJSONString(cmap);
	}

	/**
	 * 我的帖子
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectmytopic", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectmytopic(Integer pageNum, HttpServletRequest request, HttpServletResponse response,
			ModelMap map) {
		String userid = getUser(request).getId();
		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("userid", userid);
		List<Topic> topic = topicService.selectmytopic(pmap);
		int count = topicService.selectListCount(pmap);
		dmap.put("list", topic);
		dmap.put("count", count);
		return toJSONString(dmap);
	}

	/**
	 * 我的帖子删除
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/delete", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String delete(int id, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		int result = topicService.deleteByPrimaryKey(id);
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
	 * 我的帖子更新
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/update", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String update(Integer id, Topic topic, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		topic.setTid(id);
		topic.setIsDel(0);
		topic.setStatus(1);
		topic.setNid(1);
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

	/**
	 * 分页查询论坛分类
	 * 
	 * @param
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectList(Session session, Integer pageNum, String name, String type, HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();

		pmap = MapUtils.beanToMap(session);
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("sname", name);
		pmap.put("sprofile", type);
		pmap.put("pageSize", pageSize);
		List<Session> list = sessionService.selectList(pmap);
		int count = sessionService.selectListCount(pmap);
		if (!isEmpty(list))
			dmap.put("list", list);
		dmap.put("count", count);
		return toJSONString(dmap);
	}

	/**
	 * 论坛分类不分页
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/innitsession", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String innitsession(HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		List<Session> session = sessionService.selectAll();
		dmap.put("list", session);
		return toJSONString(dmap);
	}

	/**
	 * 论坛分页查询评论
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectAllcomment", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectAllcomment(int ttttid, int pageNum, HttpServletRequest request, HttpServletResponse response,
			ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("tid", ttttid);// 帖子id
		List<Comment> commentList = commentService.selectBytid(pmap);// 获取所有楼层的评论
		int count = commentService.selectBytidCount(pmap); // 记录行数
		List<Topicfloor> topiclist = new ArrayList<Topicfloor>();// 封装楼层类
																	// 评论对象user
																	// 评论comment
																	// 楼层toconmment
		for (Comment cc : commentList) {
			User user = userService.selectByPrimaryKey(cc.getUid());// 获取楼层层主个人信息
			Map<String, Object> selmap = new HashMap<String, Object>();
			selmap.put("tid", ttttid);
			selmap.put("cid", cc.getId());
			List<Toconmment> toconmmentList = toconmmentService.selectAllTocomment(selmap);// 获取楼层所有的子评论
			Topicfloor tf = new Topicfloor();
			tf.setComment(cc);
			tf.setUser(user);
			tf.setToconmmentList(toconmmentList);
			topiclist.add(tf);
		}

		dmap.put("list", topiclist);
		dmap.put("count", count);
		return toJSONString(dmap);
	}

	/**
	 * 论坛提交评论
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/insertcomment", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String insertcomment(Integer tid, String content, HttpServletRequest request, HttpServletResponse response,
			ModelMap map) {
		Comment comment = new Comment();
		User user = getUser(request);
		Map<String, Object> dmap = new HashMap<String, Object>();
		comment.setTid(tid);
		comment.setContent(content);
		comment.setCreateTime(new Date());
		comment.setToUid(0);
		comment.setUid(user.getId());
		Topic topic = topicService.selectByPrimaryKey(comment.getTid());
		topic.setComment(topic.getComment() + 1);
		int count = topicService.updateByPrimaryKey(topic);
		int commentty = commentService.insert(comment);
		if (commentty == 1) {
			dmap.put("msg", "提交评论成功");
			dmap.put("status", ReturnInfoType.SUCEEESS);

		} else {
			dmap.put("msg", "提交评论成功");
			dmap.put("status", ReturnInfoType.FAIL);

		}
		return toJSONString(dmap);
	}

	/***
	 *
	 * @param toid
	 *            被评论人id
	 * @param tid
	 *            文章
	 * @param rcontent
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/answer", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String answer(Integer toid, Integer tid, Integer pid, String rcontent, HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		User user1 = getUser(request);
		User user = userService.selectByPrimaryKey(toid + "");
		if (user1 == null) {
			dmap.put("msg", "回复前先登录");
			dmap.put("status", ReturnInfoType.FAIL);
			return toJSONString(dmap);
		} else {
			Toconmment toconmment = new Toconmment();
			toconmment.setCreateDate(new Date());
			toconmment.setPid(pid);
			toconmment.setToUserId(toid + "");// 被回复id
			toconmment.setTousername(user.getName());
			toconmment.setUsername(user1.getName());
			toconmment.setUserId(user1.getId());// 回复人id
			toconmment.setIsDel(0);
			toconmment.setTid(tid);// 文章id
			toconmment.setState("0");
			toconmment.setContent(rcontent);// 内容
			int aa = toconmmentService.insert(toconmment);
			dmap.put("status", ReturnInfoType.SUCEEESS);
			dmap.put("msg", "回复成功");
			return toJSONString(dmap);
		}

	}

	/**
	 * 查询置顶列表
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectIsTop", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectIsTop(HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> dmap = new HashMap<String, Object>();
		List<Objects> topiclist = topicService.selectIsTop(dmap);
		if (!isEmpty(topiclist))
			dmap.put("list", topiclist);
		return toJSONString(dmap);
	}

}
