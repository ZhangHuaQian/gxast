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

        <%--<div class="layui-form-item" id="x-city">
            <div class="layui-input-inline">
                <select name="province" lay-filter="province">
                    <option value="">请选择省</option>
                </select>
            </div>
            <div class="layui-input-inline" style="margin-left: 10px;">
                <select name="city" lay-filter="city">
                    <option value="">请选择市</option>
                </select>
            </div>
            <div class="layui-input-inline" style="margin-left: 10px;">
                <select name="area" lay-filter="area">
                    <option value="">请选择县/区</option>
                </select>
            </div>
        </div>--%>

        <div class="layui-form-item">
           <%-- <label class="layui-form-label">所属部门</label>
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
            </div>--%>
            <%--<label class="layui-form-label">角色</label>
            <div class="layui-input-inline">
                <select name="roleId" id="roleSelect" lay-verify="required" lay-search="" disabled>
                    <option value="">直接选择或搜索选择</option>
                </select>
            </div>--%>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">账号</label>
            <div class="layui-input-inline">
                <input type="text" name="loginname" disabled lay-verify="required" placeholder="如:手机或邮箱"
                       autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" lay-verify="required" placeholder="如:南宁市气象分局" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <%--<div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-inline">
                <input type="password" name="password" id="pwd" lay-verify="required" placeholder="密码"
                       autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">确认密码</label>
            <div class="layui-input-inline">
                <input type="password" lay-verify="regPwd" placeholder="两次密码必须一致" autocomplete="off"
                       class="layui-input">
            </div>
        </div>--%>

        <div class="layui-form-item">
            <label class="layui-form-label">手机</label>
            <div class="layui-input-inline">
                <input type="number" name="phonenum" lay-verify="required" placeholder="如:南宁市气象分局" autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">用户等级</label>
            <div class="layui-input-inline" >
                <input type="checkbox" name="isVip" lay-filter="isVip" value="1" title="论坛vip用户">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-warm" lay-submit lay-filter="formDemo">保存用户</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
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
        // if(window.parent.frames["手机用户管理"]!=undefined)window.parent.frames["手机用户管理"].location.reload();// 刷新父窗口
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }

    //渲染表单
    function renderForm() {
        layui.use('form', function () {
            form = layui.form;
            //监听提交
            form.on('submit(formDemo)', function (data) {
                $.ajax({
                    type: 'post',
                    url: '${ctx }sys/ucenter/update?id=${param.id}',
                    data: $('#main_form').serialize(),
                    dataType: 'json',
                    success: function (result) {
                        if(result.status==1){
                            layer.msg("操作成功");
                            // layer.alert(result.msg, {icon: 6}, function () {
                                reloadParentWin();
                            // });
                        }else{
                            layer.msg(result.msg, {icon: 5});
                        }
                    },
                    error: function (msg) {
                        console.log(msg);
                        layer.msg("系统异常");
                    }
                });
                return false;
            });
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