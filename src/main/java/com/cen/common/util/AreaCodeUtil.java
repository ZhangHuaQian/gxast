package com.cen.common.util;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by cenguocheng on 2018/10/8.
 * 137544496@qq.com
 * 行政区域
 */
public class AreaCodeUtil {

    /**
     * 根据经纬度获取行政区域代码  （区县级）
     * @param lon 经度
     * @param lat 纬度
     * @return
     */
    public static String getAreaCodeByLonLat(String lon,String lat){
        Map map = getParseLonLat(lon,lat);
        String admCode = map.get("admCode").toString();
        return admCode;
    }


    public static Map getParseLonLat(String lon,String lat){
        Map map = new HashMap();
        //参数解释: 纬度,经度 type 001 (100代表道路，010代表POI，001代表门址，111可以同时显示前三项)
        //http://gc.ditu.aliyun.com/regeocoding?l=22.82688,108.295067&type=111  // 经纬度转行政区域接口
        String admCode = "";
        String admName = "";
        Map<String, String> params = new HashMap<String, String>();
        params.put("l", lat + "," + lon);
        params.put("type", "111");
        String data = HttpUtil.sendGet("http://gc.ditu.aliyun.com/regeocoding", params);
        JSONObject jsonObject = JSONObject.parseObject(data);
        JSONArray jsonObject2 = JSONObject.parseArray(jsonObject.get("addrList").toString());
        for (int i = 0; i < jsonObject2.size(); i++) {
            JSONObject jo = jsonObject2.getJSONObject(i);
            admCode = jo.getString("admCode");
            admName = jo.getString("admName");
            if(admCode.length()>=6)break;
        }
        map.put("admCode",admCode);
        map.put("admName",admName);
        return map;
    }


}
