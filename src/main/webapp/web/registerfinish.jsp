<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/12/28
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>广西科普传播中心-注册成功</title>
    <style>
        /*为添加的空div设置的样式*/
        .clearDiv {
            clear: both;
        }
        .white{
            color: #FFFFFF;
        }
        .label_title{
            display: inline;
            float: left;
            border-right: #2377cd 1px solid;
            padding: 10px 25px;
        }
        .lm_label{
            display: inline;
            float: left;

            padding: 10px 25px;
        }
        .lm_label_select{
            display: inline;
            float: left;
            background-color: #2377cd;
            padding: 10px 25px;
        }
        .div0_col0{
            width: 60%;
            float: left;
        }
        .div0_col1{
            width: 40%;
        }
        #index_main_div0_row0{
            height: 57%;
        }
        #index_main_div0_row1{
            height: 43%;
        }


        .news_list{
            font-size: 16px;
            display: table-cell;
            vertical-align: middle;
            width: 100%;
        }
        .news_list_time{
            color: #ababab;
            float: right;
            margin-right: 15px;

        }
        #newslists>ul{
            width: 100%;
            padding-top: 10px;
            padding-bottom: 10px;
            color: #696969;
            display: table;
            width: 100%;
            height: 40px;
        }
        #newslists>ul:nth-child(odd){
            background-color: #f2f7fb;
        }
        #newslists>ul:nth-child(even){
            background-color: #ffffff;
        }

        .header {
            height: 60px;
            line-height: 60px;
            text-align: center;
        }
        .header .line {
            display: inline-block;
            width: 105px;
            border-top: 1px solid #efefef ;
        }
        .header .txt {
            color: #333333;
            font-size: 19px;
            vertical-align: -4px;
            margin-left: 10px;
            margin-right: 10px;
        }

    </style>
</head>
<body style="background-color: #eeeeee" onload="returnUrlByTime()" >
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <div style="width:100%;background-color: #2377cd;min-width:1302px;">

        <div id="main_center" style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 10px;padding-bottom: 10px;">
            <div id="banner" style="width: 100%;display: block;">
                <div id="logoarea" style="float: left">
                    <img src="${ctxRes}images/logo.png" style="width: 200px;">
                </div>
                <div id="index_info" style="float: left;margin-top:9px;margin-left: 40px;border-left:1px solid;padding-left:20px;border-left-color:#FFFFFF">
                    <a href="${ctx}index.jsp"  ><p style="color: #FFFFFF">返回首页</p></a>
                </div>
                <div class="clearDiv"></div>
            </div>
        </div>
    </div>
    <div id="newslistdiv" style="height:60%;width:70%;min-width:1302px;margin: 10px auto;">
        <div style="margin-top: 140px;margin-bottom: 100px;text-align: center">
            <div>
                <img src="${ctxRes}images/cg.png">
            </div>
            <div style="margin-top: 20px;">
                <p style="font-size: 20px;color: #7C7C7C">恭喜你，你已成功注册会员，你现在可以:</p>
                <p style="margin-top: 10px;margin-bottom: 10px;color: #666666">现在就<a href="${ctx}userlogin.jsp"><span style="color: #5192D4;font-size: 17px">登录</span></a></p>
            </div>
            <div style="margin-top: 20px;margin-bottom: 20px;background-color: #eeeeee"><a href="${ctx}"><button id="btn" style="padding:5px 25px;border: 1px solid #3380D0;color: #3380D0;background-color: #eeeeee;">返回首页</button></a></div>
        </div>

        <div class="clearDiv"></div>
    </div>
    <div class="clearDiv"></div>
</div>
<div id="footer" style="width: 100%;height: 150px;background-color: #313131;color:#ffffff;margin-top: 30px;text-align: center" >
    <div style="padding-top: 50px">
        <p> 网站备案号：*ICP备14012345号-1 </p>
        <p> 版权所有：广西科普传播中心 </p>
        <p>地址：南宁市青秀区古城路31号</p>
        <div class="clearDiv"></div>
    </div>
    <div>
        <a style="color: #fbfbfb;text-decoration: underline;" href="javascript:scroll(0,0)">返回顶部</a>
    </div>
    <div class="clearDiv"></div>

</div>
</body>
<script type="text/javascript">
    var time = 5;
    function returnUrlByTime() {
        window.setTimeout('returnUrlByTime()', 1000);
        time = time - 1;
        if(time<=0){
            time = 0;
            /* window.setTimeout("location.href='${pageContext.request.contextPath}/index/index.xhtml';", 0);*/
            window.setTimeout(location.href='${ctx}userlogin.jsp', 0);
        }
        document.getElementById("btn").innerHTML = '返回首页('+time+')';
    }
</script>
</html>
