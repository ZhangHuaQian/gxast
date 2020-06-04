package com.cen.web.message.controller;

import com.cen.Message.entity.Message;
import com.cen.Message.service.MessageService;
import com.cen.MessageLog.entity.MessageLog;
import com.cen.MessageLog.service.MessageLogService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;
import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.news_reply.entity.news_reply;
import com.cen.news_reply.service.news_replyService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by cenguocheng on 2019/1/8.
 * 137544496@qq.com
 */
@Controller
@RequestMapping("/web/message")
public class WebMessageController extends BaseController {
    @Autowired
    MessageService messageService;
    @Autowired
    MessageLogService messageLogService;
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
        Map<String, Object> map = new HashMap<String, Object>();

        MessageLog messageLog=messageLogService.selectAll(id);
        messageLog.setStatue("1");
        messageLogService.updateByPrimaryKeySelective(messageLog);
        return toJSONString(rMap);
    }


}
