<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/commViews/head.jsp"%>
<meta charset="utf-8">
<title>外网专题列表</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="keywords" content="">
<meta name="description" content="">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui/css/layui.css">
</head>
<body>
	<blockquote class="layui-elem-quote"
		style="padding: 10px; margin-bottom: 0px;">
		<div class="layui-input-inline">
			<input type="text" value="" placeholder="专题名称搜索" id="title"
				autocomplete="off" class="layui-input">
		</div>
		<button type="reset" class="layui-btn" onclick="selectByObjecy()">
			<i class="layui-icon">&#xe615;</i>查找

		</button>
		<!-- <button type="reset" class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe63f;</i>重置查询</button> -->
		<button class="layui-btn layui-btn-normal" onclick="addSubjectType()">
			<i class="layui-icon">&#xe608;</i>添加专题
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
   <%-- <button class="layui-btn layui-btn-xs" lay-event="select"><i class="layui-icon">&#xe615;</i>查看</button>--%>
    <button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update"><i class="layui-icon">&#xe642;</i>编辑
    </button>
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除
    </button>
</script>
	<script type="text/html" id="showImg">

		<a href="#"><img onclick="whole(this)" style="height:26px;width:50px;" src="${ctx}uploadFiles/photo/{{d.image}}"/></a>
	</script>

	<script>

        $(function() {
            getUserData(1);
        });

        function whole(projectImg){
            console.log(projectImg.src)
            layer.open({
                type: 1,
                title: false,
                closeBtn: 1,
                shadeClose: true,
                skin: 'yourclass',
                shade:0,
                resize:true,
                title:'预览图',
                move:'.layui-layer-title',
                content: "<img style='height:100%;width:100%;' src='"+projectImg.src+"'/>"
            });
        }
		//删除资讯
		function deleteUser(data, obj) {
			parent.layer.confirm('确定删除' + data.title + '吗 ?', {
				btn : [ '确定', '取消' ]
			//按钮
			}, function() {
				//console.log(data);
				$.ajax({
					type : 'post',
					url : '${ctx }sys/subjectType/delete?id=' + data.id,
					dataType : 'json',
					success : function(result) {
						//console.log(result);
						if (result.status == 1) {
							//obj.del();
							parent.layer.msg('删除成功', {
								icon : 1
							});
							location.reload();
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


        //添加专题
        function addSubjectType() {
            cen_showWin({
                width : '1000px',
                height : '750px',
                type : 2,
                title : '添加专题',
                url : '${ctx}sys/subjectType/add.jsp'
            });
        }

		//查看
		function checkPhontoShow() {
			cen_showWin({
                width : '1000px',
                height : '750px',
				type : 2,
				title : '查看广告位置',
				url : '${ctx}sys/loopphoto/checkPhonto.jsp'
			});
		}

        ///初始化查询
        function selectByObjecy() {
            getUserData(1);
            pageCurr = 1;
        }

		//获取用户列表 (条件查询)
		var title = '';

		function getUserData(pageNum) {
            title = $("#title").val();
            var url = '${ctx }sys/subjectType/selectList?pageNum=' + pageNum;
			if(title.length>0){
                url += '&title='+title;
            }
			$.ajax({
				type : 'get',
				url : url,
				dataType : 'json',
				success : function(data) {
					var result = data.data
                    console.log(result);
					if (result.count > 0) {
						initTable(result.data);
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

	        for (var i = 0; i <tableData.length; i++) {
	            tableData[i].createTime = formatDate_YMD_HMS(tableData[i].createTime);
                tableData[i].modifyTime = formatDate_YMD_HMS(tableData[i].modifyTime);
				// console.log(tableData[i].moidfyTime)
	        }
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
						fixed : 'left',
						sort : true
					}, {
						field : 'title',
						title : '专题名称',
						align : 'center',
					}, {
						field : 'url',
						title : '链接',
						align : 'center',
					},{
						field : 'introduction',
						title : '专题简介',
						align : 'center',
                            templet: '#typeTpl'
					},  {
						field : 'createTime',
						title : '创建时间',
						width : 160,
						align : 'center',
					}, {
						field : 'modifyTime',
						title : '修改时间',
						width : 160,
						align : 'center',
						sort : true
					}, {
					    field: 'image',
							title: '图片',
							align: 'center',
                            width : 100,
							templet: '#showImg'
						}
					, {
						fixed : 'right',
						title : '操作',
						width : 160,
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
							height : '750px',
							type : 2,
							title : '编辑图片',
							url : '${ctx}sys/subjectType/verify.jsp?id=' + data.id
						});
					} else if (layEvent === 'select') { //查看
						cen_showWin({
							width : '1000px',
							height : '600px',
							type : 2,
							title : '查看图片',
							url : '${ctx}sys/loopphoto/select?id=' + data.id
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
            var index = parent.layer.open({
				type : param.type,
				area : [ '1000px', '750px'],
				title : param.title,
				closeBtn : 1,
				//shade: [0.1, '#FFFFFF'],
				shadeClose : false,
                //skin: 'demo-class',
				resize : true,
				success : function(layero, index) {
					//console.log(layero, index);
				},
				content : param.url,
                cancel : function(index, layero) {
                    if (confirm('当前修改内容尚未保存，确定要关闭吗？')) { //只有当点击confirm框的确定时，该层才会关闭
                        parent.layer.close(index);
                    }
                    return false;
                }
			});

		}
	</script>

</body>
</html>