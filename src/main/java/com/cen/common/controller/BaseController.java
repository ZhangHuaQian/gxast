package com.cen.common.controller;

import java.beans.PropertyEditorSupport;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cen.common.util.*;
import com.cen.common.util.Base64;
import com.cen.ucenter.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import org.springframework.web.multipart.MultipartFile;

import static com.alibaba.fastjson.serializer.SerializerFeature.*;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年4月24日 
* 
*/
@Controller
@RequestMapping(value="/base")   
public class BaseController {
	protected Logger logger = LoggerFactory.getLogger(getClass());

	protected Integer pageSize = 10; // 分页显示数量
	@Value("${system.address}")
	protected String system_address; // 项目地址
	@Value("${system.base}")
	protected String system_base; // 项目URL路径
	@Value("${system.USER_PHOTO_RESOUREC}")
	protected String system_USER_PHOTO_RESOUREC ; //图片上传目录
	@Value("${system.SERVE_RESOUREC}")
	protected String SERVE_RESOUREC ; //农气服务上传目录
	@Value("${system.APK_RESOUREC}")
	protected String system_APK_RESOUREC ; //APK上传目录
	@Value("${system.VIDEO_RESOUREC}")
	protected String system_VIDEO_RESOUREC ; //视频上传目录
	@Value("${system.base.photo}")
	protected String system_base_photo ; //图片上传URL目录
	@Value("${system.base.apk}")
	protected String system_base_apk ; //APK上传URL目录
	@Value("${system.base.serve}")
	protected String system_base_serve ; //农气服务上传URL目录
	@Value("${system.base.video}")
	protected String system_base_video ; //视频上传URL目录
	@Value("${system.regUserDefaultRoleIds}")
	protected String system_regUserDefaultRoleIds ; //手机注册用户默认角色ID
	
	/**
	 * 图片上传(通用)   /base64Data格式
	 * @param base64Data
	 * @param request
	 * @param response
	 * @return 图片名称
	 * (width height  这里指的是需要生成缩略图参数)
	 */
	@RequestMapping(value="/uploadImgCommon",method=RequestMethod.POST)  
    @ResponseBody  
    public String uploadImgCommon(@RequestParam String base64Data,Integer width,Integer height, 
    		HttpServletRequest request, HttpServletResponse response){


		//String path = request.getServletContext().getRealPath(ReturnInfoType.USER_PHOTO_RESOUREC); // 上传目录
		String path = system_USER_PHOTO_RESOUREC; // 上传目录
		String fileName = ImageUtil.base64ImgUpLoad(base64Data, path);
		// 这里生成缩略图
		if(width!=null&&height!=null){
			ImageUtil.toMixImg(path+"/"+fileName, path+"/"+width+"_"+height+"_"+fileName, width, height);
		}
		System.err.println("fileName=="+fileName);
		return fileName==null?ReturnInfoType.ERROR:fileName;
    }

