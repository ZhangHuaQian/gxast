package com.cen.common.exception;

import com.alibaba.fastjson.JSON;
import com.cen.common.util.AjaxUtils;
import com.cen.common.util.ReturnInfoType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by cenguocheng on 2018/09/02.
 * 137544496@qq.com
 * 数据验证异常统一处理
 */
@ControllerAdvice
public class ValidateControllerAdvice {
    protected Logger logger = LoggerFactory.getLogger(getClass());

    /**
     *
     *bean校验未通过异常
     * @see javax.validation.Valid
     * @see org.springframework.validation.Validator
     * @see org.springframework.validation.DataBinder
     */
    @ExceptionHandler(BindException.class)
    public String validExceptionHandler(BindException e, WebRequest request, HttpServletResponse response) {

        List<FieldError> fieldErrors=e.getBindingResult().getFieldErrors();
        request.setAttribute("fieldErrors",fieldErrors,WebRequest.SCOPE_REQUEST);

        if(AjaxUtils.isAjaxRequest(request)){
            Map<String,Object> attrMap=new HashMap<String, Object>();
            attrMap.put("status", ReturnInfoType.param_error);
            String error_msg = "";
            for (FieldError error:fieldErrors){
                error_msg += "["+error.getField()+":"+error.getDefaultMessage()+"]";
                logger.debug(error.getField()+":"+error.getDefaultMessage());
            }
            attrMap.put("msg",error_msg);
            /*String[] atrrNames=request.getAttributeNames(WebRequest.SCOPE_REQUEST);
            for(String attr:atrrNames){
                Object value=request.getAttribute(attr,WebRequest.SCOPE_REQUEST);
                if(value instanceof Serializable){
                    attrMap.put(attr,value);
                }

            }*/
            AjaxUtils.writeJson(attrMap,response);
            return null;
        }
        return "/view/error/validError";
    }

}
