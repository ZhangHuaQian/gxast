<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes"/>
    <title>2020全国科技工作者日</title>
    <link rel="stylesheet" href="${ctx}resource/css/weui.css">
    <link rel="stylesheet" href="${ctx}resource/css/weuix.css">
    <script src="${ctx}resource/js/zepto.min.js"></script>
    <script src="${ctx}resource/js/zepto.weui.js"></script>
</head>
<style>
    body {
        margin: 0px;
        background-image: url('${ctx}resource/images/gxkx/kx_bjt.png');
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
        background-attachment: fixed;
    }

    .body {
        width: 90%;
        background-color: white;

        /*background:rgba(255,255,255,1);*/
        border: 6px solid rgba(116, 225, 185, 1);
        border-radius: 20px;
        margin: auto;
        margin-top: 51vh;

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
        padding: 10px;
        /*text-align: center;*/
        /*text-indent: 1rem;*/
        display: block;
        line-height: 6.5vw;
        font-size: 4.5vw;
        min-height: 10vw;
        background: rgba(229, 229, 229, 1);
    }

    .button-group .weui-btn:after {
        border: 0px;
    }

    .tishi p {
        margin: 5px 0px;
    }

    .button-again {
        width: 60vw;
    }

    .button-next {
        width: 40vw;
    }

    #again {
        display: none;
        text-align: center;
        margin-top: 50px;
    }

    #next {
        display: none;
        text-align: center;
        margin-top: 33px;
    }


    .err {
        display: inline-block;
        width: 12px;
        height: 2px;
        background: red;
        line-height: 0;
        font-size: 0;
        vertical-align: middle;
        -webkit-transform: rotate(45deg);
    }

    .err:after {
        content: "/";
        display: block;
        width: 12px;
        height: 2px;
        background: red;
        -webkit-transform: rotate(-90deg);
    }

    .err, .succa {
        text-align: right;
    }


    .succa {
        display: inline-block;
        position: relative;
        width: 15px;
        height: 15px;
        border-radius: 50%;
        background-color: #2ac845;
    }

    .succa:before, .succa:after {
        content: '';
        pointer-events: none;
        position: absolute;
        color: white;
        border: 1px solid;
        background-color: white;
    }


    .succa:before {
        width: 1px;
        height: 1px;
        left: 25%;
        top: 50%;
        transform: skew(0deg, 50deg);
    }

    .succColor {
        color: #33CC66 !important;
    }

    .errColor {
        color: #FF3333 !important;
    }

    .succa:after {
        width: 3px;
        height: 1px;
        left: 45%;
        top: 42%;
        transform: skew(0deg, -50deg);
    }
    .test { pointer-events: none; }
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
        </div>
        <div id="again">
            <a href="javascript:void(0);" onclick="again()">
                <img class="button-again" src="${ctx}resource/images/gxkx/zlycan.png">
            </a>
        </div>
<%--        <div id="next">--%>
<%--            <a href="javascript:void(0);" onclick="next(this)">--%>
<%--                <img class="button-next" src="${ctx}resource/images/gxkx/xytan.png">--%>
<%--            </a>--%>
<%--        </div>--%>
    </div>
