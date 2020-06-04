package com.cen.bbs.comment.controller;

import com.cen.ForumGrade.entity.ForumGrade;
import com.cen.ForumGrade.service.ForumGradeService;
import com.cen.ForumScoreDetail.entity.ForumScoreDetail;
import com.cen.ForumScoreDetail.service.ForumScoreDetailService;
import com.cen.ForumUserInfo.entity.ForumUserInfo;
import com.cen.ForumUserInfo.service.ForumUserInfoService;
import com.cen.StxcContest.entity.StxcContest;
import com.cen.bbs.favorite.entity.Favorite;
import com.cen.bbs.favorite.service.FavoriteService;
import com.cen.bbs.toconmment.dao.ToconmmentDao;
import com.cen.bbs.toconmment.entity.Toconmment;
import com.cen.bbs.toconmment.service.ToconmmentService;
import com.cen.bbs.topic.entity.Topic;
import com.cen.bbs.topic.entity.Topicfloor;
import com.cen.bbs.topic.service.TopicService;
import com.cen.bbs.comment.entity.Comment;
import com.cen.bbs.comment.service.CommentService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ResData;
import com.cen.common.util.ReturnInfoType;
import com.cen.praise.entity.Praise;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
@RequestMapping("/comment")
public class CommentController extends BaseController {

	@Autowired
	CommentService commentService;
	@Autowired
	TopicService topicService;
	@Autowired
	FavoriteService favoriteService;
	@Autowired
	ToconmmentService toconmmentService;
	@Autowired
	UserService userService;
	@Autowired
	private ForumGradeService<ForumGrade> forumGradeService;
	@Autowired
	private ForumScoreDetailService<ForumScoreDetail> forumScoreDetailService;
	@Autowired
	private ForumUserInfoService<ForumUserInfo> forumUserInfoService;

