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
</head>
<style>
    body{
        margin: 0px;
        background-image: url('${ctx}resource/images/answer/cdlshb_content_bg.png');
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
        background-color: white;
        margin: auto;
        margin-top: 40vh;
        border-radius: 15px;
    }
    .content{
        padding: 5% 15px;
        clear:both;
        overflow:hidden;
        min-height: 14rem;
    }
    #title{
        line-height: 1.5;
        font-size: 18px;
        min-height: 8vh;
    }
    .button-group{
        padding: 1rem 20px;
        padding-bottom: 0;
    }
    .button-group .weui-btn{
        border-bottom: 1px solid rgba(0, 0, 0, 0.2);
        border-radius: 25px 25px 25px 25px;
        color: #666666;
        text-align: left;
        text-indent:1rem;
        display: block;
        line-height: 2rem;
        font-size: 1rem;
    }
    .button-group .weui-btn:after{
        border: 0px;
    }
    .tishi p{
        margin: 5px 0px;
    }
</style>
<body>
<div class="body">
    <div class="content">
        <div class="weui-flex">
            <div class="weui-flex__item"><p id="title"></p></div>
        </div>
        <div class="button-group" id="options">
            <a class="weui-btn weui-btn_default" value="A" onclick="choose(this)"></a>
            <a class="weui-btn weui-btn_default" value="B" onclick="choose(this)"></a>
            <a class="weui-btn weui-btn_default" value="C" onclick="choose(this)"></a>
            <a class="weui-btn weui-btn_default" value="D" onclick="choose(this)"></a>
        </div>
    </div>
</div>
</body>
</html>
<script>
    var questionID
    $(function () {
        $.hideLoading()
        $.ajax({
            type: "get",
            url: "${ctx}appsite/kpzsContestRecord/selectByUid?openid="+'${param.openid}',
            dataType: "json",
            success: function(result) {
                $.hideLoading()
                if (result.status == "0"){
                    $.toast.prototype.defaults.duration=3000
                    $.toast(result.msg, "cancel");
                } else {
                    if (result.code){
                        window.location.href = 'kpzs_end.jsp?code='+result.code+'&msg='+result.msg
                    } else {
                        if (!result.data) {
                            $('#options').remove()
                            $.toast.prototype.defaults.duration=3000
                            $('#title').html(result.msg)
                            return false
                        } else {
                            var data = result.data.data
                            questionID = data[0].id
                            $('#title').html(data[0].item)
                            $('#options').find('a').eq(0).html(data[0].optionA)
                            $('#options').find('a').eq(1).html(data[0].optionB)
                            $('#options').find('a').eq(2).html(data[0].optionC)
                            $('#options').find('a').eq(3).html(data[0].optionD)
                        }
                    }
                }

            },
            error: function(msg) {
                $.hideLoading()
                console.log(msg)
                console.log("网络连接错误，请检查网络后重试");
            },
        });
    })

    function choose(e) {
        var getdata = {
            itemId:questionID,
            uKey:$(e).attr('value'),
            openid: '${param.openid}'
        }
        $.confirm("您确定要提交此选项吗?", "确认选项?", function() {
            $.showLoading()
            $.ajax({
                type: "post",
                url: "${ctx}appsite/kpzsContestRecord/insert",
                // ContentType:'application/json;charset=utf-8',
                dataType: "json",
                data: getdata,
                success: function(result) {
                    $.hideLoading()
                    $('#options').remove()
                    if (result.status == "1"){
                        window.location.href = 'kpzs_end.jsp?code='+result.code+'&msg='+result.msg
                    }else if (result.status == "2") {
                        $.toast.prototype.defaults.duration=3000
                        $.toast(result.code);
                    }else {
                        $.toast.prototype.defaults.duration=3000
                        $.toast(result.msg, "cancel");
                    }
                },
                error: function(msg) {
                    $.hideLoading()
                    $.toast("网络连接错误", "cancel");
                    console.log(msg)
                    console.log("网络连接错误，请检查网络后重试");
                },
            });

        }, function() {
            //取消操作
        })
    }
</script>