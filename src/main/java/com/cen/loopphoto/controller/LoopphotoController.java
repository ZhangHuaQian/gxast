package com.cen.loopphoto.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.loopphoto.entity.Loopphoto;
import com.cen.loopphoto.service.LoopphotoService;
import com.cen.operateLog.annotation.UserOperate;
import com.cen.product.entity.Product;
import com.cen.ucenter.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by pc on 2018/10/11.
 */
@Controller
@RequestMapping(value = "/sys/loopphoto")
public class LoopphotoController extends BaseController {

    @Autowired
    private LoopphotoService loopphotoService;

    @UserOperate(moduleName="轮播图",option = "添加轮播图")
    @RequestMapping(value="/insert", method=RequestMethod.POST)
    @ResponseBody
    public String insert(Loopphoto loopphoto, HttpServletRequest request, HttpServletResponse response){
        String endTime = request.getHeader("endTime");
        if(endTime != null && !endTime.equals("")){
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                loopphoto.setEndTime(sf.parse(endTime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        Map<String, Object> cmap = new HashMap<String, Object>();
        loopphoto.setIsDel(0);
        loopphoto.setCreateTime(new Date());
        loopphoto.setModifyTime(new Date());
        int result=loopphotoService.insertSelective(loopphoto);
        if (result==1) {
            cmap.put("msg", "添加成功");
            cmap.put("status", ReturnInfoType.SUCEEESS);
            return toJSONString(cmap);
        }
        else {
            cmap.put("msg", "添加失败");
            cmap.put("status", ReturnInfoType.FAIL);
            return toJSONString(cmap);
        }
    }


    /**
     * 分页查询
     * @param
     * @param pageNum
     * @param request
     * @param response
     * @param map
     * @return
     * @throws ParseException
     */
    @UserOperate(moduleName="轮播图",option = "查看轮播图列表")
    @RequestMapping(value="/selectList",method=RequestMethod.GET)
    @ResponseBody
    public String SelectList(Integer pageNum,String header,String type,String kk,HttpServletRequest request,
                             HttpServletResponse response,ModelMap map) throws ParseException{


        //正在使用的广告位
        List<Integer> isUserIdList = new ArrayList<>();
        for (int i = 1; i <= 8; i++) {
            String type2 = i<10?"zy_#0"+i:"zy_#"+i;
            List<Loopphoto> loopphotoList = loopphotoService.selectByType2(type2);

            if(loopphotoList.size()>0){
                isUserIdList.add(loopphotoList.get(0).getId());
            }

        }

        User user = getUser(request);
        Map<String, Object> pmap = new HashMap<String, Object>();
        Map<String, Object> smap = new HashMap<String, Object>();
        System.out.printf(header);
        //pmap = MapUtils.beanToMap(loopphoto);
        pmap.put("pageNum",getPageNum(pageNum));
        pmap.put("pageSize",pageSize);
        pmap.put("header",header);
        if(type!=""){
            type=type+'#'+kk;
        }
        pmap.put("type",type);
        List<Loopphoto> list = loopphotoService.selectList(pmap);  //列表
        int count = loopphotoService.selectListCount(pmap);  //列表数
        if(!isEmpty(list)) {
            for(int i=0; i<list.size(); i++){
                if(isUserIdList.size()>0){
                    for(Integer isUserLoopId : isUserIdList){
                        if(list.get(i).getId().equals(isUserLoopId)){
                            list.get(i).setIsUse(1); //使用中
                        }
                    }
                }
            }
            smap.put("list", list);
        }

        smap.put("count", count);
        return toJSONString(smap);
    }


    /**
     *
     * @param loopphoto
     * @param request
     * @param response
     * @param map
     * @return
     */
    @UserOperate(moduleName="轮播图",option = "更新轮播图")
    @RequestMapping(value="/update",method=RequestMethod.POST)
    @ResponseBody
    public String update(Loopphoto loopphoto,HttpServletRequest request,HttpServletResponse response,ModelMap map){
        String endTime = request.getHeader("endTime");
        if(endTime != null && !endTime.equals("")){
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                loopphoto.setEndTime(sf.parse(endTime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        Map<String, Object> umap = new HashMap<String, Object>();
        loopphoto.setModifyTime(new Date());
        int count = loopphotoService.updateByPrimaryKeySelective(loopphoto);
        if(count == 1){
            umap.put("msg", "更新成功");
            umap.put("status", ReturnInfoType.SUCEEESS);
        }else{
            umap.put("msg", "更新失败");
            umap.put("status", ReturnInfoType.FAIL);
        }
        return toJSONString(umap);
    }


    /**
     * 删除
     * @param id
     * @param request
     * @param response
     * @return
     */
    @UserOperate(moduleName="轮播图",option = "删除轮播图")
    @RequestMapping(value="/delete",method=RequestMethod.POST)
    @ResponseBody
    public String delete(int id,HttpServletRequest request,HttpServletResponse response) {
        Map<String, Object> umap = new HashMap<String, Object>();
        Loopphoto loopphoto=loopphotoService.selectByPrimaryKey(id);
        loopphoto.setIsDel(1);
        int result=loopphotoService.updateByPrimaryKeySelective(loopphoto);
        if(result == 1){
            umap.put("msg", "删除成功");
            umap.put("status", ReturnInfoType.SUCEEESS);
        }else{
            umap.put("msg", "删除失败");
            umap.put("status", ReturnInfoType.FAIL);
        }
        return toJSONString(umap);
    }

    /**
     *
     * @param id
     * @param request
     * @param response
     * @param map
     * @return
     */
    @UserOperate(moduleName="轮播图",option = "查询轮播图")
    @RequestMapping(value="/select", method = RequestMethod.GET)
    public String selectById(int id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
       // Map<String, Object> smap = new HashMap<String, Object>();
        Loopphoto loopphoto = loopphotoService.selectByPrimaryKey(id);
        if (!isEmpty(loopphoto))
           // smap.put("loopphoto", loopphoto);
        request.setAttribute("loopphoto",loopphoto);

        return "sys/loopphoto/select";
    }
    /**
     *
     * @param id
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value="/toupdate", method = RequestMethod.GET)
    @ResponseBody
    public String selectToupdateById(int id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
        Map<String, Object> smap = new HashMap<String, Object>();
        Loopphoto loopphoto = loopphotoService.selectByPrimaryKey(id);
        if (!isEmpty(loopphoto))
            smap.put("loopphoto", loopphoto);

        return toJSONString2(smap);
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