	/**
     * 文件上传功能
     * @param file
     * @return
     * @throws IOException 
     */
    @RequestMapping(value="/uploadfile",method=RequestMethod.POST)
    @ResponseBody
    public String upload(MultipartFile file,HttpServletRequest request) throws IOException{
    	Map<String, Object> cmap = new HashMap<String, Object>();
    	Map<String, Object> pmap = new HashMap<String, Object>();
		String path = system_USER_PHOTO_RESOUREC; // 上传目录
		String fileName = ImageUtil.imgFileUpload(file,path);
        cmap.put("code", 0);
        cmap.put("msg", "上传成功");
        pmap.put("src",system_base+"/uploadFiles/photo/"+fileName);                 
        pmap.put("src2","/gxast/uploadFiles/photo/"+fileName);
        pmap.put("title",fileName);
        cmap.put("data", pmap);
        return toJSONString(cmap);
    }
	/**
	 * 多文件上传功能
	 * @param file
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value="/uploadMultiFile",method=RequestMethod.POST)
	@ResponseBody
	public String uploadMultiFile(MultipartFile file,HttpServletRequest request) throws IOException{
		Map<String, Object> cmap = new HashMap<String, Object>();
		String path = system_USER_PHOTO_RESOUREC;
		String[] str=file.getOriginalFilename().split("\\.");
		String fileName = "(--!"+str[0]+"."+str[str.length-1]+"!--)"+IdUtil.createIdByDate2()+"."+str[str.length-1];
		File dir = new File(path,fileName);
		if(!dir.exists()){
			dir.mkdirs();
		}
		System.out.println("路径===>"+path);
		System.out.println("文件路径===>"+dir.getPath());
		file.transferTo(dir);
		cmap.put("fileName", fileName);
		cmap.put("status", ReturnInfoType.SUCEEESS);
		return toJSONString(cmap);
	}
    /**
     * APK上传功能
     * @param file
     * @return
     * @throws IOException 
     */
    @RequestMapping(value="/uploadApk",method=RequestMethod.POST)
    @ResponseBody
    public String uploadapp(MultipartFile file,HttpServletRequest request) throws IOException{
    	Map<String, Object> cmap = new HashMap<String, Object>();
        //String path = request.getServletContext().getRealPath(ReturnInfoType.APK_RESOUREC);
		String path = system_APK_RESOUREC;
        String[] str=file.getOriginalFilename().split("\\.");
        String fileName = IdUtil.createIdByDate2()+Base64.encode(str[0])+"."+str[str.length-1];
		/*String fileName = "(--!"+str[0]+"."+str[str.length-1]+"!--)"+IdUtil.createIdByDate2()+"."+str[str.length-1];*/
        File dir = new File(path,fileName);        
        if(!dir.exists()){
            dir.mkdirs();
        }
        //MultipartFile自带的解析方法
        System.out.println(path);
        file.transferTo(dir);
        cmap.put("fileName", fileName);
        cmap.put("status", ReturnInfoType.SUCEEESS);
		System.out.println(toJSONString(cmap));
        return toJSONString(cmap);
    }
    /**
     * 视频上传(通用)
     * @param file
     * @param request
     * @param response
     * @return 视频链接
     * (width height  这里指的是需要生成缩略图参数)
     */
    @RequestMapping(value="/uploadVideoCommon")
    @ResponseBody
    public String uploadVideoCommon(MultipartFile file, HttpServletRequest request, HttpServletResponse response){
        //String path = request.getServletContext().getRealPath(ReturnInfoType.VIDEO_RESOUREC); // 上传目录
    	Map<String, Object> cmap = new HashMap<String, Object>();
    	Map<String, Object> pmap = new HashMap<String, Object>();
		String path = system_VIDEO_RESOUREC;
		String filename = "";
		FileUtilImpl fileUtil = new VideoUtil();
		if (file.isEmpty()) {
			logger.warn("文档为空");
			return ReturnInfoType.ERROR;
		}
		filename = fileUtil.fileUpLoad(file,path).get("trueFileName").toString();
		cmap.put("code", 0);
        cmap.put("msg", "上传成功");
        pmap.put("src",system_base+"/uploadFiles/video/"+filename);            
        pmap.put("title",filename);
        cmap.put("data", pmap);
		return toJSONString(cmap);
    }

