package com.cen.appsite.StxcContest.controller;

import com.cen.StxcContest.entity.StxcContest;
import com.cen.StxcContest.service.StxcContestService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ResData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/appsite/stxcContest")
public class AppStxcContestController extends BaseController {

    @Autowired
    StxcContestService<StxcContest> stxcContestService;

    /**
    * 随机获取一道题目
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/selectList",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectList(StxcContest stxcContest,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> paramMap = MapUtils.beanToMap(stxcContest);

        List<StxcContest> lists = stxcContestService.selectList(paramMap);
        lists.get(0).setRightKey("");
        rMap.put("data",lists);

        return ResData.SUCCESS(rMap).toString();
    }


}