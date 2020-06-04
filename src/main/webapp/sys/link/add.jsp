<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加链接</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <%@ include file="/commViews/head.jsp" %>

</head>
<body>

<!-- 菜单添加 -->
<form class="layui-form layui-form-pane" id="main_form" style="">

    <div style="float: left;padding: 10px;">

        <div class="layui-form-item">
            <label class="layui-form-label">链接名称</label>
            <div class="layui-input-inline">
                <input type="text" name="linkname" lay-verify="required"  autocomplete="off" placeholder="请输入链接"
                       class="layui-input">
            </div>
            <%--<label class="layui-form-label">链接</label>--%>
            <%--<div class="layui-input-inline">--%>
                <%--<input type="text" name="link" lay-verify="required"  autocomplete="off" placeholder="请输入链接"--%>
                       <%--class="layui-input">--%>
            <%--</div>--%>
            <label class="layui-form-label">链接</label>
            <div class="layui-input-inline">
                <input type="text" name="link"
                       placeholder="链接" autocomplete="off" lay-verType="tips" lay-verify="url" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">内容</label>
            <div class="layui-input-inline">
                <input type="text" name="note"  lay-verify="required" placeholder="请输入内容"
                       autocomplete="off" class="layui-input">

            </div>

        </div>

        <div class="layui-form-item" style="margin-left: 100px">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn layui-btn-normal1" lay-submit lay-filter="formDemo">添加链接</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>

    //关闭当前弹出窗口
    function closeWindow() {
        window.parent.frames["友情链接"].location.reload() ;// 刷新父窗口
        setTimeout(function (){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
            //layer.closeAll(); //疯狂模式，关闭所有层
        },1000)
    }

    //渲染表单
    function renderForm() {
        layui.use('form', function () {
            form = layui.form;
            //监听提交
            form.on('submit(formDemo)', function (data) {
                $.ajax({
                    type: 'post',
                    url: '${ctx}sys/link/insert',
                    data: $('#main_form').serialize(),
                    dataType: 'json',
                    success: function (result) {
                        closeWindow();
                        console.log(result);
                        layer.msg(result.msg);
                    },
                    error: function (msg) {
                        console.log(msg);
                        alert("系统异常");
                    }
                });
                return false;
            });
        });
    }
    layui.use('form', function(){
        var form = layui.form;
        form.verify({
            url:function (value,item) {
                var myreg= /^((ht|f)tps?):\/\/[\w\-]+(\.[\w\-]+)+([\w\-.,@?^=%&:\/~+#]*[\w\-@?^=%&\/~+#])?$/;
                if(!myreg.test(value)){
                    return '请输入正确的网址';
                }
            }
        });
        form.on('submit(formDemo)', function () {
            sendData();
        });
        form.render();
    });
    $(function () {
        renderForm();

    });

</script>

</body>
</html>