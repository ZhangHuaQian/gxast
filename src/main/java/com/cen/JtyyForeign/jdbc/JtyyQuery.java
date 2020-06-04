package com.cen.JtyyForeign.jdbc;

import com.cen.JtyyForeign.entity.JtyyForeign;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class JtyyQuery {
    public static Connection conn;
    public static PreparedStatement ps;
    public static ResultSet rs;

    public static List<JtyyForeign> query(String catids, Integer id) throws Exception{
        int retryCount = 5;
        List<JtyyForeign> list = new ArrayList<JtyyForeign>();
        boolean transactionCompleted = false;
        //调用数据库链接工具类方法获取连接
        try{
            conn = JtyyConn.getConnection();
            conn.setAutoCommit(false);
            retryCount=0;
            //定义sql语句
            String sql= "SELECT xc.cid AS id, xc.catid, xc.title, xcn.zhaiyao AS description , xcn.content," +
                    " xcn.laiyuan AS orignfrom, xc.thumb AS photo, xc.hits AS pageView, xcn.zuozhe AS author, " +
                    " DATE_FORMAT(FROM_UNIXTIME(create_time),'%Y-%m-%d %H:%i:%s') AS create_time" +
                    " FROM xf_content xc" +
                    " LEFT JOIN xf_content_news xcn" +
                    " ON xc.cid = xcn.cid" +
                    " WHERE xc.catid IN ("+ catids +")" +
                    " AND xc.status=1 " +
                    " AND xc.cid > " + id +
                    " ORDER BY create_time DESC";

            //获取预编译对象
            ps = conn.prepareStatement(sql);
            //执行查询操作获取结果集
            rs = ps.executeQuery();
            //定义list集合，存放对象

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            //遍历结果集
            while(rs.next()) {
                JtyyForeign jtyyForeign=new JtyyForeign();
                jtyyForeign.setId(rs.getInt(1));
                jtyyForeign.setCatid(rs.getInt(2));
                jtyyForeign.setTitle(rs.getString(3));
                jtyyForeign.setDescription(rs.getString(4));
                jtyyForeign.setContent(rs.getString(5));
                jtyyForeign.setOrignfrom(rs.getString(6));
                jtyyForeign.setPhoto(rs.getString(7));
                jtyyForeign.setPageView(rs.getInt(8));
                jtyyForeign.setAuthor(rs.getString(9));
                jtyyForeign.setCreateTime(sf.parse(rs.getString(10)));
                list.add(jtyyForeign);
            }
            transactionCompleted = true;
        }catch (SQLException e){
            String sqlState=e.getSQLState();
            if("08S01".equals(sqlState)||"40001".equals(sqlState)){
                retryCount--;
            }else{
                retryCount=0;
            }
            e.printStackTrace();
        }finally {
            conn.close();
        }
        return list;
    }

}
