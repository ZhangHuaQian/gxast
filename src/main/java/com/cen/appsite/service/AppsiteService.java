package com.cen.appsite.service;

import com.cen.appsite.user.dto.PhoneCheckCode;

/**
 * Created by cenguocheng on 2018/8/1.
 * 137544496@qq.com
 */
public interface AppsiteService {

    /**
     * 手机验证码发送
     * @param phoneCheckCode
     * @return
     */
    PhoneCheckCode sendPhoneCheckCode(PhoneCheckCode phoneCheckCode);

    /**
     * 手机验证码发送--更新手机号
     * @param phoneCheckCode
     * @return
     */
    PhoneCheckCode sendPhoneCheckCodeUpdatePhone(PhoneCheckCode phoneCheckCode);

}
