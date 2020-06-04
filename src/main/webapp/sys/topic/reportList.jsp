<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>举报列表</title>
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
		<div class="layui-inline">
			<div class="layui-input-inline" style="width: 100px">
				<input type="text" name="start" class="layui-input" id="startTime" autocomplete="off"
					placeholder="起始日期">
			</div>
		</div>
		<div class="layui-inline">
			<div class="layui-input-inline" style="width: 100px">
				<input type="text" name="end" class="layui-input" id="endTime" autocomplete="off"
					placeholder="终止日期">
			</div>
		</div>
		<div class="layui-form layui-input-inline">
			<select name="status" id="status" lay-search="">
				<option value="">状态</option>
				<option value="0">未处理</option>
				<option value="1">已处理</option>
			</select>
		</div>

		<button type="reset" class="layui-btn" onclick="getUserData(1)">
			<i class="layui-icon">&#xe615;</i>查找
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
		<button class="layui-btn layui-btn-xs" lay-event="select"><i class="layui-icon"></i>查看</button>

		{{#  if(d.status=='0'){ }}
			<button class="layui-btn layui-btn-xs layui-btn-danger " lay-event="delete"><i class="layui-icon"></i> 处理</button>
		{{# } }}

</script>

<%--状态栏--%>
<script id="crStatus" type="text/html">
	{{# if(d.status=='0'){  }}
	<label style="color: red">待处理</label>
	{{# }else if(d.status=='1'){ }}
	<label style="color: green">已处理</label>
	{{# } }}

</script>
	<script id="cid" type="text/html">
		{{# if(d.commentId==0){  }}
		<label style="color: red">帖子</label>
		{{# }else { }}
		<label style="color: green">评论</label>
		{{# } }}
	</script>

<script>
	layui.use('laydate', function(){
		  var laydate = layui.laydate;
		  
		  //常规用法
		  laydate.render({
		    elem: '#startTime',
              format:'yyyy-MM-dd'
		  });
		  laydate.render({
			    elem: '#endTime',
              format:'yyyy-MM-dd'
		  });
	 });


    $(function() {
		getUserData(1);
		});

		//获取用户列表 (条件查询)
		var  startTime = '', endTime = '',status='';
		function getUserData(pageNum) {
            startTime = $("#startTime").val();
            endTime = $("#endTime").val();
            status=$("#status").val();
			$.ajax({
				type : 'get',
				// ReportController --> report
				url : '${ctx}report/selectList?pageNum=' + pageNum
                    +  '&date1=' + startTime + '&date2=' + endTime+'&status='+status,
				dataType : 'json',
				success : function(result) {
					if (result.count > 0) {
						initTable(result.list);
						initPage(result);
					} else {
						initTable(0);
						initPage(0);
					}
				},
				error : function(msg) {
					alert("数据初始化异常");
				}
			});
		}

		//初始化表格
		function initTable(tableData) {
            console.log(tableData);

			// 时间转换
			for (var i = 0; i < tableData.length; i++) {
				tableData[i].time = formatDate_YMD_HMS(tableData[i].time);
               /* if(tableData[i].commentId==0){
                    tableData[i].commentId="帖子";
                }else {
                    tableData[i].commentId="评论";
                }*/

			}

			layui.use('table', function() {
				var table = layui.table, form = layui.form;
				table.render({
					elem : '#demo',
					data : tableData,
					page : false //关闭分页
					,
					loading : true
					,
					cols : [ [ //表头
					{
						field : 'id',
						title : '编号',
						width : 80,
						align : 'center',
						fixed : 'left'
					}, {
						field : 'report_type',
						title : '举报类型',
						align : 'center',
						},
                        {
                            field : 'beReportedContent',
                            title : '被举报内容',
                            align : 'center'
                        },{
						field : 'content',
						title : '举报理由',
						align : 'center'
					}, {
					    field : 'username',
							title : '举报人',
                            align : 'center',
                        },{
                            field : 'commentId',
                            title : '所属模块',
                            align : 'center',
                            width : 100,
                            templet: '#cid'
                        },{
						field : 'time',
						title : '举报时间',
						width : 160,
						align : 'center',
						sort : true
					},{
					    field : 'status',
							title : '状态',
                            align : 'center',
                            templet: '#crStatus'
						}, {
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
                    console.log(data);
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					var tr = obj.tr; //获得当前行 tr 的DOM对象
                    if (layEvent === 'updateStatus') { //处理
                        updateStatus(data,obj);
                    }else if(layEvent==='select'){
                        window.open('${ctx}topic/details?id='+data.topicId);
					}else if(layEvent==='delete'){
                        deleteUser(data,obj);
                    }

				});

			});
		}

		function deleteUser(data,obj) {
			$.ajax({
                type : 'get',
                url : '${ctx}report/delete?tid='+data.topicId+'&cid='+data.commentId+'&id='+data.id+'&status='+data.status,
                dataType : 'json',
                success : function(result) {
                    console.log(result);
                    if (result.status == 1) {
						/*setTimeout(function (){
                            window.parent.frames["举报列表"].location.reload();//刷新父借口
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index);
                        },1000)*/
						closeWindow();
                    } else {
                        parent.layer.msg('删除失败', {
                            icon : 5
                        });
                    }
                },
                error : function(msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });
        }

    //关闭当前弹出窗口
    function closeWindow() {

        reload_parent('sys/topic/reportList.jsp');
        setTimeout(function (){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
            //layer.closeAll(); //疯狂模式，关闭所有层
        },1000);
    }


		function updateStatus(data,obj) {
            $.ajax({
                type : 'get',
                url : '${ctx}report/updateStatus?id='+data.id+'&status='+data.status,
                dataType : 'json',
                success : function(result) {
                    console.log(result)
                    if (result.status == 1) {
                        layer.msg("操作完成");
                     /*   setTimeout(function (){
                            window.parent.frames["举报列表"].location.reload();//刷新父借口
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index);
                        },1000)*/
                     closeWindow();
                    } else {
                        parent.layer.msg('修改失败', {
                            icon : 5
                        });
                    }
                },
                error : function(msg) {
                    console.log(msg);
                    alert("系统异常");
                }
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

	var indexWin;
		// 新建窗口
		function cen_showWin(param) {
			parent.layer.open({
				type : param.type,
				area : [ param.width, param.height ],
				title : param.title,
				closeBtn : 1,
				//shade: [0.1, '#FFFFFF'],
				shadeClose : true,
				//skin : 'yourclass',
				resize : true,
				success : function(layero, index) {
					//console.log(layero, index);
				},
				content : param.url
			});
		}

    //关闭窗口
    function layerClose(){
        parent.layer.close(indexWin);
    }
</script>

</body>
</html>