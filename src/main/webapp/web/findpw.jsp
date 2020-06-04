<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/12/28
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>广西科普传播中心-找回密码</title>
    <style>
        /*为添加的空div设置的样式*/
        .clearDiv {
            clear: both;
        }
        .white{
            color: #FFFFFF;
        }
        .label_title{
            display: inline;
            float: left;
            border-right: #2377cd 1px solid;
            padding: 10px 25px;
        }
        .lm_label{
            display: inline;
            float: left;

            padding: 10px 25px;
        }
        .lm_label_select{
            display: inline;
            float: left;
            background-color: #2377cd;
            padding: 10px 25px;
        }
        .div0_col0{
            width: 60%;
            float: left;
        }
        .div0_col1{
            width: 40%;
        }
        #index_main_div0_row0{
            height: 57%;
        }
        #index_main_div0_row1{
            height: 43%;
        }


        .news_list{
            font-size: 16px;
            display: table-cell;
            vertical-align: middle;
            width: 100%;
        }
        .news_list_time{
            color: #ababab;
            float: right;
            margin-right: 15px;

        }
        #newslists>ul{
            width: 100%;
            padding-top: 10px;
            padding-bottom: 10px;
            color: #696969;
            display: table;
            width: 100%;
            height: 40px;
        }
        #newslists>ul:nth-child(odd){
            background-color: #f2f7fb;
        }
        #newslists>ul:nth-child(even){
            background-color: #ffffff;
        }

        .header {
            height: 60px;
            line-height: 60px;
            text-align: center;
        }
        .header .line {
            display: inline-block;
            width: 105px;
            border-top: 1px solid #efefef ;
        }
        .header .txt {
            color: #333333;
            font-size: 19px;
            vertical-align: -4px;
            margin-left: 10px;
            margin-right: 10px;
        }

    </style>
</head>
<body style="background-color: #eeeeee">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <div style="width:100%;background-color: #2377cd;min-width:1302px;">

        <div id="main_center" style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 10px;padding-bottom: 10px;">
            <div id="banner" style="width: 100%;display: block;">
                <div id="logoarea" style="float: left">
                    <img src="${ctxRes}images/logo.png" style="width: 200px;">
                </div>
                <div id="index_info" style="float: left;margin-top:9px;margin-left: 40px;border-left:1px solid;padding-left:20px;border-left-color:#FFFFFF">
                    <a href="${ctx}index.jsp"><p style="color: #FFFFFF">返回首页</p></a>
                </div>
                <div class="clearDiv"></div>
            </div>
        </div>
    </div>
    <div id="newslistdiv" style="height:60%;width:70%;min-width:1302px;margin: 10px auto;">
        <div style="margin-top: 140px;margin-bottom: 100px;">

            <div style="width: 30%;background-color: #FFFFFF;height: 400px;margin: 0px auto;">
                <div style="margin:10px 30px;">
                    <div class="header">
                        <span class="line"></span>
                        <span class="txt"><strong>找回密码</strong></span>
                        <span class="line"></span>
                    </div>
                    <form method="post" class="layui-form" id="main_form">
                    <div style="height: 40px;border: 1px solid #efefef;margin: 15px 0px;">
                        <div style="margin: 1px 0px;">
                            <img src="${ctxRes}images/yh.png" style="margin-left:10px;margin-right:5px;vertical-align:middle;">
                            <input type="text" name="phone" class="phonenum" placeholder="请输入手机号码" style="vertical-align:middle;border: 0px;line-height: 35px;height: 35px;width:80%;border-left: 1px solid #efefef;margin-top: 2px;padding-left: 10px;">
                        </div>

                    </div>
                    <div style="height: 40px;;margin: 15px 0px;">
                        <div style="height: 40px;border: 1px solid #efefef;float: left;width: 72%">
                            <div style="margin: 1px 0px;">
                                <img src="${ctxRes}images/mm.png" style="margin-left:10px;margin-right:5px;vertical-align:middle;">
                                <input autocomplete="off" type="text" name="CheckCode" placeholder="请输入手机验证码" style="vertical-align:middle;border: 0px;line-height: 35px;height: 35px;width:80%;border-left: 1px solid #efefef;margin-top: 2px;padding-left: 10px;">
                            </div>
                        </div>
                        <button id="btnSendCode" type="button" style="float: right;height: 42px;width: 25%;background-color: #2377cd;border: 0px;text-align: center;color: #FFFFFF;margin-left: 3px;">
                            获取验证码
                        </button>
                        <div class="clearDiv"></div>
                    </div>
                    <div style="height: 40px;border: 1px solid #efefef;margin: 15px 0px;">
                        <div style="margin: 1px 0px;">
                            <img src="${ctxRes}images/mm.png" style="margin-left:10px;margin-right:5px;vertical-align:middle;">
                            <input type="password" name="password" lay-verify="password" placeholder="重置密码" style="vertical-align:middle;border: 0px;line-height: 35px;height: 35px;width:80%;border-left: 1px solid #efefef;margin-top: 2px;padding-left: 10px;">
                        </div>

                    </div>
                    <div style="height: 40px;margin: 15px 0px;text-align: center;">
                        <button id="register" class="layui-btn" lay-submit lay-filter="register" type="submit" style="width: 100%;height: 38px;background-color: #2377cd;color:#FFFFFF;border: 0px;border-radius:2px;">
                            确认提交
                        </button>
                    </div>
                    </form>
                    <div style="text-align: center;color: #b2b2b2">
                        <a href="${ctx}userlogin.jsp" style="color: #b2b2b2"><span>记得密码?点击登录</span></a>
                    </div>
                </div>
            </div>
            <div class="clearDiv"></div>
        </div>

        <div class="clearDiv"></div>
    </div>
    <div class="clearDiv"></div>
