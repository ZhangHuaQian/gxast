package com.cen.nfkjw.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cen.nfkjw.entity.Nfkjw;
import com.cen.nfkjw.service.NfkjwService;
import com.cen.ucenter.entity.User;
import com.cen.upms.entity.Department;
import com.cen.upms.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.*;


@Controller
@RequestMapping("/sys/nfkjw")
public class NfkjwController extends BaseController {

    @Autowired
    NfkjwService nfkjwService;
    @Autowired
    DepartmentService departmentService;
    /**
    * 添加
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/insert", method = RequestMethod.POST)
    @ResponseBody
    public String insert(Nfkjw nfkjw,HttpServletRequest request,HttpServletResponse response){
        nfkjw.setCreateTime(new Date());
        nfkjw.setModifyTime(new Date());
        nfkjw.setIsDel(0);
        //nfkjw.setAuthor(getUser(request).getName());
        nfkjw.setUserId(getUser(request).getId());
        int result = nfkjwService.insertSelective(nfkjw);
        Map<String, Object> map = new HashMap<String, Object>();
        if(result==1){
            map.put("status",ReturnInfoType.SUCEEESS);
            map.put("msg","资讯添加成功");
        }else{
            map.put("status",ReturnInfoType.FAIL);
            map.put("msg","资讯添加失败");
        }
       return toJSONString(map);
    }

    /**
    * 删除
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/delete", method = RequestMethod.POST)
    @ResponseBody
    public String delete(Integer id,HttpServletRequest request,HttpServletResponse response){
        int res = nfkjwService.deleteByPrimaryKey(id);
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
    @RequestMapping(value="/update", method = RequestMethod.POST)
    @ResponseBody
    public String update(Nfkjw nfkjw,Integer id,HttpServletRequest request,HttpServletResponse response){
        nfkjw.setModifyTime(new Date());
        nfkjw.setId(id);
        int res = nfkjwService.updateByPrimaryKeySelective(nfkjw);
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
    * 查询
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/select", method = RequestMethod.GET)
    @ResponseBody
    public String select(Integer id,HttpServletRequest request,HttpServletResponse response){
        Nfkjw nfkjw = nfkjwService.selectByPrimaryKey(id);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("nfkjw",nfkjw);
        return toJSONString(map);
    }
    /**
     * 根据id查找资讯
     *
     * @param id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/news", method = RequestMethod.GET)
    public String view(int id, HttpServletRequest request, HttpServletResponse response) {
        Nfkjw nfkjw = nfkjwService.selectByPrimaryKey(id);
        request.setAttribute("nfkjw", nfkjw);
        return "sys/nfkjw/news";
    }
    /**
    * 分页查询列表
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/selectList", method = RequestMethod.GET)
    @ResponseBody
    public String selectList(Nfkjw nfkjw,Date start, Date end, Integer pageNum,Integer newTypeId,String title,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> pmap = new HashMap<String, Object>();
        Map<String, Object> dmap = new HashMap<String, Object>();
        User user = getUser(request);
        pmap.put("start", start);
        pmap.put("end", end);
        pmap.put("pageNum", getPageNum(pageNum));
        pmap.put("pageSize", pageSize);
        pmap.put("newTypeId",newTypeId);
        pmap.put("title",title);
        List<Nfkjw> list=nfkjwService.selectList(pmap);
        int count=nfkjwService.selectListCount(pmap);

        if (!isEmpty(list)) dmap.put("list", list);
        dmap.put("count", count);
        return toJSONString(dmap);
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
        Nfkjw nfkjw = nfkjwService.selectByPrimaryKey(id);
        request.setAttribute("nfkjw", nfkjw);
        return "sys/nfkjw/edit";
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