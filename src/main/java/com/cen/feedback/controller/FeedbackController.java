package com.cen.feedback.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.feedback.entity.Feedback;
import com.cen.feedback.service.FeedbackService;
import com.cen.ucenter.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/sys/feedback")
public class FeedbackController extends BaseController {
	
	@Autowired
	private FeedbackService feedbackService;


	/**
	 * 分页查询
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value="/selectList",method=RequestMethod.GET)
	@ResponseBody
	public String SelectList( Integer pageNum,String container,HttpServletRequest request,
                             HttpServletResponse response, ModelMap map) throws ParseException{
		/*Date start = null;
		Date end = null;
		if (!isEmpty(date1) && !isEmpty(date2)) {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			start = df.parse(date1);
			end = df.parse(date2);
		}*/
		User user = getUser(request);
		Map<String, Object> pmap = new HashMap<String, Object>();//传入查询map
		Map<String, Object> smap = new HashMap<String, Object>();//查询结果map
		//pmap = MapUtils.beanToMap(feedback);
		if(!isEmpty(container))pmap.put("container",container);
		pmap.put("pageNum",getPageNum(pageNum));
		pmap.put("pageSize",pageSize);

		List<Feedback> list = feedbackService.selectList(pmap);  //列表

		int count = feedbackService.selectListCount(pmap);  //列表数
		/*for (int i=0;i<list.size();i++){
			System.out.printf(list.get(i).getContain());
			logger.debug(list.get(i).getContain());
		}*/

		if(!isEmpty(list)) smap.put("list", list);
		smap.put("count", count);
		return toJSONString(smap);
	}
	
	/**
	 * 
	 * @param feedback
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public String update(Feedback feedback, HttpServletRequest request, HttpServletResponse response, ModelMap map){
		Map<String, Object> umap = new HashMap<String, Object>();
		int count = feedbackService.updateByPrimaryKeySelective(feedback);
		if(count == 1){
			umap.put("msg", "更新成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			umap.put("msg", "更新失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
	
	/**
	 * 删除
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public String delete(int id,HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Feedback feedback=feedbackService.selectByPrimaryKey(id);
		int result=feedbackService.updateByPrimaryKeySelective(feedback);
		if(result == 1){
			umap.put("msg", "删除成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			umap.put("msg", "删除失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
	
	/**
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/select", method = RequestMethod.GET,produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectById(int id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Feedback feedback = feedbackService.selectByPrimaryKey(id);
		if (!isEmpty(feedback))
			smap.put("product", feedback);

		return toJSONString(smap);
	}
	/**
	 * 日期转化器
	 * @param binder
	 */
	@InitBinder
	public void transferToDate(WebDataBinder binder){
	binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"),true));
	}
	
	
}
