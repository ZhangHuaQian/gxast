package com.cen.subject.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;


import com.cen.dictionary.service.DictionaryService;
import com.cen.subject.entity.Subject;
import com.cen.subject.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/sys/subject")
public class SubjectController  extends BaseController {
    @Autowired
    SubjectService subjectService;
    @Autowired
    DictionaryService dictionaryService;

    /*增加*/
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody
    public String insert(Subject subject, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> cmap = new HashMap<String, Object>();
        subject.setZname(dictionaryService.selectByValue(subject.getZtype()).getName());
        subject.setCreateTime(new Date());
        //subject.setAuthor(getUser(request).getName());
        subject.setUserId(getUser(request).getId());
        int result = subjectService.insertSelective(subject);
        if (result == 1) {
            cmap.put("msg", "添加成功");
            cmap.put("status", ReturnInfoType.SUCEEESS);

        } else {
            cmap.put("msg", "添加失败");
            cmap.put("status", ReturnInfoType.FAIL);
        }
        return toJSONString(cmap);
    }

    @RequestMapping(value = "/select", method = RequestMethod.GET)
    @ResponseBody
    public String selectById(int id, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> smap = new HashMap<String, Object>();
        Subject subject = subjectService.selectByPrimaryKey(id);
        if (!isEmpty(subject))
            smap.put("subject", subject);

        return toJSONString(smap);
    }
    /*查找页面*/
    @RequestMapping(value = "/subject", method = RequestMethod.GET)
    public String view(int id, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Subject subject = subjectService.selectByPrimaryKey(id);
        request.setAttribute("subject", subject);
        return "sys/subject/subject";
    }

    @RequestMapping(value = "/toupdate", method = RequestMethod.GET)
    public String toupdate(int id, HttpServletRequest request, HttpServletResponse response) {
        Subject subject = subjectService.selectByPrimaryKey(id);
        request.setAttribute("subject", subject);
        return "sys/subject/edit";
    }

    /*跳转专题页面*/
    @RequestMapping(value = "/toList",produces = "application/json;charset=utf-8")
    //@ResponseBody
    public String toList(HttpServletRequest request, HttpServletResponse response,ModelMap map) {
        Map<String, Object> amap = new HashMap<String, Object>();
        Map<String, Object> bmap = new HashMap<String, Object>();
        Map<String, Object> cmap = new HashMap<String, Object>();
        amap.put("ztype",30);
        List<Subject> list1=subjectService.selectList(amap);
        bmap.put("ztype",31);
        List<Subject> list2=subjectService.selectList(bmap);
        cmap.put("ztype",32);
        List<Subject> list3=subjectService.selectList(cmap);
        map.put("list1", list1);
        map.put("list2", list2);
        map.put("list3", list3);
        return "web/subject/list";
        //return toJSONString(map);
    }

    /*列表*/
    @RequestMapping(value = "/selectList", method = RequestMethod.GET)
    @ResponseBody
    public String selectList(Date start, Date end,Subject subject,Integer pageNum, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> pmap = new HashMap<String, Object>();
        Map<String, Object> dmap = new HashMap<String, Object>();
        pmap = MapUtils.beanToMap(subject);
        pmap.put("start", start);
        pmap.put("end", end);
        pmap.put("pageNum", getPageNum(pageNum));
        pmap.put("pageSize", pageSize);

        List<Subject> list = subjectService.selectList(pmap); //列表
        int count = subjectService.selectListCount(pmap);  //记录行数
        if (!isEmpty(list)) dmap.put("list", list);
        dmap.put("count", count);
        dmap.put("pagecurr", getPageNum(pageNum) + 1);
        return toJSONString(dmap);
    }

   /*更新*/
   @RequestMapping(value = "/update", method = RequestMethod.POST)
   @ResponseBody
   public String update(Integer id, Subject subject, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
       Map<String, Object> umap = new HashMap<String, Object>();
       subject.setId(id);
       int count = subjectService.updateByPrimaryKeySelective(subject);
       if (count == 1) {
           umap.put("msg", "更新成功");
           umap.put("status", ReturnInfoType.SUCEEESS);
       } else {
           umap.put("msg", "更新失败");
           umap.put("status", ReturnInfoType.FAIL);
       }
       return toJSONString(umap);
   }

    /*删除*/
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public String delete(Integer id, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> umap = new HashMap<String, Object>();
        int result=subjectService.deleteByPrimaryKey(id);
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
     * 日期转化器
     *
     * @param binder
     */
    @InitBinder
    public void transferToDate(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
    }

}
