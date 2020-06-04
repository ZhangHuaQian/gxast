package com.cen.MessageLog.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.ucenter.entity.User;
import com.cen.MessageLog.service.MessageLogService;
import com.cen.MessageLog.entity.MessageLog;

@Controller
@RequestMapping("/sys/MessageLog")
public class MessageLogController extends BaseController {

    @Autowired
    MessageLogService messageLogService;

    /**
    * 添加
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/insert",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String insert(MessageLog messageLog,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        int res = messageLogService.insertSelective(messageLog);
        if(res>0){
            rMap.put("msg", "操作成功");
            rMap.put("status", ReturnInfoType.SUCEEESS);
        }else{
            rMap.put("msg", "操作失败");
            rMap.put("status", ReturnInfoType.ERROR);
        }
        return toJSONString(rMap);
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
        Map<String, Object> rMap = new HashMap<String, Object>();
        int res = messageLogService.deleteByPrimaryKey(id);
        if(res>0){
            rMap.put("msg", "操作成功");
            rMap.put("status", ReturnInfoType.SUCEEESS);
        }else{
            rMap.put("msg", "操作失败");
            rMap.put("status", ReturnInfoType.ERROR);
        }
        return toJSONString(rMap);
    }

    /**
    * 更新
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/update",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String update(MessageLog messageLog,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        int res = messageLogService.updateByPrimaryKeySelective(messageLog);
        if(res>0){
            rMap.put("msg", "操作成功");
            rMap.put("status", ReturnInfoType.SUCEEESS);
        }else{
            rMap.put("msg", "操作失败");
            rMap.put("status", ReturnInfoType.ERROR);
        }
        return toJSONString(rMap);
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
        Map<String, Object> rMap = new HashMap<String, Object>();
        MessageLog res = messageLogService.selectByPrimaryKey(id);

        rMap.put("data", res);
        rMap.put("msg", "操作成功");
        rMap.put("status", ReturnInfoType.SUCEEESS);
        return toJSONString(rMap);
    }

    /**
    * 查询列表
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/selectList",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectList(MessageLog messageLog,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap = MapUtils.beanToMap(messageLog);

        // 此处查询需要自行编写
        //List<MessageLog> lists = messageLogService.selectList(paramMap);
        rMap.put("msg", "ok");
        rMap.put("status", ReturnInfoType.SUCEEESS);
        return toJSONString(rMap);
    }


}