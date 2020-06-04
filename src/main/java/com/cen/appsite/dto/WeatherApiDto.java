package com.cen.appsite.dto;

import com.cen.common.entity.BaseEntity;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.Map;

/**
 * Created by cenguocheng on 2018/9/9.
 * 137544496@qq.com
 */
public class WeatherApiDto extends BaseEntity{

    private String lon; //经度
    private String lat; //纬度
    private String datetime; // 日期时间

    public String getLon() {
        return lon;
    }

    public void setLon(String lon) {
        this.lon = lon;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

}
