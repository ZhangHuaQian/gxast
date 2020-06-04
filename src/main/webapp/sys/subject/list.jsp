<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>专题列表</title>
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
				<input type="text" name="start" class="layui-input" id="start" autocomplete="off"
					   placeholder="起始日期">
			</div>
		</div>
		<div class="layui-inline">
			<div class="layui-input-inline" style="width: 100px">
				<input type="text" name="end" class="layui-input" id="end" autocomplete="off"
					   placeholder="终止日期">
			</div>
		</div>
		<div class="layui-input-inline">
			<input type="text" value="" placeholder="标题" id="title"
				   autocomplete="off" class="layui-input">
		</div>
		<div class="layui-form layui-input-inline">
			<select name="ztype" id="type" lay-search="">
			</select>
		</div>
		<button type="reset" class="layui-btn" onclick="selectByObjecy()">
			<i class="layui-icon">&#xe615;</i>查找
		</button>
		<button class="layui-btn layui-btn-normal" onclick="insertUserShow()">
			<i class="layui-icon">&#xe608;</i>添加
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
	<script type="text/html" id="showImg">
		<a href="#"><img onclick="whole(this)" style="height:26px;width:auto;" src="${ctx}uploadFiles/photo/{{d.img}}" /></a>
	</script>
	<%--操作栏--%>
	<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs" lay-event="select"><i class="layui-icon">&#xe615;</i>查看</button>
    <button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update"><i class="layui-icon">&#xe642;</i>编辑
    </button>
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除
    </button>
	</script>

	<script>
        layui.use('laydate', function(){
            var laydate = layui.laydate;

            //常规用法
            laydate.render({
                elem: '#start'
            });
            laydate.render({
                elem: '#end'
            });
        });
        function whole(img) {
            layer.open({
                type: 1,
                title: false,
                closeBtn: 1,
                shadeClose: true,
                skin: 'yourclass',
                shade: 0,
                resize: true,
                title: '预览图',
                move: '.layui-layer-title',
                content: "<img style='height:100%;width:100%;' src='" + img.src + "'/>"
            });
        }
		//删除资讯
		function deleteUser(data, obj) {
			parent.layer.confirm('确定删除该记录吗 ?', {
				btn : [ '确定', '取消' ]
			//按钮
			}, function() {
				//console.log(data);
				$.ajax({
					type : 'post',
					url : '${ctx }sys/subject/delete?id=' + data.id,
					dataType : 'json',
					success : function(result) {
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
				width : '1000px',
				height : '700px',
				type : 2,
				title : '添加资讯',
				url : '${ctx}sys/subject/add.jsp'
			});
		}
        //初始化资讯类型下拉列表
        function initNewsType(){
            $.ajax({
                type: 'get',
                url: '${ctx }sys/dictionary/selectList?type=type_zt',
                //data:$('#main_form').serialize(),
                dataType: 'json',
                async:false,
                success: function (result) {
                    if(result.count > 0){
                        var list=result.list;
                        var data="<option value=''>选择资讯类型</option>";
                        for(var i=0;i<list.length;i++){
                            data+="<option value="+list[i].value+">"+list[i].name+"</option>";
                        }
                    }else{
                    }
                    $("#type").append(data);
                },
                error: function (msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });
        }

		$(function() {
            initNewsType();
			getUserData(1);
		});
        function selectByObjecy() {
            getUserData(1);
            pageCurr = 1;
        }

		//获取用户列表 (条件查询)
        var userName = '', start = '', end = '',zt='';
		function getUserData(pageNum) {
            userName = $("#title").val();
            start = $("#start").val();
            end = $("#end").val();
            zt = $("#type").val();
            console.log('${ctx }sys/subject/selectList?pageNum='+pageNum+'&title='+ userName + '&start=' + start + '&end='
                + end + '&ztype='+zt);
            console.log(zt);
			$.ajax({
				type : 'get',
				url : '${ctx }sys/subject/selectList?pageNum='+pageNum+'&title='+ userName + '&start=' + start + '&end='
                    + end + '&ztype='+zt,
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

        //获取资讯类型
        var list;
        function NewsType() {
            $.ajax({
                type : 'get',
                url : '${ctx }sys/dictionary/selectList?type=type_zt',
                //data:$('#main_form').serialize(),
                dataType : 'json',
                async : false,
                success : function(result) {
                    list = result.list;
                },
                error : function(msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });
        }
		//初始化表格
		function initTable(tableData) {
            NewsType();
            for (var i = 0; i < tableData.length; i++) {
                tableData[i].createTime = formatDate_YMD_HMS(tableData[i].createTime);
				for (var j = 0; j < list.length; j++) {
                    if (tableData[i].ztype == list[j].value) {
                        tableData[i].ztype = list[j].name;
                    }
                }
            }
			console.log(tableData);
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
					},{
                            field : 'title',
                            title : '主题',
                            align : 'center',
                            width : 250
                        },
						{
						field : 'ztype',
						title : '类型',
						align : 'center',
						width : 200
					},{
                            field : 'author',
                            title : '作者',
                            align : 'center',
                            width : 250
                        }
					,  {
						field : 'img',
						title : '图片',
						width : 200,
						templet: '#showImg',
						align : 'center',

					},{
                            field : 'createTime',
                            title : '创建时间',
                            width : 300,
                            align : 'center',

                        },{
						fixed : 'right',
						title : '操作',
                            sort : true,
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
							height : '700px',
							type : 2,
							title : '编辑资讯',
							url : '${ctx}sys/subject/toupdate?id='+data.id
						});
					} else if (layEvent === 'select') { //查看
						cen_showWin({
							width : '1000px',
							height : '700px',
							type : 2,
							title : '查看',
							url : '${ctx}sys/subject/subject?id='+data.id
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
                type: param.type,
                area: [param.width, param.height],
                title: param.title,
                closeBtn: 1,
                //shade: [0.1, '#FFFFFF'],
                //shadeClose: true,
                //skin: 'yourclass',
                resize: true,
                success: function (layero, index) {
                    //console.log(layero, index);
                },
                content: param.url,
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