package com.cen.JDBC;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class SelectDao {
    public  Connection conn;
    public  PreparedStatement ps;
    public  ResultSet rs;
    /*封装的外部接口集合*/
    public  List<New_news> selectData(String cid,String status) throws Exception{
        int retryCount = 5;
        List<New_news> list = new ArrayList<New_news>();
        boolean transactionCompleted = false;
        //调用数据库链接工具类方法获取连接
        try{
            conn = JDBCUtils.getConnection();
            conn.setAutoCommit(false);
            retryCount=0;
            //定义sql语句
            String sql="select new_news.id,new_news.catid,new_news.title,new_news.description,new_news.url,new_news.username,DATE_FORMAT(FROM_UNIXTIME(inputtime),'%Y-%m-%d'),new_news_data.content,new_news_data.copyfrom from new_news LEFT JOIN new_news_data on new_news.id=new_news_data.id where new_news.catid="+ cid+" and new_news.status="+ status+" order by inputtime desc limit 0,8 ";
            //获取预编译对象
            ps = conn.prepareStatement(sql);
            //执行查询操作获取结果集
            rs = ps.executeQuery();
            //定义list集合，存放对象

            //遍历结果集
            while(rs.next()) {
                New_news new_news=new New_news();
                new_news.setId(rs.getInt(1));
                new_news.setCatid(rs.getInt(2));
                new_news.setTitle(rs.getString(3));
                new_news.setDescription(rs.getString(4));
                new_news.setUrl(rs.getString(5));
                new_news.setUsername(rs.getString(6));
                new_news.setInputtime(rs.getDate(7));
                new_news.setContent(rs.getString(8));
                new_news.setOrignfrom(rs.getString(9));
                list.add(new_news);
            }
            transactionCompleted = true;
        }catch (SQLException e){
            String sqlState=e.getSQLState();
            if("08S01".equals(sqlState)||"40001".equals(sqlState)){
                retryCount--;
            }else{
                retryCount=0;
            }
           //e.printStackTrace();
        }finally {

        }
        return list;
    }
    /*首页南方科技网*/
    public  List<New_news> selectData1(String cid,String status) throws Exception{
        int retryCount = 5;
        List<New_news> list = new ArrayList<New_news>();
        boolean transactionCompleted = false;
        //调用数据库链接工具类方法获取连接
        try{
            conn = JDBCUtils.getConnection();
            conn.setAutoCommit(false);
            retryCount=0;
            //定义sql语句
            String sql="select new_news.id,new_news.catid,new_news.title,new_news.description,new_news.url,new_news.username,DATE_FORMAT(FROM_UNIXTIME(inputtime),'%Y-%m-%d'),new_news_data.content,new_news_data.copyfrom from new_news LEFT JOIN new_news_data on new_news.id=new_news_data.id where new_news.catid="+ cid+" and new_news.status="+ status+" order by inputtime desc limit 0,4 ";
            //获取预编译对象
            ps = conn.prepareStatement(sql);
            //执行查询操作获取结果集
            rs = ps.executeQuery();
            //定义list集合，存放对象

            //遍历结果集
            while(rs.next()) {
                New_news new_news=new New_news();
                new_news.setId(rs.getInt(1));
                new_news.setCatid(rs.getInt(2));
                new_news.setTitle(rs.getString(3));
                new_news.setDescription(rs.getString(4));
                new_news.setUrl(rs.getString(5));
                new_news.setUsername(rs.getString(6));
                new_news.setInputtime(rs.getDate(7));
                new_news.setContent(rs.getString(8));
                new_news.setOrignfrom(rs.getString(9));
                list.add(new_news);
            }
            transactionCompleted = true;
        }catch (SQLException e){
            String sqlState=e.getSQLState();
            if("08S01".equals(sqlState)||"40001".equals(sqlState)){
                retryCount--;
            }else{
                retryCount=0;
            }
            //e.printStackTrace();
        }finally {

        }
        return list;
    }
    /*首页南方科技板块广告*/
    public  List<New_news> selectData2(String id) throws Exception{
        int retryCount = 5;
        List<New_news> list = new ArrayList<New_news>();
        boolean transactionCompleted = false;
        //调用数据库链接工具类方法获取连接
        try{
            conn = JDBCUtils.getConnection();
            conn.setAutoCommit(false);
            retryCount=0;
            //定义sql语句
            String sql="select id,catid,title,url,thumb  from new_news where catid="+id+" and status=99 and thumb !='' order by inputtime desc limit 0,100  ";
            //获取预编译对象
            ps = conn.prepareStatement(sql);
            //执行查询操作获取结果集
            rs = ps.executeQuery();
            //定义list集合，存放对象

            //遍历结果集
            while(rs.next()) {
                New_news new_news=new New_news();
                new_news.setId(rs.getInt(1));
                new_news.setCatid(rs.getInt(2));
                new_news.setTitle(rs.getString(3));
                new_news.setUrl(rs.getString(4));
                new_news.setThumb(rs.getString(5));
                list.add(new_news);
            }
            transactionCompleted = true;
        }catch (SQLException e){
            String sqlState=e.getSQLState();
            if("08S01".equals(sqlState)||"40001".equals(sqlState)){
                retryCount--;
            }else{
                retryCount=0;
            }
            //e.printStackTrace();
        }finally {

        }
        return list;
    }
    /*首页家庭医药*/
    public  List<New_jtyy> selectData3(String id) throws Exception{
        int retryCount = 5;
        List<New_jtyy> list = new ArrayList<New_jtyy>();
        boolean transactionCompleted = false;
        //调用数据库链接工具类方法获取连接
        try{
            conn = JDBCUtils_yy.getConnection();
            conn.setAutoCommit(false);
            retryCount=0;
            //定义sql语句
            String sql="select xf_content.cid,xf_content.catid,xf_content.title," +
                    "xf_content.thumb,xf_content.username,DATE_FORMAT(FROM_UNIXTIME(create_time),'%Y-%m-%d')," +
                    "xf_content_news.zhaiyao,xf_content_news.content " +
                    "from xf_content LEFT JOIN xf_content_news on xf_content.cid=xf_content_news.cid where xf_content.catid ="+ id+" and xf_content.status=1  order by create_time desc limit 0,8 ";
            //获取预编译对象
            ps = conn.prepareStatement(sql);
            //执行查询操作获取结果集
            rs = ps.executeQuery();
            //定义list集合，存放对象

            //遍历结果集
            while(rs.next()) {
                New_jtyy new_jtyy=new New_jtyy();
                new_jtyy.setCid(rs.getInt(1));
                new_jtyy.setCatid(rs.getInt(2));
                new_jtyy.setTitle(rs.getString(3));
                new_jtyy.setThumb(rs.getString(4));
                new_jtyy.setUsername(rs.getString(5));
                new_jtyy.setCreate_time(rs.getDate(6));
                new_jtyy.setZhaiyao(rs.getString(7));
                new_jtyy.setContent(rs.getString(8));
                list.add(new_jtyy);
            }
            transactionCompleted = true;
        }catch (SQLException e){
            String sqlState=e.getSQLState();
            if("08S01".equals(sqlState)||"40001".equals(sqlState)){
                retryCount--;
            }else{
                retryCount=0;
            }
            //e.printStackTrace();
        }finally {

        }
        return list;
    }

    public  List<New_jtyy> selectData4(String id) throws Exception{
        int retryCount = 5;
        List<New_jtyy> list = new ArrayList<New_jtyy>();
        boolean transactionCompleted = false;
        //调用数据库链接工具类方法获取连接
        try{
            conn = JDBCUtils_yy.getConnection();
            conn.setAutoCommit(false);
            retryCount=0;
            //定义sql语句
            String sql="select cid,catid,title,thumb from xf_content where catid ="+id+" and status=1 and thumb !='' order by create_time desc limit 0,100";
            //获取预编译对象
            ps = conn.prepareStatement(sql);
            //执行查询操作获取结果集
            rs = ps.executeQuery();
            //定义list集合，存放对象

            //遍历结果集
            while(rs.next()) {
                New_jtyy new_jtyy=new New_jtyy();
                new_jtyy.setCid(rs.getInt(1));
                new_jtyy.setCatid(rs.getInt(2));
                new_jtyy.setTitle(rs.getString(3));
                new_jtyy.setThumb(rs.getString(4));
                list.add(new_jtyy);
            }
            transactionCompleted = true;
        }catch (SQLException e){
            String sqlState=e.getSQLState();
            if("08S01".equals(sqlState)||"40001".equals(sqlState)){
                retryCount--;
            }else{
                retryCount=0;
            }
            //e.printStackTrace();
        }finally {

        }
        return list;
    }
}
