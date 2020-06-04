<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加播放地址</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="stylesheet" href="${ctx }resource/plugins/layui/css/layui.css">
    <%@ include file="/commViews/head.jsp" %>
</head>
<style>

</style>
<body>

<form class="layui-form layui-form-pane" id="main_form" >

    <div style="text-align: center">
        <div id="placeholder" style="height: 1.5rem;width: 16rem"></div>
        <div class="layui-form layui-inline" style="margin: 10px 0px;">
            <div class="layui-input-inline">
                <input type="text" id="phone" name="phone" class="layui-input" lay-verify="phone"
                       placeholder="请输入新的手机号" style="width: 16rem">
            </div>
        </div>

        <div class="layui-form layui-inline" style="margin: 10px 0px;">
            <div class="layui-input-inline">
                <input type="text" name="code" class="layui-input" lay-verify="required"
                       placeholder="请输入验证码" style="width: 9rem;margin-right: 7px;">
            </div>
            <button type="button" class="layui-btn layui-btn-normal" style="width:100px;" onclick="getCode()">获取验证码</button>
        </div>

        <div style="margin-top: 10px;">
            <button id="loginBtn" class="layui-btn layui-btn-normal" lay-submit lay-filter="formDemo" style="width:16rem;">确认修改</button>
        </div>

    </div>

</form>

<script>

    //获取短信验证码
    function getCode() {
        var phone = $.trim($("#phone").val());
        if(phone.length<=0){
            layer.msg("请先输入手机号",{icon: 5});
        }else{
            var ab = /1[3,4,5,7,8][0-9]{9}$/;
            if (ab.test(phone) == false) {
                layer.msg("请输入正确的手机号",{icon: 5});
            }else{
                $.ajax({
                type: 'get',
                url: '${ctx }sendPhoneCheckCodeUpdatePhone',
                data: $('#main_form').serialize(),
                dataType: 'json',
                success: function (result) {
                    layer.msg(result.msg);
                },
                error: function (msg) {
                console.log(msg);
                layer.alert("系统异常", {icon: 5});
                }
                });
            }
        }

    }

    //提交
    layui.use('form', function () {
        var form = layui.form;
        form.on('submit(formDemo)', function (data) {
            $.ajax({
                type: 'post',
                url: '${ctx }updatePhone',
                data: $('#main_form').serialize(),
                dataType: 'json',
                success: function (result) {
                    if (result.status == 1) {
                        layer.msg(result.msg, {icon: 6,time:1000}, function () {
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index); //再执行关闭
                        });
                    } else {
                        layer.msg(result.msg, {icon: 5});
                    }
                },
                error: function (msg) {
                    console.log(msg);
                    layer.alert("系统异常", {icon: 5});
                }
            });
            return false;
        });

    });

</script>

</body>
</html>