<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加用户</title>
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
            <%--<label class="layui-form-label">角色</label>
            <div class="layui-input-inline">
                <select name="roleId" id="roleSelect" lay-verify="required" lay-search="">
                    <option value="">直接选择或搜索选择</option>
                </select>
            </div>--%>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">账号</label>
            <div class="layui-input-inline">
                <input type="text" name="loginname" lay-verify="required" placeholder="如:手机或邮箱" autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" lay-verify="required" placeholder="如:南宁市气象分局" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
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
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">手机</label>
            <div class="layui-input-inline">
                <input type="number" name="phonenum" lay-verify="required" placeholder="如:1388888888" autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">用户状态</label>
            <div class="layui-input-inline">
                <input type="radio" name="loginflag" value="0" title="启用" checked>
                <input type="radio" name="loginflag" value="1" title="停用">
            </div>
        </div>

        <%--  角色多选  --%>
        <div class="layui-form-item" pane="">
            <label class="layui-form-label">用户角色</label>
            <div class="layui-input-block" id="roleCheckboxList"></div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn layui-btn-normal" lay-submit lay-filter="formDemo">添加用户</button>
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
        window.parent.frames["用户管理"].location.reload() ;// 刷新父窗口
        setTimeout(function (){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
            //layer.closeAll(); //疯狂模式，关闭所有层
        },1000)
    }

    //渲染表单
    layui.use('form', function () {
        form = layui.form;

        //校验两次密码
        form.verify({
            regPwd: function (value) {
                //获取密码
                var pwd = $("#pwd").val();
                if (!new RegExp(pwd).test(value)) {
                    return '两次输入的密码不一致';
                }
            },
            roleCheckbox: function (value){
                var roleIds = "";
                $("input[name='roleIds']:checked").each(function (){
                    roleIds += $(this).val();
                });
                if(roleIds == "")return '用户角色至少选择一项';
            }
        });

        //监听提交
        form.on('submit(formDemo)', function (data) {
            $.ajax({
                type: 'post',
                url: '${ctx }sys/ucenter/insert',
                data: $('#main_form').serialize(),
                dataType: 'json',
                success: function (result) {
                    console.log(result);
                    if(result.status=="1"){
                        closeWindow();
                        layer.msg(result.msg);
                    }

                },
                error: function (msg) {
                    console.log(msg);
                    layer.msg("系统异常");
                }
            });
            return false;
        });

        initRoleSelect(); // 在这里初始化角色 ，解决复选框不能选择问题


    });


    // 初始化角色下拉
    function initRoleSelect() {
        $.ajax({
            type: 'get',
            <shiro:hasRole name="role_super">url: '${ctx }sys/upms/role/selectAll',</shiro:hasRole>
            <shiro:lacksRole name="role_super">url: '${ctx }sys/upms/role/selectByUid?uid=${sessionScope.USER_SESSION_NAME.id}',</shiro:lacksRole>
            url: '${ctx }sys/upms/role/selectAll',
            //data:$('#main_form').serialize(),
            dataType: 'json',
            success: function (result) {
                var list = result.list;
                console.log(list)
                //var str = "";
                var roleCheckBox = "";
                for (var i = 0; i < list.length; i++) {
                    var id = "";
                    if(list[i].power == "role_phone"){
                        continue;
                    }
                    if(list[i].power == "role_topic_moderator"){
                        id=" id='moderator' ";
                    }
                    //str += '<option value="' + list[i].id + '">' + list[i].roleName + '</option>';
                    roleCheckBox += '<input lay-filter="" type="checkbox" lay-verify="roleCheckbox" name="roleIds" lay-skin="primary" title="'+list[i].roleName+'" value="'+list[i].id+'"><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>'+list[i].roleName+'</span><i class="layui-icon layui-icon-ok"></i></div>';
                }
                <shiro:hasRole name="区管理员">
                roleCheckBox += '<input type="checkbox" lay-verify="roleCheckbox" name="roleIds" lay-skin="primary" title="市县管理员" value="6"><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>市县管理员</span><i class="layui-icon layui-icon-ok"></i></div>';
                </shiro:hasRole>

                $("#roleCheckboxList").html(roleCheckBox);
                //$("#roleSelect").append(str);

                layui.form.render();//更新渲染表单
            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }

    $("#moderator").on("click",function(){
        console.log(111)
    });

    var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        data: {
            simpleData: {
                enable: true,
                idKey: "id", // id
                pIdKey: "pId", //  父级ID
                rootPId: 0   // 顶层ID默认值0
            },
            key: {
                name: "name", // 节点名称
                url: "xURL" // URL
            }
        },
        callback: {
            onClick: zTreeOnClick
        }
    };

    //树菜单点击事件
    function zTreeOnClick(event, treeId, treeNode) {
        $("#selectTreeBut").val(treeNode.name);
        $("#departmentValue").val(treeNode.id);
    }
    ;

    //初始化部门下拉
    function initDepartmentSelect() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/upms/department/selectByThisUser',
            //data:$('#main_form').serialize(),
            dataType: 'json',
            success: function (result) {
                zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, result.list);
                zTreeObj.expandAll(true); //默认全部展开
            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }

    //下拉树
    function bindTree() {
        $("#selectTreeBut").click(function () {
            $("#selectTree").toggle(500, function () {
                $(this).mouseleave(function () {
                    $(this).hide();
                });
            });
        });
    }

    $(function () {
        bindTree();
        initDepartmentSelect();
        //initRoleSelect();
    });

</script>

</body>
</html>