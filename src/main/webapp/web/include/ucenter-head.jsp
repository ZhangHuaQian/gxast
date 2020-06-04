<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div style="width:100%;background-color: #F5F5F5;min-width:1302px;height: 40px;">
    <div style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 10px;padding-bottom: 10px;">
        <div style="width: 100%;display: block;">
            <div style="float: left;">
                <a href="${ctx}"><p style="color: #6b6b6b;vertical-align: middle"><img src="${ctxRes}images/sy.png" style="vertical-align: middle">&nbsp;<strong style="vertical-align: middle">返回首页</strong></p></a>
            </div>
            <div style="float: right;">
                <div style="float: left;margin-right: 30px;">
                    <a href="#" style="color: orange" onclick="logout('${ctx}')">
                        <span><strong>登出</strong></span>
                    </a>
                </div>
                <div style="float: left;margin-right: 30px;">
                    <a href="#" style="color:#747474" onclick="openMyTopic()">
                        <span><strong>我的帖子</strong></span>
                    </a>
                </div>
                <div style="float: left;margin-right: 30px;">
                    <a href="${ctx}web/user/user.jsp" style="color: #747474">
                        <span><strong>账号：${sessionScope.USER_SESSION_NAME.loginname}</strong><img src="${ctxRes}images/x_black.png" style="margin-left: 5px;"></span>
                    </a>
                </div>
                <div style="float: left;margin-right: 30px;"><a href="${ctx}web/user/order.jsp" style="color: #747474"><span><strong>我的订单</strong><img src="${ctxRes}images/x_black.png" style="margin-left: 5px;"></span></a></div>
                <div style="float: right"><a href="${ctx}web/shopcar/shopcar.jsp" style="color: #E85958"><strong><span>购物车</span>(<span id="count2">0</span>)</strong></a></div>
                <div class="clearDiv"></div>
            </div>
            <div class="clearDiv"></div>
        </div>
    </div>
</div>
<div style="width:100%;background-color: #2377cd;min-width:1302px;">

    <div id="main_center" style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 10px;padding-bottom: 10px;">
        <div id="banner" style="width: 100%;display: block;">
            <div id="logoarea" style="float: left">
                <img src="${ctxRes}images/logo.png" style="width: 200px;">
            </div>
            <div id="bannerarea" style="float: left;margin-left: 100px;margin-top:9px;">
                <div style="float: left;margin-right: 30px;">
                    <a href="${ctx}web/user/user_index.jsp" style="color: #ffffff">
                        <span><strong>首页</strong></span>
                    </a>
                </div>
                <div style="float: left;margin-right: 30px;"><a href="${ctx}web/user/user.jsp" style="color: #ffffff"><span><strong>账户管理</strong></span></a></div>
                <div style="float: left"><a href="${ctx}web/user/user_message.jsp" id="showMessageWin" style="color: #ffffff"><strong><span>消息</span><span style="margin-left:4px;" id="thisMessageText" class="layui-badge"></span></strong></a></div>
                <div class="clearDiv"></div>
            </div>
            <div class="clearDiv"></div>
        </div>
    </div>
</div>
<script>
	$(function() {// 初始化内容
		$.ajax({
	        type:'get',
	        url:'${ctx}web/shopcar/shopcar',
	        dataType:'json',
	        success:function(data){
	            $("#count2").text(data.shopcars.length);
	        },
	        error:function (msg){
	            console.log(msg);
	        }
	    });
	});

    /*我的帖子*/
    function openMyTopic() {
        window.open("${ctx}web/user/bbs/list.jsp");
    }
    // 登出
    function logout(url){
        $.ajax({
            type:'post',
            url:'${ctx}logout',
            dataType:'json',
            success:function(data){
                if(data.status==1){
                    window.location.href = url;
                }else{
                    layer.msg("失败");
                }
            },
            error:function (msg){
                console.log(msg);
            }
        });
    }

    function message_ajax(){
        $.ajax({
            type : 'post',
            url : '${ctx}sys/Message/selectMessageLogByStatue',
            dataType : 'json',
            success : function(result) {
                // console.log(result.count)

                $("#thisMessageText").html(result.count)

            },
            error : function(msg) {
                console.log(msg);
                //alert("系统异常");
            }
        });
    };

    $(function () {
        message_ajax();
        setInterval(function(){
            message_ajax();
        },20000);
        // 时间定时器
        setInterval(function(){
            $("#thisTimeText").html(formatDate_YMD_HMS(Date.parse(new Date())));
        },1000);

       /* $("#showMessageWin").click(showMessageWin);*/

    })


    // 消息窗口
    function showMessageWin(param) {
        layer.open({
            type: 2,
            area: ['1230px', '560px'],
            title: "消息列表",
            closeBtn: 1,
            //shade: [0.1, '#FFFFFF'],
            shadeClose: true,
            skin: 'yourclass',
            resize: true,
            success: function (layero, index) {
            },
            content: '${ctx}sys/message/messagelist.jsp'
        });
    }

</script>