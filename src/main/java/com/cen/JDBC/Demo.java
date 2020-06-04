package com.cen.JDBC;


import java.util.List;

public class Demo {
   private static SelectDao selectDao=new SelectDao();
   public static void main(String[] args) throws Exception {

      List<New_news> list1=selectDao.selectData2("2");
      for (int i = 0; i <list1.size() ; i++) {
         System.out.println(list1.get(i).getThumb());
      }

   }



}
