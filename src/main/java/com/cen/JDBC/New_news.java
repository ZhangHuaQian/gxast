package com.cen.JDBC;


import java.io.Serializable;
import java.util.Date;

public class New_news implements Serializable {
    private int id;
    private int catid;
    private int typeid;
    private String title;
    private String style;
    private String thumb;
    private String keywords;
    private String description;
    private int posids;
    private String url;
    private int listorder;
    private int status;
    private int sysadd;
    private int islink;
    private String username;
    private Date inputtime;
    private Date updatetime;
    private String content;
    private String orignfrom;
    private String editor;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCatid() {
        return catid;
    }

    public void setCatid(int catid) {
        this.catid = catid;
    }

    public int getTypeid() {
        return typeid;
    }

    public void setTypeid(int typeid) {
        this.typeid = typeid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public String getThumb() {
        return thumb;
    }

    public void setThumb(String thumb) {
        this.thumb = thumb;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPosids() {
        return posids;
    }

    public void setPosids(int posids) {
        this.posids = posids;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getListorder() {
        return listorder;
    }

    public void setListorder(int listorder) {
        this.listorder = listorder;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getSysadd() {
        return sysadd;
    }

    public void setSysadd(int sysadd) {
        this.sysadd = sysadd;
    }

    public int getIslink() {
        return islink;
    }

    public void setIslink(int islink) {
        this.islink = islink;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getInputtime() {
        return inputtime;
    }

    public void setInputtime(Date inputtime) {
        this.inputtime = inputtime;
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getOrignfrom() {
        return orignfrom;
    }

    public void setOrignfrom(String orignfrom) {
        this.orignfrom = orignfrom;
    }

    public String getEditor() {
        return editor;
    }

    public void setEditor(String editor) {
        this.editor = editor;
    }
}
