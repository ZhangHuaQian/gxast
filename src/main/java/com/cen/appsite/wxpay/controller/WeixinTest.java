package com.cen.appsite.wxpay.controller;

import java.io.UnsupportedEncodingException;

public class WeixinTest {
	
	public static void main(String[] args) {
		String arr="http://www.zzw.777.com/oauth/oauth2AuthorizeController";
		String str=urlEncodeUTF8(arr);
		System.out.println(str);
	
	}
	
	/**
     * URL编码（utf-8）
     * 
     * @param source
     * @return
     */
    public static String urlEncodeUTF8(String source) {
        String result = source;
        try {
            result = java.net.URLEncoder.encode(source, "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return result;
    }

}
