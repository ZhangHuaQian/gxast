package com.cen.common.util;

import java.security.MessageDigest;
import java.util.Random;

import org.apache.shiro.codec.Hex;

/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年4月25日 
* 
*/
public class MD5Tools {

	
	/**
	 * 普通 MD5加码 生成32位md5码 
	 * @param inStr 
	 * @return
	 */
    public static String stringToMD5(String inStr){  
        MessageDigest md5 = null;  
        try{  
            md5 = MessageDigest.getInstance("MD5");  
        }catch (Exception e){  
            System.out.println(e.toString());  
            e.printStackTrace();  
            return "";  
        }  
        char[] charArray = inStr.toCharArray();  
        byte[] byteArray = new byte[charArray.length];  
  
        for (int i = 0; i < charArray.length; i++)  
            byteArray[i] = (byte) charArray[i];  
        byte[] md5Bytes = md5.digest(byteArray);  
        StringBuffer hexValue = new StringBuffer();  
        for (int i = 0; i < md5Bytes.length; i++){  
            int val = ((int) md5Bytes[i]) & 0xff;  
            if (val < 16)  
                hexValue.append("0");  
            hexValue.append(Integer.toHexString(val));  
        }  
        return hexValue.toString();
        
    }  
    
    
    /**  
     * 加盐MD5  
     * @time 2016-6-11 下午8:45:04  
     * @param password  
     * @return  
     */  
        public static String generate(String password) {  
            Random r = new Random();  
            StringBuilder sb = new StringBuilder(16);  
            sb.append(r.nextInt(99999999)).append(r.nextInt(99999999));  
            int len = sb.length();  
            if (len < 16) {
                for (int i = 0; i < 16 - len; i++) {
                    sb.append("0");
                }
            }
            String salt = sb.toString(); 
            password = md5Hex(password + salt); 
            char[] cs = new char[48];  
            for (int i = 0; i < 48; i += 3) {  
                cs[i] = password.charAt(i / 3 * 2);  
                char c = salt.charAt(i / 3);  
                cs[i + 1] = c;  
                cs[i + 2] = password.charAt(i / 3 * 2 + 1);  
            }  
            return new String(cs);  
        }  
  
        /**  
         * 校验加盐后是否和原文一致  
         * @param password  
         * @param md5  
         * @return  
         */  
        public static boolean verify(String password, String md5) {  
            char[] cs1 = new char[32];  
            char[] cs2 = new char[16];  
            for (int i = 0; i < 48; i += 3) {  
                cs1[i / 3 * 2] = md5.charAt(i);  
                cs1[i / 3 * 2 + 1] = md5.charAt(i + 2);  
                cs2[i / 3] = md5.charAt(i + 1);  
            }  
            String salt = new String(cs2);  
            //System.out.println("解密MD5---"+new String(cs1));
            //System.out.println("解盐 salt:"+salt);
            return md5Hex(password + salt).equals(new String(cs1));  
        }  
  
        /**  
         * 获取十六进制字符串形式的MD5摘要  
         */  
        private static String md5Hex(String src) {  
           try {  
                MessageDigest md5 = MessageDigest.getInstance("MD5");  
                byte[] bs = md5.digest(src.getBytes());  
                //return new String(new Hex().encode(bs));  
                return new String(Hex.encode(bs)); 
            } catch (Exception e) {  
                return null;  
            } 
        }  
    
    
  
    // 测试主函数  
    public static void main(String args[]) {  
        String s = new String("guocheng");  
        System.out.println("原始：" + s);  
       // System.out.println("普通MD5后：" + stringToMD5(s));  
        
        String md5Salt =  generate(s);
        System.out.println("加盐MD5：" + md5Salt);  
        System.out.println("校验加盐后是否和原文一致  ：" + verify(s,md5Salt));  
        
    }


    private static String byteArrayToHexString(byte b[]) {
        StringBuffer resultSb = new StringBuffer();
        for (int i = 0; i < b.length; i++)
            resultSb.append(byteToHexString(b[i]));

        return resultSb.toString();
    }

    private static String byteToHexString(byte b) {
        int n = b;
        if (n < 0)
            n += 256;
        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigits[d1] + hexDigits[d2];
    }

    public static String MD5Encode(String origin, String charsetname) {
        String resultString = null;
        try {
            resultString = new String(origin);
            MessageDigest md = MessageDigest.getInstance("MD5");
            if (charsetname == null || "".equals(charsetname))
                resultString = byteArrayToHexString(md.digest(resultString
                        .getBytes()));
            else
                resultString = byteArrayToHexString(md.digest(resultString
                        .getBytes(charsetname)));
        } catch (Exception exception) {
        }
        return resultString;
    }

    private static final String hexDigits[] = { "0", "1", "2", "3", "4", "5",
            "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };



}