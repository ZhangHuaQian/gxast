package com.cen.appsite.wechat.util;
//消息类型工具类
/**
 * 微信消息类型
 */
public enum MsgTypeEnum {
    TEXT("text"),           //文本消息
    IMAGE("image"),         //图片消息
    VOICE("voice"),         //语音消息
    VIDEO("video"),         //视频消息
    MUSIC("music"),         //音乐消息
    NEWS("news"),           //图文消息（点击跳转到外链）
    MPNEWS("mpnews"),       //图文消息（点击跳转到图文消息页面）
    WXCARD("wxcard"),;      //卡券

    private String name;

    private MsgTypeEnum(String name){
        this.name = name;
    }

    public String toCode() {
        return Integer.toString(this.ordinal());
    }

    public String toName() {
        return this.name;
    }

    public static MsgTypeEnum fromCode(String code) {
        try {
            return values()[Integer.parseInt(code)];
        } catch (Exception e) {
            return null;
        }
    }
}