</div>
</body>
</html>
<script>
    var questionList
    var code
    var questionIndex = 0
    var questionAnswer = {
        openid: '',
        data: []
    }
    let data_a;
    $(function () {
        $.showLoading()
        $.ajax({
            type: "get",
            url: "${ctx}appsite/gzbdContest/selectByUid?openid=" + '${param.openid}',
            dataType: "json",
            success: function (result) {
                console.log(result)
                data_a=result;
                $.hideLoading()
                if (result.status == "0") {
                    $.toast.prototype.defaults.duration = 3000
                    $.toast(result.msg, "cancel");

                } else {
              if (result.code) {
                  code=result.code
                  console.log('4')
                  // questionList = result.data.data
                  console.log("questionList="+result.data[0])
                  questionAnswer.openid = '${param.openid}'
                  console.log("questionAnswer.openid="+questionAnswer.openid)
                  setQuestion()
              }
                        console.log('1')
                        if (!result.data) {
                            console.log('2')
                            $('#options').remove()
                            $.toast.prototype.defaults.duration = 3000
                            $('#title').html('<span style="color: red">' + result.msg + '</span>')
                            return false
                        } else {
                            console.log('3')
                            questionList = result.data.data
                            console.log("questionList="+result,)
                            questionAnswer.openid = '${param.openid}'
                            console.log("questionAnswer.openid="+questionAnswer.openid)
                            setQuestion()
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

    let i_js=-1;
    function choose(e) {
        // $("#next").css("display", "block");
        let istrue;
        console.log('hytgr',istrue)

        // 判断是否是被染色了
        for (let i = 0; i < e.classList.length; i++) {
            console.log(!(e.classList[i].indexOf('errColor')>-1|| e.classList[i].indexOf('succColor')>-1),istrue,'iods')
            if (!(e.classList[i].indexOf('errColor')>-1|| e.classList[i].indexOf('succColor')>-1)) {
                istrue = true;

            } else {
                istrue = false
            }
        }
        console.log(istrue,'kljkhgggf')
        console.log(data_a.data.data[0].rightKey,'p')

        i_js=i_js+1

        console.log(i_js,'89')
        let rightKey=data_a.data.data[i_js].rightKey;

        // 判断是否是正确答案
        if (e.getAttribute("value") == rightKey) {

            // 判断染色情况
            if (istrue) {
                console.log('zhixing',istrue)
                let text = e.innerHTML;
                text += `<i class="succa"></i>`
                e.innerHTML = text
                e.classList.add('succColor')


                istrue=!istrue
                console.log(istrue)
            } else {

                e.innerHTML = e.innerHTML
            }
        } else {
            // 选错了 查找正确答案的哪一项
            console.log()
            for (let i = 0; i < e.parentNode.children.length; i++) {
                console.log(e.parentNode.children[i].attributes.value.nodeValue == rightKey, '检测')
                //如果等于正确答案 该项就变绿
                if (e.parentNode.children[i].attributes.value.nodeValue == rightKey) {

                    for (let i = 0; i < e.classList.length; i++) {
                        console.log(!(e.classList[i].indexOf('errColor')>-1|| e.classList[i].indexOf('succColor')>-1),istrue,'iods')
                        if (!(e.classList[i].indexOf('errColor')>-1|| e.classList[i].indexOf('succColor')>-1)) {
                            istrue = true;

                        } else {
                            istrue = false
                        }
                    }

                    console.log(istrue,'2.2')

                    // 判断染色
                    if (istrue) {
                        console.log(istrue, 'panduan')
                        console.log('zhixing')
                        let text = e.parentNode.children[i].innerHTML;
                        text += `<i class="succa"></i>`
                        e.parentNode.children[i].innerHTML = text
                        e.parentNode.children[i].classList.add('succColor')


                    } else {
                        e.innerHTML = e.innerHTML

                    }

                }
            }

            //判断是否是被染色了
            for (let i = 0; i < e.classList.length; i++) {
                if (!(e.classList[i].indexOf('errColor')>-1|| e.classList[i].indexOf('succColor')>-1)) {
                    istrue = true;
                } else {
                    istrue = false
                }
            }
            console.log(istrue, 'ytrew')

            if (istrue) {
                let text = e.innerHTML;
                text += `<i class="err"></i>`
                e.innerHTML = text
                e.classList.add('errColor')

            } else {
                e.innerHTML = e.innerHTML
            }


        }

        var answerItem = {
            itemId: questionList[questionIndex].id,
            uKey: $(e).attr('value')
        }
        questionAnswer.data.push(answerItem)
        questionIndex++
        console.log(questionAnswer,'854')

        // start
        // 定时跳转
        setTimeout(()=>{



            let next_btn=$(".weui-btn");
            console.log(next_btn)


            // 去除颜色
            for(let i=0;i<next_btn.length;i++){
                console.log(next_btn)
                next_btn[i].classList.remove("errColor");
                next_btn[i].classList.remove("succColor");

            }
            // $("#next").css("display", "none");

            // for (let i = 0; i < e.classList.length; i++) {
            //     if (!(e.classList[i].indexOf('errColor')>-1|| e.classList[i].indexOf('succColor')>-1)) {
            //         istrue = true;
            //     } else {
            //         istrue = false
            //     }
            // }
            console.log(questionAnswer)

            // var answerItem = {
            //     itemId: questionList[questionIndex].id,
            //     uKey: $(e).attr('value')
            // }
            // questionAnswer.data.push(answerItem)
            // questionIndex++
            // console.log(questionAnswer,'854')
            if (questionIndex > 2) {
                // $("#next").css("display", "none");

                var lock = false;
                $.confirm("您确定要提交所有答案吗?（取消可重新答题）", "确认提交?", function () {

                    $.showLoading()
                    if (!lock) { //防止用户多次点击
                        lock = true;
                        $.ajax({
                            type: "post",
                            url: "${ctx}appsite/gzbdContest/insert",
                            contentType: 'application/json;charset=utf-8',
                            dataType: "json",
                            data: JSON.stringify(questionAnswer),
                            success: function (result) {
                                console.log(result)
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
                                    $('#title').html('<span style="color: red">' + result.msg + '</span>')
                                    $("#again").css("display", "block");
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
                }, function () {
                    questionIndex = 0
                    questionAnswer.data = []
                    setQuestion()
                })
            } else {
                setQuestion()
            }



        },1000)


        // end


    }

    function setQuestion() {
        $('#options').find('a').eq(2).remove()
        console.log(questionList[questionIndex].id)
        questionID = questionList[questionIndex].id
        console.log(questionList)
        console.log(questionID)
        $('#title').html(questionList[questionIndex].item)
        $('#options').find('a').eq(0).html(questionList[questionIndex].optionA)
        $('#options').find('a').eq(1).html(questionList[questionIndex].optionB)
        if (questionList[questionIndex].optionC) {
            $('#options').append('<a class="weui-btn weui-btn_default" value="C" onclick="choose(this)">' + questionList[questionIndex].optionC + '</a>')
        }
    }
    // function next(e) {
    //
    //
    //
    // }
</script>