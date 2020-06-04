package com.cen.jtyy.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cen.jtyy.entity.Jtyy;
import com.cen.jtyy.service.JtyyService;
import com.cen.ucenter.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import com.cen.common.controller.BaseController;
import com.cen.common.util.*;


@Controller
@RequestMapping("/sys/jtyy")
public class JtyyController extends BaseController {

    @Autowired
    JtyyService jtyyService;

    /**
    * 添加
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/insert")
    @ResponseBody
    public String insert(Jtyy jtyy, HttpServletRequest request, HttpServletResponse response){
        jtyy.setCreateTime(new Date());
        jtyy.setModifyTime(new Date());
        jtyy.setIsDel(0);
        //jtyy.setAuthor(getUser(request).getName());
        jtyy.setUserId(getUser(request).getId());
        int res = jtyyService.insertSelective(jtyy);
        Map<String, Object> map = new HashMap<String, Object>();
        if(res==1){
            map.put("status",ReturnInfoType.SUCEEESS);
            map.put("msg","插入成功");
        }else{
            map.put("status",ReturnInfoType.FAIL);
            map.put("msg","插入失败");
        }
        return toJSONString(map);
    }

    /**
    * 删除
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/delete",method = RequestMethod.POST)
    @ResponseBody
    public String delete(Integer id,HttpServletRequest request,HttpServletResponse response){
        int res = jtyyService.deleteByPrimaryKey(id);
        Map<String, Object> map = new HashMap<String, Object>();
        if(res==1){
            map.put("status",ReturnInfoType.SUCEEESS);
            map.put("msg","删除成功");
        }else{
            map.put("status",ReturnInfoType.FAIL);
            map.put("msg","删除失败");
        }
        return toJSONString(map);
    }

    /**
    * 更新
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/update")
    @ResponseBody
    public String update(Jtyy jtyy,HttpServletRequest request,HttpServletResponse response){
        int res = jtyyService.updateByPrimaryKeySelective(jtyy);
        Map<String, Object> map = new HashMap<String, Object>();
        if(res==1){
            map.put("status",ReturnInfoType.SUCEEESS);
            map.put("msg","更新成功");
        }else{
            map.put("status",ReturnInfoType.FAIL);
            map.put("msg","更新失败");
        }
        return toJSONString(map);
    }
    /**
     * 跳转更新页面
     *
     * @param id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/toupdate", method = RequestMethod.GET)
    public String toupdate(int id, HttpServletRequest request, HttpServletResponse response) {
        Jtyy jtyy = jtyyService.selectByPrimaryKey(id);
        request.setAttribute("jtyy", jtyy);
        return "sys/jtyy/edit";
    }

    /**
     * 根据id查找资讯
     *
     * @param id
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value = "/news", method = RequestMethod.GET)
    public String view(int id, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Jtyy jtyy = jtyyService.selectByPrimaryKey(id);
        request.setAttribute("jtyy", jtyy);
        return "sys/jtyy/news";
    }
    /**
    * 查询
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/select",method = RequestMethod.GET,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String select(Integer id,HttpServletRequest request,HttpServletResponse response){
        Jtyy jtyy = jtyyService.selectByPrimaryKey(id);
        Map<String, Object> map = new HashMap<String, Object>();
        if (!isEmpty(jtyy))
        map.put("jtyy",jtyy);
        return toJSONString(map);
    }

    /**
    * 分页查询列表
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/selectList",method = RequestMethod.GET)
    @ResponseBody
    public String selectList(Jtyy jtyy, Integer pageNum, Date start, Date end, Integer newTypeId,String title,HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> pmap = new HashMap<String, Object>();
        Map<String, Object> dmap = new HashMap<String, Object>();
        User user = getUser(request);
        pmap.put("start", start);
        pmap.put("end", end);
        pmap.put("pageNum", getPageNum(pageNum));
        pmap.put("pageSize", pageSize);
        pmap.put("newTypeId",newTypeId);
        pmap.put("title",title);
        List<Jtyy> list=jtyyService.selectList(pmap);
        int count=jtyyService.selectListCount(pmap);
        if (!isEmpty(list)) dmap.put("list", list);
        dmap.put("count",count);
        return toJSONString(dmap);
    }

    /**
     * 日期转化器
     * @param binder
     */
    @InitBinder
    public void transferToDate(WebDataBinder binder){
        binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"),true));
    }
}