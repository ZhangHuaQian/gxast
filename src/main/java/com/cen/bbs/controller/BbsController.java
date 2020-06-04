package com.cen.bbs.controller;


import com.cen.common.controller.BaseController;
import com.cen.link.dao.LinkDao;
import com.cen.link.entity.Link;
import com.cen.link.service.LinkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/web/bbs/")
public class BbsController extends BaseController {
	@Autowired
	private LinkService linkService ;
	/**
	 * 跳转update更新页面

	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String toupdate( HttpServletRequest request, HttpServletResponse response,ModelMap map) {

		Map<String, Object> returnmap = new HashMap<String, Object>();

		List<Link> list=linkService.selectreturn(returnmap);

		map.put("list",list);
		return "web/bbs/index";
	}


}
