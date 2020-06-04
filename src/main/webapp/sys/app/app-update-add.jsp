<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="keywords" content="">
<meta name="description" content="">
<%@ include file="/commViews/head.jsp"%>
<link rel="stylesheet"
	href="${ctx }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script src="${ctxRes}plugins/layui/layui.js" charset="utf-8"></script>

<script type="text/javascript"
	src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
</head>
<body>
<div style="padding:10px">
	<div class="layui-form-item">
		<div class="layui-input-inline">
			<input type="text" id="version" lay-verify="required"
				placeholder="版本号" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item layui-form-text">
			<textarea id="describe" placeholder="文件描述"
				lay-verify="required" class="layui-textarea"></textarea>
	</div>
	<div class="layui-form-item" style="" >
		<button class="layui-btn layui-btn " lay-submit
			 id="test1">选择文件</button>
	</div>
	<div class="layui-form-item"  align="center">
		<button class="layui-btn layui-btn-normal" lay-submit
			 id="test2">立即发布</button>
	</div>
</div>
	<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
	<script>
		layui.use('upload', function() {
			var upload = layui.upload;

			//执行实例
			var uploadInst = upload.render({
				elem : '#test1' ,//绑定元素
				url : '${ctx}base/uploadApk' ,//上传接口
				accept : 'file',
				auto : false,
				accept: 'file',
				exts:'apk',
				bindAction : '#test2',
				done : function(res) {
					console.log(res.fileName)
					if (res.status == 1) {
						$.ajax({
							type : 'post',
							url : '${ctx }sys/apkUpdate/insert?version='+$("#version").val()+"&description="+$("#describe").val()+"&path="+res.fileName,
							dataType : 'json',
							async:false,
							success : function(result) {
								if (result.status == 1) {
									parent.layer.msg('上传成功', {
										icon : 1
									});
								} else {
									parent.layer.msg('上传失败', {
										icon : 5
									});
								}
								closeWindow();
							},
							error : function(msg) {
								console.log(msg);
								alert("系统异常");
							}
						});
					}
					//上传完毕回调
				},
				error : function(res) {
					console.log(res)
					//请求异常回调
				}
			});
		});
		//关闭当前弹出窗口
		function closeWindow() {
			window.parent.frames["应用升级"].location.reload();// 刷新父窗口
			setTimeout(function() {
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭
				//layer.closeAll(); //疯狂模式，关闭所有层
			}, 1000)
		}
	</script>

</body>
</html>

