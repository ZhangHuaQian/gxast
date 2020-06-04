package com.cen.NfkjwForeign.jdbc;

import com.cen.JtyyForeign.entity.JtyyForeign;
import com.cen.NfkjwForeign.entity.NfkjwForeign;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class NfkjwQuery {
    public static Connection conn;
    public static PreparedStatement ps;
    public static ResultSet rs;

    public static List<NfkjwForeign> query(String catids, Integer id) throws Exception{
        int retryCount = 5;
        List<NfkjwForeign> list = new ArrayList<NfkjwForeign>();
        boolean transactionCompleted = false;
        //调用数据库链接工具类方法获取连接
        try{
            conn = NfkjwConn.getConnection();
            conn.setAutoCommit(false);
            retryCount=0;
            //定义sql语句
            String sql= "SELECT nn.id, nn.catid, nn.title, nn.description," +
                    " nn.username AS editor, nnd.content, nnd.copyfrom AS orignfrom," +
                    " nn.thumb AS photo, DATE_FORMAT(FROM_UNIXTIME(nn.inputtime),'%Y-%m-%d %H:%i:%s') AS create_time" +
                    " FROM new_news nn" +
                    " LEFT JOIN new_news_data nnd \n" +
                    " ON nn.id=nnd.id " +
                    " WHERE nn.catid IN("+ catids +")" +
                    " AND nn.status= 99" +
                    " AND nn.id > " + id +
                    " ORDER BY inputtime DESC";

            //获取预编译对象
            ps = conn.prepareStatement(sql);
            //执行查询操作获取结果集
            rs = ps.executeQuery();
            //定义list集合，存放对象

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            //遍历结果集
            while(rs.next()) {
                NfkjwForeign nfkjwForeign=new NfkjwForeign();
                nfkjwForeign.setId(rs.getInt(1));
                nfkjwForeign.setCatid(rs.getInt(2));
                nfkjwForeign.setTitle(rs.getString(3));
                nfkjwForeign.setDescription(rs.getString(4));
                nfkjwForeign.setEditor(rs.getString(5));
                nfkjwForeign.setContent(rs.getString(6));
                nfkjwForeign.setOrignfrom(rs.getString(7));
                nfkjwForeign.setPhoto(rs.getString(8));
                nfkjwForeign.setCreateTime(sf.parse(rs.getString(9)));
                list.add(nfkjwForeign);
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
