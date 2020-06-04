<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>广西科普传播中心后台管理系统</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <%@ include file="/commViews/head.jsp"%>
    <link rel="stylesheet" href="${ctx}resource/css/font.css">
	<link rel="stylesheet" href="${ctx}resource/css/xadmin.css">
    <script type="text/javascript" src="${ctx}resource/js/xadmin.js"></script>
	<style type="text/css">
		.layui-nav .layui-this:after, .layui-nav-bar, .layui-nav-tree .layui-nav-itemed:after{background: none;}
	    .iconfont img{height:18px;width:auto;max-width: 30px;}

        /** 自定义layer 主题 **/
        body .demo-class .layui-layer-title{
            font-size: 16px;
            color:#fff; border: none; background: linear-gradient(#14539c, #145bad);
        }
        body .demo-class .layui-layer-btn{border-top:1px solid #E9E7E7}
        body .demo-class .layui-layer-btn a{background:#1E9FFF;}
        body .demo-class .layui-layer-btn .layui-layer-btn1{background:#E8E8E8;}
        /*body .demo-class .layui-layer-close1{
            position: absolute;
            right: -8px;
            top: -10px;
            width: 30px;
            height: 30px;
            margin-left: 0;
            background-position: -180px -31px
        }*/
        /** 自定义layer 主题 **/

    </style>
	<script>
        // 登出
        function logout(){
            $.ajax({
                type:'post',
                url:'${ctx}logout',
                dataType:'json',
                success:function(data){
                    if(data.status==1){
                        window.location.href = "${ctx}login.jsp";
                    }else{
                        layer.msg("失败");
                    }
                },
                error:function (msg){
                    console.log(msg);
                    alert("异常");
                }
            });
        }

        var set_css = setInterval(function () {
            layer.config({
                skin: 'demo-class'
            })
            if(layer!=undefined)clearInterval(set_css);
        },1000)

    </script>
</head>
<body>
    <!-- 顶部开始 -->
    <div class="container">
        <div class="logo"><a href="./index.html">广西科普传播中心</a></div>
        <div class="left_open">
            <i title="展开左侧栏" class="iconfont">&#xe699;</i>
        </div>

        <ul class="layui-nav right" lay-filter="">
            <li class="layui-nav-item to-index"><a href="${ctx}web/toList" target="_blank">专题页面</a></li>
          <li class="layui-nav-item to-index"><a href="${ctx}" target="_blank">门户首页</a></li>
          <li class="layui-nav-item">
            <a href="javascript:;">${sessionScope.USER_SESSION_NAME.name}</a>
            <dl class="layui-nav-child"> <!-- 二级菜单 -->
              <dd><a onclick="x_admin_show('个人信息','${ctx}sys/ucenter/user/update-my.jsp?id=${sessionScope.USER_SESSION_NAME.id}',660,450)">个人信息</a></dd>
              <dd><a onclick="x_admin_show('密码更改','${ctx}sys/ucenter/user/member-password.jsp',500,350)">密码更改</a></dd>
              <dd><a href="#" onclick="logout()">切换账号</a></dd>
            </dl>
          </li>
          <li class="layui-nav-item to-index"><a href="#" onclick="logout()">登出</a></li>
        </ul>

    </div>
    <!-- 顶部结束 -->
    <!-- 中部开始 -->
     <!-- 左侧菜单开始 -->
    <div class="left-nav">
      <div id="side-nav">
        <ul id="nav">
            ${menuList2}
        </ul>
      </div>
    </div>
    <!-- <div class="x-slide_left"></div> -->
    <!-- 左侧菜单结束 -->
    <!-- 右侧主体开始 -->
    <div class="page-content">
        <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
          <ul class="layui-tab-title">
            <li class="home"><i class="layui-icon">&#xe68e;</i>首页</li>
          </ul>
          <div class="layui-tab-content"  style="padding: 10px;">
            <div class="layui-tab-item layui-show">
                <iframe id="mainContainer" name="mainContainer" src='${ctx}sys/welcome' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
            </div>
          </div>
        </div>
    </div>
    <div class="page-content-bg"></div>
    <!-- 右侧主体结束 -->
    <!-- 中部结束 -->
    <!-- 底部开始 -->
    <div class="footer">
        <div class="copyright">Copyright ©2019 广西科普传播中心后台管理系统 v1.0 All Rights Reserved</div>
    </div>
    <!-- 底部结束 -->
</body>
</html>
