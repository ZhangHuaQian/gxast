package com.cen.appsite.service.impl;

import com.aliyuncs.exceptions.ClientException;
import com.cen.appsite.service.AppsiteService;
import com.cen.appsite.user.dto.PhoneCheckCode;
import com.cen.common.cache.EHCacheUtil;
import com.cen.common.util.PhoneMsg;
import com.cen.common.util.ReturnInfoType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by cenguocheng on 2018/9/23.
 * 137544496@qq.com
 */
@Service
@Transactional
public class AppsiteServiceImpl implements AppsiteService {
    protected Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public PhoneCheckCode sendPhoneCheckCode(PhoneCheckCode phoneCheckCode) {
        PhoneCheckCode pcc = new PhoneCheckCode();
        pcc.setStatus(ReturnInfoType.VALIDATECodeERROR);
        pcc.setReturnMsg("发送失败");

        // 1. 判断手机重复发送
        String cacheKey = phoneCheckCode.getPhone()+phoneCheckCode.getType();
        PhoneCheckCode pccCache = (PhoneCheckCode)EHCacheUtil.get(ReturnInfoType.cen_xczhapp_phone_code,cacheKey);
        if(pccCache!=null){
            long sendTime = (System.currentTimeMillis()-pccCache.getCreateDate().getTime())/1000; // 秒
            if(sendTime<60){
                pcc.setReturnMsg("频繁操作,请一分钟后再试");
                return pcc;
            }
        }

        // 2. 判断IP 恶意发送
        // ......

        /*pcc.setStatus(ReturnInfoType.SUCEEESS);
        pcc.setReturnMsg("发送成功");
        logger.debug(phoneCheckCode.getCheckCode());*/

        try {
            String result = PhoneMsg.sendMsg_SMS_182895025(phoneCheckCode.getPhone(),phoneCheckCode.getCheckCode());
            if(result.equals("OK")){
                pcc.setStatus(ReturnInfoType.SUCEEESS);
                pcc.setReturnMsg("发送成功");
            }
        } catch (ClientException e) {
            logger.error("短信发送异常:"+phoneCheckCode.getPhone());
            e.printStackTrace();
        }
        return pcc;
    }

    @Override
    public PhoneCheckCode sendPhoneCheckCodeUpdatePhone(PhoneCheckCode phoneCheckCode) {
        PhoneCheckCode pcc = new PhoneCheckCode();
        pcc.setStatus(ReturnInfoType.VALIDATECodeERROR);
        pcc.setReturnMsg("发送失败");

        // 1. 判断手机重复发送
        String cacheKey = phoneCheckCode.getPhone()+phoneCheckCode.getType();
        PhoneCheckCode pccCache = (PhoneCheckCode)EHCacheUtil.get(ReturnInfoType.update_phone_code,cacheKey);
        if(pccCache!=null){
            long sendTime = (System.currentTimeMillis()-pccCache.getCreateDate().getTime())/1000; // 秒
            if(sendTime<60){
                pcc.setReturnMsg("频繁操作,请一分钟后再试");
                return pcc;
            }
        }

        // 2. 判断IP 恶意发送
        // ......

        /*pcc.setStatus(ReturnInfoType.SUCEEESS);
        pcc.setReturnMsg("发送成功");
        logger.debug(phoneCheckCode.getCheckCode());*/

        try {
            String result = PhoneMsg.sendMsg_updatePhone_SMS_185845827(phoneCheckCode.getPhone(),phoneCheckCode.getCheckCode());
            if(result.equals("OK")){
                pcc.setStatus(ReturnInfoType.SUCEEESS);
                pcc.setReturnMsg("发送成功");
            }
        } catch (ClientException e) {
            logger.error("短信发送异常:"+phoneCheckCode.getPhone());
            e.printStackTrace();
        }
        return pcc;
    }
}
