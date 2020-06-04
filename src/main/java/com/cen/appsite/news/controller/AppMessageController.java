package com.cen.appsite.news.controller;

import com.cen.Message.entity.Message;
import com.cen.Message.service.MessageService;
import com.cen.MessageLog.entity.MessageLog;
import com.cen.MessageLog.service.MessageLogService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.dictionary.service.DictionaryService;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;
import com.cen.praise.entity.Praise;
import com.cen.praise.service.PraiseService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.cen.upms.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value="/appsite/phoneMessage")
public class AppMessageController extends BaseController {

	@Autowired
	MessageService messageService;
	@Autowired
	MessageLogService messageLogService;
	@Autowired
	UserService userService;


	/**
	 * 查询列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/getMyMessageTB",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String getMyMessageTB(Message message, Integer limit, Integer page, HttpServletRequest request, HttpServletResponse response){
		User user = getUser(request);
		Map<String,Object> map = new HashMap<>();
		Map<String,Object> params = new HashMap<>();
		Map<String,Object> params2 = new HashMap<>();
		MessageLog messageLog = new MessageLog();
		messageLog.setRecid(user.getId());
		params.put("messagelog",messageLog);
		params.put("limit",limit);
		params.put("page",(page-1)*limit);
		params2.put("messagelog",messageLog);
		List<Map> messages = messageService.getMyPrivateMessage(params);
		map.put("code",0);
		map.put("count",messageService.getMyPrivateMessage(params2).size());
		map.put("data",messages);
		map.put("msg","ok");
		map.put("status",ReturnInfoType.SUCEEESS);
		return toJSONString(map);
	}

	/**
	 * 读消息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/read",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String read(Integer id,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> rMap = new HashMap<String, Object>();
		Message message = messageService.selectByPrimaryKey(id);
		message.setStatus("1");
		int count = messageService.updateByPrimaryKey(message);
		if(count==1){
			rMap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			rMap.put("status", ReturnInfoType.ERROR);
		}
		return toJSONString(rMap);
	}
	/**
	 * 删除
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/delete",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String delete(Integer id,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> rMap = new HashMap<String, Object>();
		int count = messageService.deleteByPrimaryKey(id);
		if(count==1){
			rMap.put("msg", "操作成功");
			rMap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			rMap.put("msg", "操作失败");
			rMap.put("status", ReturnInfoType.ERROR);
		}
		return toJSONString(rMap);
	}

	/*消息详情*/
	@RequestMapping(value="/details",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String details(int id,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> rMap = new HashMap<String, Object>();
		Message res = messageService.selectByPrimaryKey(id);

		rMap.put("data", res);
		rMap.put("msg", "操作成功");
		rMap.put("status", ReturnInfoType.SUCEEESS);
		return toJSONString(rMap);
	}


}
