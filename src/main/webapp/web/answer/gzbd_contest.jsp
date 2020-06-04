<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes"/>
    <title>新型冠状病毒防控科普知识网络答题</title>
    <link rel="stylesheet" href="${ctx}resource/css/weui.css">
    <link rel="stylesheet" href="${ctx}resource/css/weuix.css">
    <script src="${ctx}resource/js/zepto.min.js"></script>
    <script src="${ctx}resource/js/zepto.weui.js"></script>
</head>
<style>
    body {
        margin: 0px;
        background-image: url('${ctx}resource/images/answer/xxgzbd_content_bg.png');
        top: 0;
        left: 0;
        z-index: -10;
        zoom: 1;
        background-color: #fff;
        background-repeat: no-repeat;
        background-size: 100% 100%;
        -webkit-background-size: 100% 100%;
        -o-background-size: 100% 100%;
        background-position: center 0;
        height: unset;
        background-attachment:fixed;
    }

    .body {
        width: 90%;
        background-color: white;
        margin: auto;
        margin-top: 51vh;
        border-radius: 15px;
    }

    .content {
        padding: 5% 15px;
        clear: both;
        /*overflow: hidden;*/
        max-height: 42vh;
        min-height: 10rem;
        overflow: scroll;
    }

    #title {
        line-height: 1.2;
        font-size: 18px;
        min-height: 3vh;
    }

    .button-group {
        padding: 1rem 20px;
        padding-bottom: 0;
    }

    .button-group .weui-btn {
        border-bottom: 1px solid rgba(0, 0, 0, 0.2);
        border-radius: 25px 25px 25px 25px;
        color: #666666;
        text-align: left;
        /*text-indent: 1rem;*/
        display: block;
        line-height: 6.5vw;
        font-size: 4.5vw;
        min-height: 10vw;
    }

    .button-group .weui-btn:after {
        border: 0px;
    }

    .tishi p {
        margin: 5px 0px;
    }

    .button-again{
        width: 60vw;
    }
    #again{
        display: none;
        text-align: center;
        margin-top: 50px;
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
        <div id="again">
            <a href="javascript:void(0);" onclick="again()">
                <img class="button-again" src="${ctx}resource/images/answer/again_btn.png">
            </a>
        </div>
    </div>
</div>
</body>
</html>
<script>
    var questionList
    var questionIndex = 0
    var questionAnswer = {
        openid: '',
        data: []
    }
    $(function () {
        $.showLoading()
        $.ajax({
            type: "get",
            url: "${ctx}appsite/gzbdContest/selectByUid?openid="+'${param.openid}',
            dataType: "json",
            success: function (result) {
                $.hideLoading()
                if (result.status == "0") {
                    $.toast.prototype.defaults.duration = 3000
                    $.toast(result.msg, "cancel");
                } else {
                    if (result.code) {
                        window.location.href = 'gzbd_end.jsp?code=' + result.code + '&msg=' + result.msg
                    } else {
                        if (!result.data) {
                            $('#options').remove()
                            $.toast.prototype.defaults.duration = 3000
                            $('#title').html('<span style="color: red">'+result.msg+'</span>')
                            return false
                        } else {
                            questionList = result.data.data
                            questionAnswer.openid = '${param.openid}'
                            setQuestion()
                        }
                    }
                }

            },
            error: function (msg) {
                $.hideLoading()
                console.log(msg)
                console.log("网络连接错误，请检查网络后重试");
            },
        });
    })

    function again() {
        window.location.reload();
    }

    function choose(e) {
        var answerItem = {
            itemId: questionList[questionIndex].id,
            uKey: $(e).attr('value')
        }
        questionAnswer.data.push(answerItem)
        questionIndex++
        if (questionIndex > 2) {
            var lock = false;
            $.confirm("您确定要提交所有答案吗?（取消可重新答题）", "确认提交?", function() {
                $.showLoading()
                if(!lock){ //防止用户多次点击
                    lock = true;
                    $.ajax({
                        type: "post",
                        url: "${ctx}appsite/gzbdContest/insert",
                        contentType:'application/json;charset=utf-8',
                        dataType: "json",
                        data: JSON.stringify(questionAnswer),
                        success: function (result) {
                            $.hideLoading()
                            $('#options').remove()
                            if (result.status == "1" || result.status == "2") {
                                window.location.href = 'gzbd_end.jsp?code=' + result.code + '&msg=' + result.msg

                                // else if (result.status == "2") {
                                //         $.toast.prototype.defaults.duration = 3000
                                //         $('#title').html('<span style="color: red">'+result.code+'</span>')
                                //     }
                            } else {
                                $.toast.prototype.defaults.duration = 3000
                                $('#title').html('<span style="color: red">'+result.msg+'</span>')
                                $("#again").css("display","block");
                            }
                        },
                        error: function (msg) {
                            $.hideLoading()
                            $.toast("网络连接错误", "cancel");
                            console.log(msg)
                            console.log("网络连接错误，请检查网络后重试");
                        },
                    });
                }
            }, function() {
                questionIndex = 0
                questionAnswer.data = []
                setQuestion()
            })
        } else {
            setQuestion()
        }
    }

    function setQuestion() {
        $('#options').find('a').eq(2).remove()
        questionID = questionList[questionIndex].id
        $('#title').html(questionList[questionIndex].item)
        $('#options').find('a').eq(0).html(questionList[questionIndex].optionA)
        $('#options').find('a').eq(1).html(questionList[questionIndex].optionB)
        if (questionList[questionIndex].optionC) {
            $('#options').append('<a class="weui-btn weui-btn_default" value="C" onclick="choose(this)">' + questionList[questionIndex].optionC + '</a>')
        }
    }
</script>