	/***
	 *
	 * @param toid
	 *            被评论人id
	 * @param tid
	 *            文章
	 * @param pid
	 *            评论id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/answer", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String answer(String toid, Integer tid, Integer pid, String content, HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		User user1 = getUser(request);
		User user = userService.selectByPrimaryKey(toid);
		if (user1 == null) {
			dmap.put("msg", "回复前先登录");
			dmap.put("status", ReturnInfoType.FAIL);
			return toJSONString(dmap);
		} else {
			Toconmment toconmment = new Toconmment();
			toconmment.setCreateDate(new Date());
			toconmment.setPid(pid);
			toconmment.setToUserId(toid);// 被回复id
			toconmment.setTousername(user.getName());
			toconmment.setUsername(user1.getName());
			toconmment.setUserId(user1.getId());// 回复人id
			toconmment.setIsDel(0);
			toconmment.setTid(tid);// 文章id
			toconmment.setState("0");
			toconmment.setContent(content);// 内容
			int aa = toconmmentService.insert(toconmment);
			dmap.put("status", ReturnInfoType.SUCEEESS);
			dmap.put("msg", "回复成功");
			return toJSONString(dmap);
		}

	}

	/**
	 * 论坛提交评论
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(Comment comment, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		User user = getUser(request);
		Map<String, Object> dmap = new HashMap<String, Object>();
		if(user==null){
			dmap.put("status", ReturnInfoType.ERROR);
		}else{
			if(comment.getContent().length()>0){
				comment.setCreateTime(new Date());
				comment.setToUid(0);
				comment.setUid(user.getId());
				comment.setState(0);// 首次进来设置为0,0为可见
				comment.setLikeNum(0);
//				System.out.println(comment.getId());
				int result = commentService.insert(comment);
				if(result==1){
					dmap.put("msg", "发布成功,等待管理员审核");
					dmap.put("status", ReturnInfoType.SUCEEESS);
				}else{
					dmap.put("msg", "发布失败");
					dmap.put("status", ReturnInfoType.FAIL);
				}
			}else{
				dmap.put("status",ReturnInfoType.USER_EXIST_ERROR);
			}
		}
		return toJSONString(dmap);
	}

	/**
	 * 分页查询评论
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectAllcomment", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectAllcomment(int tid, int pageNum, HttpServletRequest request, HttpServletResponse response,
			ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", 10);
		pmap.put("tid", tid);
		pmap.put("verify",1); //1-审核通过
		List<Comment> commentList = commentService.selectBytid(pmap);// 获取所有楼层的评论
		int count = commentService.selectBytidCount(pmap); // 记录行数
		List<Topicfloor> topiclist = new ArrayList<Topicfloor>();// 封装楼层类
																	// 评论对象user
																	// 评论comment
																	// 楼层toconmment
		for (Comment cc : commentList) {
			User user = userService.selectByPrimaryKey(cc.getUid());// 获取楼层层主个人信息
			ForumGrade forumGrade = forumGradeService.selectByForumUserId(user.getId());
			ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid(user.getId());
			if(forumGrade != null){
			    //论坛等级图标
				user.setForumGradeIcon(forumGrade.getPhoto());
			}
			if(forumUserInfo != null){
				//用户类型：普通、vip
				//vip图标
				user.setIsVip(forumUserInfo.getUType());
				user.setVipUserIcon(forumUserInfo.getVipIcon());
			}
			Map<String, Object> selmap = new HashMap<String, Object>();
			selmap.put("tid", tid);
			selmap.put("pid", cc.getId());
			selmap.put("pageNum", 0);
			selmap.put("pageSize", 10);
            selmap.put("verify",1); //1-审核通过

			List<Toconmment> toconmmentList = toconmmentService.selectAllTocomment(selmap);// 获取楼层所有的子评论
			for (int i = 0; i < toconmmentList.size(); i++) {
				User user2 = userService.selectByPrimaryKey(toconmmentList.get(i).getUserId());
				toconmmentList.get(i).setUserPhoto(user2.getPhoto());
				ForumUserInfo forumUserInfo1 = forumUserInfoService.selectByUid(user2.getId());
				if(forumUserInfo1 != null){
					toconmmentList.get(i).setUserType(forumUserInfo1.getUType());
				}
			}
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
	 * 分页查询评论回复
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selecToComment", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selecToComment(Integer tid,Integer cid, Integer pageNum, HttpServletRequest request, HttpServletResponse response,
			ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> selmap = new HashMap<String, Object>();
		selmap.put("tid", tid);
		selmap.put("cid", cid);
		List<Toconmment> toconmmentList1 = toconmmentService.selectAllTocomment(selmap);//
		selmap.put("pageNum", getPageNum(pageNum));
		selmap.put("pageSize", 10);
		List<Toconmment> toconmmentList = toconmmentService.selectAllTocomment(selmap);// 获取楼层所有的子评论
		for (int i = 0; i < toconmmentList.size(); i++) {
			User user2 = userService.selectByPrimaryKey(toconmmentList.get(i).getUserId());
			toconmmentList.get(i).setUserPhoto(user2.getPhoto());
		}
		dmap.put("list", toconmmentList);
		dmap.put("count",toconmmentList1.size());
		if (pageNum*10>=toconmmentList1.size()) {
			dmap.put("next",0);          
		}else {
			dmap.put("next",1);
		}
		return toJSONString(dmap);
	}

	/**
	 * 获取楼层所有的评论
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/getTocomment", method = RequestMethod.GET)
	@ResponseBody
	public String getTocomment(int ttttid, int cid, HttpServletRequest request, HttpServletResponse response,
			ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("tid", ttttid);
		pmap.put("cid", cid);
		List<Toconmment> toconmments = toconmmentService.selectAllTocomment(pmap);
		dmap.put("list", toconmments);
		return toJSONString(dmap);
	}

	/**
	 * 根据城市查询下级地市
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectByVid", method = RequestMethod.GET)
	@ResponseBody
	public String selectByVid(int cid, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		Comment comment = commentService.selectByPrimaryKey(cid);
		dmap.put("village", comment);
		return toJSONString(dmap);
	}

	/**
	 * 帖子详情的上部分点赞
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/likeit", method = RequestMethod.GET)
	@ResponseBody
	public String likeit(int tid, String userid, HttpServletRequest request, HttpServletResponse response,
			ModelMap map) {
		User user = getUser(request);
		if (user == null) {// 如果用户不存在
			return ReturnInfoType.ERROR;
		} else {
			Map<String, Object> pmap = new HashMap<String, Object>();
			Map<String, Object> dmap = new HashMap<String, Object>();
			List<Favorite> flist = favoriteService.selectByTid(tid, userid);

			if (flist.size() > 0) {
				//取消点赞
				int a = favoriteService.deleteByPrimaryKey(flist.get(0).getId());
				Topic topic = topicService.selectByPrimaryKey(tid);
				topic.setLikeNum(topic.getLikeNum() - 1);
				topicService.updateByPrimaryKey(topic);
				dmap.put("stust", 1);
				dmap.put("likeNum", topic.getLikeNum());
			} else {
				//点赞成功
				Favorite favorite = new Favorite();
				favorite.setCreateTime(new Date());
				favorite.setUid(userid);
				favorite.setTid(tid);
				favorite.setStyle(1);
				int a = favoriteService.insertSelective(favorite);
				Topic topic = topicService.selectByPrimaryKey(tid);
				topic.setLikeNum(topic.getLikeNum() + 1);
				topicService.updateByPrimaryKey(topic);
				dmap.put("stust", 2);
				dmap.put("likeNum", topic.getLikeNum());


				//积分记录
				Map<String,Object> param = new HashMap<>();
				//pid为空则为评论表的数据，不为空则为回复表的数据
				param.put("uId",userid);
				param.put("tId",tid);
				param.put("relatedUserId",user.getId());//点赞人的id
				param.put("sType",5); // 5-帖子被点赞
				List<ForumScoreDetail> list = forumScoreDetailService.selectList(param);
				if(list.size()==0) {
					Topic topic1 = topicService.selectByPrimaryKey(tid);
					//插入一条积分获取记录
					ForumScoreDetail fsd = new ForumScoreDetail();
					fsd.setUId(topic1.getUid());
					fsd.setSFrom("帖子被点赞，+"+ ReturnInfoType.BY_THUMB_UP_TOPIC +"分");
					fsd.setSValue(ReturnInfoType.BY_THUMB_UP_TOPIC);
					fsd.setTId(tid);
					fsd.setRelatedUserId(user.getId());
					fsd.setCreateTime(new Date());
					fsd.setsType(5);// 5-帖子被点赞
					forumScoreDetailService.insertSelective(fsd);

					//加积分
					ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid(topic1.getUid());
					forumUserInfo.setScore(forumUserInfo.getScore()+ReturnInfoType.BY_THUMB_UP_TOPIC);
					forumUserInfo.setModifyTime(new Date());
					forumUserInfoService.updateByPrimaryKeySelective(forumUserInfo);

				}

			}
			return toJSONString(dmap);
		}

	}

	/**
	 * 查询用户是否点赞过帖子
	 * @param tid
	 * @param userid
	 * @return
	 */
	@RequestMapping(value = "/selectUserLikeIt")
	@ResponseBody
	public String selectUserLikeIt(int tid, String userid){
		if(userid.equals("")){
			return ResData.FAIL().toString();
		}
		List<Favorite> flist = favoriteService.selectByTid(tid, userid);
		return flist.size()>0? ResData.SUCCESS().toString():ResData.FAIL().toString();
	}


