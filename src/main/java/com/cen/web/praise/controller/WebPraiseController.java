package com.cen.web.praise.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.HttpUtil;
import com.cen.common.util.ReturnInfoType;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;
import com.cen.praise.entity.Praise;
import com.cen.praise.service.PraiseService;
import com.cen.ucenter.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/web/praise")
public class WebPraiseController extends BaseController {
    @Autowired
    private PraiseService praiseService;
    @Autowired
    private NewsService newsService;


    /**
     * 点赞
     * @param id
     * @param news_type
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "insert",method= RequestMethod.POST)
    @ResponseBody
    public String insert(int id,String news_type, HttpServletRequest request, HttpServletResponse response){
        User user=getUser(request);

        if(user==null){//如果用户不存在
          return ReturnInfoType.ERROR;
        }else{
            Map<String, Object> map = new HashMap<String, Object>();
            Map<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("uid",user.getId());
            paramMap.put("newsid",id);
            paramMap.put("news_type",news_type);
            List<Praise> praise = praiseService.findByUidAndNewsId(paramMap);//找到这条记录
            if(praise.size()>0){
                //取消点赞
                praiseService.deleteByPrimaryKey( praise.get(0).getId());
                News news=newsService.selectByPrimaryKey(id);
                news.setPraise_view(news.getPraise_view()-1);
                newsService.updateByPrimaryKeySelective(news);
                map.put("news",news);
                return toJSONString(map);

            }else{
                // 执行点赞
                Praise praise2 = new Praise();
                praise2.setNewsid(id);
                praise2.setUid(user.getId());
                praise2.setNews_type(news_type);
                praiseService.insertSelective(praise2);
                //添加记录
                News news=newsService.selectByPrimaryKey(id);
                news.setPraise_view(news.getPraise_view()+1);
                newsService.updateByPrimaryKeySelective(news);
                map.put("news",news);
                return toJSONString(map);

            }
        }



    }

    @RequestMapping(value = "select",method= RequestMethod.POST)
    @ResponseBody
    public String select(int id,String news_type, HttpServletRequest request, HttpServletResponse response){
        User user=getUser(request);
        if(user==null){
            return ReturnInfoType.ERROR;
        }else{
            Map<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("uid",user.getId());
            paramMap.put("newsid",id);
            paramMap.put("news_type",news_type);
            List<Praise> praises= praiseService.findByUidAndNewsId(paramMap);
            if (praises.size()>0) {
                return ReturnInfoType.SUCEEESS;
            }else {
                return ReturnInfoType.FAIL;
            }
        }

    }


}
