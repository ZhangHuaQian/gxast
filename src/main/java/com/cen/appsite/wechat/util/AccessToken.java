package com.cen.appsite.wechat.util;

public class AccessToken {
    String access_token;
    int expires_in;

    public AccessToken(String access_token, int expires_in) {
        this.access_token = access_token;
        this.expires_in = expires_in;
    }

    public void setAccess_token(String access_token) {
        this.access_token = access_token;
    }

    public double getTimestamp() {
        return expires_in;
    }

    public void setTimestamp(int expires_in) {
        this.expires_in = expires_in;
    }

    public String getAccess_token(){
        return access_token;
    }
}
