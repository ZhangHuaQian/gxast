package com.cen.news_xbsb.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.news_xbsb.entity.Xbsb;
import com.cen.news_xbsb.service.XbsbService;
import com.cen.operateLog.annotation.UserOperate;
import com.cen.praise.entity.Praise;
import com.cen.praise.service.PraiseService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.cen.upms.entity.Department;
import com.cen.upms.service.DepartmentService;
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
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/sys/xbsb")
public class XbsbController extends BaseController {

	@Autowired
	private XbsbService xbsbService;
	@Autowired
	private DepartmentService DepartmentService;
	@Autowired
	private NewsCommentService newsCommentService;

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
	public String insert(Xbsb xbsb, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> cmap = new HashMap<String, Object>();
		xbsb.setCreateTime(new Date());
		xbsb.setModifyTime(new Date());
		xbsb.setIsDel(0);
		//xbsb.setAuthor(getUser(request).getName());
		xbsb.setUserId(getUser(request).getId());
		int result = xbsbService.insertSelective(xbsb);
		if (result == 1) {
			cmap.put("msg", "资讯添加成功");
			cmap.put("status", ReturnInfoType.SUCEEESS);

		} else {
			cmap.put("msg", "资讯添加失败");
			cmap.put("status", ReturnInfoType.FAIL);

		}
		return toJSONString(cmap);
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
	@RequestMapping(value = "/select", method = RequestMethod.GET,produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectById(int id, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Xbsb xbsb = xbsbService.selectByPrimaryKey(id);
		if (!isEmpty(xbsb))
			smap.put("xbsb", xbsb);

		return toJSONString(smap);
	}



	/**
	 * 分页查询所有资讯
	 *
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectList", method = RequestMethod.GET)
	@ResponseBody
	public String selectList(Xbsb xbsb, Date start, Date end, Integer pageNum, HttpServletRequest request,
							 HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();

		User user = getUser(request);
		String did = user.getDid();//获取当前用户的部门id
		List<Department> departments = DepartmentService.selectByThisUser(did);
		List<String> deList = new ArrayList<String>();
		for (int i = 0; i < departments.size(); i++) {
			deList.add(departments.get(i).getId());
		}

		pmap = MapUtils.beanToMap(xbsb);
		pmap.put("departments", deList);
		pmap.put("start", start);
		pmap.put("end", end);
		pmap.put("did", user.getDid());
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);

		List<Xbsb> list = xbsbService.selectList(pmap); //列表
		int count = xbsbService.selectListCount(pmap);  //记录行数

		if (!isEmpty(list)) dmap.put("list", list);
		dmap.put("count", count);

		return toJSONString(dmap);
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
	public String update(Integer id, Xbsb xbsb, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		xbsb.setModifyTime(new Date());
		xbsb.setId(id);
		int count = xbsbService.updateByPrimaryKeySelective(xbsb);
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
	 * 跳转更新页面
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/toupdate", method = RequestMethod.GET)
	public String toupdate(int id, HttpServletRequest request, HttpServletResponse response) {
		Xbsb xbsb = xbsbService.selectByPrimaryKey(id);
		request.setAttribute("xbsb", xbsb);
		return "sys/xbsb/edit";
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
	@RequestMapping(value = "/news", method = RequestMethod.GET)
	public String view(int id, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Xbsb xbsb = xbsbService.selectByPrimaryKey(id);
		request.setAttribute("xbsb", xbsb);
		return "sys/xbsb/news";
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
		Xbsb xbsb = xbsbService.selectByPrimaryKey(id);
		xbsb.setIsDel(1);//假删除
		int result = xbsbService.updateByPrimaryKeySelective(xbsb);
		newsCommentService.deleteAllMcomment(xbsb.getId());
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






	
}
