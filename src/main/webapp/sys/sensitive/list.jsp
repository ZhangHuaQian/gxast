<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>敏感词</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="keywords" content="">
<meta name="description" content="">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui/css/layui.css">
<%@ include file="/commViews/head.jsp"%>
</head>
<body>
	<blockquote class="layui-elem-quote"
		style="padding: 10px; margin-bottom: 0px;">
		<div class="layui-input-inline">
			<input type="text" value="" placeholder="敏感词" id="words" 
				autocomplete="off" class="layui-input">
		</div>
		<button type="reset" class="layui-btn" onclick="selectByObjecy()">
			<i class="layui-icon">&#xe615;</i>查找
		</button>

		<!-- <button type="reset" class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe63f;</i>重置查询</button> -->
		<button class="layui-btn layui-btn-normal" onclick="insertUserShow()">
			<i class="layui-icon">&#xe608;</i>添加敏感词
		</button>
		<a class="layui-btn layui-btn-small"
			style="margin-right: 5px; float: right"
			href="javascript:location.replace(location.href);" title="刷新">刷新</a>
	</blockquote>
	<%--</form>--%>
	<!-- 表格 -->
	<table id="demo" lay-filter="testTable"></table>
	<!-- 分页栏 -->
	<div id="demo7" style="text-align: left;"></div>
	<%--操作栏--%>
	<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除
    </button>
</script>

	<script>
	layui.use('laydate', function(){
		  var laydate = layui.laydate;
	 	 });
		//删除资讯
		function deleteUser(data, obj) {
			parent.layer.confirm('确定删除 ' + data.words + ' 吗 ?', {
				btn : [ '确定', '取消' ]
			//按钮
			}, function() {
				//console.log(data);
				$.ajax({
					type : 'post',
					url : '${ctx }sys/sensitive/delete?id=' + data.id,
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
				width : '400px',
				height : '200px',
				type : 2,
				title : '添加敏感词',
				url : '${ctx}sys/sensitive/add.jsp'
			});
		}

		$(function() {
			getUserData(1);
		});

    ///初始化查询
    function selectByObjecy() {
        getUserData(1);
        pageCurr = 1;
    }

		//获取用户列表 (条件查询)
		var userName = '';
		function getUserData(pageNum) {
			userName = $("#words").val();
			$.ajax({
				type : 'get',
				url : '${ctx }sys/sensitive/selectList?pageNum=' + pageNum
						+ '&words=' + userName,
				dataType : 'json',
				success : function(result) {
					console.log(result);
					if (result.count > 0) {
						initTable(result.list);
						initPage(result);
					} else {
						initTable(0);
						initPage(0);
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
			console.log(tableData);
			layui.use('table', function() {
				var table = layui.table, form = layui.form;
				table.render({
					elem : '#demo'
					//,skin: 'line' //行边框风格
					//,even: true //开启隔行背景
					//,size: 'sm' //小尺寸的表格
					//,height: 345
					//,width:'auto'
					,
					data : tableData,
					page : false //关闭分页
					,
					loading : true
					//,count:200
					//,limit: 10 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
					//,limits:[10]
					,
					cols : [ [ //表头
					{
						field : 'id',
						title : '编号',
						width : 80,
						align : 'center',
						fixed : 'left'
					}, {
						field : 'words',
						title : '敏感词',
						align : 'center',
					},
					{
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
					if (layEvent === 'update') { //编辑
						cen_showWin({
							width : '1000px',
							height : '800px',
							type : 2,
							title : '编辑资讯',
							url : '${ctx}sys/news/toupdate?id=' + data.id
						});
					} else if (layEvent === 'select') { //查看
						cen_showWin({
							width : '1000px',
							height : '800px',
							type : 2,
							title : '查看资讯',
							url : '${ctx}sys/news/news?id=' + data.id
						});
					} else if (layEvent === 'delete') { //删除
						deleteUser(data, obj);
					}
				});

			});
		}

		//初始化分页栏
		var pageCurr = 1;
		function initPage(pageData) {
			layui.use([ 'laypage', 'layer' ], function() {
				var laypage = layui.laypage, layer = layui.layer;
				laypage.render({
					elem : 'demo7',
					curr : pageCurr,
					count : pageData.count,
					layout : [ 'count', 'prev', 'page', 'next', 'refresh',
							'skip' ],
					jump : function(obj, first) {
						if (!first) {//首次不执行
							getUserData(obj.curr);
							pageCurr = obj.curr;
						}
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