    /**
	 * 初始化数据绑定 
	 * 1. 将所有传递进来的String进行HTML编码
	 *  
	 */  
	@InitBinder  
	protected void initBinder(WebDataBinder binder) {  
	    // String类型转换，将所有传递进来的String进行HTML编码
	    binder.registerCustomEditor(String.class, new PropertyEditorSupport() {  
	        @Override  
	        public void setAsText(String text) { 
	        	//System.out.println("A:"+text);
	            // setValue(text == null ? null : StringEscapeUtils.escapeHtml(text.trim())); 
	        	setValue(text == null ? null : cleanXSS(text.trim())); 
	            //System.out.println("B:"+cleanXSS(text.trim()));
	        }  
	        @Override  
	        public String getAsText() {  
	            Object value = getValue();  
	            return value != null ? value.toString() : "";  
	        }  
	    });

	    //日期参数格式转换
		//binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"),true));
	}
	
	
	/**
	 * cleanXSS
	 * @param value
	 * @return
	 */
	 private String cleanXSS(String value) {  
        value = value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
        value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
        value = value.replaceAll("'", "&#39;");
        value = value.replaceAll("eval\\((.*)\\)", "");  
        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");  
        value = value.replaceAll("script", "");  
        return value;  
    }

	
	/** 
	 * 响应验证码页面 
	 * @return 
	 */  
	@RequestMapping(value="/validateCode.jpg")  
	public String validateCode(HttpServletRequest request,HttpServletResponse response) throws Exception{  
	    // 设置响应的类型格式为图片格式  
	    response.setContentType("image/jpeg");  
	    //禁止图像缓存。  
	    response.setHeader("Pragma", "no-cache");  
	    response.setHeader("Cache-Control", "no-cache");  
	    response.setDateHeader("Expires", 0);  
	  
	    HttpSession session = request.getSession();  
	    ValidateCode vCode = new ValidateCode(120,40,4,50);  
	    session.setAttribute(ReturnInfoType.VALIDATECODE, vCode.getCode());  
	    vCode.write(response.getOutputStream());  
	    return null;  
	}
	
	/**
	 * 获取指定视频的帧并保存为图片至目录
	 * @param videofile 源视频文件路径
	 * @param framefile 截取帧的图片存放路径
	 * @throws Exception
	 */
/*	public static void fetchFrame(String videofile,String framefile) throws Exception{
		
		long start = System.currentTimeMillis();
		File targetFile = new File(framefile);
		FFmpegFrameGrabber ff = new FFmpegFrameGrabber(videofile);
		ff.start();
		int len = ff.getLengthInFrames();
		int i=0;
		Frame f =null;
		while(i<len){
			//过滤掉前五帧，避免出现黑图
			f = ff.grabFrame();
			if((i>5)&&(f.image != null)){
				break;
			}
			i++;
		}
		IplImage img = f.image;
		int owidth = img.width();
		int oheight = img.height();
		// 对截取的帧进行等比例缩放
		int width = 800;
		int height = (int) (((double) width / owidth) * oheight);
		BufferedImage bi = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
		bi.getGraphics().drawImage(f.image.getBufferedImage().getScaledInstance(width, height, Image.SCALE_SMOOTH),
				0, 0, null);
		ImageIO.write(bi, "jpg", targetFile);
		//ff.flush();
		ff.stop();
		System.out.println(System.currentTimeMillis() - start);
	}*/

	/**
	 * 视频截取
	 * @param ffmpegPath
	 * @param upFilePath
	 * @param mediaPicPath
	 * @return
	 */
	public boolean handlerImg(String ffmpegPath, String upFilePath, String mediaPicPath) {

		System.out.println("%%%视频路径%%%+" + upFilePath);
		System.out.println("%%%图片路径%%%+" + mediaPicPath);
		boolean boo = true;
		//windows 系统实现
		if (OSinfoUtil.isWindows()) {

			List<String> cutpic = new ArrayList<String>();
			cutpic.add(ffmpegPath);
			cutpic.add("-i");
			cutpic.add(upFilePath); // 同上（指定的文件即可以是转换为flv格式之前的文件，也可以是转换的flv文件）
			cutpic.add("-y");
			cutpic.add("-f");
			cutpic.add("image2");
			cutpic.add("-ss"); // 添加参数＂-ss＂，该参数指定截取的起始时间
			cutpic.add("0"); // 添加起始时间为第17秒
			cutpic.add("-t"); // 添加参数＂-t＂，该参数指定持续时间
			cutpic.add("0.001"); // 添加持续时间为1毫秒
			cutpic.add("-s"); // 添加参数＂-s＂，该参数指定截取的图片大小
			cutpic.add("500*400"); // 添加截取的图片大小为350*240
			cutpic.add(mediaPicPath); // 添加截取的图片的保存路径

			ProcessBuilder builder = new ProcessBuilder();
			try {

				builder.command(cutpic);
				builder.redirectErrorStream(true);
				// 如果此属性为 true，则任何由通过此对象的 start() 方法启动的后续子进程生成的错误输出都将与标准输出合并，
				// 因此两者均可使用 Process.getInputStream() 方法读取。这使得关联错误消息和相应的输出变得更容易
				builder.start();
				System.out.println("截取成功");
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
			}

		}else if (OSinfoUtil.isLinux()) {  // Linux 系统实现
			System.out.println("this is "+System.getProperty("os.name").toLowerCase());
			boo = false;
		}

		return boo;
	}
	
