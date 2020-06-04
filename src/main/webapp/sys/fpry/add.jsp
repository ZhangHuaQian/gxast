<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>驻村队伍</title>
<%@ include file="/commViews/head.jsp"%>
<script type="text/javascript" src="../../resource/js/xcity.js"></script>
<link rel="stylesheet"
	href="${ctx }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript"
	src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
<script
	src="${ctx }resource/plugins/wangEditor-3.1.1/release/wangEditor.min.js"
	type="text/javascript" charset="utf-8"></script>
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

<div class="" id="div1">
	<!-- 内容主体区域 -->
	<div style="padding: 10px;">

		<form class="layui-form" id="main_form">

			<div class="layui-form-item">
				<label class="layui-form-label">账号</label>
				<div class="layui-input-inline">
					<input type="text" name="loginname" lay-verify="required" maxlength="12" 
						placeholder="如:手机或邮箱" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">姓名</label>
				<div class="layui-input-inline">
					<input type="text" name="name" lay-verify="required" maxlength="15" 
						placeholder="姓名" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">手机</label> 
				<div class="layui-input-inline">
					<input type="number" name="phonenum" lay-verify="phone" maxlength="11"  
						placeholder="如:1388888888" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">密码</label>
				<div class="layui-input-inline">
					<input type="password" name="password" id="pwd" 
						lay-verify="min" placeholder="密码" autocomplete="off"
						class="layui-input">
				</div>
				<label class="layui-form-label">确认密码</label>
				<div class="layui-input-inline">
					<input type="password" lay-verify="regPwd" placeholder="两次密码必须一致"
						autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">用户状态</label>
				<div class="layui-input-inline">
					<input type="radio" name="loginflag" value="0" title="启用" checked>
					<input type="radio" name="loginflag" value="1" title="停用">
				</div>
			</div>

			<%--  角色多选
			<div class="layui-form-item" pane="">
				<label class="layui-form-label">用户角色</label>
				<div class="layui-input-block" id="roleCheckboxList"></div>
			</div>--%>

			<hr class="layui-bg-blue">

			<div class="layui-form-item">
				<label class="layui-form-label">性别</label>
				<div class="layui-input-inline">
					<select name="sex" lay-verify="required">
						<option>男</option>
						<option>女</option>
					</select>
				</div>
				<label class="layui-form-label">所属部门</label>
				<div class="layui-input-inline">

					<div class="layui-unselect layui-form-select layui-form-selected">
						<div class="layui-select-title">
							<input type="text" placeholder="点击选择部门" id="selectTreeBut"
								value="" readonly="" lay-verify="required"
								class="layui-input layui-unselect"> <input name="did"
								value="" type="hidden" id="departmentValue" /> <i
								class="layui-edge"></i>
						</div>
						<dl class="layui-anim layui-anim-upbit layui-select-group"
							id="selectTree" style="display: none;">
							<div
								style="width: 100%; height: 250px; overflow-y: auto; overflow-x: auto;">
								<ul id="treeDemo" class="ztree"></ul>
							</div>
						</dl>
					</div>
				</div>
				<label class="layui-form-label">人员类型</label>
				<div class="layui-input-inline">
					<select name="personnel" id="personnel" lay-verify="required">
					</select>
				</div>

			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">地区选择</label>
				<div class="layui-input-inline" style="width: 120px; display: none">
					<select id="province"  lay-verify="required">
						<option value="450">广西壮族自治区</option>
					</select>
				</div>
				<div class="layui-input-inline" style="width: 120px">
					<select id="city_"  lay-verify="required"
						lay-filter="filter">
					</select>
				</div>
				<div class="layui-input-inline" style="width: 120px">
					<select id="country_"  lay-verify="required"
						lay-filter="filter2">
					</select>
				</div>
				<div class="layui-input-inline" style="width: 120px">
					<select id="town" lay-verify="required"
						lay-filter="filter3">
						<option value=""></option>
					</select>
				</div>
				<div class="layui-input-inline" style="width: 120px">
					<select id="village"  lay-verify="required"
						lay-filter="filter4">
						<option value=""></option>
					</select>
				</div>
				<label class="layui-form-label" style="padding-left: 5px;">帮扶村</label>
				<div class="layui-input-inline">
					<select name="villageId" id="type" lay-verify="required">
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">帮扶举措</label>
				<div class="layui-input-block">
					<input type="text" name="measures" required lay-verify="required" maxlength="200"  
						placeholder="帮扶举措" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">帮扶年度</label>
				<div class="layui-input-block">
					<input type="text" name="year" required lay-verify="required" maxlength="200"  
						placeholder="帮扶年度" autocomplete="off" class="layui-input">
				</div>
			</div>
			<!--显示图片-->
			<div class="layui-form-item">
				<label class="layui-form-label">个人相片 </label>
				<div class="layui-input-inline"
					style="margin-right: 0px; width: 40%">
					<input type="hidden" id="image" class="layui-input" name="image"
						required placeholder="图片路径" value="default_user.jpg"
						autocomplete="off" />
				</div>
				<div class="layui-input-block" style="float: left; margin-left: 0px">
					<a href="" class="content-a-upload" style="height: 36px;"><input
						type="file" id="projectImgBtn" style="height: 36px; width: 100px" />上传相片</a>
				</div>
			</div>
			<div class="layui-form-item" style="display: none;" id="project_Img">
				<ul>
					<li><img src=""
						style="margin-left: 120px; width: 200px; height: auto;" /></li>
				</ul>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<!--  <button class="layui-btn" lay-submit lay-filter="formDemo" >立即提交</button> -->
					<button class="layui-btn layui-btn-normal" lay-submit=""
						lay-filter="demo1" id="subBtn">立即提交</button>
				</div>
			</div>
		</form>
	</div>

