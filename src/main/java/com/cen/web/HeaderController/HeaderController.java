package com.cen.web.HeaderController;

import com.alibaba.fastjson.JSONObject;
import com.cen.MessageLog.entity.MessageLog;
import com.cen.common.controller.BaseController;
import com.cen.common.util.HttpUtil;
import com.cen.dictionary.entity.Dictionary;
import com.cen.dictionary.service.DictionaryService;
import com.cen.ucenter.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by cenguocheng on 2019/1/8.
 * 137544496@qq.com
 */
@Controller
@RequestMapping("/headercontrol")
public class HeaderController extends BaseController {

    @Autowired
    private DictionaryService dictionaryService;

    /**
     * PC 端网站首页
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value="headercontrol")
    @ResponseBody
    public String headercontrol(HttpServletRequest request,
                             HttpServletResponse response, ModelMap map) {

        String data = HttpUtil.sendGet("https://www.apiopen.top/weatherApi?city=", null);
        JSONObject jsonObject = JSONObject.parseObject(data);
        JSONObject jsonObject1 = JSONObject.parseObject(jsonObject.get("result").toString());
        JSONObject jsonObject0 = JSONObject.parseObject(jsonObject1.get("ad_info").toString());
        String admCode = jsonObject0.getString("adcode");
        String admName = jsonObject0.getString("name");
        String coo=jsonObject0.getString("adcode");


        return "/index";
    }






}
