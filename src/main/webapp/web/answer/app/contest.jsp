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
    <script src="https://cdn.jsdelivr.net/npm/clipboard@2/dist/clipboard.min.js"></script>
</head>
<style>
    body{
        margin: 0px;
        background-image: url('${ctx}resource/images/answer/shengtai_bg.png');
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
        margin-top: 45%;
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
        min-height: 7rem;
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
        line-height: 2.5rem;
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
        </div>
    </div>
</div>
</body>
</html>
<script>
    var questionID
    $(function () {
        $.ajax({
            type: "get",
            url: "${ctx}appsite/stxcContestReconrd/selectByUid?openid="+'${param.openid}',
            dataType: "json",
            success: function(result) {
                if (result.status == "0"){
                    $('#options').remove()
                    $.toast.prototype.defaults.duration=3000
                    $.toast(result.msg, "cancel");
                } else {
                    if (result.code){
                        $('#options').remove()
                        $.prompt({
                            title: '您已回答过此题！',
                            text: '(请复制文本内容领取红包！)',
                            input: result.code,
                            empty: false, // 是否允许为空
                            onOK: function (input) {
                                //点击确认
                                window.location.href('index_stxc.jsp?openid="+\'${param.openid}')
                            },
                            onCancel: function () {
                                //点击取消
                                window.location.href('index_stxc.jsp?openid="+\'${param.openid}')
                            }
                        })
                        var tishi = '<div class="tishi" style="\n' +
                            '    text-align: left;margin-top: 15px\n' +
                            '"><p style="\n' +
                            '    text-align: center;\n' +
                            '">领红包提示</p>\n' +
                            '<p>1.点击复制，即可复制兑换编码。</p>\n' +
                            '<p style="margin-bottom: 0px">2.在南方农事公众号下面的编辑框粘</p><p style="\n' +
                            '    text-indent: 0.8em;margin: 0px\n' +
                            '">贴兑奖编码，点击发送。</p>\n' +
                            '       <p>3.点击弹出红包领取即可。</p></div>'
                        $('.weui-dialog__bd').append(tishi)
                        $('.weui-dialog__btn.primary').html('复制')
                        $('.weui-dialog__btn.primary').attr('data-clipboard-target','#weui-prompt-input')
                        new ClipboardJS('.weui-dialog__btn.primary');
                    } else {
                        if (!result.data) {
                            $('#options').remove()
                            $.toast.prototype.defaults.duration=3000
                            $.toast(result.msg);
                            return false
                        } else {
                            var data = result.data.data
                            questionID = data[0].id
                            $('#title').html(data[0].item)
                            $('#options').find('a').eq(0).html(data[0].optionA)
                            $('#options').find('a').eq(1).html(data[0].optionB)
                        }
                    }
                }

            },
            error: function(msg) {
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
                url: "${ctx}appsite/stxcContestReconrd/insert",
                // ContentType:'application/json;charset=utf-8',
                dataType: "json",
                data: getdata,
                success: function(result) {
                    $('#options').remove()
                    $.hideLoading()
                    if (result.status == "1"){
                        $.prompt({
                            title: '恭喜获得红包！',
                            text: '(请复制文本内容领取红包！)',
                            input: result.code,
                            empty: false, // 是否允许为空
                            onOK: function (input) {
                                //点击确认
                                window.location.href('index_stxc.jsp?openid="+\'${param.openid}')
                            },
                            onCancel: function () {
                                //点击取消
                                window.location.href('index_stxc.jsp?openid="+\'${param.openid}')
                            }
                        })
                        var tishi = '<div class="tishi" style="\n' +
                            '    text-align: left;margin-top: 15px\n' +
                            '"><p style="\n' +
                            '    text-align: center;\n' +
                            '">领红包提示</p>\n' +
                            '<p>1.点击复制，即可复制兑换编码。</p>\n' +
                            '<p style="margin-bottom: 0px">2.在南方农事公众号下面的编辑框粘</p><p style="\n' +
                            '    text-indent: 0.8em;margin: 0px\n' +
                            '">贴兑奖编码，点击发送。</p>\n' +
                            '       <p>3.点击弹出红包领取即可。</p></div>'
                        $('.weui-dialog__bd').append(tishi)
                        $('.weui-dialog__btn.primary').html('复制')
                        $('.weui-dialog__btn.primary').attr('data-clipboard-target','#weui-prompt-input')
                        new ClipboardJS('.weui-dialog__btn.primary');
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