</div>

<script type="text/javascript">
	//图片转码
	function run1(input_file, get_data) {
		/*input_file：文件按钮对象*/
		/*get_data: 转换成功后执行的方法*/
		if (typeof (FileReader) === 'undefined') {
			layer.alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！", {
				icon : 5
			});
			//alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！");
		} else {
			try {
				/*图片转Base64 核心代码*/
				var file = input_file.files[0];
				if(file==null) return false; 
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
	function uploadImage1(img) {
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
	//图片上传
	$('#projectImgBtn').change(function() {
		run1(this, function(data) {
			uploadImage1(data);
		});
	});
	$(function() {
		//init();
		init_()
		initNewsType();
		renderForm();
	});
	function init_city(id) {
		$.ajax({
			type : 'get',
			url : '${ctx }city/select?provinceId=450&cityId=' + id,
			success : function(result) {
				console.log(result);
				var city = result.city;
				console.log(city)
				var html = "<option value=''></option>";
				for (var i = 0; i < city.length; i++) {
					html += "<option value='"+city[i].countyId+"'>"
							+ city[i].countyName + "</option>";
				}
				$("#country_").html(html);
				renderForm();
			},
			error : function(msg) {
				alert("错误");
			}
		});
	}
	function init_country(id) {
		$.ajax({
			type : 'get',
			url : '${ctx }city/select?provinceId=450&countyId=' + id,
			success : function(result) {
				console.log(result);
				var city = result.city;
				console.log(city)
				var html = "<option value=''></option>";
				for (var i = 0; i < city.length; i++) {
					html += "<option value='"+city[i].townId+"'>"
							+ city[i].townName + "</option>";
				}
				$("#town").html(html);
				console.log(html);
				renderForm();
			},
			error : function(msg) {
				alert("错误");
			}
		});
	}
	function init_town(id) {
		$.ajax({
			type : 'get',
			url : '${ctx }city/select?provinceId=450&townId=' + id,
			success : function(result) {
				console.log(result);
				var city = result.city;
				console.log(city)
				var html = "<option value=''></option>";
				for (var i = 0; i < city.length; i++) {
					html += "<option value='"+city[i].villageId+"'>"
							+ city[i].villageName + "</option>";
				}
				$("#village").html(html);
				renderForm();
			},
			error : function(msg) {
				alert("错误");
			}
		});
	}
	function init_() {
		$.ajax({
			type : 'get',
			url : '${ctx }city/select?provinceId=450',
			async : false,
			success : function(result) {
				console.log(result);
				var city = result.city;
				console.log(city)
				var html = "<option value=''></option>";
				for (var i = 0; i < city.length; i++) {
					html += "<option value='"+city[i].cityId+"'>"
							+ city[i].cityName + "</option>";
				}
				console.log(html);
				$("#city_").html(html);
			}, 
			error : function(msg) {
				alert("错误");
			}
		});
	}
	function init_type(id){
		$.ajax({
			type : 'get', 
			url : '${ctx }sys/village/selectByVid?vid='+id,
			async : false,
			success : function(result) {
				var city = result.village;
				console.log(city);  
				if(city!=null){ 
					var html = "<option value=''></option><option value='"+city.id+"'>"+ city.name + "</option>";
					$("#type").html(html);
					renderForm(); 
				}else{
					$("#type").html("<option value=''></option>");
					console.log($("#type").html())
					renderForm(); 
				}
			}, 
			error : function(msg) {
				alert("错误");
			}
		});
	}
	//初始化资讯类型下拉列表
	function initNewsType() {
		$.ajax({
			type : 'get',
			url : '${ctx }sys/dictionary/selectList?type=type_fpry',
			//data:$('#main_form').serialize(),
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result.count > 0) {
					var list = result.list;
					var data = "<option value=''>选择人员类型</option>";
					for (var i = 0; i < list.length; i++) {
						data += "<option value="+list[i].value+">"
								+ list[i].name + "</option>";
					}
				} else {

				}
				$("#personnel").append(data);
			},
			error : function(msg) {
				console.log(msg);
				alert("系统异常");
			}
		});
	}
	//关闭当前弹出窗口 
	function closeWindow() {
		if ($(window.parent.frames["驻村队伍列表"]).length > 0) {
			window.parent.frames["驻村队伍列表"].location.reload();// 刷新父窗口
			setTimeout(function() {
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭
				//layer.closeAll(); //疯狂模式，关闭所有层
			}, 1000)
		}
	}
	function sendData() {
		var fromDate = $('#main_form').serialize();
		$.ajax({
			type : 'post',
			url : '${ctx }sys/staff/insert?'+"province=广西" 
			+"&city="+$("#city_").find("option:selected").text()+"&area="+$("#country_").find("option:selected").text(),
			data : fromDate,
			async : false,
			success : function(result) {
				if(result.status==1){
					closeWindow();
					layer.msg(result.msg);
				}else{
					layer.msg(result.msg);
				}
			},
			error : function(msg) {
				alert("错误");
			}
		});
	};
	function renderForm() {
		layui.use('form', function() {
			var form = layui.form;
			//校验两次密码
            form.verify({
                regPwd: function (value) {
                    //获取密码
                    var pwd = $("#pwd").val();
                    if (pwd != value) {  
                        return '两次输入的密码不一致';
                    }
                },
                phone: function (value) { 
                	if(value==null||value.length!=11){
                	      return '手机号格式不正确'; 
                	}
                },
                min: function (value) {  
                	if(value==null||value.length<6){
                	      return '密码位数不能低于6位'; 
                	}
                }
            });
			form.on('submit(demo1)', function() {
				sendData();
				return false;
			});
			form.on('select(filter)', function(data) {
				//console.log(data.elem); //得到select原始DOM对象
				console.log(data.value); //得到被选中的值 
				$("#country_").html("");
				$("#town").html("");
				$("#village").html("");
				$("#type").html("");
				init_city(data.value);
				//console.log(data.othis); //得到美化后的DOM对象
			});
			form.on('select(filter2)', function(data) {
				//console.log(data.elem); //得到select原始DOM对象
				console.log(data.value); //得到被选中的值
				$("#town").html("");
				$("#village").html("");
				$("#type").html("");
				init_country(data.value);
				//console.log(data.othis); //得到美化后的DOM对象  
			});
			form.on('select(filter3)', function(data) {
				//console.log(data.elem); //得到select原始DOM对象
				console.log(data.value); //得到被选中的值
				$("#village").html("");
				$("#type").html("");
				init_town(data.value);
				//console.log(data.othis); //得到美化后的DOM对象
			});
			form.on('select(filter4)', function(data) {
				//console.log(data.elem); //得到select原始DOM对象
				console.log(data.value); //得到被选中的值
				$("#type").html(""); 
				init_type(data.value);
				//console.log(data.othis); //得到美化后的DOM对象
			});
			form.render();
		});
	}
	var zTreeObj;
	// zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
	var setting = {
		data : {
			simpleData : {
				enable : true,
				idKey : "id", // id
				pIdKey : "pId", //  父级ID
				rootPId : 0
			// 顶层ID默认值0
			},
			key : {
				name : "name", // 节点名称
				url : "xURL" // URL
			}
		},
		callback : {
			onClick : zTreeOnClick
		}
	};

	//树菜单点击事件
	function zTreeOnClick(event, treeId, treeNode) {
		$("#selectTreeBut").val(treeNode.name);
		$("#departmentValue").val(treeNode.id);
	};

	//初始化部门下拉
	function initDepartmentSelect() {
		$.ajax({
			type : 'get',
			url : '${ctx }sys/upms/department/selectByThisUser',
			//data:$('#main_form').serialize(),
			dataType : 'json',
			success : function(result) {
				//console.log(result);
				zTreeObj = $.fn.zTree
						.init($("#treeDemo"), setting, result.list);
				zTreeObj.expandAll(true); //默认全部展开
			},
			error : function(msg) {
				console.log(msg);
				alert("系统异常");
			}
		});
	}

	//下拉树
	function bindTree() {
		$("#selectTreeBut").click(function() {
			$("#selectTree").toggle(500, function() {
				$(this).mouseleave(function() {
					$(this).hide();
				});
			});
		});
	}

	$(function() {
		bindTree();
		initDepartmentSelect();
	});
</script>
</body>
</html>