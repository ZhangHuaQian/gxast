<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<%@ include file="/commViews/head.jsp" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>终端升级</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!-- <meta name="viewport"
	content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" /> -->
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="${ctxRes}css/font.css">
<link rel="stylesheet" href="${ctxRes}css/xadmin.css">
<link rel="stylesheet" href="${ctxRes}plugins/layui/css/layui.css">
<script type="text/javascript" src="${ctxRes}js/jquery-1.7.2.min.js"></script>
<script src="${ctxRes}plugins/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctxRes}js/xadmin.js"></script>
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<div style="padding: 5px; background-color: #F2F2F2;">
		<%--<div class="layui-row layui-col-space15">
			<div class="layui-col-md4">
				<div class="layui-card">
					<div class="layui-card-header">终端升级</div>
					<div class="layui-card-body">
						<div class="layui-form-item">
							<label for="username" class="layui-form-label">当前版本</label>
							<div class="layui-form-mid layui-word-aux">
								<span class="layui-badge layui-bg-green" id="version"></span>
							</div>
						</div>
						<div class="layui-form-item">
							<label for="L_email" class="layui-form-label"> 升级文件</label>
							<div class="layui-input-inline" style="width: 110px;">
								<button type="button" class="layui-btn layui-btn-normal"
									id="test1" onclick="insertUserShow()">APK升级包</button>
							</div>
							<div class="layui-form-mid layui-word-aux">添加终端APK升级包</div>
						</div>
					</div>
				</div>
			</div>
		</div>--%>

		<blockquote class="layui-elem-quote" style="padding:10px;margin-bottom:0px;">
			<div class="layui-input-inline">
				<label class="layui-form-label">当前版本</label>
				<div class="layui-form-mid layui-word-aux">
					<span class="layui-badge layui-bg-green" id="version"></span>
				</div>
				<label class="layui-form-label"> 升级文件</label>
				<div class="layui-input-inline" style="width: 110px;">
					<button type="button" class="layui-btn layui-btn-normal"
							id="test1" onclick="insertUserShow()">APK升级包</button>
				</div>
				<%--<div class="layui-form-mid layui-word-aux">添加终端APK升级包</div>--%>
			</div>
			<a class="layui-btn layui-btn-small" style="margin-right:5px;float:right"
			   href="javascript:location.replace(location.href);" title="刷新">刷新</a>
		</blockquote>
	</div>
<table id="demo" lay-filter="testTable"></table>
	<%--操作栏--%>
	<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除</button>
</script>
<script>

//删除终端
function deleteUser(data, obj) {
	parent.layer.confirm('确定删除' + data.version + '吗 ?', {
		btn : [ '确定', '取消' ]
	//按钮
	}, function() {
		//console.log(data);
		$.ajax({
			type : 'post',
			url : '${ctx }sys/apkUpdate/delete?id=' + data.id,
			dataType : 'json',
			success : function(result) {
				//console.log(result);
				if (result.status == 1) {
					obj.del();
					parent.layer.msg('删除成功', {
						icon : 1
					});
				} else {
					parent.layer.msg('操作失败', {
						icon : 5
					});
				}

			},
			error : function(msg) {
				console.log(msg);
				alert("系统异常");
			}
		});
	}, function() {
	});
}

//添加用户窗口
function insertUserShow() {
	cen_showWin({
		width : '500px',
		height : '400px',
		type : 2,
		title : '添加apk',
		url : '${ctx}sys/app/app-update-add.jsp'
	});
}

$(function() {
	getUserData();
});

//获取用户列表 (条件查询)
function getUserData() {
	$.ajax({
		type : 'get',
		url : '${ctx }sys/apkUpdate/selectList',
		dataType : 'json',
		success : function(result) {
			if (result.list.length > 0) {
				initTable(result.list);
				$("#version").text(result.list[0].version);
			} else {
				initTable(0);
			}
		},
		error : function(msg) {
			console.log(msg);
			alert("数据初始化异常");
		}
	});
}

//初始化表格
function initTable(tableData) {
	// 时间转换
	for (var i = 0; i < tableData.length; i++) {
		tableData[i].createTime = formatDate_YMD_HMS(tableData[i].createTime);
	}
	layui.use('table', function() {
		var table = layui.table, form = layui.form;
		table.render({
			elem : '#demo',
			data : tableData,
			page : false //关闭分页
			,
			loading : true,
			cols : [ [ //表头
			{
				field : 'version',
				title : '版本号',
				width : 100,
				align : 'center',
				fixed : 'left'
			}, {
				field : 'description',
				title : '描述',
				align : 'center',
			},{
				field : 'createTime',
				title : '创建时间',
				width : 180,
				align : 'center',
				sort : true
			},
			{
				field : 'path',
				title : '路径',
				align : 'center',
			},{
				fixed : 'right',
				title : '操作',
				width : 100,
				align : 'center',
				toolbar : '#barDemo'
			} ] ],

		});

		//监听工具条
		table.on('tool(testTable)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
			var data = obj.data; //获得当前行数据
			var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
			var tr = obj.tr; //获得当前行 tr 的DOM对象
			if (layEvent === 'delete') { //删除
				deleteUser(data, obj);
			}
		});

	});
}

// 新建窗口
function cen_showWin(param) {
	parent.layer.open({
		type : param.type,
		area : [ param.width, param.height ],
		title : param.title,
		closeBtn : 1,
		//shade: [0.1, '#FFFFFF'],
		shadeClose : true,
		skin : 'yourclass',
		resize : true,
		success : function(layero, index) {
			//console.log(layero, index);
		},
		content : param.url
	});
}
</script>

</body>

</html>