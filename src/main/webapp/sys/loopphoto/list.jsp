<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/commViews/head.jsp"%>
<meta charset="utf-8">
<title>轮播图片列表</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="keywords" content="">
<meta name="description" content="">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui/css/layui.css">
</head>

<style>
	.isUse{
		background-color: #09b509;
		color: #fff;
		border-radius: 5px;
		box-shadow: -2px -1px 5px rgba(13, 156, 28, 0.9);
		margin-right: 5px;
	}
</style>
<body>
	<blockquote class="layui-elem-quote"
		style="padding: 10px; margin-bottom: 0px;">
		<div class="layui-input-inline">
			<input type="text" value="" placeholder="根据标题搜索" id="header"
				autocomplete="off" class="layui-input">
		</div>
		<div class="layui-input-inline">
			<select name="typep" id="typep" style="width: 160px;height: 40px;" lay-verify="required" lay-search="">
				<option value="">--广告位搜索--</option>
				<option value="zy_#01">主页#1</option>
				<option value="zy_#02">主页#2</option>
				<option value="zy_#03">主页#3</option>
				<option value="zy_#04">主页#4</option>
				<option value="zy_#05">主页#5</option>
				<option value="zy_#06">主页#6</option>
				<option value="zy_#07">主页#7</option>
				<option value="zy_#08">主页#8</option>
				<%--<option value="zy_#11">主页#11</option>--%>
				<%--<option value="zy_#12">主页#12</option>--%>
				<%--<option value="zy_#13">主页#13</option>--%>
				<%--<option value="zy_#14">主页#14</option>--%>
				<%--<option value="zy_#15">主页#15</option>--%>
				<%--<option value="zy_#16">主页#16</option>--%>
				<%--<option value="zy_#17">主页#17</option>--%>
				<%--<option value="zy_#18">主页#18</option>--%>
				<%--<option value="zy_#19">主页#19</option>--%>
				<%--<option value="zy_#20">主页#20</option>--%>
				<%--<option value="zy_#21">主页#21</option>--%>
			</select>
		</div>
		<button type="reset" class="layui-btn" onclick="selectByObjecy()">
			<i class="layui-icon">&#xe615;</i>查找

		</button>
		<!-- <button type="reset" class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe63f;</i>重置查询</button> -->
		<button class="layui-btn layui-btn-normal" onclick="insertLoopPhontoShow()">
			<i class="layui-icon">&#xe608;</i>添加广告
		</button>
		<button class="layui-btn" onclick="checkPhontoShow()">
			<i class="layui-icon">&#xe615;</i>查看广告位置
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
    <button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update"><i class="layui-icon">&#xe642;</i>使用 / 编辑
    </button>
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除
    </button>
