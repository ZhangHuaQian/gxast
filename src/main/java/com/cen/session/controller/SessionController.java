package com.cen.session.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.operateLog.annotation.UserOperate;
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
@RequestMapping("/sys/session")
public class SessionController extends BaseController{

	@Autowired
	SessionService sessionService;
	@Autowired
	private UserService userService;
	//敏感词检测
	@RequestMapping(value="/TextAudit", method=RequestMethod.POST)
	@ResponseBody
	public int TextAudit(String txt,HttpServletRequest request,HttpServletResponse response){
		/*Set result = new HashSet(sessionService.selectAll());
		//初始化敏感词库
        SessionService.initSessionWordMap(result);
        //是否含有关键字
        boolean flag = SessionService.contains(txt,2);
        System.out.println(txt);
		return flag?1:0;*/
		return 0;
	}
	/**
	 * 添加敏感词
	 * @param
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value="/insert", method=RequestMethod.POST)
	@ResponseBody
	public String insert(Session session,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> cmap = new HashMap<String, Object>();
		int result=sessionService.insertSelective(session);
		if (result==1) {
			cmap.put("msg", "添加成功");
			cmap.put("status", ReturnInfoType.SUCEEESS);
			return toJSONString(cmap);
		}
		else {
			cmap.put("msg", "添加失败");
			cmap.put("status", ReturnInfoType.FAIL);
			return toJSONString(cmap);
		}
	}
	/**
	 * 根据id删除
	 * @param id
	 * @param request
	 * @param response
	 * @param
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public String delete(int id,HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		int result=sessionService.deleteByPrimaryKey(id);
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
	 * 分页查询所有资讯
	 * @param
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/selectList",method=RequestMethod.GET)
	@ResponseBody
	public String selectList(Session session,Integer pageNum,String name,String type,HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		
		pmap = MapUtils.beanToMap(session);
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("sname", name);
		pmap.put("sprofile",type);
		pmap.put("pageSize", pageSize);
		List<Session> list = sessionService.selectList(pmap); //列表
		int count =sessionService.selectListCount(pmap);  //记录行数
		if(!isEmpty(list)) dmap.put("list", list);
		dmap.put("count", count);
		return toJSONString(dmap);
	}
	/**
	 * 分页查询所有资讯
	 * @param
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/selectAll",method=RequestMethod.GET)
	@ResponseBody
	public String selectAll(HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {
		Map<String, Object> dmap = new HashMap<String, Object>();
		List<Session> list = sessionService.selectAll(); //列表
		if(!isEmpty(list)) dmap.put("list", list);
		return toJSONString(dmap);
	}
	/**
	 * 分页查询所有资讯
	 * @param
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.GET)
	public String update(Integer id,HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {
		Map<String, Object> dmap = new HashMap<String, Object>();
		Session session = sessionService.selectByPrimaryKey(id); //列表
		request.setAttribute("session",session);
		return "web/user/session/update";
	}

	/*根据id查询论坛版块*/
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(int id, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Session session = sessionService.selectByPrimaryKey(id);
		if (!isEmpty(session))
			smap.put("session", session);

		return toJSONString(smap);
	}
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(Integer id, Session session, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		session.setSid(id);
		int count = sessionService.updateByPrimaryKey(session);
		System.out.println(count);
		if (count == 1) {
			umap.put("msg", "更新成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "更新失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}

}
