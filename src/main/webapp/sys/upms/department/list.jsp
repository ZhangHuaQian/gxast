<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title></title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="">
  <meta name="description" content="">
  <%@ include file="/commViews/head.jsp"%>
  <link rel="stylesheet" href="${ctx }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
  <script type="text/javascript" src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
</head>
<body>

<!-- 菜单添加 -->
<form class="layui-form layui-form-pane" id="main_form" style="">
   <blockquote class="layui-elem-quote" style="padding:10px;margin-bottom:10px;">
    <!-- Tips：添加部门须选着上级部门,默认为顶级部门 -->
    <a class="layui-btn layui-btn-normal" onclick="insertDep()"><i class="layui-icon"></i>添加部门</a>
    <a class="layui-btn layui-btn-warm" onclick="updateDep()"><i class="layui-icon">&#xe642;</i>编辑部门</a>
    <a class="layui-btn layui-btn-danger" onclick="deleteDep()"><i class="layui-icon">&#xe640;</i>删除部门</a>
	<a class="layui-btn layui-btn-small" style="margin-right:5px;float:right" href="javascript:location.replace(location.href);" title="刷新">刷新</a>
  </blockquote>
   
	<div style="padding: 5px; background-color: #F2F2F2;">
	  <div class="layui-row layui-col-space15">
	    <div class="layui-col-md12">
	      <div class="layui-card">
	        <div class="layui-card-header">部门列表</div>
	        <div class="layui-card-body">   
		  		<div style="height:300px;;width:300px;overflow-y:auto; overflow-x:auto;">
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
		key : {
	    	name : "name", // 节点名称
	    	url : "xURL" // URL
	    }
	},
	callback: {
        onClick: zTreeOnClick
    } 
};

//树菜单点击事件
function zTreeOnClick(event, treeId, treeNode) {
    //setPid({pId:treeNode.id,name:treeNode.name});
    $("#bindMenuCode").val(treeNode.id).attr("mname",treeNode.name);
};

function initTree(){
	$.ajax({
		type:'get',
		url:'${ctx }sys/upms/department/selectByThisUser',
		data:$('#main_form').serialize(),
		dataType:"json",
		success:function(result){
			console.log(result);
			zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, result.list);
			zTreeObj.expandAll(true); //默认全部展开
		},
		error:function (msg){
			alert("部门初始化异常");
		}
	});
}



//添加
function insertDep(){
    var bindMenuCode = $("#bindMenuCode");
	if(bindMenuCode.val()==""){parent.layer.msg('请先选择一个部门再进行操作', {icon: 5});
		return;
	}
	var tempURL = '${ctx}sys/upms/department/insert.jsp?id='+bindMenuCode.val()+'&name='+bindMenuCode.attr("mname");
	cen_showWin({width:'350px',height:'280px',type:2,title:'添加部门',url:tempURL});
}

//删除按钮
function deleteDep(){
	if($("#bindMenuCode").val()==""){parent.layer.msg('请先选择一个部门再进行操作', {icon: 5});
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
        url:'${ctx }sys/upms/department/update?id='+$("#bindMenuCode").val()+'&isDel=1',
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


//编辑按钮
function updateDep(){
	if($("#bindMenuCode").val()==""){parent.layer.msg('请先选择一个部门再进行操作', {icon: 5});
		return;
	}
	cen_showWin({width:'350px',height:'230px',type:2,title:'编辑部门',url:'${ctx}sys/upms/department/update.jsp?id='+$("#bindMenuCode").val()});
}

$(document).ready(function(){
	initTree();
});

</script>

</body>


</html>