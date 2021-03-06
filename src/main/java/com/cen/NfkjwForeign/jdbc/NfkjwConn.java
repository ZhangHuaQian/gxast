package com.cen.NfkjwForeign.jdbc;

import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class NfkjwConn {
    private static Connection conn;
    private static String driverClass;
    private static String url;
    private static String username;
    private static String password;
    private static InputStream in;

    public static void createConnection(){
        try {
            Properties prop = new Properties();
            driverClass = prop.getProperty("driverClass");
            url = "jdbc:mysql://113.16.213.191:3306/newnfkjw?useUnicode=true&characterEncoding=utf-8&useSSL=false";
            username = "sx_nfkjw";
            password = "sx_nfkjw";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

        } catch (Exception e) {
            System.out.println("加载配置文件失败");
            e.printStackTrace();
        }

    }

    /**
     * 获取连接的方法
     * @return
     */
    public static Connection getConnection() {
        createConnection();
        return conn;
    }

    /**
     * 关闭连接 释放资源
     * @param conn
     * @param
     * @throws SQLException
     */
    public static void close(Connection conn, PreparedStatement ps) throws SQLException {
        if(conn != null) {
            conn.close();
        }
        if(ps != null) {
            ps.close();
        }
    }

    /**
     * 关闭所有连接
     * @param conn
     * @param
     * @param rs
     * @throws SQLException
     */
    public static void close(Connection conn, PreparedStatement ps, ResultSet rs) throws SQLException {
        if(conn != null) {
            conn.close();
        }
        if(ps != null) {
            ps.close();
        }
        if(rs != null) {
            rs.close();
        }
    }
}
