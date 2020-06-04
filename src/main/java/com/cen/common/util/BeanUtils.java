package com.cen.common.util;

import org.springframework.beans.BeansException;
import org.springframework.beans.FatalBeanException;
import org.springframework.util.Assert;

import com.cen.common.exception.CException;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.*;

/**
 * BeanUtils
 * @author cenguocheng
 *	2018-6-1
 */
public class BeanUtils extends org.springframework.beans.BeanUtils {
    

    /**
     * bean 转为map
     *
     * @param obj         bean对象
     * @param isAllowNull 空字段是否转换 false 不转换
     * @return map值
     */
    public static Map<String, Object> bean2Map(Object obj, boolean isAllowNull) {
        if (obj == null) {
            return null;
        }
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName();
                // 过滤class属性
                if (!key.equals("class")) {
                    // 得到property对应的getter方法
                    Method getter = property.getReadMethod();
                    Object value = getter.invoke(obj);
                    if (isAllowNull || value != null && !value.toString().isEmpty()) {
                        map.put(key, value);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("transBean2Map Error " + e);
        }

        return map;
    }

    /**
     * map转bean
     *
     * @param targetMap 被转化的map
     * @param obj       对象
     */
    public static void map2Bean(Map<String, Object> targetMap, Object obj) {
        Map<String, Object> map = new HashMap<String, Object>();
        for (String key : targetMap.keySet()) {
            Object value = targetMap.get(key);
            map.put(StringUtils.lineToHump(key), value);
        }
        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();

            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName();

                if (map.containsKey(key)) {
                    try {
                        Object value = map.get(key);
                        // 得到property对应的setter方法
                        Method setter = property.getWriteMethod();
                        setter.invoke(obj, value);
                    } catch (Exception e) {
                        throw new CException("实体转换错误:" + key);
                    }
                }

            }
        } catch (Exception e) {
            e.getStackTrace();
            throw new CException("数据转换异常！");
        }
    }
}
