package com.cen.clientAPI.controller;

import com.cen.apkUpdate.entity.ApkUpdate;
import com.cen.apkUpdate.service.apkUpdateService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by cenguocheng on 2018/6/20.
 * 137544496@qq.com
 */
@Controller
@RequestMapping("/ClientApiCenter")
public class ClientApiCenterController extends BaseController {

    @Autowired
    private apkUpdateService apkUpdateService;

    /**
     * 客户端接口中心
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/index", method = RequestMethod.POST)
    @ResponseBody
    public String index(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> rMap = new HashMap<String,Object>();
        rMap.put("status","OK");
        return toJSONString(rMap);
    }


    /**
     * 获取最新(apk)文件的信息
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/getNewApk",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getApkInfo(HttpServletRequest request, HttpServletResponse response) {
        Map<String,Object> rMap =new HashMap<String, Object>();
        List<ApkUpdate> apkUpdates=apkUpdateService.selectAll();
        if(apkUpdates.size()==0){
            rMap.put("msg", "当前apk列表为空");
            rMap.put("status", ReturnInfoType.FAIL);
            return toJSONString(rMap);
        }else {
            ApkUpdate apkUpdate=apkUpdates.get(0);
            rMap.put("msg", "获取apk成功");
            rMap.put("status", ReturnInfoType.SUCEEESS);
            rMap.put("new_version", apkUpdate.getVersion());
            rMap.put("apk_file_url", system_base+system_base_apk+apkUpdate.getPath());
            rMap.put("update_log", apkUpdate.getDescription());
            rMap.put("qrcode", apkUpdate.getQrcode());
            return toJSONString(rMap);
        }
    }
    
    /**
     * 文件下载
     * @throws IOException 
     */
    @RequestMapping(value="/download",method=RequestMethod.GET)
    public void download( HttpServletRequest request,HttpServletResponse response) throws IOException {
    	
    	List<ApkUpdate> apkUpdates=apkUpdateService.selectAll();
    	if (apkUpdates.size()!=0) {
    		String filename = apkUpdates.get(0).getVersion();
    		//模拟文件，myfile.txt为需要下载的文件  
            String path = system_APK_RESOUREC+File.separator+apkUpdates.get(0).getPath();
            //获取输入流  
            InputStream bis = new BufferedInputStream(new FileInputStream(new File(path)));
            //转码，免得文件名中文乱码  
            filename = URLEncoder.encode("xczhapp-"+filename+".apk","UTF-8");  
            //设置文件下载头  
            response.addHeader("Content-Disposition", "attachment;filename=" + filename);    
            //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型    
            response.setContentType("multipart/form-data");   
            BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());  
            int len = 0;  
            while((len = bis.read()) != -1){  
                out.write(len);  
                out.flush();  
            }  
            out.close();  
		}
        
    }
    
}
