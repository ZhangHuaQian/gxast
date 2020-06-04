<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>评论列表</title>
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
				<input type="text" name="start" class="layui-input" id="startTime"
					placeholder="起始日期">
			</div>
		</div>
		<div class="layui-inline">
			<div class="layui-input-inline" style="width: 100px">
				<input type="text" name="end" class="layui-input" id="endTime"
					placeholder="终止日期">
			</div>
		</div>
		<div class="layui-form layui-input-inline">
			<select name="commentstate" id="commentstate" lay-search="">
				<option value="">状态</option>
				<option value="1">已审核</option>
				<option value="2">不通过</option>
				<option value="0">未审核</option>
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
		<button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除</button>
	<button class="layui-btn layui-btn-xs layui-btn-warm " lay-event="update"><i class="layui-icon">&#xe642;</i> 审核</button>
</script>

<%--状态栏--%>
<script id="crStatus" type="text/html">
	{{# if(d.commentstate=='未审核'){  }}
	<label style="color: orange">未审核</label>
	{{# }else if(d.commentstate=='已审核'){ }}
	<label style="color: green">已审核</label>
	{{# }else if(d.commentstate=='不通过'){ }}
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


    $(function() {
		getUserData(1);
		});

		//获取用户列表 (条件查询)
		var  startTime = '', endTime = '',commentstate='';
		function getUserData(pageNum) {
            startTime = $("#startTime").val();
            endTime = $("#endTime").val();
            commentstate=$("#commentstate").val();
			$.ajax({
				type : 'get',
				url : '${ctx }sys/news_comment/selectCommentList?pageNum=' + pageNum
                    +  '&date1=' + startTime + '&date2=' + endTime+'&commentstate='+commentstate,
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
				tableData[i].time = formatDate_YMD_HMS(tableData[i].time);
                if(tableData[i].commentstate==0){
                    tableData[i].commentstate="未审核";
                }else if(tableData[i].commentstate==1){
                    tableData[i].commentstate="已审核";
                }else if(tableData[i].commentstate==2){
                    tableData[i].commentstate="不通过";
                }
                if(tableData[i].topicType=='xwzx'){
                    tableData[i].topicType="新闻中心";
				}else if(tableData[i].topicType=='djgz'){
                    tableData[i].topicType="党建工作";
                }else if(tableData[i].topicType=='zzgk'){
                    tableData[i].topicType="政务公开";
                }else if(tableData[i].topicType=='nfkjw'){
                    tableData[i].topicType="南方科技网";
                }else if(tableData[i].topicType=='xbsb'){
                    tableData[i].topicType="小博士报";
                }else if(tableData[i].topicType=='jtyy'){
                    tableData[i].topicType="家庭医药";
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
						field : 'topicType',
						title : '新闻类型',
						align : 'center',
						width : 300,
							templet:'#detail'
					}, {
						field : 'content',
						title : '评论内容',
						align : 'center'
					},{
						field : 'time',
						title : '发表时间',
						width : 300,
						align : 'center',
						sort : true
					},{
					    field : 'commentstate',
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
					var tr = obj.tr; //获得当前行 tr 的DOM对象
					var str="";
					if(data.topicType=="新闻中心"){
					    data.topicType='xwzx';
					}else if(data.topicType=="党建工作"){
                        data.topicType='djgz';
					}else if(data.topicType=='政务公开'){
                        data.topicType='zzgk';
                    }else if(data.topicType=='南方科技网'){
                        data.topicType='nfkjw';
                    }else if(data.topicType=='小博士报'){
                        data.topicType='xbsb';
                    }else if(data.topicType=='家庭医药'){
                        data.topicType='jtyy';
                    }

					switch (data.topicType) {
						case "xwzx":
						str="news";
						break;
						case "djgz":
						    str="news_axhd";
						    break;
						case "zzgk":
						    str="news_zzgk";
						    break
                        case "nfkjw":
                            str="news_nfkjw";
                            break
                        case "jtyy":
                            str="news_jtyy";
                            break
                        case "xbsb":
                            str="news_xbsb";
                            break
                    }
					if (layEvent === 'update') { //编辑
                        //console.log(data);
                        if("未审核"==data.commentstate){
                            data.commentstate=0;
                        }else if("已审核"==data.commentstate){
                            data.commentstate=1;
                        }else if("不通过"==data.commentstate){
                            data.commentstate=2;
                        }
						cen_showWin({
							width : '350px',
							height : '300px',
							type : 2,
							title : '修改状态',
							url : '${ctx}sys/news_comment/updateindex.jsp?id=' + data.id+'&commentstate='+data.commentstate,
						});

					} else if (layEvent === 'delete') { //删除
						deleteUser(data, obj);
					}else if(layEvent === 'detail'){
						console.log(data)
                        window.open("${ctx}web/"+str+"/details/"+data.topicId+".html","_target");

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
        parent.layer.confirm('确定删除' + data.id + '吗 ?', {
            btn : [ '确定', '取消' ]
            //按钮
        }, function() {
            //console.log(data);
            $.ajax({
                type : 'post',
                url : '${ctx }sys/news_comment/delete?id=' + data.id,
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
				shadeClose : true,
				//skin : 'yourclass',
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

    //关闭窗口
    function layerClose(){
        parent.layer.close(indexWin);
    }
</script>

</body>
</html>