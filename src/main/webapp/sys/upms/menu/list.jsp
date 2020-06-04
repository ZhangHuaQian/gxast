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
    <link rel="stylesheet" href="${ctx }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
</head>
<body>

<!-- 菜单添加 -->
<form class="layui-form layui-form-pane" id="main_form" style="">
    <blockquote class="layui-elem-quote" style="padding:10px;margin-bottom:10px;">
        <!-- Tips：添加菜单须选着上级菜单,默认为顶级菜单-->
        <a class="layui-btn layui-btn-normal" onclick="insertMenu()"><i class="layui-icon"></i>添加菜单</a>
        <a class="layui-btn layui-btn-warm" onclick="updateMenu()"><i class="layui-icon"></i>编辑菜单</a>
        <a class="layui-btn layui-btn-danger" onclick="deleteMenu()"><i class="layui-icon"></i>删除菜单</a>
        <a class="layui-btn layui-btn-small" style="margin-right:5px;float:right"
           href="javascript:location.replace(location.href);" title="刷新">刷新</a>
    </blockquote>

    <div style="padding: 5px; background-color: #F2F2F2;">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-header">菜单列表</div>
                    <div class="layui-card-body">
                        <div style="height:400px;;width:300px;overflow-y:auto; overflow-x:auto;">
                            <!-- <h4 align="center" style="background: #FBFBFB;border-bottom:1px solid #eee;height:35px;line-height: 35px;">上级菜单</h4> -->
                            <ul id="treeDemo" class="ztree"></ul>
                            <input type="hidden" id="bindMenuCode" value="" mname="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>

<script>


    //编辑
    function updateMenu(){
        if($("#bindMenuCode").val()==""){parent.layer.msg('请先选择菜单再进行操作', {icon: 5});
            return;
        }
        cen_showWin({width:'700px',height:'360px',type:2,title:'编辑菜单',url:'${ctx}sys/upms/menu/update.jsp?id='+$("#bindMenuCode").val()});
    }

    //添加
    function insertMenu(){
        var bindMenuCode = $("#bindMenuCode");
        if(bindMenuCode.val()==""){parent.layer.msg('请先选择菜单再进行操作', {icon: 5});
            return;
        }
        var tempURL = '${ctx}sys/upms/menu/insert.jsp?pMenuCode='+bindMenuCode.val()+'&name='+bindMenuCode.attr("mname");
        cen_showWin({width:'700px',height:'360px',type:2,title:'添加菜单',url:tempURL});
    }

    //删除按钮
    function deleteMenu(){
        if($("#bindMenuCode").val()==""){parent.layer.msg('请先选择菜单再进行操作', {icon: 5});
            return;
        }
        parent.layer.confirm('确定删除 <span style="color:red">'+$("#bindMenuCode").attr("mname")+'</span> 吗？', {
            btn: ['确定','取消'] //按钮
        }, function(index){
            parent.layer.close(index);
            deleteDepAjax();
        }, function(){});
    }

    // 删除请求
    function deleteDepAjax(){
        $.ajax({
            type:'post',
            url:'${ctx }sys/upms/menu/update?id='+$("#bindMenuCode").val()+'&isDel=1',
            dataType:"json",
            success:function(result){
                if(result.status == 1){
                    initTree(); //重新加载
                    parent.layer.msg('删除成功', {icon: 1});
                }else{
                    parent.layer.msg('操作失败', {icon: 1});
                }
            },
            error:function (msg){
                alert("系统异常");
            }
        });
    }

    // 设置pid
    function setPid(data) {
        $("#bindMenuCode").val(data.pMenuCode);
        $("#bindMenuCode").attr('mname',data.menuName);
    }

    var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
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
        },
        view: {
            showIcon: false    //设置 zTree 不显示图标
        },
        callback: {
            onClick: zTreeOnClick
        }
    };

    //树菜单点击事件
    function zTreeOnClick(event, treeId, treeNode) {
        setPid({pMenuCode: treeNode.id, menuName: treeNode.menuName})
    }
    ;

    function initTree() {
        $.ajax({
            type: 'post',
            url: '${ctx }sys/upms/menu/selectAll',
            data: $('#main_form').serialize(),
            dataType: "json",
            success: function (result) {
                for(var i=0;i<result.length;i++){
                    result[i].icon="${ctx}uploadFiles/photo/"+result[i].icon;
                }
                //console.log(result)
                zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, result);
                zTreeObj.expandAll(true); //默认全部展开
                //$("[id*='interface_tree']").css("font-size","36px");
            },
            error: function (msg) {
                alert("菜单初始化异常");
            }
        });
    }

    $(document).ready(function () {
        initTree();
    });

    var indexWin ;
    //新建窗口
    function cen_showWin(param){
        indexWin = parent.layer.open({
            type: param.type,
            area: [param.width, param.height],
            title: param.title,
            closeBtn: 1,
            //shade: [0.1, '#FFFFFF'],
            shadeClose: true,
            skin: 'yourclass',
            resize:true,
            success: function(layero, index){
                //console.log(layero, index);
            },
            content: param.url
        });
    }

    //关闭窗口
    function layerClose(){
        parent.layer.close(indexWin);
    }


</script>

</body>


</html>