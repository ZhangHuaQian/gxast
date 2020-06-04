package com.cen.ucenter.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.ForumUserInfo.entity.ForumUserInfo;
import com.cen.ForumUserInfo.service.ForumUserInfoService;
import com.cen.operateLog.annotation.UserOperate;
import com.cen.upms.entity.Department;
import com.cen.upms.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.HttpUtil;
import com.cen.common.util.MD5Tools;
import com.cen.common.util.MapUtils;
import com.cen.common.util.Page;
import com.cen.common.util.ReturnInfoType;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;


/**
 * @author cenguocheng E-mail:137544496@qq.com
 * @version 创建时间：2018年4月24日
 */
@Controller
@RequestMapping(value = "/sys/ucenter")
public class UserController extends BaseController {

    @Autowired private UserService userService;
    @Autowired DepartmentService departmentService;
    @Autowired
    private ForumUserInfoService<ForumUserInfo> forumUserInfoService;


    /**
     * 用户注册(后台管理)
     *
     * @param request
     * @param response
     * @return produces = "application/json; charset=utf-8" 解决返回json中文乱码问题
     */
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody
    public String insert(User user, String[] roleIds, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        User u = userService.selectByLoginName(user.getLoginname().trim()); //根据用户名查询
        if (isEmpty(u)) {
            user.setIsDel(0);
            user.setCreatedate(new Date()); //设置注册时间
            user.setPassword(MD5Tools.generate(user.getPassword()));// 密码MD5转码
            user.setUsertype("2");
            int ret = userService.register(roleIds, user);
            if (ret >= 2) {
                rMap.put("msg", "添加成功");
                rMap.put("status", ReturnInfoType.SUCEEESS);

                //存到论坛用户信息表
                ForumUserInfo forumUserInfo = new ForumUserInfo();
                forumUserInfo.setUId(user.getId());
                forumUserInfo.setUName(user.getName());
                forumUserInfo.setModifyTime(new Date());
                int fRes = forumUserInfoService.insertSelective(forumUserInfo);

            } else {
                rMap.put("msg", "添加失败");
                rMap.put("status", ReturnInfoType.FAIL);
            }
        } else {
            rMap.put("msg", "用户名已存在");
            rMap.put("status", ReturnInfoType.USER_EXIST_ERROR);
        }
        return toJSONString(rMap);
    }

    /**
     * 根据用户ID查询
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/select", method = RequestMethod.GET)
    @ResponseBody
    public String select(String uid, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        User user = userService.selectByPrimaryKey(uid);
        ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid(user.getId());
        if(forumUserInfo != null){
            user.setIsVip(forumUserInfo.getUType());
        }
        if (!isEmpty(user)) rMap.put("user", user);
        return toJSONString(rMap);
    }

    /**
     * 分页查询(通用)
     *
     * @param request
     * @param response
     * @return
     */
    @UserOperate(moduleName="用户管理",option = "用户列表")
    @RequestMapping(value = "/selectList", method = RequestMethod.GET)
    @ResponseBody
    public String selectList(User u, Integer pageNum,
                             HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        Map<String, Object> rMap = new HashMap<String, Object>();

        User user = getUser(request);
        List<Department> childDepartment = departmentService.selectByThisUser(user.getDid()); //当前用户部门（包括子部门)

        paramMap = MapUtils.beanToMap(u);
        paramMap.put("pageNum", getPageNum(pageNum));
        paramMap.put("pageSize", pageSize);
        paramMap.put("childDepartment", childDepartment);

        List<User> list = userService.selectList(paramMap);  // 用户列表
        int count = userService.selectListCount(paramMap);  //记录行数

        if (!isEmpty(list)) rMap.put("list", list);
        rMap.put("count", count);

        return toJSONString(rMap);
    }

