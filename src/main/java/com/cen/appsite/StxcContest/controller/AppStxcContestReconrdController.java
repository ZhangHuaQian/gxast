package com.cen.appsite.StxcContest.controller;

import com.cen.StxcContest.entity.StxcContest;
import com.cen.StxcContest.service.StxcContestService;
import com.cen.StxcContestCode.entity.StxcContestCode;
import com.cen.StxcContestCode.service.StxcContestCodeService;
import com.cen.StxcContestReconrd.entity.StxcContestReconrd;
import com.cen.StxcContestReconrd.service.StxcContestReconrdService;
import com.cen.StxcContestUser.entity.StxcContestUser;
import com.cen.StxcContestUser.service.StxcContestUserService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ResData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 生态乡村知识竞赛
 */

@Controller
@RequestMapping("/appsite/stxcContestReconrd")
public class AppStxcContestReconrdController extends BaseController {

    @Autowired
    StxcContestReconrdService<StxcContestReconrd> stxcContestReconrdService;

    @Autowired
    StxcContestService<StxcContest> stxcContestService;

    @Autowired
    StxcContestCodeService<StxcContestCode> stxcContestCodeService;
    @Autowired
    StxcContestUserService<StxcContestUser> stxcContestUserService;


    /**
     * 查询用户当天是否答过题
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/selectByUid", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String select(String openid, HttpServletRequest request, HttpServletResponse response) {

        Map<String, Object> rMap = new HashMap<>();
        StxcContestUser stxcContestUser = stxcContestUserService.selectByOpenid(openid);
        if (stxcContestUser == null) {
            rMap.put("msg", "系统出错！");
            rMap.put("status", 0);
            return toJSONString(rMap);
        } else {
            if (stxcContestUser.getIsLock().equals(1)) {
                rMap.put("msg", "系统出错！");
                rMap.put("status", 0);
                return toJSONString(rMap);
            }
        }

        SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat ymdHMs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date1 = new Date();
        Date date2 = null;
        try {
            date2 = ymdHMs.parse(ymd.format(new Date()) + " 09:00:00");
        } catch (ParseException e) {
            e.printStackTrace();
        }
        boolean after = date1.after(date2);

        //还没到知识竞赛时间
        if (!after) {
            rMap.put("msg", "知识竞赛9点才开始，晚点再来吧！");
            rMap.put("status", 1);
            return toJSONString(rMap);
        }
        StxcContestReconrd res = stxcContestReconrdService.selectByUid(openid);
        if (res != null) {
            rMap.put("msg", "您今天已经答过题啦，明天再来吧！");
            rMap.put("status", 1);
            if (res.getCode() != null) {
                rMap.put("code", res.getCode());
            }
            return toJSONString(rMap);
        } else {
            Map<String, Object> paramMap = new HashMap<>();
            List<StxcContest> lists = stxcContestService.selectList(paramMap);
            lists.get(0).setRightKey(null);
            rMap.put("data", lists);
        }
        return ResData.SUCCESS(rMap).toString();
    }


    /**
     * 记录用户答题记录
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/insert", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String insert(StxcContestReconrd stxcContestReconrd, HttpServletRequest request, HttpServletResponse response) {
//
//        StxcContestReconrd resault = stxcContestReconrdService.selectByUid(stxcContestReconrd.getOpenid());
//        if(resault != null){
//            return null;
//        }
        Map<String, Object> rMap = new HashMap<>();

        String openid = stxcContestReconrd.getOpenid();
        StxcContestUser stxcContestUser = stxcContestUserService.selectByOpenid(openid);
        if (stxcContestUser == null) {
            rMap.put("msg", "系统出错！");
            rMap.put("status", 0);
            return toJSONString(rMap);
        } else {
            if (stxcContestUser.getIsLock().equals(1)) {
                rMap.put("msg", "系统出错！");
                rMap.put("status", 0);
                return toJSONString(rMap);
            }
        }
        SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat ymdHMs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date1 = new Date();
        Date date2 = null;
        try {
            date2 = ymdHMs.parse(ymd.format(new Date()) + " 09:00:00");
        } catch (ParseException e) {
            e.printStackTrace();
        }
        boolean after = date1.after(date2);

        //还没到知识竞赛时间
        if (!after) {
            rMap.put("msg", "系统出错！");
            rMap.put("status", 0);
            return toJSONString(rMap);
        }
        // 1.根据id获取题目正确答案
        StxcContest stxcContest = stxcContestService.selectByPrimaryKey(stxcContestReconrd.getItemId());
        String rightKey = stxcContest.getRightKey();

        StxcContestCode stxcContestCode = null;

        stxcContestReconrd.setUId(stxcContestReconrd.getOpenid());
        stxcContestReconrd.setRightKey(rightKey);
        stxcContestReconrd.setCreateTime(new Date());

        if (rightKey.equals(stxcContestReconrd.getUKey())) {
            //答题正确
            stxcContestReconrd.setResult(1);
            // 2.获取一条当天可用的兑奖码
            rMap.put("msg", "回答正确");
//            System.err.println("当前线程====================" + Thread.currentThread().getName());
            synchronized (AppStxcContestReconrdController.class) {
                stxcContestCode = stxcContestCodeService.selectOneTodayValidCode();

                if (stxcContestCode != null) {//有可用的兑奖码
                    stxcContestReconrd.setCode(stxcContestCode.getCode());
                    //奖兑奖码置为已使用
                    stxcContestCode.setStatus(1); // 1-已使用
                    stxcContestCodeService.updateByPrimaryKeySelective(stxcContestCode);
                    rMap.put("code", stxcContestCode.getCode());
                    rMap.put("status", 1);
                } else {
                    rMap.put("code", "今天红包被领光啦，明天再来吧！");
                    rMap.put("status", 2);
                }
            }
        } else {
            //答题错误
            stxcContestReconrd.setResult(0);
            rMap.put("msg", "回答错误,明天再来吧！");
            rMap.put("status", 0);
        }
        int res = stxcContestReconrdService.insertSelective(stxcContestReconrd);
        return toJSONString(rMap);
    }

}

