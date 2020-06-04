package com.cen.appsite.feedback.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.HttpUtil;
import com.cen.common.util.ReturnInfoType;
import com.cen.feedback.entity.Feedback;
import com.cen.feedback.service.FeedbackService;
import com.cen.ucenter.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value="/appsite/feedback")
public class APPFeedbackController extends BaseController {
	
	@Autowired
	private FeedbackService feedbackService;

	
	/**--
	 * 反馈信息新增方法
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/insert",method=RequestMethod.POST,produces = "application/json;charset=utf-8")
	@ResponseBody
	public String insert(String contain,String phone,String mac,String version,  HttpServletRequest request, HttpServletResponse response){
             
		Map<String, Object> map = new HashMap<String,Object>();
		Feedback feedback=new Feedback();
		//HttpUtil hu=new HttpUtil();
		User user = getUser(request);//用户
		//System.out.printf("siudahks"+user.getEducation());
		if(version!=null&version!="")feedback.setVersion(version);
		if(mac!=null&mac!="")feedback.setMac(mac);

		feedback.setDate(new Date());//日期
		feedback.setReadIf(0);//设置未读
		feedback.setIp(HttpUtil.getIpAddr(request));//获取请求设备ip
		feedback.setIsDel(0);//设置未删除
		feedback.setPhone(phone);
		feedback.setContain(contain);
		if(user==null){
			feedback.setUser("游客");//用户名称
		}else {
			feedback.setUser(user.getName());//用户名称
		}

		//System.out.printf(feedback.getContain());
		int recond = feedbackService.insertSelective(feedback);
		if(recond == 1){
			map.put("msg", "信息反馈成功");
			map.put("status", ReturnInfoType.SUCEEESS);
		}else{
			map.put("msg", "信息反馈失败");
			map.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(map);
	}

	
}
