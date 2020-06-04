package com.cen.JDBC;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

public class New_jtyy implements Serializable {
    private int cid;
    private int catid;
    private String title;
    private String thumb;
    private Set attr;
    private int status;
    private int sort;
    private int user_id;
    private String username;
    private Date create_time;
    private int update_time;
    private int hits;
    private String seotitle;
    private String seokeywords;
    private String seodescription;
    private int is_homeup;
    private int home_user;
    private String home_user_name;
    private int is_shenhe;
    private String zhaiyao;
    private String content;

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getCatid() {
        return catid;
    }

    public void setCatid(int catid) {
        this.catid = catid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumb() {
        return thumb;
    }

    public void setThumb(String thumb) {
        this.thumb = thumb;
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Set getAttr() {
        return attr;
    }

    public void setAttr(Set attr) {
        this.attr = attr;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(int update_time) {
        this.update_time = update_time;
    }

    public int getHits() {
        return hits;
    }

    public void setHits(int hits) {
        this.hits = hits;
    }

    public String getSeotitle() {
        return seotitle;
    }

    public void setSeotitle(String seotitle) {
        this.seotitle = seotitle;
    }

    public String getSeokeywords() {
        return seokeywords;
    }

    public void setSeokeywords(String seokeywords) {
        this.seokeywords = seokeywords;
    }

    public String getSeodescription() {
        return seodescription;
    }

    public void setSeodescription(String seodescription) {
        this.seodescription = seodescription;
    }

    public int getIs_homeup() {
        return is_homeup;
    }

    public void setIs_homeup(int is_homeup) {
        this.is_homeup = is_homeup;
    }

    public int getHome_user() {
        return home_user;
    }

    public void setHome_user(int home_user) {
        this.home_user = home_user;
    }

    public String getHome_user_name() {
        return home_user_name;
    }

    public void setHome_user_name(String home_user_name) {
        this.home_user_name = home_user_name;
    }

    public int getIs_shenhe() {
        return is_shenhe;
    }

    public void setIs_shenhe(int is_shenhe) {
        this.is_shenhe = is_shenhe;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getZhaiyao() {
        return zhaiyao;
    }

    public void setZhaiyao(String zhaiyao) {
        this.zhaiyao = zhaiyao;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
