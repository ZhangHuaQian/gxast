package com.cen.common.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

public class FileUtil implements FileUtilImpl{
    public Map<String, Object> fileUpLoad(MultipartFile file, String basePath) {

        String mkdirs_data = DateUtil.getThisSysTimeYMD_FILE();

        // 判断路径是否存在/创建
        File baseFath_f = new File(basePath+mkdirs_data);
        if (!baseFath_f.exists()) {
            baseFath_f.mkdirs();
        }

        Long start = System.currentTimeMillis();
        BufferedInputStream bufferedInputStream = null;
        BufferedOutputStream bufferedOutputStream = null;
        String trueFileName = "";
        String fileName=file.getOriginalFilename();// 文件原名称
        trueFileName=mkdirs_data+String.valueOf(System.currentTimeMillis())+fileName;
        Map<String,Object> map = new HashMap<String, Object>();
        try{
            //FileInputStream fileInputStream = new FileInputStream(file.getInputStream());
            bufferedInputStream = new BufferedInputStream(file.getInputStream());
            FileOutputStream fileOutputStream = new FileOutputStream(new File(basePath+"/"+trueFileName));
            bufferedOutputStream = new BufferedOutputStream(fileOutputStream);
            int size = 0;
            byte[] buffer = new byte[10240];  
            while((size=bufferedInputStream.read(buffer))!=-1){
                bufferedOutputStream.write(buffer, 0, size);
            }
            bufferedOutputStream.flush();
            bufferedOutputStream.close();
            bufferedInputStream.close();
            Long end = System.currentTimeMillis();
            System.out.println("上传完成,耗时"+(end-start)+"毫秒");
            System.out.println(trueFileName);
            map.put("trueFileName",trueFileName);
        }catch (FileNotFoundException e){
            e.printStackTrace();
            System.out.println("文件不存在");
        }catch (IOException e){
            e.getStackTrace();
            System.out.println("流对象异常");
        }finally {
            //刷新此缓冲的输出流，保证数据全部都能写出
            try{
                if(bufferedOutputStream!=null){
                    bufferedOutputStream.close();
                }
                if(bufferedInputStream!=null){
                    bufferedInputStream.close();
                }
            }catch (IOException e){
                e.getStackTrace();
                System.out.println("流对象关闭异常");
            }
        }
        return map;
    }

    public File fileDownLoad(String sources, String basePath) {
        return null;
    }

}
