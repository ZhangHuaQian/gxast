package com.cen.web.controller;

import com.cen.Message.service.MessageService;
import com.cen.MessageLog.entity.MessageLog;
import com.cen.MessageLog.service.MessageLogService;
import com.cen.common.controller.BaseController;
import com.cen.dictionary.entity.Dictionary;
import com.cen.dictionary.service.DictionaryService;
import com.cen.subject.entity.Subject;
import com.cen.subject.service.SubjectService;
import com.cen.t_html.entity.ZXJJ;
import com.cen.t_html.service.ZxjjService;
import com.cen.ucenter.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by cenguocheng on 2019/1/8.
 * 137544496@qq.com
 */
@Controller
@RequestMapping("/web")
public class WebController extends BaseController {

    @Autowired
    private DictionaryService dictionaryService;
    @Autowired
    MessageLogService messageLogService;
    @Autowired
    MessageService messageService;
    @Autowired
    ZxjjService zxjjService;
    @Autowired
    SubjectService subjectService;
    /**
     * PC 端网站首页
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value="index")
    public String selectList(HttpServletRequest request,
                             HttpServletResponse response, ModelMap map) {
        System.out.println(123);

        Map<String, Object> pmap = new HashMap<String, Object>();
        pmap.put("type","type_zx");
        List<Dictionary> list = dictionaryService.selectList(pmap);
        map.put("xxx",list);

        return "index";
    }


    @RequestMapping(value = "selectmyMessage")
    @ResponseBody
    public String selectmyMessage(int pageNum,HttpServletRequest request, HttpServletResponse response, ModelMap map){
        User user = getUser(request);
        Map<String, Object> dmap = new HashMap<String, Object>();
        Map<String, Object> pmap = new HashMap<String, Object>();
        Map<String,Object> params2 = new HashMap<>();
        MessageLog messageLog = new MessageLog();
        messageLog.setRecid(user.getId());
        pmap.put("pageNum", getPageNum(pageNum));
        pmap.put("pageSize", pageSize);
        pmap.put("messagelog",messageLog);
        params2.put("messagelog",messageLog);
        //messageLog.setStatue("0");
        List<Map> messages = messageService.getMyMessage(pmap);
        dmap.put("list", messages);
        dmap.put("count", messageService.getMyMessage(params2).size());
        return toJSONString(dmap);
    }


    /**
     * 下载最新一个(apk)文件
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/download",produces = "application/json;charset=utf-8")
    public String getFile(String fileName,HttpServletRequest request, HttpServletResponse response) {
        if (fileName != null) {
            File file = new File(system_APK_RESOUREC, fileName);
            System.out.println(file.getName());
            System.out.println(file.getPath());
            if (file.exists()) {
                //response.setContentType("application/force-download");// 设置强制下载不打开
                response.addHeader("Content-Disposition",
                        "attachment;fileName=" + fileName);// 设置文件名
                byte[] buffer = new byte[1024];
                FileInputStream fis = null;
                BufferedInputStream bis = null;
                try {
                    fis = new FileInputStream(file);
                    bis = new BufferedInputStream(fis);
                    OutputStream os = response.getOutputStream();
                    int i = bis.read(buffer);
                    while (i != -1) {
                        os.write(buffer, 0, i);
                        i = bis.read(buffer);
                    }
                } catch (Exception e) {
                    // TODO: handle exception
                    e.printStackTrace();
                } finally {
                    if (bis != null) {
                        try {
                            bis.close();
                        } catch (IOException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                    }
                    if (fis != null) {
                        try {
                            fis.close();
                        } catch (IOException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        return null;
    }
    @RequestMapping(value = "/zxjjindex",method = RequestMethod.GET)
    public String zxjjupdate( HttpServletRequest request, HttpServletResponse response,ModelMap map) {
        ZXJJ zxjj=zxjjService.selectByPrimaryKey(1);
        map.put("zxjj",zxjj);
        return "web/about/zxjj";
    }

    @RequestMapping(value = "/jgznindex", method = RequestMethod.GET)
    public String jgznupdate( HttpServletRequest request, HttpServletResponse response,ModelMap map) {
        ZXJJ jgzn=zxjjService.selectByPrimaryKey(2);
        map.put("jgzn",jgzn);
        return "web/about/jgzn";
    }

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

    /**
     * 查询资讯详情
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value="details/{id}")
    public String details(@PathVariable Integer id, HttpServletRequest request,
                          HttpServletResponse response, ModelMap map) {
        Subject subject = subjectService.selectByPrimaryKey(id);
        map.put("subject",subject);
        return "/web/subject/details";

    }


}
