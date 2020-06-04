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
<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs" type="button" lay-event="update"><i class="layui-icon">&#xe615;</i>编辑</button>
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除  
    </button>      
</script>
<script type="text/html" id="showImg">   
   {{#if(d.image!=""){ }}
 	<a href="#"><img onclick="whole(this)" style="height:26px;width:50px;" src="${ctx}uploadFiles/photo/{{d.image}}"/></a> 
 	{{# } }} 
</script>
<body>

	<!-- 菜单添加 -->
	<form class="layui-form layui-form-pane" id="main_form" style="">

		<div style="padding: 10px;">

			<div class="layui-form-item">
				<label class="layui-form-label">商品名称</label>
				<div class="layui-input-inline">
					<input type="text" name="name" lay-verify="required" maxlength="20"
						placeholder="商品名称" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">商品类型</label>
				<div class="layui-input-inline">
					<select name="type" id="type" lay-search="" lay-verify="required">
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">商品描述 </label>
				<div class="layui-input-inline" style="width: 52%">
					<input type="text" name="description" placeholder="商品描述"
						maxlength="100" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">限时出售</label>
				<div class="layui-input-inline" style="width: 70px">
					<input type="checkbox" lay-skin="switch" lay-text="开启|关闭"
						lay-filter="switch" id="switch">
				</div>
				<div class="layui-input-inline">
					<input class="layui-input" placeholder="起始日期" style="display: none"
						name="startTime" id="startTime">
				</div>
				<div class="layui-input-inline">
					<input class="layui-input" placeholder="截止日期" style="display: none"
						name="endTime" id="endTime">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">是否上架</label>
				<div class="layui-input-block">
					<input type="radio" name="isUp" value="1" title="是" id="isUp1">
					<input type="radio" name="isUp" value="0" title="否" id="isUp0">
				</div>
			</div>
			<label class="layui-form-label">添加型号</label>
			<div class="layui-btn layui-btn-fluid" onclick="type_add()"
				style="width: 100px; margin-bottom: 10px">添加型号</div>
			<table class="layui-hide" id="demo" lay-filter="testTable"></table>
			<!--显示图片-->
			<div class="layui-form-item">
				<label class="layui-form-label">封面图片 </label>
				<div class="layui-input-inline"
					style="margin-right: 0px; width: 40%">
					<input type="hidden" id="image" class="layui-input" name="image"
						required lay-verify="image" placeholder="图片路径" autocomplete="off"
						style="display: none" />
				</div>
				<div class="layui-input-block" style="float: left; margin-left: 0px">
					<div class="content-a-upload" style="height: 36px;"><input
						 onclick="updatephoto()" style="height: 36px; width: 100px" />选择图片</div>
				</div>
			</div>
			<div class="layui-form-item" style="display: none;" id="project_Img">
				<ul>
					<li><img src=""
						style="margin-left: 110px; width: 400px; height: auto;" /></li>
				</ul>
			</div>
			<!--产品链接-->
			<div class="layui-form-item">
				<label class="layui-form-label">轮播图片 </label>
				<div class="layui-input-inline" style="width: 50%; display: none;">
					<input type="text" id="pic" placeholder="轮播图片" autocomplete="off"
						class="layui-input" name="slide">
				</div>
				<button type="button" class="layui-btn" id="test2">多图片上传</button>
				<button type="button" class="layui-btn" id="remove">清空轮播列表</button>
			</div>
			<div class="layui-upload">
				<blockquote class="layui-elem-quote layui-quote-nm"
					style="margin-top: 10px;">                
					预览图<span style="color:red">(双击删除)</span>
					<div class="layui-upload-list" id="demo2"></div>
				</blockquote>
			</div>
			<!-- 商品详情 -->
			<div class="layui-form-item layui-form-text" style="display: none;">
				<label class="layui-form-label">正文</label>
				<div class="layui-input-block">
					<textarea placeholder="请输入内容" class="layui-textarea"
						id="contentTEXT"></textarea>
				</div>
			</div>
			<div class="layui-form-item" id="x-city">
				<label class="layui-form-label">地区</label>
				<div class="layui-input-inline">
					<select name="province" id="province" lay-filter="province">
						<option value="">请选择省</option>
					</select>
				</div>
				<div class="layui-input-inline">
					<select name="city" id="city" lay-filter="city">
						<option value="">请选择市</option>
					</select>
				</div>
				<div class="layui-input-inline">
					<select name="area" id="area" lay-filter="area">
						<option value="">请选择县/区</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">详情页</label>
				<div class="layui-input-block">
					<textarea id="demo3" style="display: none;"></textarea>
				</div>
			</div>
			<!-- 按钮 -->
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button type="button" class="layui-btn layui-btn layui-btn-normal"
						lay-submit lay-filter="formDemo">更新商品信息</button>
				</div>
			</div>

		</div>
		</div>
	</form>

	<script type="text/javascript">
		var array1;
		var layedit;                                       
		//富文本
		var layeditIndex;
		//型号编号 
		var id = 1;
		//型号页面iframe   
		var index;
		//型号更新页面iframe    
		var index2;
		
		var index3;                        
		//表格                    
		var table;                    
		//型号列表      
		var array = new Array();
		//填充型号列表
		function JsonData(param) {
			console.log(param);
			console.log(index);
			array.push(param);
			layer.close(index);
			render_table();
			id++;
		}
		function JsonData_update(param) {
			for (var i = 0; i < array.length; i++) {
				if (param.id_ == array[i].id_) {
					array[i] = param;
					render_table();
					layer.close(index2);
				}
			}
		}
		//渲染表格
		function render_table() {
			table.render({
				elem : '#demo',
				cols : [ [ //标题栏
				{
					field : 'id_',
					title : 'id',
					width : 120
				}, {
					field : 'name',
					title : '型号名称',
					width : 120
				}, {
					field : 'image',
					title : '预览图',
					width : 80,
					templet : "#showImg"
				}, {
					field : 'price',
					title : '价格',
					minWidth : 100,
					sort : true
				}, {
					field : 'weight',
					title : '重量',
					minWidth : 100,
					sort : true
				}, {
					field : 'stock',
					title : '库存',
					minWidth : 100,
					sort : true
				}, {
					fixed : 'right',
					title : '操作',
					width : 250,
					align : 'center',
					toolbar : '#barDemo'
				} ] ],
				limit : 50,
				data : array,
				even : true
			});
			//监听工具条   
			table.on('tool(testTable)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
				var data = obj.data; //获得当前行数据
				var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				var tr = obj.tr; //获得当前行 tr 的DOM对象
				if (layEvent === 'update') { //编辑   
					type_update(data);
				} else if (layEvent === 'delete') { //删除
					obj.del();
					array.splice(data.id_ - 1,1);                                               
				}
			});
		}
		//初始化
		layui.use('table', function() {
			table = layui.table;
			//展示已知数据
			render_table();
		});
		//型号图片预览
		function whole(image) {
			console.log(image.src)
			layer.open({
				type : 1,
				title : false,
				closeBtn : 1,
				shadeClose : true,
				skin : 'yourclass',
				shade : 0,
				resize : true,
				title : '预览图',             
				move : '.layui-layer-title',
				content : "<img style='height:100%;width:100%;' src='"
						+ image.src + "'/>"
			});
		}
		//添加型号页面
		function type_add() {
			index = layer.open({
				type : 2,                        
				title : '添加型号',
				area : [ '600px', '400px' ],
				content : '${ctx}sys/product/type_add.jsp?iframeID='
						+ window.name,
				cancel : function(index, layero) {
					if (confirm('当前内容尚未保存,确定要关闭吗？')) { //只有当点击confirm框的确定时，该层才会关闭
						layer.close(index)
					}
					return false;
				}
			});
		}
		//更新型号页面 
		function type_update(data) {
			index2 = layer.open({
				type : 2,
				title : '更新型号',
				area : [ '600px', '400px' ],
				content : '${ctx}sys/product/type_update.jsp?iframeID='
						+ window.name + '&name=' + data.name + '&image='
						+ data.image + '&weight=' + data.weight + '&price='
						+ data.price + '&id=' + data.id_ + "&stock="
						+ data.stock,
				cancel : function(index, layero) {
					if (confirm('当前修改内容尚未保存，确定要关闭吗？')) { //只有当点击confirm框的确定时，该层才会关闭
						layer.close(index)
					}
					return false;
				}

			});
		}
		var form;
		//轮播图清空
		$("#remove").click(function() {
			$(".layui-upload-img").remove();
			$("#pic").val("");
		});
		//富文本上传图片，视频
		layui.use('layedit', function() {
			layedit = layui.layedit;
			layeditIndex = layedit.build('demo3', {
				height : 600,
				uploadImage : {
					url : '${ctx}base/uploadfile',
					type : 'post' //默认post 
				},
				uploadVideo : {
					url : '${ctx}base/uploadVideoCommon',
					accept : 'video',
					acceptMime : 'video/*',
					exts : 'mp4|flv|avi|rm|rmvb',
					size : '20480'
				}
			});
		});
		layui.use('upload',function() {
		var $ = layui.jquery, upload = layui.upload;
		//多图片上传
		upload.render({
					type : "POST",
					elem : '#test2',
					url : '${ctx}base/uploadfile',
					multiple : true,
					number : 5,
					before : function(obj) {
						//预读本地文件示例，不支持ie8
						obj.preview(function(index,file, result) {
									if ($("#demo2").find(
											"img").size() >= 5) {
										layer.msg('不能超过5张',{icon : 5});
										return false;
									}
									$('#demo2').append('<img src="'+ result +'" alt="'+ file.name +'" class="layui-upload-img">');
								});
					},
					done : function(res) {
						if ($("#pic").val() == null|| $("#pic").val() == "") {
							$("#pic").val(res.data.src)
						} else {
							$("#pic").val($("#pic").val() + ","+ res.data.src);
						}
						console.log(res)
						//上传完毕
					}
				});
						});
		layui.use([ 'form' ], function() {
			form = layui.form;
			form.verify({
				image : function(value, item) { //value：表单的值、item：表单的DOM对象
					if (value == null || value == "") {
						return '封面图片不能留空';
					}
				}
			});
			form.on('submit(formDemo)', function(data) {
				if (array.length == 0) {
					layer.msg('请至少添加一种型号', {
						icon : 5
					});
					return false;                                 
				}
				//var content = $("#contentTEXT").val(editor.txt.html());
				console.log($('#main_form').serialize() + "&content="
						+ layedit.getContent(layeditIndex) + "&specifications="
						+ JSON.stringify(array));
				$.ajax({
					type : 'POST',
					url : '${ctx }sys/product/update',
					data : $('#main_form').serialize()
							+ "&content="
							+ encodeURIComponent(layedit
									.getContent(layeditIndex))
							+ "&specifications=" + JSON.stringify(array)
							+ "&id=${param.id}",
					dataType : 'json',
					success : function(result) {
						if (result.status == 1) {
							closeWindow();
							layer.msg(result.msg);
						} else if (result.status == 0) {
							layer.msg(result.msg);
						}
					},
					error : function(msg) {
						console.log(msg);
						alert("系统异常");
					}
				});
				return false;
			})
			form.on('switch(switch)', function(data) {
				//console.log(data.elem.checked); //开关是否开启，true或者false
				if (data.elem.checked) {
					$("#startTime").show();
					$("#startTime").attr("lay-verify", "required");
					$("#endTime").show();
					$("#endTime").attr("lay-verify", "required");
				} else {
					$("#startTime").val("");
					$("#endTime").val("");
					$("#startTime").removeAttr("lay-verify");
					$("#endTime").removeAttr("lay-verify");
					$("#startTime").hide();
					$("#endTime").hide();
				}
			});
			//$('#x-city').xcity('广西','百色市','田东县');
		});
		//时间控件初始化
		layui.use('laydate', function() {
			var laydate = layui.laydate;
			//执行一个laydate实例
			laydate.render({
				elem : '#startTime', //指定元素
				format : 'yyyy-MM-dd'
			});

			//执行一个laydate实例
			laydate.render({
				elem : '#endTime', //指定元素
				format : 'yyyy-MM-dd'
			});
		});
		//关闭当前弹出窗口
		function closeWindow() {
			window.parent.frames["商品列表"].location.reload();// 刷新父窗口
			setTimeout(function() {
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭
				//layer.closeAll(); //疯狂模式，关闭所有层
			}, 1000)
		}
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
					if (file == null)
						return false;
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

		//渲染表单
		function renderForm() {
			layui.use('form', function() {
				//form = layui.form;   
				//监听提交

				form.render();
			});
		}
		function updatephoto(){
			index3 = layer.open({              
				type : 2,
				title : '上传图片',
				area : [ '460px', '460px' ],
				content : '${ctx}sys/product/clipphoto.jsp',
				cancel : function(index, layero) {
					if (confirm('当前修改内容尚未保存，确定要关闭吗？')) { //只有当点击confirm框的确定时，该层才会关闭
						layer.close(index)
					}
					return false;                                  
				}               
			});
	    }
		function ImageClip(path){                    
			$("#project_Img img").attr("src","${ctx}uploadFiles/photo/" + path);
			$("input[name='image']").val(path);
			$("#project_Img").show();
			layer.close(index3);                                                           
		}
		//初始化用户信息
		function initUser() {
			$.ajax({type : 'get',
						url : '${ctx }sys/product/select?id=${param.id}',
						dataType : 'json',
						async : false,
						success : function(result) {
							console.log(result);
							var product = result.product;                                                                            
							layui.use([ 'form' ], function() {
								form = layui.form;                                                                  
								//$('#x-city').xcity('广西','百色市','田东县');
								$('#x-city').xcity(product.province,
										product.city, product.area);
								if (product.isUp == 0) {
									$("#isUp0").attr('checked', 'checked');
								} else {
									$("#isUp1").attr('checked', 'checked');
								}
								form.render();
							});
							$("input[name='name']").val(product.name);
							$("#type").val(product.type);
							$("input[name='description']").val(
									product.description);
							$("input[name='image']").val(product.image);
							if (product.startTime != ""
									&& product.startTime != null
									&& product.endTime != null
									&& product.endTime != "") {
								$("#switch").click();
								$("#startTime").show();
								$("#startTime").attr("lay-verify", "required");
								$("#endTime").show();
								$("#endTime").attr("lay-verify", "required");
								$("input[name='startTime']").val(
										formatDate_YMD(product.startTime));
								$("input[name='endTime']").val(
										formatDate_YMD(product.endTime));
							}
							//初始化
							$("#demo3").html(
									htmlspecialchars_decode(product.content));
							$("input[name='slide']").val(product.slide);
							if (!(product.slide.split(",").length == 1 && product.slide
									.split(",")[0] == "")) {
								array1 = product.slide.split(",");
								for (var i = 0; i < array1.length; i++) {
									$('#demo2')
											.append(
													"<img src='"+ array1[i] +"' class='layui-upload-img'>");
								}
							}                                                                                            
							$("#demo2 img").dblclick(function(){                                                                                                                                                
									var index = $(this).index();                  
									array1.splice(index,1);
									console.log(array1);                                                       
									$(this).remove();                                                            
									$("#pic").val(array1.join(','));
									console.log($("#pic").val());
							});                                                      
							$("#project_Img img").attr(
									"src",
									"${ctx}uploadFiles/photo/" + product.image
											+ "")
							$("#project_Img").show();
							array = JSON.parse(product.specifications);
							console.log(array);
							if (array.length != 0)
								id = array[array.length - 1].id_ + 1;

						},
						error : function(msg) {
							console.log(msg);
							alert("初始化异常");
						}
					});
		}
		function htmlspecialchars_decode(str) {
			str = str.replace(/&lt;/g, '<');
			str = str.replace(/&gt;/g, '>');
			str = str.replace(/&#40;/g, "(");
			str = str.replace(/&#41;/g, ")");
			str = str.replace(/&#39;/g, "\'");
			return str;
		}
		//获取产品类型
		function getType() {
			$.ajax({
				type : 'get',
				url : '${ctx }sys/dictionary/selectList?type=product',
				dataType : 'json',
				async : false,
				success : function(result) {
					console.log(result);
					if (result.count > 0) {
						var list = result.list;    
						var data = "<option value=''>选择商品类型</option>";
						for (var i = 0; i < list.length; i++) {     
							data += "<option value="+list[i].id+">"
									+ list[i].name + "</option>";
						}
					}
					$("#type").append(data);
				},
				error : function(msg) {
					console.log(msg);
					alert("数据初始化异常");
				}
			});
		}

		$(function() {
			getType();
			initUser();
			renderForm();
		});
	</script>

</body>
</html>