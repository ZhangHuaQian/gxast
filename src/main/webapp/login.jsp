<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>广西科普传播中心后台管理系统</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>

    <%@ include file="/commViews/head.jsp"%>
    <link rel="stylesheet" href="${ctx}resource/css/font.css">
    <link rel="stylesheet" href="${ctx}resource/css/xadmin.css">
    <script type="text/javascript" src="${ctx}resource/js/xadmin.js"></script>
</head>
<style>
    .login hr {
        background: #0000ff00;
    }
</style>
<body class="login-bg">                                              

<div class="login layui-anim layui-anim-up" style="background-color: rgba(0, 0, 0, 0);text-align: center;">
    <img src="${ctxRes}images/logo.png" style="margin-bottom: 30px;margin-top: 10px;height: 50px">
    <form method="post" class="layui-form" id="main_form">
        <input id="loginname" name="loginname" style="text-align: center;height: 40px"  placeholder="请输入用户名" type="text" lay-verify="required" class="layui-input">
        <input id="password" name="password" style="margin-top:20px;text-align: center;height: 40px" lay-verify="required" placeholder="请输入密码" type="password" class="layui-input">
        <input value="登录" style="margin-top:30px;padding: 9px 24px;width:100%;height:44px;background-color: #2377CD;border: 1px solid #ffffff36;" lay-submit lay-filter="login"  type="submit">
        <%--<a style="margin-top:20px;color: white;float: right">忘记密码？</a>--%>
        <%--<a href="" style="float: right;margin-right: 10px;">忘记密码</a>--%>
    </form>                      
</div>

<script>
    var key = "";
    $(function () {
        getKey();
    });

    //用户登录
    function login(){
        // var fromDate = $('#main_form').serialize();
        var pwd = encrypt($("#password").val(),key);
        var loginname = encrypt($("#loginname").val(),key);
        var fromDate = "loginname="+encodeURIComponent(loginname)+"&password="+encodeURIComponent(pwd);
         //console.log(fromDate)
        $.ajax({
            type:'post',
            url:'${ctx }login',
            data:fromDate,
            dataType:'json',
            success:function(data){
                console.log(data);
                if(data.status==1){
                    window.location.href = "${ctx}sys/index";
                }else{
                    layer.msg("用户名或密码错误");
                }
            },
            error:function (msg){
                console.log(msg);
                layer.msg("用户名或密码错误");
            }
        });

    }

    function getKey(){
        $.ajax({
            type:'get',
            url:'${ctx }getKey',
            dataType:'json',
            asyn:false,
            success:function(data){
                // console.log(data);
                key =  data.data.key;

            },
            error:function (msg){
		console.log("error");
                console.log(msg);
            }
        });
    }
    $(function () {
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

</body>
</html>