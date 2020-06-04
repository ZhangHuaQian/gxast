<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>部门添加</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="">
  <meta name="description" content="">
  <%@ include file="/commViews/head.jsp"%>
</head>
<body>

<!-- 菜单添加 -->
<form class="layui-form layui-form-pane" id="main_form" style="">
       <div class="layui-card-body">
     	<div class="layui-form-item">
		    <label class="layui-form-label">部门名称</label>
		    <div class="layui-input-inline">
		      <input type="text" name="name" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
		    </div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">排序</label>
		    <div class="layui-input-inline">
		      <input type="number" name="orderNo" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
		    </div>
		</div>
		<div class="layui-form-item"> 
		    <label class="layui-form-label">上级部门</label>
		    <div class="layui-input-inline"> 
		      <input type="hidden" name="pId" id="pMenuCode"  value="${param.id}">
		      <input type="text" name="name" id="menuTypeBut" value="${param.name}" disabled="disabled" placeholder="请选择部门" autocomplete="off" class="layui-input">
		    </div>
		</div> 
		<div class="layui-form-item">
		    <div class="layui-input-inline">
		      <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
		    </div>
		</div>
       </div>
</form>
 
<script>

//
layui.use('form', function(){
  var form = layui.form;
  
  //监听提交
  form.on('submit(formDemo)', function(data){
     $.ajax({
		type:'post',
		url:'${ctx }sys/upms/department/insert',
		data:$('#main_form').serialize(),
		success:function(result){
		    if(result.status == 1){
                layer.msg(result.msg,{icon: 1});
                setTimeout(function (){
                    window.parent.frames["部门管理"].location.reload() ;// 刷新父窗口
                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                    parent.layer.close(index); //再执行关闭
                },1000)
            }else{
                layer.msg(result.msg,{icon: 5});
            }

		},
		error:function (msg){
			console.log(msg);
			alert("系统异常");
		}
	});
	
    return false;
  });
});

</script>

</body>


</html>