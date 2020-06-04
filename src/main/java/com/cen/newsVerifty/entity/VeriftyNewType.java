package com.cen.newsVerifty.entity;

import com.cen.news.entity.News;

public enum VeriftyNewType {
    ZZGK("zzgk","news_zzgk","政务公开","2"),
    AXHD("axhd","news_axhd","党建工作","1"),
    NEWS("news","news","新闻中心","0");

    public String type;//类型名称

    public String allTypeName;//类型全称

    public String typename;//类型中文名称

    public String typeStatus;//类型标志

    VeriftyNewType(String type,String allTypeName,String typename,String typeStatus){
        this.type = type;
        this.allTypeName = allTypeName;
        this.typename = typename;
        this.typeStatus = typeStatus;
    }
}
