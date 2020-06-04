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
    <title>广西科普传播中心</title>
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
    </style>
</head>
<body style="background-color: #f2f5f9">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <div style="width:100%;background-image: url('${ctxRes}images/news_top.png');min-width:1302px;">

        <div id="main_center" style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 20px;">
            <div id="banner" style="width: 100%;height: auto;display: block;">
                <div id="logoarea" style="float: left">
                    <img src="${ctxRes}images/logo.png">
                </div>
                <div id="index_info" style="float: left;margin-top:9px;margin-left: 40px;border-left:1px solid;padding-left:20px;border-left-color:#FFFFFF">
                    <p style="color: #FFFFFF">今天（2018年11月2日 星期五）</p>
                    <p style="color: #FFFFFF">南宁 10~19℃ 多云</p>
                </div>
                <div id="search" style="float: right;border: #66aede 5px solid;border-radius:25px;background-color: #FFFFFF;margin-top: 5px;">
                    <div class="search_input_div" style="float: left;border: #FFFFFF 5px solid;border-radius:25px;">
                        <input class="search_input" style="height: 20px;border-width:0px;" maxlength="2048" type="text" autocomplete="off" autocorrect="off" role="combobox" spellcheck="false" title="搜索"aria-label="搜索">
                    </div>
                    <div class="search_button_div" style="float: left;background-color: #FFFFFF;border: #2377cd 5px solid;border-radius:25px;">
                        <button class="search_button" type="button" style="height: 20px;border-width:0px;background-color: #2377cd;color: #FFFFFF;" aria-label="搜索" >
                            &nbsp;&nbsp;搜&nbsp;索&nbsp;&nbsp;
                        </button>
                    </div>
                </div>
                <div class="clearDiv"></div>
            </div>
            <div id="main_main" style="width: 100%;height: auto;display: block;margin-top: 20px;min-width: 1162px;">
                <div id="label" style="width: 100%;background-color: #085099;">
                    <div id="label_div">
                        <ul><a href="${ctx}index.jsp"><div class="label_title white">网站首页</div></a></ul>
                        <ul><div class="label_title white">新闻中心</div></ul>
                        <ul><div class="label_title white">中心简介</div></ul>
                        <ul><div class="label_title white">党建工作</div></ul>
                        <ul><div class="label_title white">政务公开</div></ul>
                        <ul><div class="label_title white">订书订报</div></ul>
                    </div>
                    <div id="login_info" class="white" style="float: right;margin-right:5px;">
                        <p style="padding: 10px 25px;">下午好，欢迎你，请<a href="#" style="color: #FFFFFF">&nbsp;登录&nbsp;</a>或<a href="#" style="color: #FFFFFF">&nbsp;注册&nbsp;</a></p>
                    </div>
                    <div class="clearDiv"></div>
                </div>

            </div> 
        </div>           
    </div>                                      
     <iframe onload="this.height=this.contentWindow.document.body.scrollHeight+200" frameborder="0" width="100%" src="${ctx}web/product/SelectList?pageNum=1&pageSize=16"></iframe>   
    <div class="clearDiv"></div>
</div>
<div id="footer" style="width: 100%;height: 150px;background-color: #313131;color:#ffffff;margin-top: 30px;text-align: center" >
    <div style="padding-top: 50px">
        <p>电话:0233-65846145 传真:0235-2586888 E-mail:LKJTYJ@163.com 网站备案号：*ICP备14012345号-1</p>
        <p>版权所有：广西科普传播中心 承办：广西县科学技术协会 技术支持：广西协会</p>
        <p>地址广西科普集传播中心</p>
        <div class="clearDiv"></div>
    </div>
    <div class="clearDiv"></div>

</div>
</body>
</html>
