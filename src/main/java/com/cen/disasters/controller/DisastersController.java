package com.cen.disasters.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.cen.common.controller.BaseController;
import com.cen.common.util.FileUtilImpl;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.common.util.VideoUtil;
import com.cen.disasters.entity.Disasters;
import com.cen.disasters.service.DisastersService;
import com.cen.operateLog.annotation.UserOperate;
import com.cen.ucenter.entity.User;
import com.cen.upms.entity.Department;
import com.cen.upms.service.DepartmentService;



@Controller
@RequestMapping("/sys/disasters")
public class DisastersController extends BaseController {
	
	@Autowired
	private DisastersService disastersService;
	@Autowired
	private DepartmentService DepartmentService;
	
	/**
	 * 添加数据
	 * @param disasters
	 * @param request
	 * @param response
	 * @param
	 * @return
	 */
	/*@RequestMapping(value="/insert",method=RequestMethod.POST)
	@ResponseBody
	public String insert(Disasters disasters,HttpServletRequest request,HttpServletResponse response, ModelMap map){
		Map<String, Object> dmap = new HashMap<String, Object>();
		
		User user = getUser(request);
		disasters.setUserid(user.getId());
		disasters.setUsername(user.getName());
		disasters.setCreatetime(new Date());
		disasters.setIsDel(0);
		disasters.setWarningLevel(1);
		
		int recond = disastersService.insertSelective(disasters);
		if(recond == 1){
			dmap.put("msg", "添加成功");
			dmap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			dmap.put("msg", "添加失败");
			dmap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(dmap);
	}*/
	//敏感词检测
	@RequestMapping(value="/TextAudit", method=RequestMethod.POST)
	@ResponseBody
	public String TextAudit(Disasters disasters,HttpServletRequest request,HttpServletResponse response){
	  return com.cen.news.util.TextAudit.Text_Audit(disasters.getTitle()+disasters.getDescript()+disasters.getContent());
	}
	/**
	 * 插入数据
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 */
	@UserOperate(moduleName="防灾减灾",option = "上传视频")
	@RequestMapping(value = "/insertVideo",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String insertVideo(MultipartFile file,HttpServletRequest request,HttpServletResponse response){
       MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
        User user = getUser(request);
		Disasters dis = new Disasters();
		dis.setTitle(multipartRequest.getParameter("title"));
		dis.setDescript(multipartRequest.getParameter("descript"));
		dis.setVideo(multipartRequest.getParameter("video"));
		dis.setContent(multipartRequest.getParameter("content"));
        dis.setTypeValue(Integer.valueOf(multipartRequest.getParameter("typeValue")));
        dis.setIsDel(0);
        dis.setUserid(user.getId());
        dis.setUsername(user.getName());
        dis.setCreatetime(new Date());   
        dis.setWarningLevel(1);
        
        //String path = request.getServletContext().getRealPath(ReturnInfoType.VIDEO_RESOUREC); //视频路径
        //String img_path = request.getServletContext().getRealPath(ReturnInfoType.USER_PHOTO_RESOUREC); //图片路径
		String path = system_VIDEO_RESOUREC; //视频路径
		String img_path = system_USER_PHOTO_RESOUREC; //图片路径
        String filename = "";
        FileUtilImpl fiImpl = new VideoUtil();
        if(file.isEmpty()){
        	System.out.println("视频文件为空");
        }
        else if(!file.isEmpty()){
    	filename = fiImpl.fileUpLoad(file, path).get("trueFileName").toString();
        
        String img = (String) filename.substring(0,filename.lastIndexOf("."))+".jpg";
        System.out.println("---图片名称---:"+img);
        String ffpath = this.getClass().getClassLoader().getResource("/conf/util/ffmpeg.exe").getPath();
        System.out.println("---插件路径---:"+ffpath);
        String videopath =path+"\\"+ filename;
        System.out.println("---视频路径---:"+videopath);
        String imgpath = img_path+"\\"+img;
        System.out.println("---图片路径---:"+imgpath);
        
        /*try {
			fetchFrame(videopath, imgpath);
		} catch (Exception e) {
			e.printStackTrace();
		}*/
        boolean boo = handlerImg(ffpath, videopath, imgpath);
     
        if(boo)dis.setImage(img);
        dis.setVideo(filename);
        }
        int recond = disastersService.insertSelective(dis);
        if(recond == 1){
        	return ReturnInfoType.SUCEEESS;
        }else
		return ReturnInfoType.FAIL;
	}
	
	/**
	 * 假删除数据
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@UserOperate(moduleName="防灾减灾",option = "删除视频")
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public String delete(int id,HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Disasters disasters = disastersService.selectByPrimaryKey(id);
		disasters.setIsDel(1);//假删除
		int result=disastersService.updateByPrimaryKeySelective(disasters);
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
	 * 更新数据
	 * @param disasters
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	/*@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public String update(Disasters disasters,HttpServletRequest request,HttpServletResponse response,ModelMap map){
		Map<String, Object> dmap = new HashMap<String, Object>();
		int count = disastersService.updateByPrimaryKeySelective(disasters);
		if(count == 1){
			dmap.put("msg", "更新成功");
			dmap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			dmap.put("msg", "更新失败");
			dmap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(dmap);
	}*/
	
	/**
	 * 更新数据
	 * @param id
	 * @param videoUrl
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 */
	@UserOperate(moduleName="防灾减灾",option = "更新视频")
	@RequestMapping(value = "/updateVideo",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updateVideo(int id,String videoUrl,MultipartFile file,HttpServletRequest request,HttpServletResponse response){
		    MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
		    Disasters disasters = disastersService.selectByPrimaryKey(id);
		    System.out.println("查询出来的数据："+ disasters);
		    System.out.println("获得到的数据："+videoUrl);
		
			disasters.setTitle(multipartRequest.getParameter("title"));
			disasters.setDescript(multipartRequest.getParameter("descript"));
			disasters.setContent(multipartRequest.getParameter("content"));
			disasters.setTypeValue(Integer.valueOf(multipartRequest.getParameter("typeValue")));
			disasters.setVideo(multipartRequest.getParameter("video"));
			
			//String path = request.getServletContext().getRealPath(ReturnInfoType.VIDEO_RESOUREC); //视频路径
			//String img_path = request.getServletContext().getRealPath(ReturnInfoType.USER_PHOTO_RESOUREC); //图片路径
			String path = system_VIDEO_RESOUREC; //视频路径
			String img_path = system_USER_PHOTO_RESOUREC; //图片路径
	        logger.info("视频存放路径"+path);
	        String filename = "";
	        String img = "";
	        FileUtilImpl fiImpl = new VideoUtil();
	        if(file.isEmpty()){
				logger.warn("视频文件为空");
				if (videoUrl!="") {
					img = (String) videoUrl.substring(0,videoUrl.lastIndexOf("."))+".jpg";
		        	filename = videoUrl;
				}
	        }
	        else if(!file.isEmpty()){
	        filename = fiImpl.fileUpLoad(file, path).get("trueFileName").toString();
	        img = (String) filename.substring(0,filename.lastIndexOf("."))+".jpg";
	        System.out.println("---图片名称---:"+img);
	        String ffpath = this.getClass().getClassLoader().getResource("/conf/util/ffmpeg.exe").getPath();
	        System.out.println("---插件路径---:"+ffpath);
	        String videopath =path+"\\"+ filename;
	        System.out.println("---视频路径---:"+videopath);
	        String imgpath = img_path+"\\"+img;
	        System.out.println("---图片路径---:"+imgpath);
	        
	        boolean boo = handlerImg(ffpath, videopath, imgpath);
	        /* try {
				//fetchFrame(videopath, imgpath);
			} catch (Exception e) {
				e.printStackTrace();
			}*/
	        if(boo)disasters.setImage(img);
	        disasters.setVideo(filename);
	        }
	        
	        int recond = disastersService.updateByPrimaryKeySelective(disasters);
	        if(recond == 1){
	        	return ReturnInfoType.SUCEEESS;
	        }else
			return ReturnInfoType.FAIL;
	}
	
	/**
	 * 根据id查询
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@UserOperate(moduleName="防灾减灾",option = "查询视频信息")
	@RequestMapping(value="/select", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(int id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Disasters disasters = disastersService.selectByPrimaryKey(id);
		if (!isEmpty(disasters))
			smap.put("disasters", disasters);

		return toJSONString(smap);
	}
	
	/**
	 * 查询列表
	 * @param disasters
	 * @param pageNum
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws ParseException 
	 */
	@UserOperate(moduleName="防灾减灾",option = "防灾减灾信息列表")
	@RequestMapping(value="/selectList",method=RequestMethod.GET)
	@ResponseBody
	public String selectList(Disasters disasters,Integer pageNum,Date date1, Date date2,HttpServletRequest request,
			HttpServletResponse response, ModelMap map) throws ParseException {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();

		User user =getUser(request);
		String did = user.getDid();//获取当前用户的部门id
		List<Department> departments = DepartmentService.selectByThisUser(did);
		List<String> deList =new ArrayList<String>();
		for (int i = 0; i < departments.size(); i++) {
			deList.add(departments.get(i).getId());
		}
		
		pmap = MapUtils.beanToMap(disasters);
		pmap.put("did", user.getDid());
		pmap.put("departments", deList);
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("start", date1);
		pmap.put("end", date2);
		
		List<Disasters> list = disastersService.selectList(pmap); //列表
		int count = disastersService.selectListCount(pmap);  //记录行数

		if(!isEmpty(list)) dmap.put("list", list);
		dmap.put("count", count);
		return toJSONString(dmap);
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
