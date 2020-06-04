<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>密码修改</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <%@ include file="/commViews/head.jsp" %>
    <link rel="stylesheet" href="${ctxRes}css/font.css">
    <link rel="stylesheet" href="${ctxRes}css/xadmin.css">
    <script type="text/javascript" src="${ctxRes}js/xadmin.js"></script>
</head>

<body>
<div class="x-body" style="padding: 20px">
    <form class="layui-form" id="main_form">
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
                <span class="x-red"> * </span>原始密码
            </label>
            <div class="layui-input-inline">
                <input type="password" name="oldpassword" required="" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_pass" class="layui-form-label">
                <span class="x-red"> * </span>新密码
            </label>
            <div class="layui-input-inline">
                <input type="password" id="pwd" name="newpassword" required="" lay-verify="pwd"
                       autocomplete="off" class="layui-input">
            </div>
            <%--<div class="layui-form-mid layui-word-aux">
                6到16个字符
            </div>--%>
        </div>
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
                <span class="x-red"> * </span>确认密码
            </label>
            <div class="layui-input-inline">
                <input type="password" lay-verify="regPwd"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
            </label>
            <button class="layui-btn" lay-filter="save" lay-submit="">更新密码</button>
        </div>
    </form>
</div>
<script>
    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var form = layui.form
            , layer = layui.layer;


        //校验两次密码
        form.verify({
            pwd:function(value, item){
                var reg=/^[a-zA-Z0-9_-]{4,16}$/;
                if(!reg.test(value)){
                    return '密码至少4-16个字符';
                }
            },
            regPwd: function (value) {
                //获取密码
                var pwd = $("#pwd").val();
                if (!new RegExp(pwd).test(value)) {
                    return '两次输入的密码不一致';
                }
            }
        });

        //监听提交
        form.on('submit(save)', function (data) {

            $.ajax({
                type: 'post',
                url: '${ctx }sys/ucenter/updatePassword',
                data: $('#main_form').serialize(),
                dataType: 'json',
                success: function (result) {
                    if(result.status==1){
                        layer.alert(result.msg, {icon: 6}, function () {
                            var index = parent.layer.getFrameIndex(window.name);// 获得frame索引
                            parent.layer.close(index);//关闭当前frame
                        });
                    }else{
                        layer.msg(result.msg, {icon: 5});
                    }
                },
                error: function (msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });

            return false;
        });


    });
</script>

</body>

</html>