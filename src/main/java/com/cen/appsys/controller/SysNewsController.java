package com.cen.appsys.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;
import com.cen.ucenter.entity.User;

@Controller
@RequestMapping("/appsys/news")
public class SysNewsController extends BaseController{
	@Autowired
	NewsService newsService;
	
	/**
	 * 编辑
	 * @param
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/news_edit",method=RequestMethod.GET)
	public String news_edit(Integer id,HttpServletRequest request,HttpServletResponse response,ModelMap map){
		News news = newsService.selectByPrimaryKey(id);
		request.setAttribute("news", news);
		return "appsys/news_edit";
	}
	/**
	 * 更新操作
	 * @param
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public String update(Integer id,News news,HttpServletRequest request,HttpServletResponse response,ModelMap map){
		Map<String, Object> umap = new HashMap<String, Object>();
		news.setModifyTime(new Date());
		news.setId(id);
		int count = newsService.updateByPrimaryKeySelective(news);
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
	 * 分页查询所有资讯
	 * @param
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/selectNews",method=RequestMethod.GET)
	@ResponseBody
	public String selectList(Integer pageNum,String title,HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {
		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		User user = getUser(request);
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("title", title);
		pmap.put("userId", user.getId());
		List<News> list = newsService.selectList(pmap); //列表
		int count = list.size();
		if(!isEmpty(list)) dmap.put("list", list);
		dmap.put("count", count);
		return toJSONString(dmap);
	}
	/**
	 * 根据id删除资讯
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
		News news=newsService.selectByPrimaryKey(id);
		news.setIsDel(1);//假删除
		int result=newsService.updateByPrimaryKeySelective(news);
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
	 * 添加新闻资讯
	 * @param
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	@ResponseBody
	public String insert(News news,HttpServletRequest request,HttpServletResponse response){
      Map<String, Object> cmap = new HashMap<String, Object>();
      System.out.println(news.getContent());
      news.setCreateTime(new Date());
      news.setModifyTime(new Date());
      news.setIsDel(0);
      news.setAuthor(getUser(request).getName());
      news.setUserId(getUser(request).getId());
      int result=newsService.insertSelective(news);
      if (result==1) {
    	  cmap.put("msg", "资讯添加成功");
	      cmap.put("status", ReturnInfoType.SUCEEESS);
	      return toJSONString(cmap);
      }
      else {
    	  cmap.put("msg", "资讯添加失败");
	      cmap.put("status", ReturnInfoType.FAIL);
	      return toJSONString(cmap);
      }
	}
}