	/**
	 * 评论点赞
	 *
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/likeitTwo", method = RequestMethod.GET)
	@ResponseBody
	public String likeitTwo(int tid, String userid, int cid,HttpServletRequest request, HttpServletResponse response,
						 ModelMap map) {
		User user = getUser(request);
		if (user == null) {// 如果用户不存在
			return ReturnInfoType.ERROR;
		} else {
			Map<String, Object> pmap = new HashMap<String, Object>();
			Map<String, Object> dmap = new HashMap<String, Object>();
			List<Favorite> flist = favoriteService.selectByCid(userid, tid,cid);
			if (flist.size() > 0) {
				int a = favoriteService.deleteByPrimaryKey(flist.get(0).getId());
				Comment comment=commentService.selectByPrimaryKey(cid);
				comment.setLikeNum(comment.getLikeNum()-1);
				commentService.updateByPrimaryKeySelective(comment);
				dmap.put("stust", 1);
				dmap.put("likeNum", comment.getLikeNum());
			} else {
				Favorite favorite = new Favorite();
				favorite.setCreateTime(new Date());
				favorite.setUid(userid);
				favorite.setTid(tid);
				favorite.setStyle(1);
				favorite.setEventId(cid);
				int a = favoriteService.insertSelective(favorite);
				Comment comment=commentService.selectByPrimaryKey(cid);
				comment.setLikeNum(comment.getLikeNum()+1);
				commentService.updateByPrimaryKeySelective(comment);
				dmap.put("stust", 2);
				dmap.put("likeNum", comment.getLikeNum());

                //积分记录
                Map<String,Object> param = new HashMap<>();
                //pid为空则为评论表的数据，不为空则为回复表的数据
                param.put("uId",userid);
                param.put("tId",tid);
                param.put("relatedUserId",user.getId());//点赞人的id
                param.put("sType",6); // 6-评论被点赞
                List<ForumScoreDetail> list = forumScoreDetailService.selectList(param);
                if(list.size()==0) {
                    Topic topic1 = topicService.selectByPrimaryKey(tid);
                    //插入一条积分获取记录
                    ForumScoreDetail fsd = new ForumScoreDetail();
                    fsd.setUId(topic1.getUid());
                    fsd.setSFrom("评论被点赞，+"+ ReturnInfoType.BY_THUMB_UP_COMMENT +"分");
                    fsd.setSValue(ReturnInfoType.BY_THUMB_UP_COMMENT);
                    fsd.setTId(tid);
                    fsd.setRelatedUserId(user.getId());
                    fsd.setCreateTime(new Date());
                    fsd.setsType(6);// 6-评论被点赞
                    forumScoreDetailService.insertSelective(fsd);

                    //加积分
                    ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid(topic1.getUid());
                    forumUserInfo.setScore(forumUserInfo.getScore()+ReturnInfoType.BY_THUMB_UP_COMMENT);
                    forumUserInfo.setModifyTime(new Date());
                    forumUserInfoService.updateByPrimaryKeySelective(forumUserInfo);

                }
			}
			return toJSONString(dmap);
		}

	}

	/*查询评论点赞*/
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	@ResponseBody
	public String select(int tid, String userid, int cid,HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		List<Comment> comments=commentService.selectByCid(tid,cid);
			if(comments.size()>0){
				map.put("status",ReturnInfoType.SUCEEESS);
				map.put("comments",comments);
			}else{
				map.put("status",ReturnInfoType.FAIL);
			}

		return toJSONString(map);

	}

