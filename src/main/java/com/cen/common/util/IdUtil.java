package com.cen.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;


/**
 * 名称：IdUtil <br>
 * 描述：ID 生成工具类<br>
 * @author cenguocheng
 *	2018-6-1
 */
public class IdUtil {

    /**
     * 随机数 位数自定
     * @param num
     * @return
     */
    public static String RandomNumber(Integer num){
        int a[] = new int[num];
        String ram ="";
        for(int i=0;i<a.length;i++ ) {
            a[i] = (int)(10*(Math.random()));
            System.out.print(a[i]);
            ram += a[i];
        }
        return ram;
    }

    /**
     * 主要功能:生成流水号 yyyyMMddHHmmssSSS + 3位随机数
     * 注意事项:无
     *
     * @return 流水号
     */
    public static String createIdByDate() {
        // 精确到毫秒
        SimpleDateFormat fmt = new SimpleDateFormat("(yyyyMMddHHmmssSSS)");
        String suffix = fmt.format(new Date());
        suffix = suffix + "-" + Math.round((Math.random() * 100000));
        return suffix;
    }
    /**
     * 主要功能:生成流水号 yyyyMMddHHmmssSSS + 3位随机数
     * 注意事项:无
     *
     * @return 流水号
     */
    public static String createIdByDate2() {
        // 精确到毫秒
        SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String suffix = fmt.format(new Date());
        suffix = suffix + "" + Math.round((Math.random() * 100000));
        return suffix;
    }
    /**
     * 主要功能:生成uuid
     * 注意事项:无
     *
     * @return uuid 32 位
     */
    public static String createIdbyUUID() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
