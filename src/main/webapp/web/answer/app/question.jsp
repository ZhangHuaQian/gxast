<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
    <title>问题</title>
    <link rel="stylesheet" href="${ctx}resource/css/weui.css">
    <link rel="stylesheet" href="${ctx}resource/css/weuix.css">
    <script src="${ctx}resource/js/zepto.min.js"></script>
    <script src="${ctx}resource/js/zepto.weui.js"></script>
</head>
<style>
    body{
        width: 100%;
        margin: 0px;
        background-image: url('${ctx}resource/images/answer/beij3.png');
        position:fixed;
        top: 0;
        left: 0;
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
        background-color: white;
        display: block;
        margin: 26% 20px 20px 20px;
        border-radius: 15px;
    }
    .content{
        padding: 10% 15px;
        clear:both;
        overflow:hidden;
    }
    #title{
        line-height: 1.5;
    }
    .button-group{
        padding: 2rem 20px;
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
    .weui-btn.checked{
        border: 2px solid #4879FA;
        color: #4879FA;
    }
    .arrow {
        position: absolute;
        top: -70px;
        width: 0px;
        left: 40%;
        height: 0px;
        font-size: 0;
        border: solid 35px;
        border-color: #ffffff00 #ffffff00 white #ffffff00;
    }
    /*.box{*/
    /*    !* 最外层的盒子 *!*/
    /*    width:50px;*/
    /*    height:50px;*/
    /*    margin: 0 auto;*/
    /*    overflow: hidden;*/
    /*    border-radius: 50%;*/
    /*    background-color: #FF2811;*/
    /*    position: absolute;*/
    /*    left: 43%;*/
    /*    top: -35px;*/
    /*    z-index: 10;*/
    /*}*/
    /*.left_box,.right_box{*/
    /*    !**/
    /*      左右两边用于 隐藏 旋转的div的盒子*/
    /*      通过overflow来隐藏内部div旋转出去的部分*/
    /*    *!*/
    /*    position: absolute;*/
    /*    top: 0;*/
    /*    width:25px;*/
    /*    height:50px;*/
    /*    overflow: hidden;*/
    /*    z-index: 1;*/
    /*}*/
    /*.left_box{*/
    /*    left: 0;*/
    /*}*/
    /*.right_box{*/
    /*    right: 0;*/
    /*}*/
    /*.left_item,.right_item{*/
    /*    !**/
    /*     这是需要旋转的div(没有被mask遮盖展示出来的部分作为倒计时的线条)*/
    /*     为了方便理解，下面用deeppink和cyan分别设置了左右两边div的颜色*/
    /*    *!*/
    /*    width: 25px;*/
    /*    height: 50px;*/
    /*}*/
    /*.left_item{*/
    /*    !**/
    /*     1.设置圆角，圆角大小为高度的一半*/
    /*     2.这只旋转的中心店，这是左边圆，中心点设置到右边中心点，右边圆则设置到左边中心点*/
    /*     *!*/
    /*    border-top-left-radius: 25px;*/
    /*    border-bottom-left-radius: 25px;*/
    /*    -webkit-transform-origin: right center;*/
    /*    transform-origin: right center;*/
    /*    -webkit-animation: loading_left 3s linear;*/
    /*    background-color: #D2D2D2;*/
    /*}*/
    /*.right_item{*/
    /*    border-top-right-radius: 25px;*/
    /*    border-bottom-right-radius: 25px;*/
    /*    -webkit-transform-origin: left center;*/
    /*    transform-origin: left center;*/
    /*    -webkit-animation: loading_right 3s linear;*/
    /*    background-color: #D2D2D2;*/
    /*}*/
    /*.mask{*/
    /*    !* 遮住div多余的部分，呈现出线条的效果 *!*/
    /*    position: absolute;*/
    /*    top: 5px;*/
    /*    left: 5px;*/
    /*    right: 5px;*/
    /*    bottom: 5px;*/
    /*    z-index: 2;*/
    /*    border-radius: 50%;*/
    /*    background-color: #fff;*/
    /*    text-align: center;*/
    /*    line-height: 2.3;*/
    /*    font-size: 18px;*/
    /*}*/
    /*@-webkit-keyframes loading_left{*/
    /*    0%{*/
    /*        -webkit-transform: rotate(0deg);*/
    /*    }*/
    /*    50%{*/
    /*        -webkit-transform: rotate(0deg);*/
    /*    }*/
    /*    100%{*/
    /*        -webkit-transform: rotate(180deg);*/
    /*    }*/
    /*}*/
    /*@-webkit-keyframes loading_right{*/
    /*    0%{*/
    /*        -webkit-transform: rotate(0deg);*/
    /*    }*/
    /*    50%{*/
    /*        -webkit-transform: rotate(180deg);*/
    /*    }*/
    /*    100%{*/
    /*        -webkit-transform: rotate(180deg);*/
    /*    }*/
    /*}*/
</style>
<body>
    <div class="body">
        <div class="content">
            <div class="weui-flex">
                <div class="weui-flex__item"><h4 style="color: #4879FA" id="count"></h4></div>
            </div>
            <div class="weui-flex">
                <div class="weui-flex__item"><p id="title"></p></div>
            </div>
            <div class="button-group" id="options">

            </div>
        </div>

    </div>
</body>
</html>
<script>
    var list = []
    var Qnum = 0
    var answer = []
    var uid = ''
    $(function () {
        window.addEventListener('pageshow', function(e) {
            if (e.persisted) {
                location.reload();
            }
        })
        history.pushState(null, null, '${ctx}web/answer/app/xczx_index.jsp');
        window.addEventListener('popstate', function(e) {
            history.pushState(null, null, document.URL);
        })
        uid = ${param.uid}
            $.ajax({
                type: "get",
                url: "${ctx}appsite/itemBank/selectAll",
                dataType: "json",
                success: function(data) {
                    console.log(data)
                    list = data.data.data
                    getOption(Qnum)
                },
                error: function(msg) {
                    console.log(msg)
                    console.log("网络连接错误，请检查网络后重试");
                },
            });
    })

    function getOption(num) {
        $('#options').empty()
        if (list[num]){
            var question = list[num]
            var options = question.options.substring(1,question.options.length-1).split(',')
            $('#title').html(question.content)
            $('#count').html((num+1)+'/50选择题(单选题)')
            for (var i = 0; i <options.length ; i++) {
                var n = 'op'+(i+1)
                var option = '<a class="weui-btn weui-btn_default" onclick="choose(this)" qid="'+question.id+'" optionNum="'+n+'">'+JSON.parse(options[i])[n]+'</a>'
                $('#options').append(option)
            }
        }else{
            var data = {
                answer:answer,
                uid:uid
            }
            console.log(data)
            $.ajax({
                type: "post",
                url: "${ctx}appsite/itemBank/submit",
                ContentType:'application/json;charset=utf-8',
                dataType: "json",
                data: {
                    data:JSON.stringify(data)
                },
                success: function(data) {
                    if (data.status == 1) {
                        window.location.href = 'xczx_end.jsp'
                    }else{
                        $.toast(data.msg, "cancel");
                    }
                },
                error: function(msg) {
                    console.log(msg)
                    console.log("网络连接错误，请检查网络后重试");
                },
            });

        }
    }

    function choose(e) {
        var getdata = {
            qid:$(e).attr('qid'),
            option:$(e).attr('optionNum')
        }
        answer.push(getdata)
        Qnum++
        getOption(Qnum)
    }
</script>