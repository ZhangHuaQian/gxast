<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
    <title>“倡导绿色环保生活”科普知识挑战赛</title>
    <link rel="stylesheet" href="${ctx}resource/css/weui.css">
    <link rel="stylesheet" href="${ctx}resource/css/weuix.css">
    <script src="${ctx}resource/js/zepto.min.js"></script>
    <script src="${ctx}resource/js/zepto.weui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/clipboard@2/dist/clipboard.min.js"></script>
</head>
<style>
    body{
        margin: 0px;
        background-image: url('${ctx}resource/images/answer/cdlshb_end_bg.png');
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
        width: 65%;
        background-color: white;
        margin: auto;
        margin-top: 40vh;
        border-radius: 15px;
    }
    .content{
        padding: 5% 15px;
        clear:both;
        overflow:hidden;
        min-height: 10vh;
        color: red;
        font-size: 7vw;
    }
    .content p{
        line-height: 2.5;
        text-align: center;
    }

</style>
<body>
<div class="body">
    <div class="body">
        <div class="content">
            <p id="code" class="code" data-clipboard-target="#code">${param.code}</p>
        </div>
    </div>
</div>
</body>
</html>
<script>
    $(function () {
        $.toast('${param.msg}')
        $.toast.prototype.defaults.duration=1500
        var clipboard = new ClipboardJS('#code')
        clipboard.on('success', function(e) {
            $.toast('复制成功!')
            e.clearSelection();
        });
    })
</script>