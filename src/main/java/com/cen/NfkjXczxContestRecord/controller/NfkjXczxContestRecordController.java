package com.cen.NfkjXczxContestRecord.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.*;
import com.cen.ucenter.entity.User;
import com.cen.NfkjXczxContestRecord.service.NfkjXczxContestRecordService;
import com.cen.NfkjXczxContestRecord.entity.NfkjXczxContestRecord;

@Controller
@RequestMapping("/sys/nfkjXczxContestRecord")
public class NfkjXczxContestRecordController extends BaseController {

    @Autowired
    NfkjXczxContestRecordService<NfkjXczxContestRecord> nfkjXczxContestRecordService;

    /**
    * 添加
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/insert",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String insert(NfkjXczxContestRecord nfkjXczxContestRecord,HttpServletRequest request,HttpServletResponse response){
        int res = nfkjXczxContestRecordService.insertSelective(nfkjXczxContestRecord);
        return res>=1?ResData.SUCCESS().toString():ResData.FAIL().toString();
    }

    /**
    * 删除
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/delete",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String delete(Integer id,HttpServletRequest request,HttpServletResponse response){
        int res = nfkjXczxContestRecordService.deleteByPrimaryKey(id);
        return res>=1?ResData.SUCCESS().toString():ResData.FAIL().toString();
    }

    /**
    * 更新
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/update",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String update(NfkjXczxContestRecord nfkjXczxContestRecord,HttpServletRequest request,HttpServletResponse response){
        int res = nfkjXczxContestRecordService.updateByPrimaryKeySelective(nfkjXczxContestRecord);
        return res>=1?ResData.SUCCESS().toString():ResData.FAIL().toString();
    }

    /**
    * 查询
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/select",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String select(Integer id,HttpServletRequest request,HttpServletResponse response){
        NfkjXczxContestRecord res = nfkjXczxContestRecordService.selectByPrimaryKey(id);
        return ResData.SUCCESS(res).toString();
    }

    /**
    * 分页查询列表
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/selectList",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectList(NfkjXczxContestRecord nfkjXczxContestRecord,Integer pageNum,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> paramMap = MapUtils.beanToMap(nfkjXczxContestRecord);
        // 此处查询需要自行编写
        PageHelper.startPage(getPageNum2(pageNum),pageSize);
        List<NfkjXczxContestRecord> lists = nfkjXczxContestRecordService.selectList(paramMap);
        PageInfo<NfkjXczxContestRecord>  p2 = new PageInfo<NfkjXczxContestRecord>(lists);
        rMap.put("pageNum", p2.getPageNum()); //  当前页
        rMap.put("pages", p2.getPages()); //  总页数
        rMap.put("nextPage", p2.getNextPage()); // 下一页
        rMap.put("prePage", p2.getPrePage()); // 上一页
        rMap.put("data", p2.getList()); // 数据集合
        rMap.put("count", p2.getTotal()); // 总行数
        PageHelper.clearPage(); // 如果开启分页，必须调用清除
        return ResData.SUCCESS(rMap).toString();
    }


}