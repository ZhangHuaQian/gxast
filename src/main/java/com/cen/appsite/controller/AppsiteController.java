package com.cen.appsite.controller;

import java.io.*;
import java.net.URLEncoder;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.JDBC.JDBCUtils_yy;
import com.cen.JDBC.New_jtyy;
import com.cen.JDBC.SelectDao;
import com.cen.JtyyForeign.entity.JtyyForeign;
import com.cen.JtyyForeign.jdbc.JtyyQuery;
import com.cen.JtyyForeign.service.JtyyForeignService;
import com.cen.NfkjwForeign.entity.NfkjwForeign;
import com.cen.NfkjwForeign.jdbc.NfkjwQuery;
import com.cen.NfkjwForeign.service.NfkjwForeignService;
import com.cen.address.entity.Address;
import com.cen.address.service.AddressService;
import com.cen.appsite.service.AppsiteService;
import com.cen.appsite.user.dto.PhoneCheckCode;
import com.cen.collection.entity.collection;
import com.cen.collection.service.CollectionService;
import com.cen.common.cache.EHCacheUtil;
import com.cen.common.task.TaskCenter;
import com.cen.common.util.*;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.dictionary.entity.Dictionary;
import com.cen.dictionary.service.DictionaryService;
import com.cen.news.service.NewsService;
import com.cen.product.dao.productMapper;
import com.cen.product.entity.Product;
import com.cen.product.service.ProductService;

@Controller
@RequestMapping("/appsite")
public class AppsiteController extends BaseController {

	@Autowired
	private DictionaryService DictionaryService;
	@Autowired
	private UserService userService;
	@Autowired
	private AppsiteService appsiteService;
	@Autowired
	private AddressService addressService;
	@Autowired
	private CollectionService collectionService;
	@Autowired
	private NfkjwForeignService<NfkjwForeign> nfkjwForeignService;

	@Value("${system.USER_PHOTO_RESOUREC}")
	private String target;

	@ResponseBody
	@RequestMapping(value = "/test")
	public String test(HttpServletRequest request) throws Exception {

		//栏目id
		String catids = "20";
		//获取最后一条插入的资讯 id
		NfkjwForeign nfkjwForeign = nfkjwForeignService.selectLastInsertId();
		if(nfkjwForeign == null){
			nfkjwForeign = new NfkjwForeign();
			nfkjwForeign.setId(0);
		}
		List<NfkjwForeign> result = NfkjwQuery.query(catids ,nfkjwForeign.getId());
		if(result.size() > 0){
			String dateDirs = DateUtil.getThisSysTimeYMD_FILE();
			// 判断路径是否存在/创建
			File basePath = new File(target + dateDirs);
			if (!basePath.exists()) {
				basePath.mkdirs();
			}

			for(NfkjwForeign nfkjw : result){
				String photo = nfkjw.getPhoto();

				// 下载图片到本地服务器
				if (photo != null && !photo.equals("")){
					String fileName = dateDirs + photo.substring(photo.lastIndexOf("/")+1);
					ImageDown.download( photo, target + fileName);
					nfkjw.setPhoto(fileName);
				}

				//修改资讯内容中的图片路径并下载到本地服务器
				String temp = nfkjw.getContent();
				List<String> imgStr = ImageDown.getImgStr(temp);
				if(imgStr.size() > 0){
					String src = "";
					String fileName = "";
					for (int i=0; i<imgStr.size(); i++){
//						src = imgStr.get(i).substring(1);
						src = imgStr.get(i);
						fileName = dateDirs + src.substring(src.lastIndexOf("/")+1);
						ImageDown.download( src , target + fileName);
						temp = temp.replace(src, "/uploadFiles/photo" + fileName);
					}
				}
				nfkjw.setContent(temp);

				nfkjwForeignService.insertSelective(nfkjw);
			}
		}

		return ResData.SUCCESS().toString();
	}



