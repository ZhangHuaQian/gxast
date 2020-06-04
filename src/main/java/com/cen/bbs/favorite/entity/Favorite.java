package com.cen.bbs.favorite.entity;

import java.util.Date;

public class Favorite {
    private Integer id;

    private String type;

    private String uid;

    private Integer eventId;

    private Date createTime;

    private Integer style;

    private Integer tid;

    private String tFavoritecol;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid == null ? null : uid.trim();
    }

    public Integer getEventId() {
        return eventId;
    }

    public void setEventId(Integer eventId) {
        this.eventId = eventId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getStyle() {
        return style;
    }

    public void setStyle(Integer style) {
        this.style = style;
    }

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public String gettFavoritecol() {
        return tFavoritecol;
    }

    public void settFavoritecol(String tFavoritecol) {
        this.tFavoritecol = tFavoritecol == null ? null : tFavoritecol.trim();
    }
}