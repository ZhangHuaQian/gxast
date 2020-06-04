<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../../commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>layout 后台大布局 - Layui</title>
 <%@ include file="../../../commViews/head.jsp"%>
  <script src="${ctx }resource/plugins/wangEditor-3.1.1/release/wangEditor.min.js" type="text/javascript" charset="utf-8"></script>
</head>
  
  <div class="" id="div1">
    <!-- 内容主体区域 -->
    <div style="padding: 10px;"> 
    
  <form class="layui-form" id="main_form">
  <div class="layui-form-item">
   	<label class="layui-form-label">敏感词</label>
   	<div class="layui-input-block">
    	 	<input type="text" name="words" required  lay-verify="required" placeholder="请输入内容" autocomplete="off" class="layui-input">
   	</div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
     <!--  <button class="layui-btn" lay-submit lay-filter="formDemo" >立即提交</button> -->
      <button class="layui-btn layui-btn-warm" lay-submit="" lay-filter="demo1" id="subBtn">立即提交</button>
    </div>
  </div>
	</form>
    </div>
     
  </div>
  
<script type="text/javascript">


//关闭当前弹出窗口
function closeWindow() {
	if($(window.parent.frames["敏感词管理"]).length>0){
		window.parent.frames["敏感词管理"].location.reload() ;// 刷新父窗口
		 setTimeout(function (){
		        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		        parent.layer.close(index); //再执行关闭
		        //layer.closeAll(); //疯狂模式，关闭所有层
		    },1000)
	}
	if($(window.parent.frames["添加敏感词"]).length>0){
		//window.parent.frames["添加资讯"].location.reload() ; 刷新父窗口
		
	}
}
function sendData(){
	var fromDate = $('#main_form').serialize();
	$.ajax({
		type:'post',
		url:'${ctx }sys/sensitive/insert',
		data:fromDate,
		async:false,
		success:function(result){
			closeWindow();
			layer.msg(result.msg);
		},
		error:function (msg){
			alert("错误");
		}
	});
};
layui.use('form', function(){
	var form = layui.form;
	form.on('submit(demo1)', function () {
		sendData();
    	return false;
  	});
	form.render();
}); 
</script>
</body>
</html>