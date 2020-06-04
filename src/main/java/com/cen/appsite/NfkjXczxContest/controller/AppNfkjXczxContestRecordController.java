package com.cen.appsite.NfkjXczxContest.controller;

import com.cen.NfkjXczxContest.entity.NfkjXczxContest;
import com.cen.NfkjXczxContest.service.NfkjXczxContestService;
import com.cen.NfkjXczxContestCode.entity.NfkjXczxContestCode;
import com.cen.NfkjXczxContestCode.service.NfkjXczxContestCodeService;
import com.cen.NfkjXczxContestRecord.entity.NfkjXczxContestRecord;
import com.cen.NfkjXczxContestRecord.service.NfkjXczxContestRecordService;
import com.cen.NfkjXczxContestUser.entity.NfkjXczxContestUser;
import com.cen.NfkjXczxContestUser.service.NfkjXczxContestUserService;
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

 */

@Controller
@RequestMapping("/appsite/nfkj/xczxContestRecord")
public class AppNfkjXczxContestRecordController extends BaseController {

    @Autowired
    NfkjXczxContestRecordService<NfkjXczxContestRecord> nfkjXczxContestRecordService;

    @Autowired
    NfkjXczxContestService<NfkjXczxContest> nfkjXczxContestService;

    @Autowired
    NfkjXczxContestCodeService<NfkjXczxContestCode> nfkjXczxContestCodeService;
    @Autowired
    NfkjXczxContestUserService<NfkjXczxContestUser> nfkjXczxContestUserService;


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
        NfkjXczxContestUser nfkjXczxContestUser = nfkjXczxContestUserService.selectByOpenid(openid);
        if (nfkjXczxContestUser == null) {
            rMap.put("msg", "系统出错！");
            rMap.put("status", 0);
            return toJSONString(rMap);
        } else {
            if (nfkjXczxContestUser.getIsLock().equals(1)) {
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
        NfkjXczxContestRecord res = nfkjXczxContestRecordService.selectByUid(openid);
        if (res != null) {
            rMap.put("msg", "您今天已经答过题啦，明天再来吧！");
            rMap.put("status", 1);
            if (res.getCode() != null) {
                rMap.put("code", res.getCode());
            }
            return toJSONString(rMap);
        } else {
            Map<String, Object> paramMap = new HashMap<>();
            List<NfkjXczxContest> lists = nfkjXczxContestService.selectList(paramMap);
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
    public String insert(NfkjXczxContestRecord nfkjXczxContestRecord, HttpServletRequest request, HttpServletResponse response) {
//
//        StxcContestReconrd resault = xczxContestRecordService.selectByUid(stxcContestReconrd.getOpenid());
//        if(resault != null){
//            return null;
//        }
        Map<String, Object> rMap = new HashMap<>();

        String openid = nfkjXczxContestRecord.getOpenid();
        NfkjXczxContestUser nfkjXczxContestUser = nfkjXczxContestUserService.selectByOpenid(openid);
        if (nfkjXczxContestUser == null) {
            rMap.put("msg", "系统出错！");
            rMap.put("status", 0);
            return toJSONString(rMap);
        } else {
            if (nfkjXczxContestUser.getIsLock().equals(1)) {
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
        NfkjXczxContest nfkjXczxContest = nfkjXczxContestService.selectByPrimaryKey(nfkjXczxContestRecord.getItemId());
        String rightKey = nfkjXczxContest.getRightKey();

        NfkjXczxContestCode nfkjXczxContestCode = null;

        nfkjXczxContestRecord.setUId(nfkjXczxContestRecord.getOpenid());
        nfkjXczxContestRecord.setRightKey(rightKey);
        nfkjXczxContestRecord.setCreateTime(new Date());

        if (rightKey.equals(nfkjXczxContestRecord.getUKey())) {
            //答题正确
            nfkjXczxContestRecord.setResult(1);
            // 2.获取一条当天可用的兑奖码
            rMap.put("msg", "回答正确");
//            System.err.println("当前线程====================" + Thread.currentThread().getName());
            synchronized (AppNfkjXczxContestRecordController.class) {
                nfkjXczxContestCode = nfkjXczxContestCodeService.selectOneTodayValidCode();

                if (nfkjXczxContestCode != null) {//有可用的兑奖码
                    nfkjXczxContestRecord.setCode(nfkjXczxContestCode.getCode());
                    //奖兑奖码置为已使用
                    nfkjXczxContestCode.setStatus(1); // 1-已使用
                    nfkjXczxContestCodeService.updateByPrimaryKeySelective(nfkjXczxContestCode);
                    rMap.put("code", nfkjXczxContestCode.getCode());
                    rMap.put("status", 1);
                } else {
                    rMap.put("code", "今天红包被领光啦，明天再来吧！");
                    rMap.put("status", 2);
                }
            }
        } else {
            //答题错误
            nfkjXczxContestRecord.setResult(0);
            rMap.put("msg", "回答错误,明天再来吧！");
            rMap.put("status", 0);
        }
        int res = nfkjXczxContestRecordService.insertSelective(nfkjXczxContestRecord);
        return toJSONString(rMap);
    }

}