	/**
	 *  obj 转 json
	 * @param obj
	 * @return
	 */
	public String toJSONString(Object obj){
		return JSON.toJSONString(obj,WriteMapNullValue,WriteNullNumberAsZero,WriteNullListAsEmpty,WriteNullStringAsEmpty,WriteNullBooleanAsFalse,DisableCircularReferenceDetect,WriteDateUseDateFormat);
	}

	public String toJSONString2(Object obj){
		return JSON.toJSONString(obj,WriteMapNullValue,WriteNullListAsEmpty,WriteNullBooleanAsFalse,DisableCircularReferenceDetect,WriteDateUseDateFormat);
	}

	/**
	 * 判断对象是否为空  (obj,list,map)
	 * @param obj
	 * @return
	 */
	public boolean isEmpty(Object obj){
		return StringUtils.isNullOrEmpty(obj);
	}
	
	/**
	 * 页码
	 * @param pageNum
	 * @return
	 */
	public int getPageNum(Integer pageNum){
		if(pageNum==null||pageNum<1)pageNum = 1;
		return (pageNum-1)*pageSize;
	}

	/**
	 * 页码(PageHelper)
	 * @param pageNum
	 * @return
	 */
	public int getPageNum2(Integer pageNum){
		if(pageNum==null||pageNum<1)pageNum = 1;
		return pageNum;
	}

	/**
	 * 页码
	 * @param pageNum
	 * @return
	 */
	public int getStart(Integer pageNum,Integer pageSize){
		if(pageNum==null||pageNum<1)
			pageNum = 1;
		if(pageSize==null||pageSize<1)
			pageSize = this.pageSize;

		return (pageNum-1)*pageSize;
	}

	/**
	 * 第页显示条数(PageHelper)
	 * @param pageSize
	 * @return
	 */
	public int getPageSize(Integer pageSize){
		if(pageSize==null||pageSize<1){
			pageSize = this.pageSize;
		}
		return pageSize;
	}

	/**
	 * 获取当前登录用户信息
	 * @param request
	 * @return
	 */
	public User getUser(HttpServletRequest request){
		return (User)HttpUtil.getUserInSession(request);
	}

	@RequestMapping(value="/htmltopdf")
	@ResponseBody
	public void htmltopdf(String path,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException {
		//String path = "http://blog.csdn.net";//request.getParameter("path");
		if(path == null || path.equals("")){
			return;
		}

		//获取pdf的临时保存路径
		//tmp为网站下的目录
		//把生成的pdf放到网站下以便下载
		String pdfPath = request.getSession().getServletContext().getRealPath("/tmp");
		String pdfName = UUID.randomUUID().toString() + ".pdf";

		if(HtmlToPdfUtil.convert(path, pdfPath + "/" + pdfName)){
			response.sendRedirect(request.getContextPath() + "/tmp/" + pdfName);
		}
	}


}
