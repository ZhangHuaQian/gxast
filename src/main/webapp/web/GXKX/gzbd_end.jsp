<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
    <title>2020全国科技工作者日</title>
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
        width: 80vw;

        margin: auto;

        margin-top: 51vh;


    }
    .content{
        padding: 5% 1px;
        clear:both;
        overflow:hidden;
        min-height: 5vh;
        color: red;
        font-size: 5vw;
        background:rgba(255,255,255,1);
        border:3px solid rgba(116,225,185,1);
        border-radius:15px;

    }
    .content p{
        line-height: 2.5;
        text-align: center;
    }
    .mess {
        margin-top: 10px;
        background:rgba(255,255,255,1);
        border:3px solid rgba(116,225,185,1);
        border-radius:15px;
        min-height: 30vh;
        width: 90vw;
        margin-left: -7.4%;
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

            <p id="code" class="code" data-clipboard-target="#code">${param.code}</p>
            <p id="code2" class="code" style="font-size: 90%;" data-clipboard-target="#code">${param.msg}</p>

        </div>


    </div>
    <div class="mess">
        <p style="padding-top:10px;padding-left:5px;font-weight: 600">领奖方法</p>
        <p class="mess_p">
            <span style="display: block;font-size: 14px;font-weight: 600">1.长按上方方框中的红包口令编码，选择复制；</span>
            <span style="display: block;font-size: 14px;font-weight: 600">2.将该口令编码发送给“大众科普”微信公众号；</span>
            <span style="display: block;font-size: 14px;font-weight: 600">3.收到中奖信息，点击领取，红包即可入账；</span>
            <span style="display: block;font-size: 14px;font-weight: 600">4.活动期间每天红包数量有限，领完即止。</span>




        </p>
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