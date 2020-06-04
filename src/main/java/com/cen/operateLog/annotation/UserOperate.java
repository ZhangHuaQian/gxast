package com.cen.operateLog.annotation;

import java.lang.annotation.*;

/**
 * 
 * @author cenguocheng
 *	2018-5-25
 */
@Retention(RetentionPolicy.RUNTIME)    
@Target({ElementType.METHOD})  
@Documented  
public @interface UserOperate {  
  
    //模块名    
    String moduleName() default "";    
    //操作内容    
    String option() default "";    
}  