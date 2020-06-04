package com.cen.appsite.wechat.util;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

public class HttpRequestUtil {


    public static String getRequest(String url, Map<String,String> params){
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append(url+"?");
        for (Map.Entry<String,String> arg:params.entrySet()){
            stringBuffer.append(arg.getKey()+"="+arg.getValue()+"&");
        }

        stringBuffer.deleteCharAt(stringBuffer.length() - 1);
        //System.out.println(stringBuffer);
        //System.out.println(httpsRequest(stringBuffer.toString(), "GET", null));
        return httpsRequest(stringBuffer.toString(), "GET", null);
    }
    //请求地址，请求参数，请求方式，请求协议，携带参数
    public static String getInfoByNet(String url, Map<String,String> params,String requestMethod,String requestProtocol,String outputStr){
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append(url+"?");
        String result="";
        for (Map.Entry<String,String> arg:params.entrySet()){
            stringBuffer.append(arg.getKey()+"="+arg.getValue()+"&");
        }

        stringBuffer.deleteCharAt(stringBuffer.length() - 1);
        //System.out.println(stringBuffer);
        if(requestProtocol.equals("https")){
            result = httpsRequest(stringBuffer.toString(), requestMethod, outputStr);
            //System.out.println(result);
            return result;
        }else {
            result = httpRequest(stringBuffer.toString(), requestMethod, outputStr);
            //System.out.println(result);
            return result;
        }

    }

    //处理http请求  requestUrl为请求地址  requestMethod请求方式，值为"GET"或"POST"
    public static String httpRequest(String requestUrl,String requestMethod,String outputStr){
        StringBuffer buffer=null;
        try{
            URL url=new URL(requestUrl);
            HttpURLConnection conn=(HttpURLConnection)url.openConnection();
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setRequestMethod(requestMethod);
            conn.connect();
            //往服务器端写内容 也就是发起http请求需要带的参数
            if(null!=outputStr){
                OutputStream os=conn.getOutputStream();
                os.write(outputStr.getBytes("utf-8"));
                os.close();
            }

            //读取服务器端返回的内容
            InputStream is=conn.getInputStream();
            InputStreamReader isr=new InputStreamReader(is,"utf-8");
            BufferedReader br=new BufferedReader(isr);
            buffer=new StringBuffer();
            String line=null;
            while((line=br.readLine())!=null){
                buffer.append(line);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return buffer.toString();
    }
    /*
     * 处理https GET/POST请求
     * 请求地址、请求方法、参数
     * */
    public static String httpsRequest(String requestUrl,String requestMethod,String outputStr){
        StringBuffer buffer=null;
        try{
            //创建SSLContext
            SSLContext sslContext=SSLContext.getInstance("SSL");
            TrustManager[] tm={new MyX509TrustManager()};
            //初始化
            sslContext.init(null, tm, new java.security.SecureRandom());;
            //获取SSLSocketFactory对象
            SSLSocketFactory ssf=sslContext.getSocketFactory();
            URL url=new URL(requestUrl);
            HttpsURLConnection conn=(HttpsURLConnection)url.openConnection();
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod(requestMethod);
            //设置当前实例使用的SSLSoctetFactory
            conn.setSSLSocketFactory(ssf);
            conn.connect();
            //往服务器端写内容
            if(null!=outputStr){
                OutputStream os=conn.getOutputStream();
                os.write(outputStr.getBytes("utf-8"));
                os.close();
            }

            //读取服务器端返回的内容
            InputStream is=conn.getInputStream();
            InputStreamReader isr=new InputStreamReader(is,"utf-8");
            BufferedReader br=new BufferedReader(isr);
            buffer=new StringBuffer();
            String line=null;
            while((line=br.readLine())!=null){
                buffer.append(line);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return buffer.toString();
    }
}
