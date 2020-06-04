package com.cen.bbs.report.controller;


import com.cen.Message.entity.Message;
import com.cen.Message.service.MessageService;
import com.cen.bbs.comment.entity.Comment;
import com.cen.bbs.comment.service.CommentService;
import com.cen.bbs.report.entity.Report;
import com.cen.bbs.report.service.ReportService;
import com.cen.bbs.topic.entity.Topic;
import com.cen.bbs.topic.service.TopicService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;


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
@RequestMapping("/report")
public class ReportController extends BaseController {
    @Autowired
     ReportService reportService;
    @Autowired
     UserService userService;
    @Autowired
    MessageService messageService;
    @Autowired
    TopicService topicService;
    @Autowired
    CommentService commentService;

    /*举报*/
    @RequestMapping(value="/reportTopic",method= RequestMethod.POST)
    @ResponseBody
    public String reportTopic(String topicId,String commentId,String content,String report_type, HttpServletRequest request, HttpServletResponse response) {
        User user=getUser(request);
        Report report=new Report();
        Map<String, Object> map = new HashMap<String, Object>();
        if(user==null){
            map.put("msg","用户不存在");
            map.put("status",ReturnInfoType.ERROR);
        }else{
            System.out.println(commentId);
            report.setTopicId(topicId);
            report.setCommentId(commentId);
            report.setUserId(user.getId());
            report.setUsername(userService.selectByPrimaryKey(user.getId()).getName());//获取举报人姓名
            report.setReport_type(report_type);
            report.setTime(new Date());
            report.setContent(content);
            report.setStatus("0");
            int result=reportService.insertSelective(report);
            Message message=new Message();
            Topic topic=topicService.selectByPrimaryKey(Integer.valueOf(report.getTopicId()));

            if(commentId.equals("0")){
                message.setMessage(user.getName()+"举报了一条帖子，其主题是："+topic.getTitle());
            }else {
                message.setMessage(user.getName()+"举报了一条帖子主题为："+topic.getTitle()+"下的评论");
            }


            message.setSendid(user.getId());
            message.setType("Private");
            message.setPostdate(new Date());
            message.setTitle("论坛举报");
            String[] recIds = {report.getUserId()};
            messageService.sendMessage(message,recIds);//发送非私信，不需要recIds参数
            if(result==1){
                map.put("msg","添加成功");
                map.put("status",ReturnInfoType.SUCEEESS);
            }else{
                map.put("msg","添加失败");
                map.put("status",ReturnInfoType.FAIL);
            }

        }

        return toJSONString(map);


    }


    /*查询举报列表*/
    @RequestMapping(value="/selectList",method= RequestMethod.GET)
    @ResponseBody
    public String selectList(Report report,Integer pageNum,Date date1, Date date2, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> bmap = new HashMap<String, Object>();
        map= MapUtils.beanToMap(report);
        map.put("start", date1);
        map.put("end", date2);
        map.put("pageNum",getPageNum(pageNum));
        map.put("pageSize",pageSize);
        List<Report> list=reportService.selectList(map);

        int count=reportService.selectListCount(map);
        if (!isEmpty(list)){
            for(Report rep : list){
                if(rep.getCommentId().equals("0")){
                    //帖子被举报
                    Topic topic = topicService.selectByPrimaryKey(Integer.valueOf(rep.getTopicId()));
                    rep.setBeReportedContent(topic.getContent());
                }else{
                    //评论被举报
                    Comment comment = commentService.selectByPrimaryKey(Integer.valueOf(rep.getCommentId()));
                    if(comment != null){
                        rep.setBeReportedContent(comment.getContent());
                    }
                }
            }
            bmap.put("list",list);
        }
        bmap.put("count", count);
        bmap.put("msg","查询成功");
        bmap.put("code",0);
        return toJSONString(bmap);

    }
    /*查询未处理举报列表*/
    @RequestMapping(value="/selectListunreport",method= RequestMethod.GET)
    @ResponseBody
    public String selectListunreport(Report report,Integer pageNum,Date date1, Date date2, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> bmap = new HashMap<String, Object>();
        map= MapUtils.beanToMap(report);
        map.put("start", date1);
        map.put("end", date2);
        map.put("pageNum",getPageNum(pageNum));
        map.put("pageSize",pageSize);
        map.put("status","0");
        List<Report> list=reportService.selectList(map);
        int count=reportService.selectListCount(map);
        if (!isEmpty(list)) bmap.put("list",list);
        bmap.put("count", count);
        bmap.put("msg","查询成功");
        bmap.put("code",0);
        return toJSONString(bmap);

    }


