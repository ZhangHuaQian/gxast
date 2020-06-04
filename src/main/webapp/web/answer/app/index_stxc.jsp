<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
    <title>广西“生态乡村”网络知识竞赛</title>
    <link rel="stylesheet" href="${ctx}resource/css/weui.css">
    <link rel="stylesheet" href="${ctx}resource/css/weuix.css">
    <script src="${ctx}resource/js/zepto.min.js"></script>
    <script src="${ctx}resource/js/zepto.weui.js"></script>
</head>
<style>
    body{
        margin: 0px;
        background-image: url('${ctx}resource/images/answer/index_bg_stxc.png');
        top: 0;
        left: 0;
        z-index:-10;
        zoom: 1;
        background-color: #fff;
        background-repeat: no-repeat;
        background-size: 100% 100%;
        -webkit-background-size: 100% 100%;
        -o-background-size: 100% 100%;
        background-position: center 0;
        height: unset;
    }
    .body {
        width: 90%;
        margin: auto;
        border-radius: 15px;
        text-align: center;
        margin-top: 80%;
    }
    .button-goto{
        width: 40%;
        height: 40%
    }
    @media screen and (max-width: 700px) {
        .body {
            margin-top: 80%;
        }
    }
    @media screen and (min-width: 701px) {
        .body {
            margin-top: 60%;
        }
    }

</style>
<body>
<div class="body">
    <a href="contest.jsp?openid=${param.openid}">
        <img class="button-goto" src="${ctx}resource/images/answer/button_stxc.png">
    </a>
</div>
</body>
</html>
<script>
</script>