<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <%@ include file="/commViews/head.jsp" %>
    <link rel="stylesheet" href="${ctxRes }plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="${ctxRes }plugins/zTree_v3/js/jquery.ztree.core.min.js"></script>
    <script type="text/javascript" src="${ctxRes }plugins/zTree_v3/js/jquery.ztree.excheck.min.js"></script>
</head>
<body>

<div style="float:left;width: 250px;height:210px;overflow: auto;">
    <ul id="treeDemo" class="ztree" style=""></ul>
</div>

<!-- 角色添加 -->
<form class="layui-form layui-form-pane" id="main_form" style="padding: 10px;width:350px;float:left;">
    <div class="layui-form-item">
        <label class="layui-form-label">角色名称</label>
        <div class="layui-input-block">
            <input type="text" name="roleName" placeholder="" lay-verify="required" autocomplete="off"
                   class="layui-input">
            <input type="hidden" name="id" value="<c:out value="${param.id}" />">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">权限标识</label>
        <div class="layui-input-block">
            <input type="text" disabled name="power" placeholder="" lay-verify="required" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">排序</label>
        <div class="layui-input-block">
            <input type="number" name="orderNo" placeholder="" lay-verify="required" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">描述</label>
        <div class="layui-input-block">
            <input type="text" name="description" placeholder="" lay-verify="required" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item" style="">
        <%--<label class="layui-form-label"></label>--%>
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-warm" lay-submit lay-filter="formDemo">更新</button>
            <%--<button type="reset" class="layui-btn layui-btn-primary">重置</button>--%>
        </div>
    </div>
</form>

<%--<div style="width: 100%;height:50px;">
	<button class="layui-btn" style="float: right;margin:10px 10px 0 0;" onclick="update()">更新</button>
</div>--%>

<script>

    // 更新
    function update() {

        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getCheckedNodes(true);
        var mid = "";
        for (var i = 0; i < nodes.length; i++) {
            mid += nodes[i].id + ",";
        }

        /*if(mid==""){
         layer.msg("未选择菜单");
         return false;
         }*/

        mid = mid.substring(0, mid.length - 1);

        $.ajax({
            type: 'post',
            url: '${ctx }sys/upms/roleMenu/insert.do',
            data: {rid:<c:out value="${param.id}" />, mids: mid},
            success: function (result) {
                console.log(result)
                if (result.status == 1) {
                    //layer.msg("提交成功");
                } else {
                    alert("提交失败");
                }
            },
            error: function (msg) {
                alert("菜单初始化异常");
            }
        });

    }

    // 初始化树
    function initTree(param) {
        var roleMenu = param.list;
        var zTreeObj;
        // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
        var setting = {
            check: {
                enable: true,
                chkStyle: "checkbox"
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "id", // id
                    pIdKey: "pMenuCode", //  父级ID
                    rootPId: 0   // 顶层ID默认值0
                },
                key: {
                    name: "menuName", // 节点名称
                    url: "xURL" // URL
                }
            }
        };

        $.ajax({
            type: 'post',
            url: '${ctx }sys/upms/menu/selectAll.do',
            dataType: "json",
            success: function (result) {
                // 初始化默认选中
                if (roleMenu.length > 0) {
                    for (var i = 0; i < result.length; i++) {
                        for (var k = 0; k < roleMenu.length; k++) {
                            if (roleMenu[k].menuCode == result[i].id) result[i].checked = true;
                        }
                    }
                }
                zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, result);
                zTreeObj.expandAll(true); //默认全部展开
            },
            error: function (msg) {
                alert("菜单初始化异常");
            }
        });

    }

    //初始化个人菜单
    function initRoleMenu() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/upms/roleMenu/selectByRoleCode',
            data: {rid:<c:out value="${param.id}" />},
            dataType: "json",
            success: function (result) {
                initTree(result);
            },
            error: function (msg) {
                alert("菜单初始化异常");
            }
        });
    }

    //初始化角色
    function initRole() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/upms/role/selectById',
            data: {rid:<c:out value="${param.id}" />},
            dataType: "json",
            success: function (result) {
                $("input[name='roleName']").val(result.role.roleName);
                $("input[name='power']").val(result.role.power);
                $("input[name='orderNo']").val(result.role.orderNo);
                $("input[name='description']").val(result.role.description);
            },
            error: function (msg) {
                alert("角色初始化异常");
            }
        });
    }


    //更新角色
    layui.use('form', function () {
        var form = layui.form;

        //监听提交
        form.on('submit(formDemo)', function (data) {

            update();
            $.ajax({
                type: 'post',
                url: '${ctx }sys/upms/role/update',
                data: $('#main_form').serialize(),
                success: function (result) {
                    if (result.status == 1) {
                        parent.layer.alert(result.msg, {icon: 1},function (){
                            parent.layer.closeAll();
                        });
                    } else {
                        alert("操作失败");
                    }
                },
                error: function (msg) {
                    alert("系统异常");
                }
            });

            return false;
        });

    });


    $(document).ready(function () {
        initRoleMenu();
        initRole();
    });


</script>

</body>
</html>