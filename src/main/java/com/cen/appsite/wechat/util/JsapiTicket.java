package com.cen.appsite.wechat.util;

public class JsapiTicket {
    String ticket;
    int expires_in;

    public JsapiTicket(String ticket, int expires_in) {
        this.ticket = ticket;
        this.expires_in = expires_in;
    }

    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }

    public int getExpires_in() {
        return expires_in;
    }

    public void setExpires_in(int expires_in) {
        this.expires_in = expires_in;
    }
}
