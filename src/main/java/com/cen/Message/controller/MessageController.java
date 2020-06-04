package com.cen.Message.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.MessageLog.entity.MessageLog;
import com.cen.MessageLog.service.MessageLogService;
import com.cen.ucenter.service.UserService;
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
import com.cen.Message.service.MessageService;
import com.cen.Message.entity.Message;

@Controller
@RequestMapping("/sys/Message")
public class MessageController extends BaseController {

    @Autowired
    MessageService messageService;
    @Autowired
    MessageLogService messageLogService;
    @Autowired
    UserService userService;
    /**
    * 添加
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/insert",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String insert(Message message,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        int res = messageService.insertSelective(message);
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
        int count = messageService.deleteByPrimaryKey(id);
        if(count==1){
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
    public String update(Message message,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        int count = messageService.updateByPrimaryKeySelective(message);
        if(count==1){
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
        Message res = messageService.selectByPrimaryKey(id);

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
    @RequestMapping(value="/getMyMessageTB")
    @ResponseBody
    public String selectList(Message message, Integer limit,Integer page,HttpServletRequest request, HttpServletResponse response){
        User user = getUser(request);
        Map<String,Object> map = new HashMap<>();
        Map<String,Object> params = new HashMap<>();
        Map<String,Object> params2 = new HashMap<>();
        MessageLog messageLog = new MessageLog();
        messageLog.setRecid(user.getId());
        /* messageLog.setStatue("0");*/
        params.put("messagelog",messageLog);
        params.put("limit",limit);
        params.put("page",(page-1)*limit);
        params2.put("messagelog",messageLog);
        List<Map> messages = messageService.getMyPrivateMessage(params);
        map.put("code",0);
        map.put("msg","");
        map.put("count",messageService.getMyPrivateMessage(params2).size());
        map.put("data",messages);
        return toJSONString(map);
    }




    @RequestMapping(value="/read",produces = "application/json;charset=utf-8")
    @ResponseBody
    public  String read(Message message,MessageLog messageLog, HttpServletRequest request, HttpServletResponse response){

        Map<String,Object> tmap=new HashMap<>();
        messageLog.setMessageid(message.getId());
        messageLog.setRecid(getUser(request).getId());
        int count=messageLogService.updateStatueByIDID(messageLog);
        if(count==1){
            tmap.put("msg","更新成功");
            tmap.put("status", ReturnInfoType.SUCEEESS);
        }else{
            tmap.put("msg","更新失败");
            tmap.put("status",ReturnInfoType.FAIL);
        }
        return toJSONString(tmap);
    }

    @RequestMapping("/selectMessageLogByStatue")
    @ResponseBody
    public String selectMessageLogByStatue(Message message,HttpServletRequest request,HttpServletResponse response){
        User user = getUser(request);
        Map<String,Object> map = new HashMap<>();
        Map<String,Object> params2 = new HashMap<>();
        MessageLog messageLog = new MessageLog();
        messageLog.setRecid(user.getId());
        messageLog.setStatue("0");
        params2.put("messagelog",messageLog);

        map.put("count",messageService.getMyPrivateMessage(params2).size());

        return toJSONString(map);
    }



}