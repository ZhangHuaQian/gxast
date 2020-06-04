package com.cen.JtyyForeign.entity;

import java.util.Date;

import com.cen.common.entity.BaseEntity;

/**
* @author cframework
* @version V1.0 2020-05-14
*/
public class JtyyForeign {

    private Integer id; //
    private Integer catid; //栏目id
    private String title; //标题
    private String description; //资讯描述
    private String author; //作者
    private String editor; //编辑者
    private String content; //资讯内容
    private Integer pageView; //浏览量
    private Integer praiseView; //点赞量
    private String orignfrom; //来源
    private String photo; //封面图片
    private Date createTime; //创建时间
    private String type; //资讯类型

    public JtyyForeign setId(Integer id) {
        this.id = id;
        return this;
    }
    public Integer getId() {
        return id;
    }
    public JtyyForeign setCatid(Integer catid) {
        this.catid = catid;
        return this;
    }
    public Integer getCatid() {
        return catid;
    }
    public JtyyForeign setTitle(String title) {
        this.title = title;
        return this;
    }
    public String getTitle() {
        return title;
    }
    public JtyyForeign setDescription(String description) {
        this.description = description;
        return this;
    }
    public String getDescription() {
        return description;
    }
    public JtyyForeign setAuthor(String author) {
        this.author = author;
        return this;
    }
    public String getAuthor() {
        return author;
    }
    public JtyyForeign setEditor(String editor) {
        this.editor = editor;
        return this;
    }
    public String getEditor() {
        return editor;
    }
    public JtyyForeign setContent(String content) {
        this.content = content;
        return this;
    }
    public String getContent() {
        return content;
    }
    public JtyyForeign setPageView(Integer pageView) {
        this.pageView = pageView;
        return this;
    }
    public Integer getPageView() {
        return pageView;
    }
    public JtyyForeign setPraiseView(Integer praiseView) {
        this.praiseView = praiseView;
        return this;
    }
    public Integer getPraiseView() {
        return praiseView;
    }
    public JtyyForeign setOrignfrom(String orignfrom) {
        this.orignfrom = orignfrom;
        return this;
    }
    public String getOrignfrom() {
        return orignfrom;
    }
    public JtyyForeign setPhoto(String photo) {
        this.photo = photo;
        return this;
    }
    public String getPhoto() {
        return photo;
    }
    public JtyyForeign setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public JtyyForeign setType(String type) {
        this.type = type;
        return this;
    }
    public String getType() {
        return type;
    }

}
