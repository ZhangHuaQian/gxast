package com.cen.common.util;

/**
 * Created by cenguocheng on 2018/7/19.
 * 137544496@qq.com
 * 操作系统类型工具类
 */
public class OSinfoUtil {

    private static String OS = System.getProperty("os.name").toLowerCase();

    public static boolean isLinux(){
        return OS.indexOf("linux")>=0;
    }

    public static boolean isWindows(){
        return OS.indexOf("windows")>=0;
    }

}
