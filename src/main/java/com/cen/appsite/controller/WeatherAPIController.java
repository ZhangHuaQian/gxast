package com.cen.appsite.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.cen.appsite.dto.*;
import com.cen.common.controller.BaseController;
import com.cen.common.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by cenguocheng on 2018/8/30.
 * 137544496@qq.com
 * 手机端天气预报、实况、预警接口中心
 */
@Controller
@RequestMapping("/appsite/weatherAPI")
public class WeatherAPIController extends BaseController {


    /**
     * 根据经纬度转地区 批量查询 (application/json 参数协议 [{"lon":123,"lat":456,"datetime":20180909230000}])
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/getParseLonLat", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getParseLonLat(@RequestBody WeatherApiDto[] wapi, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> umap = new HashMap<String, Object>();
        umap.put("msg", "ok");
        List result = new ArrayList();
        for (WeatherApiDto w : wapi) {
            Map map = AreaCodeUtil.getParseLonLat(w.getLon(),w.getLat());
            String admName = map.get("admName").toString().replaceAll(",","");
            map.put("admName",admName);
            result.add(map);
        }
        umap.put("status", ReturnInfoType.SUCEEESS);
        umap.put("data", result);
        return toJSONString(umap);
    }

}
