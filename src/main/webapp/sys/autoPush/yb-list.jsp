<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>预报信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <%@ include file="/commViews/head.jsp" %>
    <%--<link rel="stylesheet" href="${ctxRes }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="${ctxRes }resource/plugins/zTree_v3/js/jquery.ztree.core.min.js"></script>
    <script type="text/javascript" src="${ctxRes }plugins/zTree_v3/js/jquery.ztree.excheck.min.js"></script>--%>
</head>
<body>
<!-- 用户添加 -->
<%--<form class="layui-form layui-form-pane" onsubmit="return false" id="main_form" style="">--%>
    <blockquote class="layui-elem-quote" style="padding:10px;margin-bottom:0px;">
        <div class="layui-input-inline">
           
           <input class="layui-input" placeholder="起始日" id="startTime" autocomplete="off">
           
           <!-- <input type="text" value="" placeholder="起始时间" id="startTime" autocomplete="off"
                   class="layui-input"> --> 
        </div>
        
        <div class="layui-input-inline">
        
          <input class="layui-input" placeholder="截止日" id="endTime" autocomplete="off">
          <!--  <input type="text" value="" placeholder="结束时间" id="overTime" autocomplete="off"
                   class="layui-input">-->
        </div>
        
        <div class="layui-input-inline">
            <input type="text" value="" placeholder="ip地址" id="ipaddress" autocomplete="off"
                   class="layui-input">
        </div>
        
        <button type="reset" class="layui-btn" onclick="selectByObjecy()"><i class="layui-icon">&#xe615;</i>查找</button>
        <!-- <button type="reset" class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe63f;</i>重置查询</button> -->
        <button class="layui-btn layui-btn-normal" onclick="insertUserShow()"><i class="layui-icon">&#xe608;</i>添加黑白数据
        </button> 
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
    <input type="checkbox" name="{{d.ipaddress}}" value="{{d.id}}" title="开启" lay-filter="lockDemo" {{ d.status == 0 ? 'checked' : '' }}>
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
						url : '${ctx }sys/iproll/update?id=' + data.id
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

	  //添加用户窗口
	 function insertUserShow() {
	     cen_showWin({
	         width: '660px',
	         height: '450px',
	         type: 2,
	         title: '添加数据字典',
	         url: '${ctx}sys/iproll/insert.jsp'
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
	var startTime = '', endTime = '', ipaddress = '';
	var re =  /^([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/;  
	function getUserData(pageNum) {
		/* dictName = $("#dictName").val();
		dictType = $("#dictType").val(); */
		startTime = $("#startTime").val();
		endTime = $("#endTime").val();
		ipaddress = $("#ipaddress").val();
		
		
		if((ipaddress != null && ipaddress != '') && !re.test(ipaddress)){
			alert("ip地址格式不正确,请重新输入");
			return false;
		}

		console.log('${ctx }sys/iproll/selectList?pageNum=' + pageNum
				+ '&startTime=' + startTime + '&endTime=' + endTime + '&ipaddress=' + ipaddress);
		$.ajax({
			type : 'get',
			url : '${ctx }sys/iproll/selectList?pageNum=' + pageNum +'&startTime='+startTime
					+'&endTime='+endTime+'&ipaddress='+ipaddress,
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
		//console.log(tableData.length);

		for (var i = 0; i < tableData.length; i++) {
			var newTime = new Date(tableData[i].createtime);
			tableData[i].createtime = newTime.toLocaleString().substring(0,
					newTime.toLocaleString().indexOf(" "));
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
					width : 200,
					align : 'center',
					fixed : 'left'
				}, {
					field : 'ipaddress',
					title : 'IP地址',
					align : 'center'
				}, {
					field : 'createtime',
					title : '加入时间',
					align : 'center',
					sort : true
				}, {
					field : 'status',
					title : '状态',
					align : 'center',
					width : 300,
					templet: '#checkboxTpl',
					unresize: true
				}
				//, {field: 'loginflag', title: '状态', align: 'center', width: 150}
				//,{field:'loginflag', title:'是否锁定', width:110, templet: '#checkboxTpl', unresize: true}
				//,{field: 'description', title: '描述', align:'center'}
				, {
					fixed : 'right',
					title : '操作',
					width : 250,
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
			 form.on('checkbox(lockDemo)', function(obj){
			    //layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
			    var status = obj.elem.checked?0:1;
			    $.ajax({
			        type: 'post',
			        url: '${ctx }sys/iproll/update?id=' +this.value+'&status='+status,
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
			}); 

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
	 function cen_showWin(param) {
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
	} 
</script>

</body>
</html>