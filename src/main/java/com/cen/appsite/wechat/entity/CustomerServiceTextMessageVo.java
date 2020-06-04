package com.cen.appsite.wechat.entity;

public class CustomerServiceTextMessageVo extends CustomerServiceBaseMessageVo {
    private TextContentVo textContentVo;

    public TextContentVo GetText() {
        return textContentVo;
    }

    public void setText(TextContentVo textContentVo) {
        this.textContentVo = textContentVo;
    }
}