	/**
	 * 更新用户信息
	 *
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/checkLogin")
	public String checkLogin(HttpServletRequest request){
		User user = getUser(request);
		if(user == null){
			return ResData.FAIL("请先登录").toString();
		}
		return ResData.SUCCESS().toString();
	}

	/**
	 * 更新用户信息
	 * 
	 * @param request
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/user_update", method = RequestMethod.POST)
	public String user_update(User user, HttpServletRequest request, HttpServletResponse response) {
		User uu = getUser(request);
		uu.setPhoto(user.getPhoto());
		uu.setName(user.getName());
		uu.setPhonenum(user.getPhonenum());
		int a = userService.updateByPrimaryKeySelective(uu);
		Map<String, Object> rMap = new HashMap<>();
		if (a == 1) {
			rMap.put("msg", "更新成功");
			rMap.put("status", "1");
		} else {
			rMap.put("msg", "更新失败");
			rMap.put("status", "0");
		}

		return toJSONString(rMap);
	}

	/**
	 * 我的收藏
	 * 
	 * @param request

	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/myCollection", method = RequestMethod.GET)
	public String myCollection(Integer pageNum, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> cmap = new HashMap<String, Object>();
		Map<String, Object> rMap = new HashMap<>();
		User u = getUser(request);
		cmap.put("uid", u.getId());
		List<collection> collections1 = collectionService.selectList(cmap);
		cmap.put("pageSize", pageSize);
		cmap.put("pageNum",getPageNum(pageNum));
		List<collection> collections = collectionService.selectList(cmap);
		rMap.put("list", collections);
		rMap.put("count", collections1.size());
		return toJSONString(rMap);
	}


	/**
	 * 我的收藏
	 * 
	 * @param request

	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/selectCollection", method = RequestMethod.GET)
	public String selectCollection(String pid, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> cmap = new HashMap<String, Object>();
		Map<String, Object> rMap = new HashMap<>();
		User u = getUser(request);
		cmap.put("uid", u.getId());
		cmap.put("pid", pid);
		collection collection = collectionService.selectByUidPid(cmap);
		return toJSONString(collection);
	}

	/**
	 * 收藏或取消收藏
	 * 
	 * @param request

	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/collection", method = RequestMethod.GET)
	public String collection(String pid, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> cmap = new HashMap<String, Object>();
		Map<String, Object> rMap = new HashMap<>();
		User u = getUser(request);

		cmap.put("uid", u.getId());
		cmap.put("pid", pid);

		collection collection = collectionService.selectByUidPid(cmap);
		if (collection == null) {
			collection collection2 = new collection();
			collection2.setPid(pid);
			collection2.setTime(new Date());
			collection2.setUid(u.getId());
			int a = collectionService.insertSelective(collection2);
			if (a == 1) {
				rMap.put("msg", "收藏成功");
				rMap.put("status", "1");
			} else {
				rMap.put("msg", "收藏失败");
				rMap.put("status", "0");
			}
		} else {
			int a = collectionService.deleteByPrimaryKey(collection.getId());
			if (a == 1) {
				rMap.put("msg", "取消收藏成功");
				rMap.put("status", "1");
			} else {
				rMap.put("msg", "取消收藏失败");
				rMap.put("status", "0");
			}
		}
		return toJSONString(rMap);
	}

	/**
	 * 添加地址
	 * 
	 * @param address
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/address_insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(Address address, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> cmap = new HashMap<String, Object>();
		address.setCreateDate(new Date());
		address.setUserid(getUser(request).getId());
		address.setIsDel(0);
		address.setAddress(address.getProvince() + address.getCity() + address.getArea());
		if (address.getState() == 0) {
			address.setState(0);
		} else {
			addressService.updateState(address.getUserid());
		}
		int a = addressService.insert(address);

		cmap.put("msg", "添加成功");
		cmap.put("status", ReturnInfoType.SUCEEESS);
		return toJSONString(cmap);
	}

	/**
	 * 根据id删除地址
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/address_delete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(String id, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		int result = addressService.deleteByPrimaryKey(id);
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
	 * 根据id查询地址
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/address_select", method = RequestMethod.POST)
	@ResponseBody
	public String select(String id, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Address address = addressService.selectByPrimaryKey(id);
		umap.put("address", address);
		return toJSONString(umap);
	}

	/**
	 * 更新地址
	 * 
	 * @param address
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/address_update", method = RequestMethod.POST)
	@ResponseBody
	public String update(Address address, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		address.setAddress(address.getProvince() + address.getCity() + address.getArea());
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("userid", getUser(request).getId());
		if (address.getState() == 1) {
			List<Address> addressList = addressService.selectList(pmap);
			for (int i = 0; i < addressList.size(); i++) {
				Address address2 = addressList.get(i);
				address2.setState(0);
				addressService.updateByPrimaryKeySelective(address2);
			}
		}
		int count = addressService.updateByPrimaryKeySelective(address);
		if (count == 1) {
			umap.put("msg", "更新成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "更新失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}

	/****
	 * 手机端查询所有地址
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectAddressList", method = RequestMethod.GET)
	@ResponseBody
	public String selectAddressList(HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		User u = getUser(request);
		pmap.put("userid", u.getId());
		List<Address> addressList = addressService.selectList(pmap);
		Address address = addressService.getuserAddress(u.getId());
		dmap.put("address", address);
		dmap.put("list", addressList);
		dmap.put("count", addressList.size());
		return toJSONString(dmap);
	}

	/**
	 * 获取当前用户信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/selectUserInfo")
	@ResponseBody
	public String selectUserInfo(HttpServletRequest request, HttpServletResponse response) {
		C c = new C("失败", ReturnInfoType.FAIL);
		User user = getUser(request);
		if (user != null) {
			c.setMsg("成功");
			c.setStatus(ReturnInfoType.SUCEEESS);
			c.getData().put("user", user);
		}
		return toJSONString(c);
	}

	/**
	 * 分页查询所有数据字典
	 * 
	 * @param dict
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectList", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectList(Dictionary dict, Integer pageNum, HttpServletRequest request, HttpServletResponse response,
			ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();

		pmap = MapUtils.beanToMap(dict);
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);

		List<Dictionary> list = DictionaryService.selectList(pmap); // 列表
		int count = DictionaryService.selectListCount(pmap); // 记录行数

		if (!isEmpty(list))
			dmap.put("list", list);
		dmap.put("count", count);
		return toJSONString(dmap);
	}

	/**
	 * 下载最新一个(apk)文件
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/download", produces = "application/json;charset=utf-8")
	public String getFile(String fileName, HttpServletRequest request, HttpServletResponse response) {
		if (fileName != null) {
			File file = new File(system_APK_RESOUREC, fileName);
			System.out.println(file.getName());
			System.out.println(file.getPath());
			if (file.exists()) {
				// response.setContentType("application/force-download");//
				// 设置强制下载不打开
				response.addHeader("Content-Disposition", "attachment;fileName=" + fileName);// 设置文件名
				byte[] buffer = new byte[1024];
				FileInputStream fis = null;
				BufferedInputStream bis = null;
				try {
					fis = new FileInputStream(file);
					bis = new BufferedInputStream(fis);
					OutputStream os = response.getOutputStream();
					int i = bis.read(buffer);
					while (i != -1) {
						os.write(buffer, 0, i);
						i = bis.read(buffer);
					}
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				} finally {
					if (bis != null) {
						try {
							bis.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					if (fis != null) {
						try {
							fis.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
			}
		}
		return null;
	}

	@RequestMapping(value = "/downLoadFile", produces = "application/json;charset=utf-8")
	public String downLoadFile(String fileName, String newname, HttpServletRequest request,
			HttpServletResponse response) {
		if (fileName != null) {
			String path = system_USER_PHOTO_RESOUREC;
			String fileName1 = fileName.replaceAll("&#40;", "(");
			String fileName2 = fileName1.replaceAll("&#41;", ")");
			String newName1 = newname.replaceAll("&#40;", "(");
			String newName2 = newName1.replaceAll("&#41;", ")");
			File file = new File(path, fileName2);
			System.out.println(file.getName());
			System.out.println(file.getPath());
			if (file.exists()) {
				try {
					// 下载
					InputStream fis = new BufferedInputStream(new FileInputStream(file));
					byte[] buffer = new byte[fis.available()];
					fis.read(buffer);
					fis.close();
					response.reset();
					response.setContentType("text/html;charset=UTF-8");
					OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
					response.setContentType("application/x-msdownload");
					String newName = URLEncoder.encode(newName2, "UTF-8");
					response.addHeader("Content-Disposition", "attachment;filename=\"" + newName + "\"");
					response.addHeader("Content-Length", "" + file.length());
					toClient.write(buffer);
					toClient.flush();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {

				}
			}
		}
		return null;
	}

	/**
	 * 发送手机验证码(忘记密码)
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/sendPhoneCheckCode", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String sendPhoneCheckCode(PhoneCheckCode phoneCheckCode, HttpServletRequest request,
			HttpServletResponse response) {

		User user = userService.selectByLoginName(phoneCheckCode.getPhone()); // 查询用户是否存在
		if (user == null) {
			return toJSONString(new C("用户不存在", ReturnInfoType.USER_NoFound));
		}

		C c = new C();
		phoneCheckCode.setBath(IdUtil.RandomNumber(6), HttpUtil.getIpAddr(request), "resetPsw");
		PhoneCheckCode result = appsiteService.sendPhoneCheckCode(phoneCheckCode); // 发送手机短信

		// 发送成功
		if (result.getStatus().equals(ReturnInfoType.SUCEEESS)) {
			String cacheKey = phoneCheckCode.getPhone() + phoneCheckCode.getType();
			EHCacheUtil.put(ReturnInfoType.cen_xczhapp_phone_code, cacheKey, phoneCheckCode); // 写入缓存
		}

		c.setStatus(result.getStatus());
		c.setMsg(result.getReturnMsg());
		return toJSONString(c);
	}

	/**
	 * 根据手机验证码 找回密码
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/resetPsw", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String resetPsw(User user, PhoneCheckCode pcc, String password, HttpServletRequest request,
			HttpServletResponse response) {

		String cacheKey = pcc.getPhone() + "resetPsw";
		/* String cacheKey = user.getPhonenum()+"resetPsw"; */
		PhoneCheckCode pccCache = (PhoneCheckCode) EHCacheUtil.get(ReturnInfoType.cen_xczhapp_phone_code, cacheKey);
		if (pccCache == null) {
			return toJSONString(new C("验证码错误", ReturnInfoType.VALIDATECodeERROR));
		} else if (!pcc.getCheckCode().equals(pccCache.getCheckCode())) {
			// 错误次数大于5次
			if (pccCache.getSendNum() >= 5) {
				EHCacheUtil.remove(ReturnInfoType.cen_xczhapp_phone_code, cacheKey); // 从缓存删除
			} else {
				pccCache.setSendNum(pccCache.getSendNum() + 1);
				EHCacheUtil.put(ReturnInfoType.cen_xczhapp_phone_code, cacheKey, pccCache); // 写入缓存
			}
			return toJSONString(new C("验证码错误", ReturnInfoType.VALIDATECodeERROR));
		}

		C c = new C();
		boolean boo = userService.resetPsw(pccCache.getPhone(), MD5Tools.generate(password));
		if (boo) {
			EHCacheUtil.remove(ReturnInfoType.cen_xczhapp_phone_code, cacheKey); // 从缓存删除
			c.setStatus(ReturnInfoType.SUCEEESS);
			c.setMsg("密码已重置,请重新登录");
		} else {
			c.setStatus(ReturnInfoType.FAIL);
			c.setMsg("重置失败,请联系管理员");
		}

		return toJSONString(c);
	}

}
