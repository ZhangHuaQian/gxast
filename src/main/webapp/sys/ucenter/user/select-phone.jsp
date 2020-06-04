<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑用户</title>
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
       <%-- <div class="layui-form-item">
            <label class="layui-form-label">所属部门</label>
            <div class="layui-input-inline">

                <div class="layui-unselect layui-form-select layui-form-selected">
                    <div class="layui-select-title">
                        <input type="text" placeholder="点击选择部门" id="selectTreeBut" value="" readonly=""
                               lay-verify="required" class="layui-input layui-unselect">
                        <input name="did" value="" type="hidden" id="departmentValue"/>
                        <i class="layui-edge"></i>
                    </div>
                    <dl class="layui-anim layui-anim-upbit layui-select-group" id="selectTree" style="display: none;">
                        <div style="width:100%;height:250px;overflow-y:auto; overflow-x:auto;">
                            <ul id="treeDemo" class="ztree"></ul>
                        </div>
                    </dl>
                </div>
            </div>
        </div>--%>

            <div class="layui-form-item">
            <label class="layui-form-label">账号</label>
            <div class="layui-input-inline">
                <input type="text" name="loginname" disabled lay-verify="required" placeholder="如:手机或邮箱"
                       autocomplete="off" readonly
                       class="layui-input">
            </div>
            <label class="layui-form-label">名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" lay-verify="required" placeholder="如:南宁市气象分局" autocomplete="off" readonly
                       class="layui-input">
            </div>
        </div>

            <div class="layui-form-item">
            <label class="layui-form-label">手机</label>
            <div class="layui-input-inline">
                <input type="number" name="phonenum" lay-verify="required" placeholder="如:南宁市气象分局" autocomplete="off" readonly
                       class="layui-input">
            </div>
                <label class="layui-form-label">用户等级</label>
                <div class="layui-input-inline" >
                    <input type="checkbox" name="isVip" lay-filter="isVip" value="1" title="论坛vip用户">
                </div>
        </div>

    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>

    var form;
    $(function () {
        initUser();
        renderForm();
    })

    //刷新父窗口
    function reloadParentWin() {
        if(window.parent.frames["手机用户管理"]!=undefined)window.parent.frames["手机用户管理"].location.reload();// 刷新父窗口
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }

    //渲染表单
    function renderForm() {
        layui.use('form', function () {
            form = layui.form;
        });
    }

    //初始化用户信息
    function initUser() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/ucenter/select?uid=${param.id}',
            dataType: 'json',
            success: function (result) {
                var user = result.user;
                console.log(user)
                $("input[name='loginname']").val(user.loginname);
                $("input[name='name']").val(user.name);
                $("input[name='phonenum']").val(user.phonenum);
                if(user.isVip == 1){
                    $("input[name='isVip']").attr('checked',true);
                }
                form.render();
            },
            error: function (msg) {
                console.log(msg);
                layer.msg("初始化异常");
            }
        });
    }

</script>

</body>
</html>