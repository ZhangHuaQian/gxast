package com.cen.appsite.GzbdContest.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cen.GzbdContest.entity.GzbdContest;
import com.cen.GzbdContest.service.GzbdContestService;
import com.cen.GzbdContestCode.entity.GzbdContestCode;
import com.cen.GzbdContestCode.service.GzbdContestCodeService;
import com.cen.GzbdContestFirewall.entity.GzbdContestFirewall;
import com.cen.GzbdContestFirewall.service.GzbdContestFirewallService;
import com.cen.GzbdContestRecord.entity.GzbdContestRecord;
import com.cen.GzbdContestRecord.service.GzbdContestRecordService;
import com.cen.GzbdContestResult.entity.GzbdContestResult;
import com.cen.GzbdContestResult.service.GzbdContestResultService;
import com.cen.GzbdContestUser.entity.GzbdContestUser;
import com.cen.GzbdContestUser.service.GzbdContestUserService;
import com.cen.KpzsContestUser.entity.KpzsContestUser;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ResData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/appsite/gzbdContest")
public class AppGzbdContestController extends BaseController {

    @Autowired
    GzbdContestUserService<GzbdContestUser> gzbdContestUserService;

    @Autowired
    GzbdContestRecordService<GzbdContestRecord> gzbdContestRecordService;

    @Autowired
    GzbdContestResultService<GzbdContestResult> gzbdContestResultService;

    @Autowired
    GzbdContestService<GzbdContest> gzbdContestService;

    @Autowired
    GzbdContestCodeService<GzbdContestCode> gzbdContestCodeService;

