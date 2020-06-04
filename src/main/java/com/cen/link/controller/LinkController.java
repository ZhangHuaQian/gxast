package com.cen.link.controller;


import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.link.entity.Link;
import com.cen.link.service.LinkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sys/link")
public class LinkController extends BaseController {
    @Autowired
    private LinkService linkService;

    @RequestMapping(value = "/select", method = RequestMethod.GET)
    @ResponseBody
    public String selectById(Integer id, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> smap = new HashMap<String, Object>();
       Link link = linkService.selectByPrimaryKey(id);
       smap.put("data",link);
       smap.put("msg","操作成功");
       smap.put("status",ReturnInfoType.SUCEEESS);
        return toJSONString(smap);
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody
    public String insert(Link link, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> imap = new HashMap<String, Object>();

     int res=linkService.insertSelective(link);
        if (res>0) {
            imap.put("msg", "操作成功");
            imap.put("status", ReturnInfoType.SUCEEESS);
        } else {
            imap.put("msg", "操作失败");
            imap.put("status", ReturnInfoType.ERROR);
        }
        return toJSONString(imap);
    }
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public String delete(Integer id, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> umap = new HashMap<String, Object>();
//        String sql="delete from link where id="+id;
        int res = linkService.deleteByPrimaryKey(id);
        if (res > 0) {
            umap.put("msg", "操作失败");
            umap.put("status", ReturnInfoType.SUCEEESS);
        } else {
            umap.put("msg", "操作失败");
            umap.put("status", ReturnInfoType.ERROR);
        }
        return toJSONString(umap);
    }

//    @RequestMapping(value="/delete",produces = "application/json;charset=utf-8")
//    @ResponseBody
//    public String delete(Integer id,HttpServletRequest request,HttpServletResponse response){
//        Map<String, Object> rMap = new HashMap<String, Object>();
////        String sql="delete from books where id="+id;
//        int res = workerService.deleteByPrimaryKey(id);
//        if(res>0){
//            rMap.put("msg", "操作成功");
//            rMap.put("status", ReturnInfoType.SUCEEESS);
//        }else{
//            rMap.put("msg", "操作失败");
//            rMap.put("status", ReturnInfoType.ERROR);
//        }
//        return toJSONString(rMap);
//    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String update(Integer id, Link link, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
        Map<String, Object> umap = new HashMap<String, Object>();
        link.setId(id);
        int count = linkService.updateByPrimaryKeySelective(link);
        if (count == 1) {
            umap.put("msg", "更新成功");
            umap.put("status", ReturnInfoType.SUCEEESS);
        } else {
            umap.put("msg", "更新失败");
            umap.put("status", ReturnInfoType.FAIL);
        }
        return toJSONString(umap);
    }

    /**
     * 分页查询所有资讯
     *
     * @param pageNum
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value = "/selectList", method = RequestMethod.GET)
    @ResponseBody
    public String selectList(Link link, Integer pageNum, HttpServletRequest request, HttpServletResponse response, ModelMap map) {

        Map<String, Object> pmap = new HashMap<String, Object>();
        Map<String, Object> dmap = new HashMap<String, Object>();

        pmap = MapUtils.beanToMap(link);
        pmap.put("pageNum", getPageNum(pageNum));
        pmap.put("pageSize", pageSize);
        List<Link> list= linkService.selectList(pmap);
        List<String> linklist=new ArrayList<>();
        for (Link lk:list){
              String Slink=lk.getLink();
              linklist.add(Slink);
        }//列表

        int count = linkService.selectListCount(pmap);

        dmap.put("linklist",linklist);
        dmap.put("count",count);
        dmap.put("list",list);
        return toJSONString(dmap);
    }

//    @UserOperate(moduleName="轮播图",option = "查看轮播图列表")
//    @RequestMapping(value="/selectList",method=RequestMethod.GET)
//    @ResponseBody
//    public String SelectList(Integer pageNum,String header,String type,String kk,HttpServletRequest request,
//                             HttpServletResponse response,ModelMap map) throws ParseException{
//
//        User user = getUser(request);
//        Map<String, Object> pmap = new HashMap<String, Object>();
//        Map<String, Object> smap = new HashMap<String, Object>();
//        System.out.printf(header);
//        //pmap = MapUtils.beanToMap(loopphoto);
//        pmap.put("pageNum",getPageNum(pageNum));
//        pmap.put("pageSize",pageSize);
//        pmap.put("header",header);
//        if(type!=""){
//            type=type+'#'+kk;
//        }
//        pmap.put("type",type);
//        List<Loopphoto> list = loopphotoService.selectList(pmap);  //列表
//        int count = loopphotoService.selectListCount(pmap);  //列表数
//        if(!isEmpty(list)) smap.put("list", list);
//        smap.put("count", count);
//        return toJSONString(smap);
//    }
}
