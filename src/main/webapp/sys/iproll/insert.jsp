<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> 
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>黑白名单</title>
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
            <label class="layui-form-label">IP地址</label>
            <div class="layui-input-inline">
                <input type="text" name="ipaddress" lay-verify="required" placeholder="IP地址" autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">状态</label>
            <div class="layui-input-inline">
                <input type="radio" name="status" value="0" title="启用" checked>
                <input type="radio" name="status" value="1" title="停用">
            </div>
        </div>
        
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn layui-btn-normal" lay-submit lay-filter="formDemo">添加IP地址</button>
                <%--<button type="reset" class="layui-btn layui-btn-primary">重置</button>--%>
            </div>
        </div>
    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>

    //关闭当前弹出窗口
    function closeWindow() {
        window.parent.frames["黑白名单"].location.reload() ;// 刷新父窗口
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
                //console.log($('#main_form').serialize())
                $.ajax({
                    type: 'POST',
                    url: '${ctx }sys/iproll/insert',
                    data: $('#main_form').serialize(),
                    dataType: 'json',
                    success: function (result) {
                    	if(result.status==1){
                    	    console.log(result.status);
                    		closeWindow();
                            layer.msg(result.msg);
                         }else if(result.status==2){
                        	console.log(result.status);
                            layer.msg(result.msg);
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


    // 初始化角色下拉
    function initRoleSelect() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/upms/role/selectAll',
            //data:$('#main_form').serialize(),
            dataType: 'json',
            success: function (result) {
                var list = result.list;
                var str = "";
                for (var i = 0; i < list.length; i++) {
                    str += '<option value="' + list[i].id + '">' + list[i].roleName + '</option>';
                }
                $("#roleSelect").append(str);
                renderForm();//渲染表单
            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }


    var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
   /* var setting = {
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
    };*/

    //树菜单点击事件
   /* function zTreeOnClick(event, treeId, treeNode) {
        $("#selectTreeBut").val(treeNode.name);
        $("#departmentValue").val(treeNode.id);
    }
    ;*/

    //初始化部门下拉
    /*function initDepartmentSelect() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/upms/department/selectByThisUser',
            //data:$('#main_form').serialize(),
            dataType: 'json',
            success: function (result) {
                //console.log(result);
                zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, result.list);
                zTreeObj.expandAll(true); //默认全部展开
            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }*/

    //下拉树
   /* function bindTree() {
        $("#selectTreeBut").click(function () {
            $("#selectTree").toggle(500, function () {
                $(this).mouseleave(function () {
                    $(this).hide();
                });
            });
        });
    }*/

    $(function () {
        initRoleSelect();
        bindTree();
        initDepartmentSelect();
    });

</script>

</body>
</html>