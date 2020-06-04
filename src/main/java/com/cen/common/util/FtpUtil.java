package com.cen.common.util;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

/**
 * Created by cenguocheng on 2018/8/28.
 * 137544496@qq.com
 */
public class FtpUtil {
    protected Logger logger = LoggerFactory.getLogger(getClass());

    /*private String address = "192.168.220.1";
    private String username = "root";
    private String password = "root";*/

    public String address = "172.22.96.9";
    public String username = "bedq";
    public String password = "bedq1";
    public String code = "utf-8";
    
    private int port = 21;

    /**
     * 获得连接
     * @throws IOException
     */
    public FTPClient getConnect() {
        FTPClient ftp = new FTPClient();

        try {
            ftp.connect(address, port);
            ftp.setControlEncoding(code);
            ftp.login(username, password); //登录ftp服务器
            int replyCode = ftp.getReplyCode(); //是否成功登录服务器
            if(!FTPReply.isPositiveCompletion(replyCode)){
                ftp = null;
                logger.error("replyCode :"+replyCode);
                logger.error("login ftp failed :"+this.address+":"+this.port);
                logger.error("username:"+username+" password:"+password+" code:"+code);
            }
        } catch (IOException e) {
            ftp = null;
            logger.error("connect ftp failed :"+this.address+":"+this.port+" --->>> "+e.toString());
            //e.printStackTrace();
        }
        return ftp;
    }

    /**
     * 关闭连接
     * @throws IOException
     */
    public void close(FTPClient ftp) {
        try {
            ftp.logout();
            ftp.disconnect();
        } catch (IOException e) {
            logger.error("connect ftp failed :"+this.address+":"+this.port);
            //e.printStackTrace();
        }
    }

}
