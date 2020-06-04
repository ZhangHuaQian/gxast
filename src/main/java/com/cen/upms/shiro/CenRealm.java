package com.cen.upms.shiro;  
  
//import org.apache.commons.lang3.builder.ReflectionToStringBuilder;  
//import org.apache.commons.lang3.builder.ToStringStyle;  

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;  
import org.apache.shiro.authz.SimpleAuthorizationInfo;  
import org.apache.shiro.realm.AuthorizingRealm;  
import org.apache.shiro.session.Session;  
import org.apache.shiro.subject.PrincipalCollection;  
import org.apache.shiro.subject.Subject;  
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.cen.common.util.HttpUtil;
import com.cen.common.util.MD5Tools;
import com.cen.common.util.ReturnInfoType;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.cen.upms.entity.Menu;
import com.cen.upms.entity.Role;
import com.cen.upms.service.MenuService;
import com.cen.upms.service.RoleService;
  
/**
 *  自定义的指定Shiro验证用户登录的类 
 * @author cenguocheng
 *	2018-5-27
 */
//@Component("cenRealm")
public class CenRealm extends AuthorizingRealm {  
	
	@Autowired UserService userService;
	@Autowired MenuService menuService;
	@Autowired RoleService roleService;
	
    /** 
     * 为当前登录的Subject授予角色和权限 
     */  
    @Override  
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals){  
      //获取当前登录的用户名,等价于(String)principals.fromRealm(this.getName()).iterator().next()  
      //String currentUsername = (String)super.getAvailablePrincipal(principals);  
      List<String> roleList = new ArrayList<String>();  
      List<String> permissionList = new ArrayList<String>();  
      
      //从数据库中获取当前登录用户的详细信息  
      User user = (User)getSession(ReturnInfoType.USER_SESSION_NAME);
      if(null != user){  
    	  List<Role> roleLists = roleService.selectByUid(user.getId()); //获取角色
    	  for (Role role : roleLists) {
    		  //System.out.println("角色名称:"+role.getRoleName());
              if(role.getPower()!=null&&role.getPower().length()>0)roleList.add(role.getPower().trim());
    		  List<Menu> menuLists =  menuService.selectByRid(role.getId()); //获取菜单权限
    		  for (Menu menu : menuLists) {
    			  //System.out.println("菜单名称:"+menu.getMenuName());
    			if(menu.getPower()!=null&&menu.getPower().length()>0)permissionList.add(menu.getPower().trim());
			  }
    	  }
      }else{  
          throw new AuthorizationException();  
      }  
      //为当前用户设置角色和权限  
      SimpleAuthorizationInfo simpleAuthorInfo = new SimpleAuthorizationInfo();  
      simpleAuthorInfo.addRoles(roleList);  
      simpleAuthorInfo.addStringPermissions(permissionList);  
        
      if(simpleAuthorInfo!=null){
    	  return simpleAuthorInfo;
      }

        //若该方法什么都不做直接返回null的话,就会导致任何用户访问/admin/listUser.jsp时都会自动跳转到unauthorizedUrl指定的地址  
        //详见applicationContext.xml中的<bean id="shiroFilter">的配置  
        return null;  
    }  
  
      
    /** 
     * 验证当前登录的Subject 
     */  
    @Override  
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {  

    	UsernamePasswordToken token = (UsernamePasswordToken)authcToken;  //获取基于用户名和密码的令牌   
        //System.out.println("验证当前Subject时获取到token为" + ReflectionToStringBuilder.toString(token, ToStringStyle.MULTI_LINE_STYLE));  
        User user = userService.selectByLoginName(token.getUsername());
	    if(null != user){  
	        if(MD5Tools.verify(new String(token.getPassword()), user.getPassword())){

                // 判断账号是否锁定
                if (user.getLoginflag().equals("1")) {
                    throw new LockedAccountException();  // 抛出 账号锁定异常
                }

	        	AuthenticationInfo authcInfo = new SimpleAuthenticationInfo(user.getLoginname(), token.getPassword(), user.getName());
                List<Role> myroles = roleService.selectByUid(user.getId());
                List<Role> allRoles = roleService.selectAll();
                Map<String,Boolean> roleAuth = new HashMap<>();
                for(Role r:allRoles){
                    roleAuth.put(r.getPower(),myroles.contains(r));
                }
	    		this.setSession(ReturnInfoType.USER_SESSION_NAME, user);
                this.setSession(ReturnInfoType.USER_SESSION_ROLE, roleAuth);
	    		return authcInfo;
	    	}
	    }

		//没有返回登录用户名对应的SimpleAuthenticationInfo对象时,就会在LoginController中抛出UnknownAccountException异常  
		return null;  
    }  
      
      
    /** 
     * 将一些数据放到ShiroSession中,以便于其它地方使用 
     * @see  
     */  
    private void setSession(Object key, Object value){  
        Subject currentUser = SecurityUtils.getSubject();  
        if(null != currentUser){  
            Session session = currentUser.getSession();  
            //System.out.println("Session默认超时时间为[" + session.getTimeout() + "]毫秒");  
            if(null != session){  
                session.setAttribute(key, value);  
            }  
        }  
    } 
    
    
    /** 
     * 获得session
     * @see  
     */  
    private Object getSession(String key){  
        Subject currentUser = SecurityUtils.getSubject();  
        if(null != currentUser){  
            Session session = currentUser.getSession();  
            //System.out.println("Session默认超时时间为[" + session.getTimeout() + "]毫秒");  
            if(null != session){  
                return session.getAttribute(key);
            }  
        }
        return null;
    }  
    
    
  //只需要向父类注入缓存区域即可
    //认证缓存区域
   /* @Value("cen_realm_authentication_cache")
    //方法上注入按照参数注入，和方法名无关
    public void setSuperAuthenticationCacheName(String authenticationCacheName){
        super.setAuthenticationCacheName(authenticationCacheName);
    }
    //授权缓存区域
    @Value("cen_realm_authorization_cache")
    public void setSuperAuthorizationCacheName(String authorizationCacheName){
        super.setAuthorizationCacheName(authorizationCacheName);
    }*/
    
    
    
    //清除缓存
    public void clearCached() {
	    PrincipalCollection principals = SecurityUtils.getSubject().getPrincipals();
	    super.clearCache(principals);
    }
    
}