    /*处理举报*/
    @RequestMapping(value="/updateStatus",method= RequestMethod.GET)
    @ResponseBody
    public String updateStatus(Report report,Integer id,String status,HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        User user=getUser(request);
        System.out.println(status);
        if(status=="0"){
            report.setStatus("1");
        }else{
            report.setStatus("1");
        }

        int count=reportService.updateByPrimaryKeySelective(report);
        Message message=new Message();
        Report report1=reportService.selectByPrimaryKey(id);
        Topic topic=topicService.selectByPrimaryKey(Integer.valueOf(report1.getTopicId()));
        topic.setStatus(1);
        topic.setIsTop(0);
        topicService.updateByPrimaryKey(topic);
        if(report1.getCommentId().equals("0")){
            message.setMessage(user.getName()+"处理了一条被举报的帖子，其主题是："+topic.getTitle());
        }else{
            message.setMessage(user.getName()+"处理了一条被举报的帖子为："+topic.getTitle()+"下的评论");
        }
        message.setSendid(user.getId());
        message.setType("Private");
        message.setPostdate(new Date());
        message.setTitle("处理反馈");
        String[] recIds = {report1.getUserId()};
        messageService.sendMessage(message,recIds);//发送非私信，不需要recIds参数
        if(count==1){
            map.put("msg","更新成功");
            map.put("status",ReturnInfoType.SUCEEESS);
        }else{
            map.put("msg","更新失败");
            map.put("status",ReturnInfoType.FAIL);
        }
        return toJSONString(map);

    }


    /*处理举报*/
    @RequestMapping(value="/delete",method= RequestMethod.GET)
    @ResponseBody
    public String delete(Integer id,String tid,String cid,String status,HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        User user=getUser(request);
        Message message=new Message();
        Report report=reportService.selectByPrimaryKey(id);

      if(status.equals("0")){
          report.setStatus("1");
      }else{
          report.setStatus("1");
      }
        reportService.updateByPrimaryKeySelective(report);//更新处理状态*/

       if(cid.equals("0")){
            Topic topic=topicService.selectByPrimaryKey(Integer.valueOf(tid));
            topic.setStatus(1);
            topic.setIsTop(0);
            int count=topicService.updateByPrimaryKey(topic);
            message.setMessage(user.getName()+"删除了一条被举报的帖子，其主题是："+topic.getTitle());
            message.setSendid(user.getId());
            message.setType("Private");
            message.setPostdate(new Date());
            message.setTitle("删除帖子");
            String[] recIds = {user.getId()};
            messageService.sendMessage(message,recIds);
            if(count==1){
                map.put("msg","删除成功");
                map.put("status",ReturnInfoType.SUCEEESS);
            }else{
                map.put("msg","删除失败");
                map.put("status",ReturnInfoType.FAIL);
            }
        }else{
           Comment comment=commentService.selectByPrimaryKey(Integer.valueOf(cid));
           comment.setState(1);
           int count=commentService.updateByPrimaryKeySelective(comment);
           message.setMessage(user.getName()+"删除了一条被举报的评论，其内容是："+comment.getContent());
           message.setSendid(user.getId());
           message.setType("Private");
           message.setPostdate(new Date());
           message.setTitle("删除评论");
           String[] recIds = {user.getId()};
           messageService.sendMessage(message,recIds);
           if(count==1){
               map.put("msg","删除成功");
               map.put("status",ReturnInfoType.SUCEEESS);
           }else{
               map.put("msg","删除失败");
               map.put("status",ReturnInfoType.FAIL);
           }
        }

        return toJSONString(map);

    }

    /*查询待处理的举报条数*/
    @RequestMapping(value="/selectReportCount",method= RequestMethod.GET)
    @ResponseBody
    public String selectReportCount(HttpServletRequest request, HttpServletResponse response){
        User user=getUser(request);
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String,Object> paramMap = new HashMap<String,Object>();
        //paramMap.put("uid",user.getId());
        int count=reportService.selectReportCount(paramMap);
        map.put("count",count);
        return toJSONString(map);
    }
    /*查询待处理的举报条数*/
    @RequestMapping(value="/newdelete",method= RequestMethod.GET)
    @ResponseBody
    public String newdelete(Integer id, HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> map = new HashMap<String, Object>();
        Report report=reportService.selectByPrimaryKey(id);
        if(report.getStatus()=="0"){
            report.setStatus("1");
        }else{
            report.setStatus("1");
        }
        reportService.updateByPrimaryKeySelective(report);//更新处理状态*/
        map.put("msg","删除成功");
        map.put("status",ReturnInfoType.SUCEEESS);
        return toJSONString(map);
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