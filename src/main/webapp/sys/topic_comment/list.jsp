<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>论坛评论列表</title>
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
			<select name="commentstate" id="commentstate" lay-search="">
				<option value="">状态</option>
				<option value="1">通过</option>
				<option value="2">不通过</option>
				<option value="0">未审核</option>
			</select>
		</div>

		<button type="reset" class="layui-btn" onclick="selectByObjecy()">
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
		<button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除</button>
		{{# if(d.verify=='未审核'){  }}
			<button class="layui-btn layui-btn-xs layui-btn-warm " lay-event="update"><i class="layui-icon">&#xe642;</i> 审核</button>
		{{# } }}
	</script>

<%--状态栏--%>
<script id="crStatus" type="text/html">
	{{# if(d.verify=='未审核'){  }}
	<label style="color: orange">未审核</label>
	{{# }else if(d.verify=='通过'){ }}
	<label style="color: green">通过</label>
	{{# }else if(d.verify=='不通过'){ }}
	<label style="color: red">不通过</label>
	{{# } }}
</script>

<script id="detail" type="text/html">
	<a lay-event="detail"><span style="color:#78bcff">{{d.topicType}}</span></a>
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

    $(function () {
        getUserData(1);
    });
    ///初始化查询
    function selectByObjecy() {
        getUserData(1);
        pageCurr = 1;
    }

		//获取用户列表 (条件查询)
		var  startTime = '', endTime = '',commentstate='';
		function getUserData(pageNum) {
            startTime = $("#startTime").val();
            endTime = $("#endTime").val();
            verify=$("#commentstate").val();
			$.ajax({
				type : 'get',
				url : '${ctx }comment/selectList?pageNum=' + pageNum
                    +  '&startTime=' + startTime + '&endTime=' + endTime+'&verify='+verify,
				dataType : 'json',
				success : function(result) {
					console.log(result);
					initTable(result.data.data);
					initPage(result.data);
				},
				error : function(msg) {
					//console.log(msg);
					alert("数据初始化异常");
				}
			});
		}

		//初始化表格
		function initTable(tableData) {
            console.log(tableData);

			// 时间转换
			for (var i = 0; i < tableData.length; i++) {
				tableData[i].createTime = formatDate_YMD_HMS(tableData[i].createTime);
                if(tableData[i].verify==0){
                    tableData[i].verify="未审核";
                }else if(tableData[i].verify==1){
                    tableData[i].verify="通过";
                }else if(tableData[i].verify==2){
                    tableData[i].verify="不通过";
                }

			}

			layui.use('table', function() {
				var table = layui.table, form = layui.form;
				table.render({
					elem : '#demo'

					,
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
						field : 'content',
						title : '评论内容',
						align : 'center'
					},{
						field : 'createTime',
						title : '评论时间',
						width : 300,
						align : 'center',
						sort : true
					},{
					    field : 'verify',
							title : '审核状态',
                            width : 200,
                            align : 'center',
                            templet: '#crStatus'
						}, {
						fixed : 'right',
						title : '操作',
						width : 250,
						align : 'center',
						toolbar : '#barDemo'
					} ] ],

				});

				//监听工具条
				table.on('tool(testTable)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
					var data = obj.data; //获得当前行数据
					console.log(data);
					var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					if (layEvent === 'update') { //编辑
                        //console.log(data);
                        if("未审核"==data.verify){
                            data.verify=1;
                        }else if("通过"==data.verify){
                            data.verify=1;
                        }else if("不通过"==data.verify){
                            data.verify=2;
                        }
						cen_showWin({
							width : '350px',
							height : '300px',
							type : 2,
							title : '审核',
							url : '${ctx}sys/topic_comment/verify.jsp?id=' + data.id+'&verify='+data.verify+"&pid="+data.pid,
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
		//console.log(pageData);
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

	//删除
    function deleteUser(data, obj) {
        parent.layer.confirm('确定删除 ' + data.id + ' 吗 ?', {
            btn : [ '确定', '取消' ]
            //按钮
        }, function() {
            var url = '${ctx }comment/delete?id=' + data.id;
            if(data.pid){
				url = url + "&pid="+data.pid;
            }
            $.ajax({
                type : 'post',
                url : url ,
                dataType : 'json',
                success : function(result) {
                    //console.log(result);
                    if (result.status == 1) {
                        obj.del();
                        parent.layer.msg('删除成功', {
                            icon : 1
                        });
                        obj.del();

                    } else {
                        parent.layer.msg('操作失败', {
                            icon : 5
                        });
                    }

                },
                error : function(msg) {
                    //console.log(msg);
                    alert("系统异常");
                }
            });
        }, function() {
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
				shadeClose : false,
				//skin : 'yourclass',
				resize : true,
				success : function(layero, index) {
					// console.log(layero, index);
				},
				content : param.url,
                cancel : function(index, layero) {
                    // if (confirm('当前修改内容尚未保存，确定要关闭吗？')) { //只有当点击confirm框的确定时，该层才会关闭
                    //     parent.layer.close(index);
                    // }
                    parent.layer.close(index);
                    return false;
                },
				end : function () {
                    getUserData(pageCurr)
                }
			});
		}

    //关闭窗口
    function layerClose(){
        parent.layer.close(indexWin);
    }
</script>

</body>
</html>