    @Autowired
    GzbdContestFirewallService<GzbdContestFirewall> gzbdContestFirewallService;


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
        GzbdContestUser gzbdContestUser = gzbdContestUserService.selectByOpenid(openid);
        if (gzbdContestUser == null) {
            rMap.put("msg", "系统出错！");
            rMap.put("status", 0);
            return toJSONString(rMap);
        } else {
            if (gzbdContestUser.getIsLock().equals(1)) {
                rMap.put("msg", "系统出错！");
                rMap.put("status", 0);
                return toJSONString(rMap);
            }
        }

//        SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
//        SimpleDateFormat ymdHMs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        Date date1 = new Date();
//        Date date2 = null;
//        try {
//            date2 = ymdHMs.parse(ymd.format(new Date()) + " 09:00:00");
//        } catch (ParseException e) {
//            e.printStackTrace();
//        }
//        boolean after = date1.after(date2);
//
//        //还没到知识竞赛时间
//        if (!after) {
//            rMap.put("msg", "知识竞赛9点才开始，晚点再来吧！");
//            rMap.put("status", 1);
//            return toJSONString(rMap);
//        }
        GzbdContestResult res = gzbdContestResultService.selectByUid(openid);
        if (res != null && res.getResult().equals(1) && res.getCode() != null) {  //答过题且已经答对并领了红包
            rMap.put("code", res.getCode());
            Map<String, Object> paramMap = new HashMap<>();
            List<GzbdContest> lists = gzbdContestService.selectList(paramMap);
//            for(int i=0; i<lists.size(); i++){
//                lists.get(i).setRightKey(null);
//            }
            rMap.put("data", lists);
        } else {
            Map<String, Object> paramMap = new HashMap<>();
            List<GzbdContest> lists = gzbdContestService.selectList(paramMap);
//            for(int i=0; i<lists.size(); i++){
//                lists.get(i).setRightKey(null);
//            }
            rMap.put("data", lists);
        }
        return ResData.SUCCESS(rMap).toString();
    }


    /**
     * 记录用户答题记录
     *

     * @return
     */
    @RequestMapping(value = "/insert", produces = "application/json;charset=utf-8",method = RequestMethod.POST)
    @ResponseBody
    public String insert(@RequestBody JSONObject jsonObject) {

        Map<String, Object> rMap = new HashMap<>();
        String openid = jsonObject.getString("openid");
        GzbdContestUser gzbdContestUser = gzbdContestUserService.selectByOpenid(openid);
        if (gzbdContestUser == null) {
            rMap.put("msg", "系统出错！");
            rMap.put("status", 0);
            return toJSONString(rMap);
        } else {
            if (gzbdContestUser.getIsLock().equals(1)) {
                rMap.put("msg", "系统出错！");
                rMap.put("status", 0);
                return toJSONString(rMap);
            }
        }

        //每调用一次，将用户id插入该表中，后面通过同个openid的插入表中的时间间隔判断是否是机器刷题
        GzbdContestFirewall gzbdContestFirewall = new GzbdContestFirewall();
        gzbdContestFirewall.setCreateTime(new Date());
        gzbdContestFirewall.setOpenid(openid);
        gzbdContestFirewallService.insertSelective(gzbdContestFirewall);

        SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat ymdHMs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date1 = new Date();
        Date date2 = null;
        try {
            date2 = ymdHMs.parse(ymd.format(new Date()) + " 12:00:00");
        } catch (ParseException e) {
            e.printStackTrace();
        }
        boolean after = date1.after(date2);

        //还没到知识竞赛时间
        if (!after) {
            rMap.put("msg", "活动9点才开始，晚点再来吧！");
            rMap.put("status", 1);
            return toJSONString(rMap);
        }

        //还没到知识竞赛时间
//        if (!after) {
//            rMap.put("msg", "系统出错！");
//            rMap.put("status", 0);
//            return toJSONString(rMap);
//        }

//        //防止用户多次调用接口答题,
//        GzbdContestResult res2 = gzbdContestResultService.selectByUid(openid);
//        if (res2 != null && res2.getResult().equals(1) && res2.getCode() != null) { //用户答过题且已经答对并领过红包
//
//            //恶意调用接口将用户拉黑
////            gzbdContestUserService.lockUser(openid,1);
//            rMap.put("msg", "系统出错！");
//            rMap.put("status", 0);
//            return toJSONString(rMap);
//        }

        JSONArray data = jsonObject.getJSONArray("data");

        boolean allKeyRight = true;

        for (int x=0; x<data.size(); x++){

            GzbdContestRecord gzbdContestRecord = new GzbdContestRecord();
            gzbdContestRecord.setUId(openid);
            gzbdContestRecord.setItemId(data.getJSONObject(x).getIntValue("itemId"));
            gzbdContestRecord.setUKey(data.getJSONObject(x).getString("uKey"));
            gzbdContestRecord.setCreateTime(new Date());

            // 1.根据id获取题目正确答案
            GzbdContest gzbdContest = gzbdContestService.selectByPrimaryKey(gzbdContestRecord.getItemId());
            String rightKey = gzbdContest.getRightKey();

            gzbdContestRecord.setRightKey(rightKey);
            if (rightKey.equals(gzbdContestRecord.getUKey())) {
                //答题正确
                gzbdContestRecord.setResult(1);
            }else{
                gzbdContestRecord.setResult(0);
                allKeyRight = false;
            }

            int res = gzbdContestRecordService.insertSelective(gzbdContestRecord);
        }

        GzbdContestCode gzbdContestCode = null;

        GzbdContestResult gzbdContestResult = new GzbdContestResult();
        gzbdContestResult.setUId(openid);
        gzbdContestResult.setCreateTime(new Date());

        //所有题目都回答正确
        if (allKeyRight) {
            rMap.put("msg", "全部回答正确");

            try {
                //线程休眠1.5s, 如果是机器刷题,确保在为其分配红包编码之前,尽量有2次以上的其openid 插入到表 gzbd_contest_firewall中
                //为以下同步代码块中执行第一次直接能判定为机器答题,不给分配红包并拉黑
                //机器答题两次时间差一般为0s或1s
                Thread.sleep(1500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            synchronized (AppGzbdContestController.class) {

                //判断是否是机器刷题
                List<GzbdContestFirewall> list = gzbdContestFirewallService.selectByOpenid(openid);
                System.err.println("list size ================================================================ "+list.size());
                if(list.size()>1){
                    long time = list.get(0).getCreateTime().getTime()-list.get(1).getCreateTime().getTime();
                    System.err.println("time========================================================="+time);
                    if(time< 3000){
                        //两次时间间隔小于3s判定为恶意调用接口，将用户拉黑，假设用户两次答题时间间隔应不小于3s
                        gzbdContestUserService.lockUser(openid,1);
                        rMap.put("msg", "系统出错！");
                        rMap.put("status", 0);
                        System.out.println("机器答题！！退出答题！");
                        return toJSONString(rMap);
                    }
                }
                String code = null;
                String result=null;
                List<GzbdContestResult> list1 = gzbdContestResultService.selectListByUid(openid);
                for (GzbdContestResult gzbdContestResult1 : list1) {
                    if (gzbdContestResult1.getCode()!=null&&gzbdContestResult1.getResult()==1){
                        code=gzbdContestResult1.getCode();
                        result="1";
             }
         }
                if (result != null&&result.equals("1") && code != null) {  //答过题且已经答对并领了红包
                    rMap.put("code", code);
                    rMap.put("status", 1);
                    rMap.put("msg","每人一天只允许领一次红包！");
                } else {
                    // 2.获取一条当天可用的兑奖码
                    gzbdContestCode = gzbdContestCodeService.selectOneTodayValidCode();

                    if (gzbdContestCode != null) {//有可用的兑奖码

                        //奖兑奖码存到用户答题结果中
                        gzbdContestResult.setCode(gzbdContestCode.getCode());

                        //奖兑奖码置为已使用
                        gzbdContestCode.setStatus(1); // 1-已使用
                        gzbdContestCodeService.updateByPrimaryKeySelective(gzbdContestCode);
                        rMap.put("code", gzbdContestCode.getCode());
                        rMap.put("status", 1);
                    } else {
                    rMap.put("code", "今日红包已领完");
                    rMap.put("status", 2);
                }
            }
                //全部答对
                gzbdContestResult.setResult(1);
                //插入一条用户答题结果记录
                gzbdContestResultService.insertSelective(gzbdContestResult);
            }

        } else {
            //答题错误
            rMap.put("msg", "答题有错误，再来一次吧！");
            rMap.put("status", 0);

            //部分答错
            gzbdContestResult.setResult(0);
            //插入一条用户答题结果记录
            gzbdContestResultService.insertSelective(gzbdContestResult);
        }
        return toJSONString(rMap);
    }

}