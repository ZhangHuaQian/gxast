package com.cen.bbs.favorite.controller;


import com.cen.bbs.favorite.entity.Favorite;
import com.cen.bbs.favorite.service.FavoriteService;
import com.cen.bbs.comment.service.CommentService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
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
@RequestMapping("/Favorite")
public class FavoriteController extends BaseController {


	@Autowired
	FavoriteService favoriteService;
	@Autowired
	UserService userService;
	@Autowired
	CommentService commentService;

	/**
	 * 添加apk
	 *
	 * @param
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(Favorite favorite, String userid, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> cmap = new HashMap<String, Object>();
		/*Favorite.setCreateTime(new Date());
		Favorite.setUpdateTime(new Date());
		Favorite.setUid(userid);
		Favorite.setNid(1);
		Favorite.setIsDel(0);
		Favorite.setStatus(1);*/
		//int a=FavoriteService.insertSelective(favorite);
		cmap.put("msg", "发布成功");
		cmap.put("status", ReturnInfoType.SUCEEESS);
		return toJSONString(cmap);
	}



	/**
	 * 查询所有地址
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectList", method = RequestMethod.GET)
	@ResponseBody
	public String selectList(String userid, int pageNum, HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("userid", userid);
		//List<favorite> FavoriteList=FavoriteService.selectList( pmap);

		/*dmap.put("list", FavoriteList);
		dmap.put("count", FavoriteList.size());*/
		return toJSONString(dmap);
	}
	/**
	 * 查询用户默认地址
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/getuserfavorite", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String getuserfavorite(int userid,HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> dmap = new HashMap<String, Object>();
		//favorite Favorite=FavoriteService.getuserfavorite(userid);
		//dmap.put("favorite", favorite);
		return toJSONString(dmap);
	}
	/**
	 * 查询用户默认地址
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/details", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
	public String getdetails(int id,HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Favorite favorite=favoriteService.selectByPrimaryKey(id);
		/*User user=userService.selectByPrimaryKey(Favorite.getUid());
		if(Favorite.getClickNum()==null){
			Favorite.setClickNum(1);
		}else{
			Favorite.setClickNum(Favorite.getClickNum()+1);
		}*/
		int a=favoriteService.updateByPrimaryKey(favorite);
		request.setAttribute("Favorite",favorite);
		//request.setAttribute("user",user);
		return "web/bbs/details";
	}


	/**
	 * 查询用户发布的帖子
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectmyFavorite", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectmyFavorite(String userid,int pageNum, HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("userid", userid);
	/*	List<favorite> Favorite=FavoriteService.selectmyFavorite(pmap);
		int count = FavoriteService.selectListCount(pmap);  //记录行数*/

		/*dmap.put("list", Favorite);
		dmap.put("count", count);*/
		return toJSONString(dmap);
	}
	/**
	 * 分页查询帖子
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectAllFavorite", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectAllFavorite(int pageNum, HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		//pmap.put("userid", userid);
		/*List<Objects> Favorite=FavoriteService.selectAllFavorite(pmap);
		int count = FavoriteService.selectAllFavoriteCount(pmap);  //记录行数
		dmap.put("list", Favorite);
		dmap.put("count", count);*/
		return toJSONString(dmap);
	}

	/**
	 * 根据id删除apk
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(int id, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		/*favorite rr=FavoriteService.selectByPrimaryKey(id);
		int result = FavoriteService.deleteByPrimaryKey(id);
		int aa=commentService.deleteAllMcomment(rr.getTid());
		if (result == 1) {
			umap.put("msg", "删除成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "删除失败");
			umap.put("status", ReturnInfoType.FAIL);
		}*/
		return toJSONString(umap);
	}

	/**
	 * 跳转update更新页面
	 * @param id
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/toupdate", method = RequestMethod.GET)
	@ResponseBody
	public String toupdate(int id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		/*favorite Favorite = FavoriteService.selectByPrimaryKey(id);
		umap.put("Favorite", Favorite);*/
		return toJSONString(umap);
	}
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(int id, Favorite favorite, HttpServletRequest request, HttpServletResponse response,
						 ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		/*favorite.setTid(id);*/
		/*favorite.setfavorite(favorite.getProvince()+favorite.getCity()+favorite.getArea());*/
		int count = favoriteService.updateByPrimaryKeySelective(favorite);
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