</script>
	<script type="text/html" id="showImg">

		<a href="#"><img onclick="whole(this)" style="height:26px;width:50px;" src="${ctx}uploadFiles/photo/{{d.projectImg}}"/></a>
	</script>
	<script id="typeTpl" type="text/html">

		{{# if (d.type=="zy_#01"){ }}
			{{# if (d.isUse== 1){ }}
			<span class="isUse">使用中</span>
			{{# } }}
			<label style="">主页#1</label>
		{{# }else if (d.type=="zy_#02"){ }}
			{{# if (d.isUse== 1){ }}
			<span class="isUse">使用中</span>
			{{# } }}
			<label style="">主页#2</label>
		{{# }else if (d.type=="zy_#03"){ }}
			{{# if (d.isUse== 1){ }}
			<span class="isUse">使用中</span>
			{{# } }}
			<label style="">主页#3</label>
		{{# }else if (d.type=="zy_#04"){ }}
			{{# if (d.isUse== 1){ }}
			<span class="isUse">使用中</span>
			{{# } }}
			<label style="">主页#4</label>
		{{# }else if (d.type=="zy_#05"){ }}
			{{# if (d.isUse== 1){ }}
			<span class="isUse">使用中</span>
			{{# } }}
			<label style="">主页#5</label>
		{{# }else if (d.type=="zy_#06"){ }}
			{{# if (d.isUse== 1){ }}
			<span class="isUse">使用中</span>
			{{# } }}
			<label style="">主页#6</label>
		{{# }else if (d.type=="zy_#07"){ }}
		{{# if (d.isUse== 1){ }}
			<span class="isUse">使用中</span>
			{{# } }}
			<label style="">主页#7</label>
		{{# }else if (d.type=="zy_#08"){ }}
			{{# if (d.isUse== 1){ }}
			<span class="isUse">使用中</span>
			{{# } }}
			<label style="">主页#8</label>
		{{# }else { }}
		<label style="">其他</label>
		{{# } }}
	</script>


	<script>

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
			parent.layer.confirm('确定删除' + data.header + '吗 ?', {
				btn : [ '确定', '取消' ]
			//按钮
			}, function() {
				//console.log(data);
				$.ajax({
					type : 'post',
					url : '${ctx }sys/loopphoto/delete?id=' + data.id,
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

		//添加图片
		function insertLoopPhontoShow() {
			cen_showWin({
				width : '1000px',
				height : '750px',
				type : 2,
				title : '添加广告',
				url : '${ctx}sys/loopphoto/add.jsp'
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

		$(function() {
			getUserData(1);
		});

        ///初始化查询
        function selectByObjecy() {
            getUserData(1);
            pageCurr = 1;
        }

		//获取用户列表 (条件查询)
		var Header = '';
		var typep = '';
        var kk='';
		function getUserData(pageNum) {
			Header = $("#header").val();
            typep = $("#typep").val().toString();
            if(typep!=''){
                kk=typep.split('#')[1];
                typep=typep.split('#')[0];
			}
			$.ajax({
				type : 'get',
				url : '${ctx }sys/loopphoto/selectList?pageNum=' + pageNum+'&header='+Header+'&type='+typep+'&kk='+kk,
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

	        for (var i = 0; i <tableData.length; i++) {

	            tableData[i].createTime = formatDate_YMD_HMS(tableData[i].createTime);
	            if(tableData[i].endTime){
                    tableData[i].endTime = formatDate_YMD_HMS(tableData[i].endTime);
				}else{
                    tableData[i].endTime = '无期限';
				}
                tableData[i].moidfyTime = formatDate_YMD_HMS(tableData[i].moidfyTime);

	            /*for(var j=0;j<list.length;j++){
	            	if(tableData[i].villageId==list[j].id){
	            		tableData[i].villageId=list[j].name;
	            		tableData[i].did=didname;
	            	}
	            }*/
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
						field : 'header',
						title : '标题',
						align : 'center',
						width : 200
					}, {
						field : 'htmlUrl',
						title : '链接',
						align : 'center',
						width : 400,
					},
					// 	{
					// 	field : 'photoDescribe',
					// 	title : '图片描述',
					// 	align : 'center',
					// 	width : 200,
					// }
					//,{field: 'orderNo', title: '排序', align:'center',width: 80, sort: true}
					//, {field: 'orderNo', title: '所属部门', align: 'center', width: 200}
					//, {field: 'orderNo', title: '用户角色', align: 'center', width: 150}

					//, {field: 'loginflag', title: '状态', align: 'center', width: 150}
					//,{field:'macAddress', title:'MAC 地址', width:150, align: 'center'}
					//,{field: 'description', title: '描述', align:'center'}
					/*, {
						field : 'serial',
						title : '序号',
						width : 80,
						align : 'center',
					}*/
						//{field : 'num', title : '数量', width : 80, align : 'center',},
						{
						field : 'type',
						title : '广告位置',
						width : 200,
						align : 'center',
                            templet: '#typeTpl'
					},  {
						field : 'endTime',
						title : '结束时间',
						width : 160,
						align : 'center',
					}, {
						field : 'modifyTime',
						title : '发布时间',
						width : 160,
						align : 'center',
						sort : true
					}, {field: 'projectImg', title: '图片',align: 'center',templet: '#showImg'}
					, {
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
					var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					var tr = obj.tr; //获得当前行 tr 的DOM对象
					if (layEvent === 'update') { //编辑
						cen_showWin({
							width : '1000px',
							height : '750px',
							type : 2,
							title : '编辑广告',
							url : '${ctx}sys/loopphoto/update.jsp?id=' + data.id
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