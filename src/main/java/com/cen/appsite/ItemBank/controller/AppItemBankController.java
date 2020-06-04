package com.cen.appsite.ItemBank.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ResData;
import com.cen.sys.ItemAnswer.entity.ItemAnswer;
import com.cen.sys.ItemAnswer.service.ItemAnswerService;
import com.cen.sys.ItemBank.entity.ItemBank;
import com.cen.sys.ItemBank.service.ItemBankService;
import com.cen.sys.ItemUser.entity.ItemUser;
import com.cen.sys.ItemUser.service.ItemUserService;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.InvocationTargetException;
import java.util.*;

@Controller
@RequestMapping("/appsite/itemBank")
@Transactional
public class AppItemBankController extends BaseController {

    @Autowired
    ItemBankService<ItemBank> itemBankService;

    @Autowired
    private ItemUserService<ItemUser> itemUserService;
    @Autowired
    private ItemAnswerService<ItemAnswer> itemAnswerService;


    /**
     * 查询用户是否已经答过题
     *
     * @return
     */
    @RequestMapping(value = "/selectUserInfo", produces = "application/json;charset=utf-8", method = RequestMethod.POST)
    @ResponseBody
    public String selectUserInfo(ItemUser itemUser) {
        Map<String, Object> param = new HashMap<>();
        Map<String, Object> rMap = new HashMap<>();
        param.put("s_name", itemUser.getSName().trim());
        param.put("t_name", itemUser.getTName().trim());
        param.put("t_tel", itemUser.getTTel());
        ItemUser itemUser2 = itemUserService.selectByUnameAndTnameAndTtel(param);

        if (itemUser2 == null) {   //用户不存在
            itemUser.setCreateTime(new Date());
            itemUserService.insertSelective(itemUser);
            rMap.put("msg", "可开始答题");
            rMap.put("status", 0);
            rMap.put("uId",itemUser.getId());
        } else {
//            List<ItemAnswer> list = itemAnswerService.selectByUid(itemUser.getId());
//            if (list.size() == 0) {
                rMap.put("msg", "您已参与过答题，感谢您的参与！");
                rMap.put("status", 1);
                rMap.put("uId",itemUser.getId());
//            }
        }
        return toJSONString(rMap);
    }

    /**
     * 获取所有题目
     *
     * @return
     */
    @RequestMapping(value = "/selectAll", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectAll() {
        Map<String, Object> param = new HashedMap();
        Map<String, Object> rMap = new HashMap<>();
        param.put("limit", 50);
        List<ItemBank> list = itemBankService.selectAll(param);
        rMap.put("msg", "成功");
        rMap.put("status", 1);
        rMap.put("data", list);
        return ResData.SUCCESS(rMap).toString();
    }

    /**
     *  提交答题结果
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/submit" ,produces = "application/json;charset=utf-8", method = RequestMethod.POST)
    @ResponseBody
    public String submitItemBank(String data, HttpServletRequest request, HttpServletResponse response) throws InvocationTargetException, IllegalAccessException {

        Map<String, Object> rMap = new HashMap<>();
        JSONObject jsonAnswer = JSON.parseObject(data);
        Integer uid = (Integer)jsonAnswer.get("uid");

        List<ItemAnswer> itemAnswers = itemAnswerService.selectByUid(uid);
        if(itemAnswers.size() > 0){ //
            rMap.put("msg","已提交过答题结果");
            rMap.put("status",0);
            return toJSONString(rMap);
        }
        int count = 0; //答对题数
        ItemUser user = itemUserService.selectByPrimaryKey(uid);
        String answer = jsonAnswer.get("answer").toString();

        List<ItemAnswer> itemAnswersList = new ArrayList<>();
        JSONArray jsonOptionList = JSONArray.parseArray(answer); // 首先把字符串转成 JSONArray  对象

        for(int i=0; i<jsonOptionList.size();i++){
            Map<String, Object> vMap = (Map<String, Object>)jsonOptionList.get(i);
            ItemAnswer itemAnswer  = new ItemAnswer();
            Integer ItemId = Integer.valueOf(vMap.get("qid").toString());
            ItemBank itemBank = itemBankService.selectByPrimaryKey(ItemId);
            String option = itemBank.getOptions();
            JSONArray jsonOption = JSONArray.parseArray(option); // 首先把字符串转成 JSONArray  对象


            String uOptionIndex = vMap.get("option").toString().substring(2);
            for (int x=0; x<jsonOption.size(); x++){
                 //查看题目正确选项
                if(x+1 == Integer.valueOf(itemBank.getRightKeyId())){ //加1是因为option下标从1开始
                    Map<String, Object> opMap = (Map<String, Object>)jsonOption.get(x);
                    String rValue = (String)opMap.get("op"+(x+1));
                    itemAnswer.setROption(rValue);
                }
                if(Integer.valueOf(uOptionIndex) == x+1){
                    Map<String, Object> opMap = (Map<String, Object>)jsonOption.get(x);
                    String uOption = (String)opMap.get("op"+(x+1));
                    itemAnswer.setUOption(uOption);
                }
            }
            itemAnswer.setUId(uid);
            itemAnswer.setUName(user.getSName());
            itemAnswer.setItemBankId(ItemId);
            if (uOptionIndex.equals(itemBank.getRightKeyId())){
                count ++;
                itemAnswer.setResult(1);
            }else{
                itemAnswer.setResult(0);
            }
            itemAnswer.setEndTime(new Date());
            itemAnswersList.add(itemAnswer);
        }
        //插入答题结果记录表
        if (itemAnswersList.size()>0){
            int res = itemAnswerService.insertList(itemAnswersList);
            user.setScore(count * 2);
            itemUserService.updateByPrimaryKeySelective(user);
            if(res >=1){
                rMap.put("msg","提交成功");
                rMap.put("status",1);
            }else{
                rMap.put("msg","提交失败");
                rMap.put("status",0);
            }
        }
        return toJSONString(rMap);
    }

}