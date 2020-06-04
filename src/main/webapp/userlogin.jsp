<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>用户登录-广西科普传播中心</title>
    <link rel="stylesheet" href="${ctx}resource/css/font.css">
    <link rel="stylesheet" href="${ctx}resource/css/xadmin.css">
    <script type="text/javascript" src="${ctx}resource/js/xadmin.js"></script>
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
<body style="background-color: #eeeeee">
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
                    <a href="${ctx}"><p style="color: #FFFFFF">返回首页</p></a>
                </div>
                <div class="clearDiv"></div>
            </div>
        </div>
    </div>
    <div id="newslistdiv" style="height:60%;width:70%;min-width:1302px;margin: 10px auto;">
        <div style="margin-top: 140px;margin-bottom: 100px;">
            <div style="float: left;width: 50%;text-align: center">
                <img src="${ctxRes}images/zt.png" style="width: 400px;height: 400px;">
            </div>
            <div style="float: right;width: 30%;background-color: #FFFFFF;height: 400px;margin-right: 200px;">

                <div style="margin:10px 30px;">
                    <div class="header">
                        <span class="line"></span>
                        <span class="txt"><strong>欢迎登录</strong></span>
                        <span class="line"></span>
                    </div>

                    <form method="post" class="layui-form" id="main_form">
                    <div style="height: 40px;border: 1px solid #efefef;margin: 15px 0px;">
                        <div style="margin: 1px 0px;">
                            <img src="${ctxRes}images/yh.png" style="margin-left:10px;margin-right:5px;">
                            <input placeholder="用户名" lay-verType="tips" lay-verify="required" id="loginName" name="loginname" style="border: 0px;line-height: 35px;height: 35px;width:80%;border-left: 1px solid #efefef;margin-top: 2px;padding-left: 10px;">
                        </div>
                    </div>
                    <div style="height: 40px;border: 1px solid #efefef;margin: 15px 0px;">
                        <div style="margin: 1px 0px;">
                            <img src="${ctxRes}images/mm.png" style="margin-left:10px;margin-right:5px;">
                            <input type="password" id="password" lay-verType="tips" name="password" placeholder="密码" lay-verify="required" style="border: 0px;line-height: 35px;height: 35px;width:80%;border-left: 1px solid #efefef;margin-top: 2px;padding-left: 10px;">
                        </div>
                    </div>
                    <div style="height: 40px;border: 1px solid #efefef;margin: 15px 0px;">
                        <div style="margin: 1px 0px;">
                            <img src="${ctxRes}images/mm.png" style="margin-left:10px;margin-right:5px;">
                            <input type="text" lay-verType="tips" placeholder="请输入验证码" id="code" name="ValidateCode" lay-verify="required"  style="border: 0px;line-height: 35px;height: 35px;width:190px;border-left: 1px solid #efefef;margin-top: 2px;padding-left: 10px;">
                            <img title="点击更换" style="width: 90px;height:30px;cursor: pointer;" id="imgObj" alt="验证码" src="${ctx}base/validateCode.jpg" onclick="javascript:reset_validateCode()">
                        </div>
                    </div>
                    <div style="height: 40px;margin: 15px 0px;text-align: center;">
                        <button id="login" class="layui-btn" lay-submit lay-filter="login" type="submit" style="width: 100%;height: 38px;background-color: #2377cd;color:#FFFFFF;border: 0px;border-radius:2px;">
                            立即登录
                        </button>
                    </div>
                </form>
                    <div style="text-align: center;color: #b2b2b2">
                        <a href="${ctx}web/register.jsp" style="color: #b2b2b2"><span style="padding-right: 3px;">注册新账号</span></a><a href="${ctx}web/findpw.jsp" style="color: #b2b2b2"><span style="padding-left: 3px;border-left: 1px solid #b2b2b2">忘记密码?</span></a>
                    </div>
                </div>

            </div>
            <div class="clearDiv"></div>
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

<script>

    //用户登录
    function login(){
        var fromDate = $('#main_form').serialize();
        $.ajax({
            type:'post',
            url:'${ctx }login_two',
            data:fromDate,
            dataType:'json',
            success:function(data){
                if(data.status==1){
                    // 获取用户登前所在页面url
                    var historyUrl = sessionStorage.getItem("historyUrl");
                    if(historyUrl != null){
                        window.location.href = historyUrl;
                    }else{
                        window.location.href = "${ctx}/web/user/user_index.jsp";
                    }

                }else{
                    layer.msg(data.msg, {icon: 5});
                    reset_validateCode();
                }
            },
            error:function (msg){
                console.log(msg);
                alert("错误!");
            }
        });
    }

    // reset 验证码
    function reset_validateCode(){
        $("#imgObj").attr('src','${ctx}base/validateCode.jpg?t='+Math.random());
    }

    $("#login").on("click",function () {
        layui.use('form', function () {
            var form = layui.form;
            //监听提交
            form.on('submit(login)', function (data) {
                login();
                return false;
            });
        });
    })

    if(window.parent.location.pathname.search("login.jsp") == -1){
        window.parent.location.href = "${ctx}login.jsp";
    }

</script>
</html>
