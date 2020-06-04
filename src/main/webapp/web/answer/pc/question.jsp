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
        width: 55%;
        border: 1px solid #58C8F7;
    }
    .question{
        padding: 5% 5%;
    }
    .title{
        color: white;
        font-size: 20px;
    }
    .options{
        margin-top: 5%;
        text-align: center;
    }
    .layui-btn{
        width: 50%;
        color: black;
        font-size: 18px;
        background:rgba(255,255,255,1);
        border:2px solid rgba(255,255,255,1);
        opacity:0.6;
        border-radius:5px;
    }
    .checked{
        background:rgba(76,150,234,1);
        border:2px solid rgba(255,255,255,1);
        border-radius:6px;
    }
    .options .layui-row{
        margin: 25px 0px;
    }
</style>
<body>
    <div class="body">
        <div class="question">
            <div class="layui-row">
                <div class="title" id="title">
                    <p></p>
                </div>
            </div>
            <div class="layui-row">
                <div class="options" id="options">

                </div>
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
        history.pushState(null, null, '${ctx}web/answer/pc/xczx_index.jsp');
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
            $('#title p').html((num+1)+'.'+question.content)
            for (var i = 0; i <options.length ; i++) {
                var n = 'op'+(i+1)
                var option = '<div class="layui-row">' +
                    '           <button type="button" onclick="choose(this)"' +
                    ' class="layui-btn layui-btn-primary" qid="'+question.id+'" optionNum="'+n+'">'+JSON.parse(options[i])[n]+'</button>' +
                    '         </div>'
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
                        layui.msg(data.msg);
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