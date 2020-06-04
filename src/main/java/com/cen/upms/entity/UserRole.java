package com.cen.upms.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
 * 
 * @author cenguocheng  Email:137544496@qq.com 
 *	创建时间：2018年5月17日
 */
public class UserRole extends BaseEntity{

    private String userCode;

    private String roleCode;

    private Date createTime;

    private Date modifyTime;

    private Integer isDel;

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode == null ? null : userCode.trim();
    }

    public String getRoleCode() {
        return roleCode;
    }

    public void setRoleCode(String roleCode) {
        this.roleCode = roleCode == null ? null : roleCode.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public Integer getIsDel() {
        return isDel;
    }

    public void setIsDel(Integer isDel) {
        this.isDel = isDel;
    }
}