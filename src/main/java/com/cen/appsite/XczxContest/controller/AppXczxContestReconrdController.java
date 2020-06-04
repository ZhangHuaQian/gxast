package com.cen.appsite.XczxContest.controller;

import com.cen.XczxContest.entity.XczxContest;
import com.cen.XczxContest.service.XczxContestService;
import com.cen.XczxContestCode.entity.XczxContestCode;
import com.cen.XczxContestCode.service.XczxContestCodeService;
import com.cen.XczxContestRecord.entity.XczxContestRecord;
import com.cen.XczxContestRecord.service.XczxContestRecordService;
import com.cen.XczxContestUser.entity.XczxContestUser;
import com.cen.XczxContestUser.service.XczxContestUserService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ResData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
 * 2019年大众科普“倡导绿色环保生活”
 * 科普知识挑战赛
 */

@Controller
@RequestMapping("/appsite/xczxContestRecord")
public class AppXczxContestReconrdController extends BaseController {

    @Autowired
    XczxContestRecordService<XczxContestRecord> xczxContestRecordService;

    @Autowired
    XczxContestService<XczxContest> xczxContestService;

    @Autowired
    XczxContestCodeService<XczxContestCode> xczxContestCodeService;
    @Autowired
    XczxContestUserService<XczxContestUser> xczxContestUserService;


    /**
     * 查询用户当天是否答过题
     *
     * @param response
     * @return
     */
    @RequestMapping(value = "/selectByUid", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String select(String openid, HttpServletRequest request, HttpServletResponse response) {

        Map<String, Object> rMap = new HashMap<>();
        XczxContestUser xczxContestUser = xczxContestUserService.selectByOpenid(openid);
        if (xczxContestUser == null) {
            rMap.put("msg", "系统出错！");
            rMap.put("status", 0);
            return toJSONString(rMap);
        } else {
            if (xczxContestUser.getIsLock().equals(1)) {
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
        XczxContestRecord res = xczxContestRecordService.selectByUid(openid);
        if (res != null) {
            rMap.put("msg", "您今天已经答过题啦，明天再来吧！");
            rMap.put("status", 1);
            if (res.getCode() != null) {
                rMap.put("code", res.getCode());
            }
            return toJSONString(rMap);
        } else {
            Map<String, Object> paramMap = new HashMap<>();
            List<XczxContest> lists = xczxContestService.selectList(paramMap);
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
    public String insert(XczxContestRecord xczxContestRecord, HttpServletRequest request, HttpServletResponse response) {
//
//        StxcContestReconrd resault = xczxContestRecordService.selectByUid(stxcContestReconrd.getOpenid());
//        if(resault != null){
//            return null;
//        }
        Map<String, Object> rMap = new HashMap<>();

        String openid = xczxContestRecord.getOpenid();
        XczxContestUser xczxContestUser = xczxContestUserService.selectByOpenid(openid);
        if (xczxContestUser == null) {
            rMap.put("msg", "系统出错！");
            rMap.put("status", 0);
            return toJSONString(rMap);
        } else {
            if (xczxContestUser.getIsLock().equals(1)) {
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
        XczxContest xczxContest = xczxContestService.selectByPrimaryKey(xczxContestRecord.getItemId());
        String rightKey = xczxContest.getRightKey();

        XczxContestCode xczxContestCode = null;

        xczxContestRecord.setUId(xczxContestRecord.getOpenid());
        xczxContestRecord.setRightKey(rightKey);
        xczxContestRecord.setCreateTime(new Date());

        if (rightKey.equals(xczxContestRecord.getUKey())) {
            //答题正确
            xczxContestRecord.setResult(1);
            // 2.获取一条当天可用的兑奖码
            rMap.put("msg", "回答正确");
//            System.err.println("当前线程====================" + Thread.currentThread().getName());
            synchronized (AppXczxContestReconrdController.class) {
                xczxContestCode = xczxContestCodeService.selectOneTodayValidCode();

                if (xczxContestCode != null) {//有可用的兑奖码
                    xczxContestRecord.setCode(xczxContestCode.getCode());
                    //奖兑奖码置为已使用
                    xczxContestCode.setStatus(1); // 1-已使用
                    xczxContestCodeService.updateByPrimaryKeySelective(xczxContestCode);
                    rMap.put("code", xczxContestCode.getCode());
                    rMap.put("status", 1);
                } else {
                    rMap.put("code", "今天红包被领光啦，明天再来吧！");
                    rMap.put("status", 2);
                }
            }
        } else {
            //答题错误
            xczxContestRecord.setResult(0);
            rMap.put("msg", "回答错误,明天再来吧！");
            rMap.put("status", 0);
        }
        int res = xczxContestRecordService.insertSelective(xczxContestRecord);
        return toJSONString(rMap);
    }

}

