package com.cen.appsite.user.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.*;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;
import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;

import com.cen.upms.entity.Menu;
import com.cen.upms.entity.Role;
import com.cen.upms.service.MenuService;
import com.cen.upms.service.RoleService;
import com.cen.upms.shiro.CenRealm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.text.ParseException;
import java.util.*;

/**
 * Created by cenguocheng on 2018/7/25.
 * 137544496@qq.com
 * 用户中心 -- 安卓客户端
 */
@Controller
@RequestMapping(value="/appsite/phoneUser")
public class PhoneUserController extends BaseController {

	 @Autowired
	 private UserService userService;
     @Autowired
     MenuService menuService;
     @Autowired
     RoleService roleService;
    @Autowired
    private NewsService newsService;

	
    /**
     * 获取当前用户信息
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value="/selectUserInfo")
    @ResponseBody
    public String selectUserInfo(HttpServletRequest request,HttpServletResponse response){
        C c = new C("失败",ReturnInfoType.FAIL);
        User user = getUser(request);
        if(user!=null){
            c.setMsg("成功");
            c.setStatus(ReturnInfoType.SUCEEESS);
            c.getData().put("user",user);
        }
        return toJSONString(c);
    }


    /**
     * 用户信息更新
     * @param user
     * @param request
     * @return
     */
    @RequestMapping(value="/updateUserInfo",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String updateUserInfo(@Valid User user, HttpServletRequest request){
        C c = new C("失败",ReturnInfoType.FAIL);
        //if(bindingResult.hasErrors())return toJSONString(new C(paramErrorInfo(bindingResult),ReturnInfoType.param_error));
        User thisUser = getUser(request);
        if(thisUser==null)return toJSONString(c);

        // 真实姓名，性别，生日
        user.setId(thisUser.getId()); // 当前登录的用户ID
        user.setModifyTime(new Date()); //更新时间
        int recond = userService.updateByPrimaryKeySelective(user);
        if(recond > 0){
        	 c.setMsg("成功");
             c.setStatus(ReturnInfoType.SUCEEESS);
        }
        return toJSONString(c);
    }


    /**
     *  图片(用户头像)上传 (android 端)
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value="/androidImgUpload")
    @ResponseBody
    public String androidImgUpload(MultipartFile file,HttpServletRequest request,HttpServletResponse response){
        C c = new C("图片上传失败",ReturnInfoType.FAIL);
        //String path = request.getServletContext().getRealPath(ReturnInfoType.USER_PHOTO_RESOUREC);
        String path = system_USER_PHOTO_RESOUREC;
        logger.debug("Android:path="+path);
        String imgName = ImageUtil.imgFileUpload(file, path);
        if(imgName != null){
        	c.setMsg("图片上传成功");
            c.setStatus(ReturnInfoType.SUCEEESS);
            c.getData().put("imgName", imgName);
            User user = getUser(request);
            if(user!=null){
                User newUser = new User();
                newUser.setId(user.getId());
                newUser.setModifyTime(new Date());
                newUser.setPhoto(imgName);
                userService.updateByPrimaryKeySelective(newUser); //更新用户头像图片
            }
        }
        return toJSONString(c);
    }


    /**
     * 获取手机用户权限菜单
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value="/userMenu",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String userMenu(HttpServletRequest request,HttpServletResponse response){
        User user = getUser(request);
        Map<String,Object> rMap = new HashMap<String,Object>();
        List<Menu> list = new ArrayList<Menu>();
        if(null != user){
            List<Role> roleLists = roleService.selectByUid(user.getId()); //获取角色
            for (Role role : roleLists) {
                // 这里获取的是手机菜单
                List<Menu> menuLists =  menuService.selectPhoneByRid(role.getId()); //获取菜单权限
                list.addAll(menuLists);
            }
        }
        rMap.put("status",ReturnInfoType.SUCEEESS);
        rMap.put("msg","ok");
        rMap.put("list",list);
        return toJSONString(rMap);
    }


    /**
     * 手机端 修改密码
     * @param user
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/updatePsw", method = RequestMethod.POST , produces = "application/json;charset=utf-8")
    public String androidPswUpdate(User user,String newPassword, HttpServletRequest request){
        User user_this = getUser(request);
        Map<String, Object> rMap = new HashMap<String,Object>();
        if(MD5Tools.verify(new String(user.getPassword()),user_this.getPassword())){
            user_this.setModifyTime(new Date());
            user_this.setPassword(MD5Tools.generate(newPassword));
            userService.updateByPrimaryKeySelective(user_this);
            rMap.put("msg","修改成功,请重新登录");
            rMap.put("status",ReturnInfoType.SUCEEESS);
        }else{
            rMap.put("msg","原始密码不一致,修改失败");
            rMap.put("status",ReturnInfoType.FAIL);
        }
        return toJSONString(rMap);
    }






}
