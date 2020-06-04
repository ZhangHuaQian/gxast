package com.cen.material;

/**
 * Created by Administrator on 2019/7/12.
 */
public class MeterialImage {
    //要获取的素材的media_id
    private String media_id;
    //文件名称
    private String name;
    //图片的URL
    private String url;

    public String getMedia_id() {
        return media_id;
    }

    public void setMedia_id(String media_id) {
        this.media_id = media_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

}
