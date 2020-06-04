package com.cen.operateLog.aspect;

import com.cen.common.util.HttpUtil;
import com.cen.common.util.RequestUtil;
import com.cen.operateLog.annotation.UserOperate;
import com.cen.operateLog.entity.Operatelog;
import com.cen.operateLog.service.OperatelogService;
import com.cen.ucenter.entity.User;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.util.UrlPathHelper;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.Map;

/**
 * @author cenguocheng
 *         2018-5-25
 */
@Aspect
@Component
public class LogAspect {  
      
    /*static User anonyUser = new User();
    static {  
        anonyUser.setId(-1);
        anonyUser.setLoginname("anonymous");
        anonyUser.setName("游客");
    }*/

    @Autowired
    private OperatelogService operatelogService;

    @Pointcut("@annotation(com.cen.operateLog.annotation.UserOperate)")
    public void controllerAspecta() {
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW) //日志切片事务
    @AfterReturning(value = "controllerAspecta() && @annotation(annotation) &&args(object,..) ", argNames = "annotation,object")
    public void interceptorApplogic(UserOperate annotation, Object object) {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        User user = (User)HttpUtil.getUserInSession(request);
        UrlPathHelper urlPathHelper = new UrlPathHelper();
        String urlPath = urlPathHelper.getLookupPathForRequest(request);
        Map<String, Object> requestParams = RequestUtil.getParameters(request);
        if(user==null){
            //user = anonyUser; // 游客操作
        }else{
            String desc = "desc:["+annotation.option()+"],url:["+urlPath+"],param:["+requestParams.toString()+"]";
            Operatelog operate = new Operatelog();
            operate.setCustid(user.getId().toString());
            operate.setCustname(user.getLoginname());
            operate.setRealname(user.getName());
            operate.setIpaddress(HttpUtil.getIpAddr(request));
            operate.setModulename(annotation.moduleName());
            operate.setOperatedesc(desc);
            operate.setCreatetime(new Date());
            operate.setIsDel(0);

            operatelogService.insertSelective(operate);// 记录入库
        }
    }

}  
