<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑数据字典</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <%@ include file="/commViews/head.jsp" %>
    <link rel="stylesheet" href="${ctx }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
</head>
<body>

<!-- 菜单添加 -->
<form class="layui-form layui-form-pane" id="main_form" style="">

    <div style="float: left;padding: 10px;">

        <div class="layui-form-item">
            <label class="layui-form-label">字典名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" lay-verify="required" placeholder="字典名称" autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">字典类型</label>
            <div class="layui-input-inline">
                <input type="text" name="type" lay-verify="required" placeholder="字典类型" autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">字典值</label>
            <div class="layui-input-inline">
                <input type="text" name="value" lay-verify="required" placeholder="字典值"
                       autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">字典码</label>
            <div class="layui-input-inline">
                <input type="text" name="code" lay-verify="required" placeholder="字典码" autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">排序</label>
            <div class="layui-input-inline">
                <input type="number" name="orderNo" lay-verify="required" placeholder="排序" autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">备注</label>
            <div class="layui-input-inline">
                <input type="text" name="remark" lay-verify="required" placeholder="字典码" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-warm" lay-submit lay-filter="formDemo">保存字典</button>
                <!-- <button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
            </div>
        </div>
    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>

    //刷新父窗口
    function reloadParentWin() {
        if(window.parent.frames["数据字典"]!=undefined)window.parent.frames["数据字典"].location.reload();// 刷新父窗口
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
        // layer.closeAll(); //疯狂模式，关闭所有层
    }

    //渲染表单
        layui.use('form', function () {
            form = layui.form;
            //$('#x-city').xcity('广西','百色市','田东县');
            //$('#x-city').xcity('广西');

            //监听提交
            form.on('submit(formDemo)', function (data) {
                $.ajax({
                    type: 'post',
                    url: '${ctx }sys/dictionary/update?id='+${param.id},
                    data: $('#main_form').serialize(),
                    dataType: 'json',
                    success: function (result) {
                        if(result.status==1){
                            layer.alert(result.msg, {icon: 6}, function () {
                                reloadParentWin();
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

    //初始化用户信息
    function initUser() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/dictionary/select?id='+${param.id},
            dataType: 'json',
            success: function (result) {
                var dict = result.dict;

                $("input[name='name']").val(dict.name);
                $("input[name='type']").val(dict.type);
                $("input[name='value']").val(dict.value);
                $("input[name='code']").val(dict.code);
                $("input[name='orderNo']").val(dict.orderNo);
                $("input[name='remark']").val(dict.remark); 
            },
            error: function (msg) {
                console.log(msg);
                alert("初始化异常");
            }
        });
    }

    $(function () {
    	initUser();
    });

</script>

</body>
</html>