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
        width: 90%;
        margin: auto;
        border-radius: 15px;
        text-align: center;
        margin-top: 37vh;
    }
    .button-goto{
        width: 60vw;
    }
    @media screen and (max-width: 700px) {
        .body {
            margin-top: 75vh;
        }
    }
    @media screen and (min-width: 701px) {
        .body {
            margin-top: 65vh;
        }
    }

    .box {
        margin-top: 50vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .mess {
        background:rgba(255,255,255,1);
        border:6px solid rgba(116,225,185,1);
        border-radius:20px;
        height:15vh;
        padding:50px

    }
    .mess p{
        color:#7093C2 ;
    }


</style>
<body>
<div class="body">

    <div class="container">
        <div class="row">
            <div class="box col-xs-12" >
                <div class="mess col-xs-10" >
                    <p>时间：5月30日-6月5日</p>
                    <p>主办：广西壮族自治区科学技术协会</p>
                    <p>承办：广西科学技术普及传播中心</p>
                </div>

            </div>
            <div class="btn col-xs-2" >

                    <a href="gzbd_contest.jsp?openid=${param.openid}">
                        <img class="button-goto" src="${ctx}resource/images/gxkx/ksdtan.png">
                    </a>

            </div>
        </div>
    </div>

</div>
</body>
</html>
<script>
</script>