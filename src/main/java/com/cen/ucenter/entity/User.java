package com.cen.ucenter.entity;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.cen.common.entity.BaseEntity;
import com.cen.upms.entity.Role;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;

/**
 * 
 * @author cenguocheng
 *	2018-5-3
 */
@Validated
public class User extends BaseEntity {
	
	private String loginname;
	
	@JSONField(serialize=false)
	private String password;

	@NotNull(message = "名称不能为空")
	private String name;

	private String sex;

	private String phonenum;

	private String photo;

	private String email;

	private String usertype;
	
	private Date createdate;

	private String oldloginip;
	
	private Date oldlogindate;

	private String loginflag;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")// 解决提交日期类型页面报错400问题
	private Date birthdate;

	private String idtype;

	private String idnumber;

	private String identityimg;

	private String nationality;

	private String nation;

	private String politicalstatus;

	private String graduateinstitutions;

	private String professional;

	private String education;

	private String qualification;

	private String bloodtype;

	private String nativeplace;

	private String contactaddress;

	private Integer postalnumber;

	private String fixedtelephone;

	private String othercontact;

	private String worktitle;

	private String workpost;

	private String workname;

	private String workindustry;

	private String worknature;

	private Integer isDel;

	private String did;
	
	private Date modifyTime;

	private String forumGradeIcon; //论坛等级图标

	private Integer isVip; //是否是手机vip用户

	private String vipUserIcon;//

	public String getVipUserIcon() {
		return vipUserIcon;
	}

	public void setVipUserIcon(String vipUserIcon) {
		this.vipUserIcon = vipUserIcon;
	}

	public Integer getIsVip() {
		return isVip;
	}

	public void setIsVip(Integer isVip) {
		this.isVip = isVip;
	}

	public String getForumGradeIcon() {
		return forumGradeIcon;
	}

	public void setForumGradeIcon(String forumGradeIcon) {
		this.forumGradeIcon = forumGradeIcon;
	}

	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname == null ? null : loginname.trim();
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password == null ? null : password.trim();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex == null ? null : sex.trim();
	}

	public String getPhonenum() {
		return phonenum;
	}

	public void setPhonenum(String phonenum) {
		this.phonenum = phonenum == null ? null : phonenum.trim();
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo == null ? null : photo.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	public String getUsertype() {
		return usertype;
	}

	public void setUsertype(String usertype) {
		this.usertype = usertype == null ? null : usertype.trim();
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public String getOldloginip() {
		return oldloginip;
	}

	public void setOldloginip(String oldloginip) {
		this.oldloginip = oldloginip == null ? null : oldloginip.trim();
	}

	public Date getOldlogindate() {
		return oldlogindate;
	}

	public void setOldlogindate(Date oldlogindate) {
		this.oldlogindate = oldlogindate;
	}

	public String getLoginflag() {
		return loginflag;
	}

	public void setLoginflag(String loginflag) {
		this.loginflag = loginflag == null ? null : loginflag.trim();
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public String getIdtype() {
		return idtype;
	}

	public void setIdtype(String idtype) {
		this.idtype = idtype == null ? null : idtype.trim();
	}

	public String getIdnumber() {
		return idnumber;
	}

	public void setIdnumber(String idnumber) {
		this.idnumber = idnumber == null ? null : idnumber.trim();
	}

	public String getIdentityimg() {
		return identityimg;
	}

	public void setIdentityimg(String identityimg) {
		this.identityimg = identityimg == null ? null : identityimg.trim();
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality == null ? null : nationality.trim();
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation == null ? null : nation.trim();
	}

	public String getPoliticalstatus() {
		return politicalstatus;
	}

	public void setPoliticalstatus(String politicalstatus) {
		this.politicalstatus = politicalstatus == null ? null : politicalstatus
				.trim();
	}

	public String getGraduateinstitutions() {
		return graduateinstitutions;
	}

	public void setGraduateinstitutions(String graduateinstitutions) {
		this.graduateinstitutions = graduateinstitutions == null ? null
				: graduateinstitutions.trim();
	}

	public String getProfessional() {
		return professional;
	}

	public void setProfessional(String professional) {
		this.professional = professional == null ? null : professional.trim();
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education == null ? null : education.trim();
	}

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification == null ? null : qualification
				.trim();
	}

	public String getBloodtype() {
		return bloodtype;
	}

	public void setBloodtype(String bloodtype) {
		this.bloodtype = bloodtype == null ? null : bloodtype.trim();
	}

	public String getNativeplace() {
		return nativeplace;
	}

	public void setNativeplace(String nativeplace) {
		this.nativeplace = nativeplace == null ? null : nativeplace.trim();
	}

	public String getContactaddress() {
		return contactaddress;
	}

	public void setContactaddress(String contactaddress) {
		this.contactaddress = contactaddress == null ? null : contactaddress
				.trim();
	}

	public Integer getPostalnumber() {
		return postalnumber;
	}

	public void setPostalnumber(Integer postalnumber) {
		this.postalnumber = postalnumber;
	}

	public String getFixedtelephone() {
		return fixedtelephone;
	}

	public void setFixedtelephone(String fixedtelephone) {
		this.fixedtelephone = fixedtelephone == null ? null : fixedtelephone
				.trim();
	}

	public String getOthercontact() {
		return othercontact;
	}

	public void setOthercontact(String othercontact) {
		this.othercontact = othercontact == null ? null : othercontact.trim();
	}

	public String getWorktitle() {
		return worktitle;
	}

	public void setWorktitle(String worktitle) {
		this.worktitle = worktitle == null ? null : worktitle.trim();
	}

	public String getWorkpost() {
		return workpost;
	}

	public void setWorkpost(String workpost) {
		this.workpost = workpost == null ? null : workpost.trim();
	}

	public String getWorkname() {
		return workname;
	}

	public void setWorkname(String workname) {
		this.workname = workname == null ? null : workname.trim();
	}

	public String getWorkindustry() {
		return workindustry;
	}

	public void setWorkindustry(String workindustry) {
		this.workindustry = workindustry == null ? null : workindustry.trim();
	}

	public String getWorknature() {
		return worknature;
	}

	public void setWorknature(String worknature) {
		this.worknature = worknature == null ? null : worknature.trim();
	}

	public Integer getIsDel() {
		return isDel;
	}

	public void setIsDel(Integer isDel) {
		this.isDel = isDel;
	}

	public String getDid() {
		return did;
	}

	public void setDid(String did) {
		this.did = did == null ? null : did.trim();
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

}