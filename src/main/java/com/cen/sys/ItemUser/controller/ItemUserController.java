package com.cen.sys.ItemUser.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.*;
import com.cen.ucenter.entity.User;
import com.cen.sys.ItemUser.service.ItemUserService;
import com.cen.sys.ItemUser.entity.ItemUser;

@Controller
@RequestMapping("/sys/itemUser")
public class ItemUserController extends BaseController {

    @Autowired
    ItemUserService<ItemUser> itemUserService;

    /**
    * 添加
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/insert",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String insert(ItemUser itemUser,HttpServletRequest request,HttpServletResponse response){
        int res = itemUserService.insertSelective(itemUser);
        return res>=1?ResData.SUCCESS().toString():ResData.FAIL().toString();
    }

    /**
    * 删除
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/delete",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String delete(Integer id,HttpServletRequest request,HttpServletResponse response){
        int res = itemUserService.deleteByPrimaryKey(id);
        return res>=1?ResData.SUCCESS().toString():ResData.FAIL().toString();
    }

    /**
    * 更新
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/update",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String update(ItemUser itemUser,HttpServletRequest request,HttpServletResponse response){
        int res = itemUserService.updateByPrimaryKeySelective(itemUser);
        return res>=1?ResData.SUCCESS().toString():ResData.FAIL().toString();
    }

    /**
    * 查询
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/select",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String select(Integer id,HttpServletRequest request,HttpServletResponse response){
        ItemUser res = itemUserService.selectByPrimaryKey(id);
        return ResData.SUCCESS(res).toString();
    }

    /**
    * 分页查询列表
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/selectList",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectList(ItemUser itemUser,Integer pageNum,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> paramMap = MapUtils.beanToMap(itemUser);
        // 此处查询需要自行编写
        PageHelper.startPage(getPageNum2(pageNum),pageSize);
        List<ItemUser> lists = itemUserService.selectList(paramMap);
        PageInfo<ItemUser>  p2 = new PageInfo<ItemUser>(lists);
        rMap.put("pageNum", p2.getPageNum()); //  当前页
        rMap.put("pages", p2.getPages()); //  总页数
        rMap.put("nextPage", p2.getNextPage()); // 下一页
        rMap.put("prePage", p2.getPrePage()); // 上一页
        rMap.put("data", p2.getList()); // 数据集合
        rMap.put("count", p2.getTotal()); // 总行数
        PageHelper.clearPage(); // 如果开启分页，必须调用清除
        return ResData.SUCCESS(rMap).toString();
    }


}