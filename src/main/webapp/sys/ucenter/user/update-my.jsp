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

        <div class="layui-form-item">
            <label class="layui-form-label">所属部门</label>
            <div class="layui-input-inline">
                <div class="layui-unselect layui-form-select layui-form-selected">
                    <div class="layui-select-title">
                        <input type="text" placeholder="点击选择部门" disabled id="selectTreeBut" value="" readonly=""
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

        <div class="layui-form-item">
            <label class="layui-form-label">手机</label>
            <div class="layui-input-inline">
                <input type="number" name="phonenum" lay-verify="required" placeholder="如:南宁市气象分局" autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">用户状态</label>
            <div class="layui-input-inline">
                <input type="radio" disabled name="loginflag" value="0" title="启用">
                <input type="radio" disabled name="loginflag" value="1" title="停用">
            </div>
        </div>

        <%--  角色多选  --%>
        <div class="layui-form-item" style="display: none;">
            <label class="layui-form-label">用户角色</label>
            <div class="layui-input-block" id="roleCheckboxList"></div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-warm" lay-submit lay-filter="formDemo">保存</button>
                <%--<button type="reset" class="layui-btn layui-btn-primary">重置</button>--%>
            </div>
        </div>
    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>

    //刷新父窗口
    function reloadParentWin() {
        reload_parent("sys/ucenter/user/list.jsp")
        reload_parent("sys/ucenter/user/list-phone.jsp")
        //if(window.parent.frames["用户管理"]!=undefined)window.parent.frames["用户管理"].location.reload();// 刷新父窗口
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }

    //渲染表单
    function renderForm() {
        layui.use('form', function () {
            form = layui.form;
            //$('#x-city').xcity('广西','百色市','田东县');
            //$('#x-city').xcity('广西');

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
                    url: '${ctx }sys/ucenter/update?id=${param.id}',
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

    //初始化部门下拉
    var depData;
    function initDepartmentSelect() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/upms/department/selectByThisUser',
            dataType: 'json',
            success: function (result) {
                depData = result.list;
                zTreeObj = $.fn.zTree.init($("#treeDemo"), setting,depData);
                zTreeObj.expandAll(true); //默认全部展开
                bindTree();
                initRoleSelect();
            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }

    var zTreeObj;// zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        data: {
            simpleData: {
                enable: true,
                idKey: "id", // id
                pIdKey: "pId", //  父级ID
                rootPId: 0  // 顶层ID默认值0
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

    //树菜单点击事件
    function zTreeOnClick(event, treeId, treeNode) {
        $("#selectTreeBut").val(treeNode.name);
        $("#departmentValue").val(treeNode.id);
    }
    ;

    // 初始化角色下拉
    function initRoleSelect() {
        $.ajax({
            type: 'get',
            <shiro:hasRole name="role_super">url: '${ctx }sys/upms/role/selectAll',</shiro:hasRole>
            <shiro:lacksRole name="role_super">url: '${ctx }sys/upms/role/selectByUid?uid=${param.id}',</shiro:lacksRole>
            url: '${ctx }sys/upms/role/selectAll',
            dataType: 'json',
            success: function (result) {
                var list = result.list;
                console.log(list)
                //var str = "";
                var roleCheckBox = "";
                for (var i = 0; i < list.length; i++) {
                    //str += '<option value="' + list[i].id + '">' + list[i].roleName + '</option>';
                    roleCheckBox += '<input type="checkbox" lay-verify="roleCheckbox" name="roleIds" lay-skin="primary" title="'+list[i].roleName+'" value="'+list[i].id+'"><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>'+list[i].roleName+'</span><i class="layui-icon layui-icon-ok"></i></div>';
                }
                $("#roleCheckboxList").html(roleCheckBox);
                //$("#roleSelect").append(str);
                initUser();
            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
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

                $("input[name='loginname']").val(user.loginname);
                $("input[name='name']").val(user.name);
                $("input[name='phonenum']").val(user.phonenum);

                // 初始化状态
                $("input[name='loginflag']").each(function () {
                    if ($(this).val() == user.loginflag) $(this).attr("checked", "checked")
                });

                // 初始化部门
                for (k = 0; k < depData.length; k++) {
                    if ((depData[k].id) == parseInt(user.did)) {
                        $("#selectTreeBut").val(depData[k].name);
                        $("#departmentValue").val(depData[k].id);
                    }
                }
                // 初始化角色
                $.ajax({
                    type: 'get',
                    url: '${ctx }sys/upms/role/selectByUid?uid=${param.id}',
                    dataType: 'json',
                    success: function (result) {
                        var myRoleList = result.list;
                        // 初始化状态
                        /*$("#roleSelect option").each(function () {
                            if ($(this).val() == result.userRole.roleCode) $(this).attr("selected", "selected");
                        });*/

                        $("#roleCheckboxList input").each(function () {
                            for (c = 0; c < myRoleList.length; c++) {
                                if($(this).val() == myRoleList[c].id)$(this).attr("checked","checked");
                            }
                        });
                        renderForm();//渲染表单
                    },
                    error: function (msg) {
                        console.log(msg);
                        alert("初始化异常11");
                    }
                });
            },
            error: function (msg) {
                console.log(msg);
                alert("初始化异常22");
            }
        });
    }

    $(function () {
        initDepartmentSelect();
    });

</script>

</body>
</html>