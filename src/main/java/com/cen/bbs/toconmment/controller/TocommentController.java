package com.cen.bbs.toconmment.controller;


import com.cen.bbs.comment.entity.Comment;
import com.cen.bbs.comment.service.CommentService;
import com.cen.bbs.favorite.entity.Favorite;
import com.cen.bbs.favorite.service.FavoriteService;
import com.cen.bbs.topic.entity.Topic;
import com.cen.bbs.topic.service.TopicService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
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
@RequestMapping("/tocomment")
public class TocommentController extends BaseController{



	/**
	 * 根据城市查询下级地市
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/answer",method=RequestMethod.POST)
	@ResponseBody
	public String answer(String userid,String toid,int tid,String rcontent, HttpServletRequest request,HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		System.out.println(userid);
		System.out.println(userid);
		System.out.println(toid);
		if(tid>0){
			for(int i=0;i<tid;i++){
				System.out.println(i*9);
			}
		}
		System.out.println(tid);
		System.out.println(userid);
		dmap.put("status", ReturnInfoType.SUCEEESS);
		return toJSONString(dmap);
	}
}

