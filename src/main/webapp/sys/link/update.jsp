<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑</title>
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
            <label class="layui-form-label">链接名称</label>
            <div class="layui-input-inline">
                <input type="text" name="linkname" lay-verify="required"  autocomplete="off" placeholder="请输入链接名称"
                       class="layui-input">
            </div>
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


        <div class="layui-form-item" style="margin-left: 100px;padding-top: 30px">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn layui-btn-normal" lay-submit lay-filter="formDemo">编辑信息</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>

    //关闭当前弹出窗口
    function reloadParentWin() {
        window.parent.frames["友情链接"].location.reload() ;// 刷新父窗口
        setTimeout(function (){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
            //layer.closeAll(); //疯狂模式，关闭所有层
        },1000)
    }


    //渲染表单
    var form;
    function renderForm() {
        layui.use('form', function () {
            form = layui.form;
            form.render();
            form.on('submit(formDemo)', function (data) {
                $.ajax({
                    type: 'post',
                    url: '${ctx }sys/link/update?id='+${param.id},
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

    }
    <%--url: '${ctx }sys/worker/select?id=${param.id}' ,--%>

    function initUser() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/link/select?id=${param.id}' ,
            dataType: 'json',
            success: function (result) {

                var link = result.data;

                $("input[name='linkname']").val(link.linkname);
                $("input[name='link']").val(link.link);
                $("input[name='note']").val(link.note);
                     console.log(link);

            },

            error: function (msg) {
                console.log(msg);
                alert("初始化异常");
            }
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
        initUser();


    });



</script>

</body>
</html>