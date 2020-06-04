function encrypt(word,sessionSalt){
    //按照自己页面模板取出session中的加密因子（thymeleaf中如下取得）
    // var sessionSalt = [[${session.salt}]];

    //按照自己页面模板取出session中的加密因子（jsp中如下取得）
    var key = CryptoJS.enc.Utf8.parse(sessionSalt);
    var srcs = CryptoJS.enc.Utf8.parse(word);
    var encrypted = CryptoJS.AES.encrypt(srcs, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
    return encrypted.toString();
}