package com.cen.common.util;
/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年4月27日 
* 状态返回码、系统常量
*/
public class ReturnInfoType {

	public static Integer TOPIC = 3; //论坛发帖成功加积分
	public static Integer COMMENT = 1; //论坛评论、回复成功加积分
	public static Integer REPORT_TOPIC = 10; //论坛帖子举报成功加积分
	public static Integer REPORT_COMMENT = 3; //论坛评论举报成功加积分
	public static Integer BE_REPORTED_TOPIC = 10; //论坛帖子被举报成功被举报人减积分
	public static Integer BE_REPORTED_COMMENT = 3; //论坛评论被举报成功被举报人减积分
	public static Integer BY_THUMB_UP_TOPIC = 1; //论坛帖子被点赞加积分
	public static Integer BY_THUMB_UP_COMMENT = 1; //论坛评论被点赞加积分

	public static String FAIL = "0" ; //失败
	public static String SUCEEESS = "1" ;  //成功
	public static String ERROR = "2" ; //错误
	public static String USER_NoFound = "3" ; //用户不存在
	public static String VALIDATECodeERROR = "4" ; //验证码错误
	public static String USER_EXIST_ERROR = "5" ; //用户存在错误
	public static String param_error = "400" ; //参数错误
	public static String Token_Invalid_expired = "1044" ; //token 失效


	public static String CLIENT_NoFound = "2004" ; //终端不存在
	public static String CLIENT_EXIST_ERROR = "2005" ; //终端存在错误
	
	public static String USER_SESSION_NAME = "USER_SESSION_NAME"; //用户session key
	public static String USER_SESSION_ROLE = "USER_SESSION_ROLE"; //用户角色session key
	public static String VALIDATECODE = "ValidateCode"; //用户登录验证码 key
	
	//public static String USER_PHOTO_RESOUREC = "C:\\home\\xczhapp\\uploadFiles\\photo"; //图片上传目录
	//public static String APK_RESOUREC = "C:\\home\\xczhapp\\uploadFiles\\apk"; //APK上传目录
	//public static String VIDEO_RESOUREC = "C:\\home\\xczhapp\\uploadFiles\\video"; //视频上传目录

	public static String cen_xczhapp_token = "cen_xczhapp_token"; // token 缓存名称 (EHCache)
	public static int TokenExpiryDate = 604800;// token 有效期 (秒数) 7天有效期（604800秒）

	public static String cen_xczhapp_phone_code = "cen_xczhapp_phone_code"; //手机验证码缓存

	public static String update_phone_code = "update_phone_code"; //手机验证码缓存,更新手机号

	public static String warn_xml_dir = "warnXML/"; //预警XML文件目录

	public static String weather_dl_addr = "http://192.168.18.83:8686/"; // 短临系统接口IP端口地址

	public static String FOREIGN_NEWS = "FOREIGN_NEWS";  //家庭医药、南方科技网资讯缓存

}
