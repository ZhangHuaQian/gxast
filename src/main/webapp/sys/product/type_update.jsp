<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>添加土特产</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="keywords" content="">
<meta name="description" content="">
<%@ include file="/commViews/head.jsp"%>
<link rel="stylesheet"
	href="${ctx }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript"
	src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<style type="text/css">
.content-a-upload {
	text-align: center;
	position: relative;
	float: left;
	height: 30px;
	width: 100px;
	line-height: 35px;
	color: #FFFFFF;
	background: #EF4F4F !important;
	border-radius: 2px;
	display: inline-block;
}

.layui-upload-img {
	width: 90px;
	height: 90px;
	padding: 4px
}

.content-a-upload input {
	position: absolute;
	float: left;
	right: 0;
	top: 0;
	opacity: 0;
	cursor: pointer;
}

.content-a-upload:hover {
	color: #FFFFFF;
	background: #EF4F4F !important;
	border-color: #ccc;
	text-decoration: none
}
</style>
</head>
<body>

	<!-- 菜单添加 -->
	<form class="layui-form layui-form-pane" id="main_form" style="">

		<div style="padding: 10px;">

			<div class="layui-form-item">
				<label class="layui-form-label">型号名称</label>
				<div class="layui-input-inline">
					<input type="text" id="name" lay-verify="required" value="${param.name }" maxlength="20"
						placeholder="型号名称" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">型号价格</label>
				<div class="layui-input-inline">  
					<input type="number" id="price" lay-verify="required" value="${param.price }" maxlength="10"
						placeholder="型号价格" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">型号重量</label>    
				<div class="layui-input-inline">  
					<input type="number" id="weight" lay-verify="required" value="${param.weight }"  maxlength="10" 
						placeholder="型号重量" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">型号库存</label>    
				<div class="layui-input-inline">  
					<input type="number" id="stock" lay-verify="required" value="${param.stock }" onkeyup="NumberCheck(this)" maxlength="10"
						placeholder="型号库存" autocomplete="off" class="layui-input">
				</div> 
			</div>
			<!--显示图片-->
			<div class="layui-form-item">
				<label class="layui-form-label">型号图片 </label>
				<div class="layui-input-inline"
					style="margin-right: 0px; width: 40%">
					<input type="hidden" id="image" class="layui-input" name="image"
						required lay-verify="required" placeholder="图片路径"
						autocomplete="off" style="display: none" value="${param.image}"/>  
				</div>
				<div class="layui-input-block" style="float: left; margin-left: 0px">
					<a href="" class="content-a-upload" style="height: 36px;"><input
						type="file" id="projectImgBtn" style="height: 36px; width: 100px" />选择图片</a>
				</div>
			</div>      
			<div class="layui-form-item" <c:if test="${param.image == ''}">style="display:none"</c:if> id="project_Img">   
				<ul>
					<li><img src="${ctx}uploadFiles/photo/${param.image}"   
						style="margin-left: 120px; width: 400px; height: 230px;" /></li>
				</ul>
			</div>
			<!-- 按钮 -->
			<div class="layui-form-item">
				<div class="layui-input-block">
					<div class="layui-btn layui-btn layui-btn-normal" onclick="send()">更新型号</div>     
				</div>
			</div>
			
		</div>
		</div>
	</form>  
	
	<script type="text/javascript">   
	function NumberCheck(t){
        var num = t.value;
        var re=/^\d*$/;
        if(!re.test(num)){
            isNaN(parseInt(num))?t.value=0:t.value=parseInt(num);
        }
    }                  
		var	form;
		layui.use([ 'form' ], function() {   
			form = layui.form;
		});
		// 图片上传
		$('#projectImgBtn').change(function() {
			run(this, function(data) {
				uploadImage(data);
			});
		});

		//图片转码
		function run(input_file, get_data) {
			/*input_file：文件按钮对象*/
			/*get_data: 转换成功后执行的方法*/
			if (typeof (FileReader) === 'undefined') {
				layer.alert(
						"抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！", {
							icon : 5
						});
				//alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！");
			} else {
				try {
					/*图片转Base64 核心代码*/
					var file = input_file.files[0];
					//这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件
					if (!/image\/\w+/.test(file.type)) {
						layer.alert("请确保文件为图像类型", {
							icon : 5
						});
						return false;
					}
					var reader = new FileReader();
					reader.onload = function() {
						get_data(this.result);
					}
					reader.readAsDataURL(file);
				} catch (e) {
					layer.alert('图片转Base64出错啦！' + e.toString(), {
						icon : 5
					});
				}
			}
		}

		//图片上传
		function uploadImage(img) {
			//判断是否有选择上传文件
			var imgPath = $("#projectImgBtn").val();
			if (imgPath == "") {
				layer.alert('请选择上传图片！', {
					icon : 5
				});
				return;
			}
			//判断上传文件的后缀名
			var strExtension = imgPath.substr(imgPath.lastIndexOf('.') + 1);
			if (strExtension != 'jpg' && strExtension != 'gif'
					&& strExtension != 'png' && strExtension != 'bmp'
					&& strExtension != 'jpeg') {
				layer.alert("这不是图片文件!", {
					icon : 5
				});
				return;
			}
			$.ajax({
				type : "POST",
				url : "${ctx}base/uploadImgCommon.do",
				data : {
					base64Data : img,
					width : 260,
					height : 260
				}, //视情况将base64的前面字符串data:image/png;base64,删除
				cache : false,
				dataType : "text",
				success : function(data) {
					console.log(data);
					//hui.closeLoading();
					$("#project_Img img").attr("src", img)
					// $("#imageshow").attr("src",img);
					// $("#imageshow").show();
					if ($("#project_Img img")[0].src != null
							&& $("#project_Img img")[0].src != '') {
						$("#project_Img").show();
					} else {
						$("#project_Img").hide();
					}

					$("#recordCertificate").val(data);
					$("#image").val(data.replace("uploadFiles/photo/", ""));
					layer.msg('图片上传成功', {
						icon : 6
					});
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					//hui.closeLoading();
					console.log(XMLHttpRequest);
					console.log(textStatus);
					console.log(errorThrown);
					layer.msg('请检查网络后重试', {
						icon : 5
					});
				}
			});    
		}
		function send(){                         
			if($("#name").val()==""||$("#name").val()==null){
				layer.msg("名称不能留空");
				return false;
			}
			if($("#price").val()==""||$("#price").val()==null){            
				layer.msg("价格不能留空");
				return false;
			}
			if($("#price").val().indexOf('-')!= -1||$("#price").val().indexOf('+')!= -1){                  
				layer.msg("价格不能有其它符号");          
				return false;
			}
			if($("#weight").val()==""||$("#weight").val()==null){
				layer.msg("重量不能留空");
				return false;
			}
			if($("#weight").val().indexOf('-')!= -1||$("#weight").val().indexOf('+')!= -1){                  
				layer.msg("重量不能有其它符号");          
				return false;
			}
			if($("#stock").val()==""||$("#stock").val()==null){
				layer.msg("库存不能留空");                         
				return false;
			}
			if($("#stock").val().indexOf('-')!= -1||$("#stock").val().indexOf('+')!= -1){                  
				layer.msg("库存不能有其它符号");                              
				return false;
			}
			if($("#image").val()==""||$("#image").val()==null){
				layer.msg("图片不能留空");
				return false;
			}
			var param = {id_:"${param.id}",name:$("#name").val(),stock:$("#stock").val(),image:$("#image").val(),price:$("#price").val(),weight:$("#weight").val()};
			console.log(param);       
			parent.JsonData_update(param);                        
			layer.msg("更新成功"); 
			setTimeout( function(){   
				window.location.reload();
			}, 1500 );
		}     
		//渲染表单  
		function renderForm() {
			layui.use('form', function() {       
				form = layui.form;
			});
		}
	</script>

</body>
</html>