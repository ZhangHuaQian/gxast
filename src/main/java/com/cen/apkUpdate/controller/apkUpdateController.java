package com.cen.apkUpdate.controller;

import java.io.File;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.apkUpdate.entity.ApkUpdate;
import com.cen.apkUpdate.service.apkUpdateService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.CreateQRCode;
import com.cen.common.util.ReturnInfoType;

@Controller
@RequestMapping("/sys/apkUpdate")
public class apkUpdateController extends BaseController {

	@Autowired
	apkUpdateService apkUpdateService;

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
	public String insert(ApkUpdate apkUpdate, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> cmap = new HashMap<String, Object>();
		apkUpdate.setCreateTime(new Date());
		apkUpdate.setIsDel(0);
		String[] string= apkUpdate.getPath().split("\\.");
		string[string.length-1]="";
		String string2= String.join("", string);
		apkUpdate.setQrcode(system_base+system_base_photo+string2+"."+"jpg");
		CreateQRCode.CreateQrCode(system_base+system_base_apk+apkUpdate.getPath(), system_USER_PHOTO_RESOUREC+File.separator+string2+"."+"jpg");
		apkUpdateService.insert(apkUpdate);
		cmap.put("msg", "添加成功");
		cmap.put("status", ReturnInfoType.SUCEEESS);
		return toJSONString(cmap);
	}



	/**
	 * 查询所有apk
	 * 
	 * @param apkUpdate
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectList", method = RequestMethod.GET)
	@ResponseBody
	public String selectAllList(ApkUpdate apkUpdate, HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		List<ApkUpdate> aList=apkUpdateService.selectAll();
		pmap.put("list", aList);
		return toJSONString(pmap);
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
		int result = apkUpdateService.deleteByPrimaryKey(id);
		if (result == 1) {
			umap.put("msg", "删除成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "删除失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}

}
