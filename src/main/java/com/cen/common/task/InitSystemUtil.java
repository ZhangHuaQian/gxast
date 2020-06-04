package com.cen.common.task;

import com.cen.common.cache.EHCacheUtil;
import com.cen.iproll.service.iprollService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PreDestroy;
import java.util.ArrayList;
import java.util.List;

/**
 * 作者: @author cenguocheng
 * 时间: 2017-08-16 10:14
 * 描述: 系统初始化数据
 */
@Component
public class InitSystemUtil implements InitializingBean {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    @Value("jdbc.driver")
    public String test;


    @Autowired
    iprollService iprollService;

    public static List<String> ipRollList = new ArrayList<String>(); // IP黑名单

    /**
     * 初始化 IP黑名单
     */
    private void initIpRollList() {

        System.out.println("test:"+test);

        /*List<IpRoll> ipRollListTemp = iprollService.selectList(new HashMap<String, Object>());
        for (IpRoll ipRoll : ipRollListTemp) {
            if(ipRoll.getStatus()==0)ipRollList.add(ipRoll.getIpaddress());
        }
        logger.info("IP黑名单初始化完成 记录数: "+ipRollList.size());*/
    }

    public void init() {
        initIpRollList();
    }


    public static void reload(){
        new InitSystemUtil().init();
    }

    public void afterPropertiesSet() throws Exception {
        init();
    }

    @PreDestroy
    public void dostory(){
        EHCacheUtil.getCacheManager().shutdown();
        System.out.println("服务关闭了");
    }

}