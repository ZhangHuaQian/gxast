<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>日志列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <%@ include file="/commViews/head.jsp" %>
</head>
<body>
<!-- 用户添加 -->
<%--<form class="layui-form layui-form-pane" onsubmit="return false" id="main_form" style="">--%>
    <blockquote class="layui-elem-quote" style="padding:10px;margin-bottom:0px;">
        <div class="layui-input-inline">
           
           <input class="layui-input" placeholder="起始日" id="startTime">
        </div>
        
        <div class="layui-input-inline">
        
          <input class="layui-input" placeholder="截止日" id="endTime">
        </div>
        
        <div class="layui-input-inline">
            <input type="text" value="" placeholder="用户名" id="custName" autocomplete="off"
                   class="layui-input">
        </div>
        
        <button type="reset" class="layui-btn" onclick="selectByObjecy()"><i class="layui-icon">&#xe615;</i>查找</button>

        <!-- <button type="reset" class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe63f;</i>重置查询</button> -->
        <a class="layui-btn layui-btn-small" style="margin-right:5px;float:right"
           href="javascript:location.replace(location.href);" title="刷新">刷新</a>
    </blockquote>
    </div>
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
<%--锁定栏--%>
<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="{{d.name}}" value="{{d.id}}" title="锁定" lay-filter="lockDemo" {{ d.loginflag == 1 ? 'checked' : '' }}>
</script>

<script>


	layui.use('laydate', function() {
		var laydate = layui.laydate;
        
		//执行一个laydate实例
		laydate.render({
			elem : '#startTime', //指定元素
			format:'yyyy-MM-dd'
		});

		//执行一个laydate实例
		laydate.render({
			elem : '#endTime', //指定元素
			format:'yyyy-MM-dd'
		});
	});

	//删除用户
	function deleteUser(data, obj) {
		parent.layer.confirm('确定删除ID为' + data.id + '的数据吗 ?', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			//console.log(data);
			$
					.ajax({
						type : 'post',
						url : '${ctx }sys/operatelog/update?id=' + data.id
								+ '&isDel=1',
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

	$(function() {
		getUserData(1);
	});

    ///初始化查询
    function selectByObjecy() {
        getUserData(1);
        pageCurr = 1;
    }

	//获取用户列表 (条件查询)
	var startTime = '', endTime = '', custName = '';
	function getUserData(pageNum) {
		startTime = $("#startTime").val();
		endTime = $("#endTime").val();
		custName = $("#custName").val();

		console.log('${ctx }sys/operatelog/selectList?pageNum=' + pageNum
				+ '&startTime=' + startTime + '&endTime=' + endTime + '&custname=' + custName);
		$.ajax({
			type : 'get',
			url : '${ctx }sys/operatelog/selectList?pageNum=' + pageNum +'&startTime='+startTime
					+'&endTime='+endTime+'&custname='+custName,
			dataType : 'json',
			success : function(result) {
				console.log(result);
				if(result.count > 0){
				initTable(result.list);
				initPage(result);
				}else{
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
			tableData[i].createtime = formatDate_YMD_HMS(tableData[i].createtime);
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
					title : 'ID',
					width : 80,
					align : 'center',
					fixed : 'left'
				}, {
					field : 'custname',
					title : '用户名',
					align : 'center',
					width : 150
				}, {
					field : 'realname',
					title : '真实名',
					align : 'center',
					width : 150
				}, {
					field : 'modulename',
					title : '模块名',
					align : 'center',
                    width : 150
				}, {
					field : 'operatedesc',
					title : '操作内容',
					align : 'center'
				}, {
					field : 'ipaddress',
					title : 'IP地址',
					align : 'center',
					width : 120
				}, {
					field : 'createtime',
					title : '创建时间',
					align : 'center',
					sort : true,
                    width : 160
				}
				//, {field: 'loginflag', title: '状态', align: 'center', width: 150}
				//,{field:'loginflag', title:'是否锁定', width:110, templet: '#checkboxTpl', unresize: true}
				//,{field: 'description', title: '描述', align:'center'}
				, {
					fixed : 'right',
					title : '操作',
					width : 80,
					align : 'center',
					toolbar : '#barDemo'
				}

				] ],

			});

			//监听工具条
			table.on('tool(testTable)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
				var data = obj.data; //获得当前行数据
				var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				var tr = obj.tr; //获得当前行 tr 的DOM对象           
				if (layEvent === 'delete') { //编辑
					console.log(data);
					deleteUser(data, obj);
				}
			});

			//监听锁定操作
			/* form.on('checkbox(lockDemo)', function(obj){
			    //layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
			    var loginflag = obj.elem.checked?1:0;
			    $.ajax({
			        type: 'post',
			        url: '${ctx }sys/ucenter/update?id=' +this.value+'&loginflag='+loginflag,
			        data: $('#main_form').serialize(),
			        dataType: 'json',
			        success: function (result) {
			            if(result.status!=1){
			                layer.msg(result.msg, {icon: 5});
			            }
			        },
			        error: function (msg) {
			            console.log(msg);
			            alert("系统异常");
			        }
			    });
			}); */

		});
	}

	//初始化分页栏
	var pageCurr = 1;
	function initPage(pageData) {
		layui.use([ 'laypage', 'layer' ], function() {
			var laypage = layui.laypage, layer = layui.layer;
			laypage
					.render({
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
	/* function cen_showWin(param) {
	    parent.layer.open({
	        type: param.type,
	        area: [param.width, param.height],
	        title: param.title,
	        closeBtn: 1,
	        //shade: [0.1, '#FFFFFF'],
	        shadeClose: true,
	        skin: 'yourclass',
	        resize: true,
	        success: function (layero, index) {
	            //console.log(layero, index);
	        },
	        content: param.url
	    });
	} */
</script>

</body>
</html>