</div>
<div id="footer" style="width: 100%;height: 150px;background-color: #313131;color:#ffffff;margin-top: 30px;text-align: center" >
    <div style="padding-top: 50px">
        <p> 网站备案号：*ICP备14012345号-1 </p>
        <p> 版权所有：广西科普传播中心 </p>
        <p>地址：南宁市青秀区古城路31号</p>
        <div class="clearDiv"></div>
    </div>
    <div>
        <a style="color: #fbfbfb;text-decoration: underline;" href="javascript:scroll(0,0)">返回顶部</a>
    </div>
    <div class="clearDiv"></div>

</div>
</body>
<script>

    function register(){
        var fromDate = $('#main_form').serialize();
        $.ajax({
            type:'post',
            url:'${ctx }appsite/resetPsw',
            data:fromDate,
            dataType:'json',
            success:function(data){
                if(data.status==1){
                    layer.msg('重置成功,正在跳转...');
                    setTimeout(function () {
                        location.href="${ctx}userlogin.jsp";
                    },5000)
                }else{
                    layer.msg(data.msg, {icon: 5});
                }
            },
            error:function (msg){
                console.log(msg);

            }
        });
    }
    layui.use('form', function () {
        var form = layui.form;
        form.verify({
            password: function(value, item){ //value：表单的值、item：表单的DOM对象
                /*var myreg=/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{8,16}$/;*/
                var myreg=/^[a-zA-Z0-9_-]{4,16}$/;
                if(!myreg.test(value)){
                    /*return '密码至少8-16个字符，至少1个大写字母，1个小写字母和1个数字';*/
                    return '密码至少4-16个字符';
                }
            }
        });
        //监听提交
        form.on('submit(register)', function (data) {
            register();

            return false;
        });


    });
</script>

<script>


    $(function () {
        $("#btnSendCode").attr("disabled",false);
        $("#btnSendCode").click(function () {
            $.ajax({
                type : "get",
                url : '${ctx}appsite/sendPhoneCheckCode',
                data:{phone:$(".phonenum").val()},
                dataType:'json',
                error : function(data) {
                    console.log(data);
                    layer.msg('网络异常');
                },
                success : function(data) {
                    console.log(data);
                    if(data.status==1){
                        layer.msg('短信发送成功，收到后请输入密码!');
                        time(this);
                    }else if(data.status==5){
                        layer.msg('用户名已存在!');
                    }else{
                        layer.msg('短信发送失败！');
                    }
                }
            });
        })
    })

    //验证码倒计时
    var wait = 60;
    function time(obj) {
        if(wait==0) {
            $("#btnSendCode").attr("disabled",false);
            $("#btnSendCode").text("获取验证码");
            wait = 60;
        }else {
            $("#btnSendCode").attr("disabled",true);
            $("#btnSendCode").text(wait+"秒后重试");
            wait--;
            setTimeout(function() {     //倒计时方法
                time(obj);
            },1000);    //间隔为1s
        }
    }

</script>
</html>
