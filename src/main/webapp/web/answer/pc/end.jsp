<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>广西青少年科普知识竞赛</title>
</head>
<style>
    body{
        margin: 0px;
        background: url('${ctx}resource/images/answer/pc/PCbeij.png');
        position:fixed;
        top: 0;
        left: 0;
        width:100%;
        height:100%;
        min-width: 1000px;
        z-index:-10;
        zoom: 1;
        background-color: #fff;
        background-repeat: no-repeat;
        background-size: cover;
        -webkit-background-size: cover;
        -o-background-size: cover;
        background-position: center 0;
    }
    .body{
        background-color: rgba(76, 150, 234, 0.6);
        margin: auto;
        margin-top: 17%;
        border-radius: 5px;
        height: 47%;
        width: 50%;
        border: 1px solid #58C8F7;
    }
    .layui-row{
        text-align: center;
    }
    .jiangbei{
        margin: 2.5% 0px;
    }
    .end{
        margin: 2% 0px;
    }
    .end .layui-row{
        margin: 15px 0px;
    }
    .back-button{
        margin: 5% 0px;
    }
    .jiangbei img{
        width: 265px;
        height: 190px;
    }
    .end img{
        width: 190px;
        height: 45px;
    }
    .end p{
        color: white;
        font-size: 18px;
    }
    #endButton{
        background-color: #FEDD26;
        color: #CF7C1F;
        width: 200px;
        height: 40px;
        border-radius: 5px;
    }
</style>
<body>
<div class="body">
    <div class="jiangbei">
        <div class="layui-row">
            <img src="${ctx}resource/images/answer/pc/Djiangbei.png">
        </div>
    </div>
    <div class="end">
        <div class="layui-row">
            <img src="${ctx}resource/images/answer/pc/Ddati.png">
        </div>
        <div class="layui-row">
            <p>你已经答题成功，感谢您的参与！</p>
        </div>
    </div>
    <div class="back-button">
        <div class="layui-row">
            <button class="layui-btn" id="endButton">返回首页</button>
        </div>
    </div>
</div>
</body>
</html>
<script>
    $(function () {
        $('#endButton').click(function () {
            window.location.href = 'personal.jsp'
        })
    })
</script>