<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
    <title>答题结束</title>
    <link rel="stylesheet" href="${ctx}resource/css/weui.css">
    <link rel="stylesheet" href="${ctx}resource/css/weuix.css">
    <script src="${ctx}resource/js/zepto.min.js"></script>
    <script src="${ctx}resource/js/zepto.weui.js"></script>
</head>
<style>
    body{
        margin: 0px;
        background-image: url('${ctx}resource/images/answer/beij3.png');
        background-size: 100% 100%;
    }
    .body{
        background-color: white;
        display: block;
        margin: 45% 20px 20px 20px;
        border-radius: 15px;
        height: 46.5%;
    }
    .jiangbei{
        width: 55%;
        position: absolute;
        top: 15%;
        left: 22.5%;
    }
    .end{
        width: 40%;
        position: absolute;
        top: 44%;
        left: 30%;
    }
    .end-text{
        position: absolute;
        top: 51.5%;
        left: 20%;
        color: #666666;
    }
    #back{
        width: 89.5%;
        text-align: center;
        position: absolute;
        top: 60%;
    }
    #back img{
        width: 60%;
    }

</style>
<body>
    <div class="body">
        <div class="weui-flex">
            <img class="jiangbei" src="${ctx}resource/images/answer/jiangbei.png">
        </div>
        <div class="weui-flex">
            <img class="end" src="${ctx}resource/images/answer/end.png">
        </div>
        <div class="weui-flex">
            <p class="end-text">你已经答题成功，感谢您的参与！</p>
        </div>
        <div class="weui-flex">
            <a id="back" href="personal.jsp">
                <img src="${ctx}resource/images/answer/fanh_nor.png">
            </a>
        </div>
    </div>
</body>
</html>
