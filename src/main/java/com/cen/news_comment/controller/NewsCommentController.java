package com.cen.news_comment.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;

import com.cen.common.util.ReturnInfoType;
import com.cen.news_comment.entity.NewsComment;
import com.cen.news_comment.service.NewsCommentService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sys/news_comment")
public class NewsCommentController extends BaseController {
    @Autowired
     NewsCommentService newsCommentService;
    @Autowired
    private UserService userService;

    @RequestMapping(value="/selectList", method = RequestMethod.GET)
    @ResponseBody
    public  String selectList(NewsComment newsComment, Date date1, Date date2, Integer pageNum, HttpServletRequest request, HttpServletResponse response)throws ParseException {
        Map<String, Object> pmap = new HashMap<String, Object>();
        Map<String, Object> dmap = new HashMap<String, Object>();

        pmap = MapUtils.beanToMap(newsComment);
        pmap.put("start", date1);
        pmap.put("end", date2);
        pmap.put("pageNum", getPageNum(pageNum));
        pmap.put("pageSize", pageSize);
        List<NewsComment> list=newsCommentService.selectList(pmap);
        int count=newsCommentService.selectListCount(pmap);
        if (!isEmpty(list)) dmap.put("list", list);
        dmap.put("count", count);
        dmap.put("msg","");
        dmap.put("code",0);
        return toJSONString(dmap);
    }

    @RequestMapping(value="/selectCommentList", method = RequestMethod.GET)
    @ResponseBody
    public  String selecCommenttList(NewsComment newsComment, Date date1, Date date2, Integer pageNum, HttpServletRequest request, HttpServletResponse response)throws ParseException {
        Map<String, Object> pmap = new HashMap<String, Object>();
        Map<String, Object> dmap = new HashMap<String, Object>();

        pmap = MapUtils.beanToMap(newsComment);
        pmap.put("start", date1);
        pmap.put("end", date2);
        pmap.put("pageNum", getPageNum(pageNum));
        pmap.put("pageSize", pageSize);
        pmap.put("commentstate",'0');
        List<NewsComment> list=newsCommentService.selectList(pmap);
        int count=newsCommentService.selectListCount(pmap);
        if (!isEmpty(list)) dmap.put("list", list);
        dmap.put("count", count);
        dmap.put("msg","");
        dmap.put("code",0);
        return toJSONString(dmap);
    }

    /**
     * 查询未审核的
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/comment_two",method = RequestMethod.POST)
    @ResponseBody
    public String comment_two(HttpServletRequest request, HttpServletResponse response) {
        User user=getUser(request);
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String,Object> paramMap = new HashMap<String,Object>();
        //paramMap.put("uid",user.getId());
        int count=newsCommentService.selectCommentCount(paramMap);

        map.put("count",count);
        return toJSONString(map);

    }


    @RequestMapping(value="/delete",method = RequestMethod.POST)
    @ResponseBody
    public  String delete(int id,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> bmap = new HashMap<String, Object>();

        int record=newsCommentService.deleteByPrimaryKey(id);
        if(record==1){
            bmap.put("msg","删除成功");
            bmap.put("status", ReturnInfoType.SUCEEESS);

        }else{
            bmap.put("msg","删除失败");
            bmap.put("status",ReturnInfoType.FAIL);

        }
        return toJSONString(bmap);
    }

    @RequestMapping(value="/updateStatus",produces = "application/json;charset=utf-8")
    @ResponseBody
    public  String updateStatus(NewsComment newsComment,HttpServletRequest request,HttpServletResponse response){

        Map<String,Object> tmap=new HashMap<>();

        if(Integer.valueOf(newsComment.getCommentstate())==2){
            newsComment.setCommentstate("2");
        }else if(Integer.valueOf(newsComment.getCommentstate())==1){
            newsComment.setCommentstate("1");
        }else if(Integer.valueOf(newsComment.getCommentstate())==0){
            newsComment.setCommentstate("0");
        }
        int count=newsCommentService.updateByPrimaryKey(newsComment);

        if(count==1){

            tmap.put("msg","更新成功");
            tmap.put("status",ReturnInfoType.SUCEEESS);
        }else{
            tmap.put("msg","更新失败");
            tmap.put("status",ReturnInfoType.FAIL);
        }
        return toJSONString(tmap);
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
