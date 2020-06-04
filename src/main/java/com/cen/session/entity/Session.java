package com.cen.session.entity;

public class Session {
    private Integer sid;

    private String sname;

    private String smasterid;

    private String sprofile;

    private String sstatement;

    private Integer stopiccount;

    private Integer sclickcount;

    private String smaster;

    private Integer type; //版块类型

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getSmaster() {
        return smaster;
    }

    public void setSmaster(String smaster) {
        this.smaster = smaster;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname == null ? null : sname.trim();
    }

    public String getSmasterid() {
        return smasterid;
    }

    public void setSmasterid(String smasterid) {
        this.smasterid = smasterid;
    }

    public String getSprofile() {
        return sprofile;
    }

    public void setSprofile(String sprofile) {
        this.sprofile = sprofile == null ? null : sprofile.trim();
    }

    public String getSstatement() {
        return sstatement;
    }

    public void setSstatement(String sstatement) {
        this.sstatement = sstatement == null ? null : sstatement.trim();
    }

    public Integer getStopiccount() {
        return stopiccount;
    }

    public void setStopiccount(Integer stopiccount) {
        this.stopiccount = stopiccount;
    }

    public Integer getSclickcount() {
        return sclickcount;
    }

    public void setSclickcount(Integer sclickcount) {
        this.sclickcount = sclickcount;
    }
}