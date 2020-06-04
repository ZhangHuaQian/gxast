<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
    <title>广西青少年科普知识竞赛</title>
    <link rel="stylesheet" href="${ctx}resource/css/weui.css">
    <link rel="stylesheet" href="${ctx}resource/css/weuix.css">
    <script src="${ctx}resource/js/zepto.min.js"></script>
    <script src="${ctx}resource/js/zepto.weui.js"></script>
</head>
<style>
    body{
        margin: 0px;
        background-image: url('${ctx}resource/images/answer/beij.png');
        background-size: 100% 100%;
    }
    a img{
        height: 8%;
        width: 58.3%;
        position: absolute;
        top: 71%;
        left: 22.5%;
    }
    p{
        font-size: 14px;
        text-align: center;
        color: #e4e4e4;
    }
    .footer-content{
        width: 100%;
        position: absolute;
        bottom: 5%;
    }
</style>
<body>
    <div>
        <a href="personal.jsp">
            <img src="${ctx}resource/images/answer/dat_nor.png">
        </a>
    </div>
    <div class="footer-content">
        <p>主办单位：广西科学技术协会</p>
        <p>承办单位：广西科学技术普及传播中心</p>
        <p>活动时间：2019年11月15日-12月15日</p>
    </div>
</body>
</html>
<script>
    $(function () {
        if(IsPC()){
            //这里执行的是PC端的代码；
            window.location.href="${ctx}web/answer/pc/personal.jsp"
            return
        }
        else{

        }
    })
    function IsPC() {
        var userAgentInfo = navigator.userAgent;
        var Agents = ["Android", "iPhone",
            "SymbianOS", "Windows Phone",
            "iPad", "iPod"];
        var flag = true;
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) {
                flag = false;
                break;
            }
        }
        return flag;
    };
</script>
