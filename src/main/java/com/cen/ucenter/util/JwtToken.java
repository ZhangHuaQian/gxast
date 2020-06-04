package com.cen.ucenter.util;

public class JwtToken{

    private String token;   // token 令牌

    private int expires;  // 有效时间 （秒数）

    private String salt; // 加密盐

    public JwtToken() {}

    public JwtToken(String token, int expires) {
        this.token = token;
        this.expires = expires;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getExpires() {
        return expires;
    }

    public void setExpires(int expires) {
        this.expires = expires;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }
}
