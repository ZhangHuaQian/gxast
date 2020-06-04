<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
    <title>新型冠状病毒防控科普知识网络答题</title>
    <link rel="stylesheet" href="${ctx}resource/css/weui.css">
    <link rel="stylesheet" href="${ctx}resource/css/weuix.css">
    <script src="${ctx}resource/js/zepto.min.js"></script>
    <script src="${ctx}resource/js/zepto.weui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/clipboard@2/dist/clipboard.min.js"></script>
</head>
<style>
    body{
        margin: 0px;
        background-image: url('${ctx}resource/images/gxkx/kx_bjt.png');
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
        width: 65vw;

        margin: auto;

        margin-top: 51vh;


    }
    .button-goto{
        width: 60vw;
    }
    .content{
        padding: 5% 1px;
        clear:both;
        overflow:hidden;
        min-height: 5vh;
        color: red;
        font-size: 16px;
        background:rgba(255,255,255,1);
        border:6px solid rgba(116,225,185,1);
        border-radius:20px;

    }
    .content p{
        line-height: 2.5;
        text-align: center;
    }
    .mess {
        margin-top: 50px;
        /*background:rgba(255,255,255,1);*/
        /*border:6px solid rgba(116,225,185,1);*/
        /*border-radius:20px;*/
        min-height: 30vh;
        width: 80vw;
        /*margin-left: -14%;*/
    }
    .mess_p {
        padding: 20px;
        font-size: 12px;
    }
</style>
<body>
<div class="body">
    <div class="body col-xs-4">
        <div class="content">
            <p id="code" class="code" data-clipboard-target="#code">没有全部答对，再来一次</p>
        </div>

    </div>
    <div class="mess">
        <div class="btn col-xs-2" >

            <a href="gzbd_contest.jsp?openid=${param.openid}">
                <img class="button-goto" src="${ctx}resource/images/gxkx/zlycan.png">
            </a>

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