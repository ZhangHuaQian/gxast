package com.cen.t_html.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.t_html.entity.ZXJJ;
import com.cen.t_html.service.ZxjjService;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sys/zxjj")
public class ZxjjController extends BaseController {
    @Autowired
    private ZxjjService zxjjService;

    @RequestMapping(value = "/select", method = RequestMethod.GET)
    @ResponseBody
    public String selectById(Integer id, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> smap = new HashMap<String, Object>();
        ZXJJ zxjj = zxjjService.selectByPrimaryKey(id);
        if (!isEmpty(zxjj))
            smap.put("zxjj", zxjj);

        return toJSONString(smap);
    }
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String update(Integer id, ZXJJ zxjj, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> umap = new HashMap<String, Object>();
        zxjj.setId(id);
        int count = zxjjService.updateByPrimaryKeySelective(zxjj);
        if (count == 1) {
            umap.put("msg", "更新成功");
            umap.put("status", ReturnInfoType.SUCEEESS);
        } else {
            umap.put("msg", "更新失败");
            umap.put("status", ReturnInfoType.FAIL);
        }
        return toJSONString(umap);
    }

//    @RequestMapping(value = "/zxjjindex",method = RequestMethod.GET)
//    public String zxjjupdate( HttpServletRequest request, HttpServletResponse response,ModelMap map) {
//        ZXJJ zxjj=zxjjService.selectByPrimaryKey(1);
//        map.put("zxjj",zxjj);
//        return "web/about/zxjj";
//    }
//
//    @RequestMapping(value = "/jgznindex", method = RequestMethod.GET)
//    public String jgznupdate( HttpServletRequest request, HttpServletResponse response,ModelMap map) {
//        ZXJJ jgzn=zxjjService.selectByPrimaryKey(2);
//        map.put("jgzn",jgzn);
//        return "web/about/jgznindex";
//    }

    /**
     * 日期转化器
     * @param binder
     */
    @InitBinder
    public void transferToDate(WebDataBinder binder){
        binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"),true));
    }

}
