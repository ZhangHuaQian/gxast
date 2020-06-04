package com.cen.common.entity;

import java.io.Serializable;
import java.util.Map;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年4月24日 
* 
*/
public class BaseEntity implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	protected String id; // mybatis mysql uuid
	
	/**
	 * 自定义SQL（SQL标识，SQL内容）
	 */
	protected Map<String, String> sqlMap;

	/**
	 * 数据级校验参数
	 */
	protected String CFrameworkDataCheckToken;
	
	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


	public String getCFrameworkDataCheckToken() {
		return CFrameworkDataCheckToken;
	}

	public void setCFrameworkDataCheckToken(String CFrameworkDataCheckToken) {
		this.CFrameworkDataCheckToken = CFrameworkDataCheckToken;
	}

}
