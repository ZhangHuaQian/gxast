<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport"content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>个人信息填写</title>
    <link rel="stylesheet" href="${ctx}resource/css/weui.css">
    <link rel="stylesheet" href="${ctx}resource/css/weuix.css">
    <script src="${ctx}resource/js/zepto.min.js"></script>
    <script src="${ctx}resource/js/zepto.weui.js"></script>
</head>
<style>
    body{
        margin: 0px;
        background-image: url('${ctx}resource/images/answer/beij2.png');
        top: 0;
        left: 0;
        z-index:-10;
        zoom: 1;
        background-color: #fff;
        background-repeat: no-repeat;
        background-size: 100% 125%;
        -webkit-background-size: 100% 125%;
        -o-background-size: 100% 125%;
        background-position: center 0;
        height: unset;
    }
    .body {
        width: 90%;
        background-color: white;
        margin: auto;
        margin-top: 70%;
        border-radius: 15px;
    }
    @media screen and (max-height: 750px) {
        .body {
            margin-top: 65%;
        }
    }
    @media screen and (min-height: 751px) {
        .body {
            margin-top: 90%;
        }
    }
    .footer-content{
        margin-top: 10px;
        font-size: 14px;
        text-align: center;
        color: #e4e4e4;
    }
    .weui-form{
        height: 78%;
        padding: 2.5%;
    }
    .weui-form-li{
        margin: 10px 20px 10px 15px;
        display: flex;
    }
    .weui-flex{
        width: 100%;
    }
    .inf-title{
        margin-right: 15px;
        line-height: 35px;
        flex: 0.9;
        color: #686868;
        text-align: right;
    }
    .inf-input{
        flex: 2.5;
    }
    .inf-input input{
        border: 0px;
        background-color: #F0F7FC;
    }
    .submit img{
        height: 14%;
        width: 64%;
    }
    .submit a{
        display: block;
        text-align: center;
    }
    .inf-title{
        font-size: 12px;
    }
    .allcontent{

    }
</style>
<body>
<div class="allcontent">
    <div class="body">
     <form>
         <div class="weui-form">
             <div class="weui-form-li">
                 <div class="weui-flex">
                     <div class="weui-flex__item inf-title"><span>姓名</span></div>
                     <div class="weui-flex__item inf-input"><input type="text" class="weui-form-input" name="sName" ></div>
                 </div>
             </div>
             <div class="weui-form-li">
                 <div class="weui-flex">
                     <div class="weui-flex__item inf-title"><span>学校名称</span></div>
                     <div class="weui-flex__item inf-input"><input type="text" class="weui-form-input" name="school" ></div>
                 </div>
             </div>
             <div class="weui-form-li">
                 <div class="weui-flex">
                     <div class="weui-flex__item inf-title"><span>年级/班级</span></div>
                     <div class="weui-flex__item inf-input"><input type="text" class="weui-form-input" name="sClass" ></div>
                 </div>
             </div>
             <div class="weui-form-li">
                 <div class="weui-flex">
                     <div class="weui-flex__item inf-title"><span>指导老师</span></div>
                     <div class="weui-flex__item inf-input"><input type="text" class="weui-form-input" name="tName" ></div>
                 </div>
             </div>
             <div class="weui-form-li">
                 <div class="weui-flex">
                     <div class="weui-flex__item inf-title"><span>手机号码</span></div>
                     <div class="weui-flex__item inf-input"><input type="number" class="weui-form-input" name="tTel" ></div>
                 </div>
             </div>
             <div class="weui-form-li">
                 <div class="weui-flex">
                     <div class="weui-flex__item inf-title"><span>联系地址</span></div>
                     <div class="weui-flex__item inf-input"><input type="text" class="weui-form-input" name="address"></div>
                 </div>
             </div>
         </div>
     </form>
     <div class="submit">
         <a id="submit">
             <img src="${ctx}resource/images/answer/dat_nor.png">
         </a>
     </div>
    </div>
    <div class="footer-content">
     <p>主办单位：广西科学技术协会</p>
     <p>承办单位：广西科学技术普及传播中心</p>
     <p>活动时间：2019年11月15日-12月15日</p>
    </div>
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
        $('#submit').click(function () {
            var telnum = $('form').find('input[name="tTel"]').val()
            if (telnum.length<11) {
                $.toast("手机号码格式错误！", "cancel");
                return false;
            }
            if (checkNull()) {
                $.confirm("确定提交吗?", "确认提交", function() {
                    $.ajax({
                        type: "POST",
                        url: "${ctx}appsite/itemBank/selectUserInfo",
                        data: $('form').serialize(),
                        async: false,
                        dataType: "json",
                        success: function(data) {
                            switch (data.status) {
                                case 0:
                                    window.location.href = 'question.jsp?uid='+ data.uId
                                case 1:
                                    $.toast(data.msg);
                            }
                        },
                        error: function(msg) {
                            console.log(msg)
                            // console.log("网络连接错误，请检查网络后重试");
                        },
                    });

                }, function() {
                    //取消操作
                });
            }
        })
    })

    function checkNull() {
        if (!$('input[name="sName"]').val()){
            $.toast('姓名不能为空','cancel');
            return false
        }
        if (!$('input[name="tName"]').val()){
            $.toast('指导老师不能为空','cancel');
            return false
        }
        if (!$('input[name="tTel"]').val()){
            $.toast('手机号码不能为空','cancel');
            return false
        }
        if (!$('input[name="school"]').val()){
            $.toast('学校名称不能为空','cancel');
            return false
        }
        if (!$('input[name="sClass"]').val()){
            $.toast('班级/年级不能为空','cancel');
            return false
        }
        if (!$('input[name="address"]').val()){
            $.toast('联系地址不能为空','cancel');
            return false
        }
        return true
    }

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