    /**
     * 分页查询(手机用户)
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/selectListPhoneUser")
    @ResponseBody
    public String selectListPhoneUser(User u, Integer pageNum,
                             HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        Map<String, Object> rMap = new HashMap<String, Object>();

        paramMap = MapUtils.beanToMap(u);
        paramMap.put("pageNum", getPageNum(pageNum));
        paramMap.put("pageSize", pageSize);

        List<User> list = userService.selectList(paramMap);  // 用户列表
        int count = userService.selectListCount(paramMap);  //记录行数

        if (!isEmpty(list)){
            for(User u1 : list){
                ForumUserInfo forumUserInfo = forumUserInfoService.selectByUid(u1.getId());
                u1.setIsVip(forumUserInfo.getUType());
            }
            rMap.put("list", list);
        }
        rMap.put("count", count);

        return toJSONString(rMap);
    }


    /*查询userType为1的用户*/
    @RequestMapping(value = "/selectUserList", method = RequestMethod.GET)
    @ResponseBody
    public String selectUserList(User u, Integer pageNum,
                             HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        Map<String, Object> rMap = new HashMap<String, Object>();

        User user = getUser(request);
        List<Department> childDepartment = departmentService.selectByThisUser(user.getDid()); //当前用户部门（包括子部门)
        int page = Integer.valueOf(request.getParameter("page"));
        int limit = Integer.valueOf(request.getParameter("limit"));
        String keyword=request.getParameter("keyword");
        paramMap = MapUtils.beanToMap(u);
        paramMap.put("page",(page-1)*limit);
        paramMap.put("limit",limit);
        paramMap.put("keyword",keyword);
        List<User> list = userService.selectUserList(paramMap);  // 用户列表

        int count=userService.selectUserListCount(paramMap);
        if (!isEmpty(list)) rMap.put("data", list);
        rMap.put("code",0);
        rMap.put("msg","ok");
        rMap.put("count",count);
        return toJSONString(rMap);
    }

    /**
     * 修改密码
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    @ResponseBody
    public String modifyPassword(String oldpassword, String newpassword, HttpServletRequest request, HttpServletResponse response) {
        User u = (User) HttpUtil.getUserInSession(request);
        Map<String, Object> rMap = new HashMap<String, Object>();
        if (MD5Tools.verify(oldpassword, u.getPassword())) {
            User user = new User();
            user.setId(u.getId());
            user.setModifyTime(new Date());
            user.setPassword(MD5Tools.generate(newpassword));
            int res = userService.updateByPrimaryKeySelective(user);
            if (res == 1) {
                rMap.put("msg", "更新成功");
                rMap.put("status", ReturnInfoType.SUCEEESS);
            } else {
                rMap.put("msg", "更新失败");
                rMap.put("status", ReturnInfoType.FAIL);
            }
        } else {
            rMap.put("msg", "旧密码错误");
            rMap.put("status", ReturnInfoType.ERROR);
        }
        return toJSONString(rMap);
    }


    /**
     * 更新个人信息
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String update(User user,String[] roleIds,HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> rMap = new HashMap<String, Object>();

        // 判断如果是恢复手机用户角色
        if(roleIds!=null&&Arrays.asList(roleIds).contains(system_regUserDefaultRoleIds)&&roleIds.length==1){
            user.setDid("recoveryPhoneUser");
            logger.debug("恢复手机用户:"+user.getLoginname());
        }
        ForumUserInfo forumUserInfo = new ForumUserInfo();
        if(user.getIsVip() != null){
            //设置为vip用户
            forumUserInfo.setUType(1);
            forumUserInfo.setVipIcon("default_vip_icon.png");
        }else{
            //设置为普通用户
            forumUserInfo.setUType(0);
            forumUserInfo.setVipIcon(null);
        }
        forumUserInfo.setUId(user.getId());
        forumUserInfo.setModifyTime(new Date());
        int res2 = forumUserInfoService.updateByUid(forumUserInfo);

        user.setModifyTime(new Date());
        int res = userService.save(roleIds,user);
        //int res = userService.updateByPrimaryKeySelective(user);
        if (res >= 1) {
            rMap.put("msg", "更新成功");
            rMap.put("status", ReturnInfoType.SUCEEESS);
        } else {
            rMap.put("msg", "更新失败");
            rMap.put("status", ReturnInfoType.FAIL);
        }
        return toJSONString(rMap);
    }
    /**
     * 密码重置
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/changepsw", method = RequestMethod.POST)
    @ResponseBody
    public String ChangePSW(String id, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        User u = userService.selectByPrimaryKey(id);
        u.setPassword(MD5Tools.generate(u.getLoginname()));
        int res=userService.updateByPrimaryKeySelective(u);
        if (res == 1) {
            rMap.put("msg", "更新成功");
            rMap.put("status", ReturnInfoType.SUCEEESS);
        } else {
            rMap.put("msg", "更新失败");
            rMap.put("status", ReturnInfoType.FAIL);
        }
        return toJSONString(rMap);
    }


    /**
     * 删除用户
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public String delete(User user, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        int res = userService.deleteByPrimaryKey(user.getId());
        if (res == 1) {
            rMap.put("msg", "操作成功");
            rMap.put("status", ReturnInfoType.SUCEEESS);
        } else {
            rMap.put("msg", "操作失败");
            rMap.put("status", ReturnInfoType.FAIL);
        }
        return toJSONString(rMap);
    }


}