	/**
	 * 分页查询列表 后台
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/selectList",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectList(Comment comment, Integer pageNum,String startTime,String endTime, HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> rMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = MapUtils.beanToMap(comment);
		if(!startTime.equals("")){
			startTime = startTime + " 00:00:00";
			paramMap.put("startTime",startTime);
		}
		if(!endTime.equals("")){
			endTime = endTime + " 23:59:59";
			paramMap.put("endTime",endTime);
		}
		// 此处查询需要自行编写
		PageHelper.startPage(getPageNum2(pageNum),pageSize);
		//lists 的数据为表t_comment和表t_toconmment的总合
		List<Comment> lists = commentService.selectList(paramMap);
		PageInfo<Comment> p2 = new PageInfo<Comment>(lists);
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
	 * 评论、回复审核
	 * @param comment
	 * @return
	 */
	@RequestMapping(value = "/verify",method = RequestMethod.POST)
	@ResponseBody
	public String verify(Comment comment){
		Map<String,Object> rMap = new HashMap<>();

		String uId = null;
		Integer tId = null;

		Toconmment toconmment = null;
		int res = 0;
		//pid为空则为评论表的数据，不为空则为回复表的数据
		if (comment.getPid() == null){
			res = commentService.updateByPrimaryKeySelective(comment);
			comment = commentService.selectByPrimaryKey(comment.getId());
			uId = comment.getUid();
			tId = comment.getTid();
		}else{
			toconmment = new Toconmment();
			toconmment.setId(comment.getId());
			toconmment.setVerify(comment.getVerify());
			res = toconmmentService.updateByPrimaryKeySelective(toconmment);
			toconmment = toconmmentService.selectByPrimaryKey(toconmment.getId());
			uId = toconmment.getUserId();
			tId = toconmment.getTid();
		}
		if(res>0){

			//1.查询帖子的言论数
			Map<String,Object> tidMap = new HashMap<>();
			tidMap.put("tid",tId);
			int count = commentService.selectBytidCount(tidMap);

			//2.重置帖子评论数
			Topic topic = topicService.selectByPrimaryKey(comment.getTid());
			topic.setComment(count);
			int a = topicService.updateByPrimaryKey(topic);

			rMap.put("msg","操作成功");
			rMap.put("status",1);

			//审核通过
			if(comment.getVerify().equals(1)){

				Map<String,Object> param = new HashMap<>();
				param.put("uId",uId);
				param.put("tid",tId);
				if(toconmment != null){ //如果是回复别人，则获取被回复人的id
					param.put("relatedUserId",toconmment.getToUserId());
				}

				param.put("sType",2); // 2-评论回复成功
				List<ForumScoreDetail> list = forumScoreDetailService.selectList(param);

				if(list.size()==0){
					//插入一条积分获取记录
					ForumScoreDetail fsd = new ForumScoreDetail();
					fsd.setUId(uId);
					fsd.setSFrom("评论、回复成功，+"+ ReturnInfoType.COMMENT +"分");
					fsd.setSValue(ReturnInfoType.COMMENT);
					fsd.setTId(tId);
                    if(toconmment != null){ //如果是回复别人，则插入被回复人的id
                        fsd.setRelatedUserId(toconmment.getToUserId());
                    }
					fsd.setCreateTime(new Date());
					fsd.setsType(2);
					forumScoreDetailService.insertSelective(fsd);

					//加积分
					ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid(uId);
					if(forumUserInfo != null){
						forumUserInfo.setScore(forumUserInfo.getScore()+ReturnInfoType.COMMENT);
						forumUserInfo.setModifyTime(new Date());
						forumUserInfoService.updateByPrimaryKeySelective(forumUserInfo);
					}
				}
			}
		}else{
			rMap.put("msg","操作失败");
			rMap.put("status",0);
		}
		return toJSONString(rMap);
	}


	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	@ResponseBody
	public String delete(Comment comment){
		Map<String,Object> rMap = new HashMap<>();
		//pid为空则为评论表的数据，不为空则为回复表的数据
		int res = 0;
		if (comment.getPid() == null){
			Comment comment1 = commentService.selectByPrimaryKey(comment.getId());
			res = commentService.deleteByPrimaryKey(comment.getId());

			//评论数加-1
			Topic topic = topicService.selectByPrimaryKey(comment1.getTid());
			if(topic != null && topic.getComment()>0){
				topic.setComment(topic.getComment() - 1);
				int a = topicService.updateByPrimaryKey(topic);
			}
		}else{
			res = toconmmentService.deleteByPrimaryKey(comment.getId());
		}
		if(res>0){
			rMap.put("msg","操作成功");
			rMap.put("status",1);
		}else{
			rMap.put("msg","操作失败");
			rMap.put("status",0);
		}
		return toJSONString(rMap);
	}
}
