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
  <script type="text/javascript" src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.core.min.js"></script>
  <script type="text/javascript" src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.excheck.min.js"></script>
</head>
<body>
<!-- 角色添加 -->
<form class="layui-form layui-form-pane" id="main_form" style="padding: 10px;">
  <div class="layui-form-item">
    <label class="layui-form-label">角色名称</label>
     <div class="layui-input-block">
       <input type="text" name="roleName" placeholder="" lay-verify="required" autocomplete="off" class="layui-input">
     </div>
  </div>
    <div class="layui-form-item">
        <label class="layui-form-label">权限标识</label>
        <div class="layui-input-block">
            <input type="text" name="power" placeholder="" lay-verify="required" autocomplete="off" class="layui-input">
        </div>
    </div>
  <div class="layui-form-item">
    <label class="layui-form-label">排序</label>
     <div class="layui-input-block">
       <input type="number" name="orderNo" placeholder="" lay-verify="required" autocomplete="off" class="layui-input">
     </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">描述</label>
     <div class="layui-input-block"> 
       <input type="text" name="description" placeholder="" lay-verify="required" autocomplete="off" class="layui-input">
     </div>
  </div>
  
 <div class="layui-form-item" style="">
     <%--<label class="layui-form-label"></label>--%>
     <div class="layui-input-block">
         <button class="layui-btn" lay-submit lay-filter="formDemo">添加</button>
         <button type="reset" class="layui-btn layui-btn-primary">重置</button>
     </div>
</div>
</form>

<script>

//添加角色
layui.use('form', function(){
  var form = layui.form;
  
  //监听提交
  form.on('submit(formDemo)', function(data){
	  
     $.ajax({
		type:'post',
		url:'${ctx }sys/upms/role/insert.do',
		data:$('#main_form').serialize(),
		success:function(result){
			if(result>0){
				layer.msg("提交成功");
				setInterval(function (){
					parent.window.frames['main_iframe'].layerClose();
				},500);
				window.parent.iframeReload(1000);
			}else{
				alert("提交失败");
			}
		},
		error:function (msg){
			alert("系统异常");
		}
	}); 
	
    return false;
  });
});




</script>

<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="editMenu">配置菜单</a>
</script>
 

</body>
</html>