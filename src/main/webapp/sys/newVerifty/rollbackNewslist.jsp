<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>资讯列表</title>
	<meta name="viewport"
		  content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="keywords" content="">
	<meta name="description" content="">
	<link rel="stylesheet" href="${ctx }resource/plugins/layui/css/layui.css">
	<%@ include file="/commViews/head.jsp"%>

	<style type="text/css">
		.dl{
			top: 39px;
		}
		ul span{
			/*background-color: white;*/
		}
	</style>
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
		<input type="text" value="" placeholder="标题" maxlength="10" id="title"
			   autocomplete="off" class="layui-input">
	</div>
	<div class="layui-form layui-input-inline">
		<select name="newsModule" id="newsModule"  lay-search="">
			<option value="">资讯模块</option>
			<option value="news">新闻中心</option>
			<option value="news_axhd">党建工作</option>
			<option value="news_zzgk">政务公开</option>
		</select>
	</div>
	<div class="layui-form layui-input-inline">
		<select name="verifty" id="verifty"  lay-search="">
			4二审不通过 后面的状态不一定用得到先设计着 5已发布 6退回 7关闭
			<option value="">审核状态</option>
			<option value="0">未审核</option>
			<option value="1">一审通过</option>
			<option value="2">一审不通过</option>
			<%--<option value="3">二审通过</option>--%>
			<option value="4">二审不通过</option>
			<option value="5">已发布(二审通过)</option>
		</select>
	</div>
	<button type="reset" class="layui-btn" onclick="selectByObjecy()">
		<i class="layui-icon">&#xe615;</i>查找
	</button>
	<%--<button class="layui-btn layui-btn-normal" onclick="insertNews()">--%>
	<%--<i class="layui-icon">&#xe608;</i>添加资讯--%>
	<%--</button>--%>

	<ul class="layui-nav" style="display: inline;">
		<li class="layui-nav-item" style="line-height: 23px;height: 43px;">
			<a style="padding: 10px 15px;background-color: #1e9fff;color: white;height: 17px;font-size: 15px;border-radius: 2px;" href="javascript:;"><i class="layui-icon">&#xe608;</i>添加资讯</a>
			<dl class="layui-nav-child dl">
				<dd><a href="javascript:void(0)" onclick="insertNews('${ctx}sys/news/add.jsp')">新闻中心</a></dd>
				<dd><a href="javascript:void(0)" onclick="insertNews('${ctx}sys/news_axhd/add.jsp')">党建工作</a></dd>
				<dd><a href="javascript:void(0)" onclick="insertNews('${ctx}sys/news_zzgk/add.jsp')">政务公开</a></dd>
			</dl>
		</li>
	</ul>


	<a class="layui-btn layui-btn-small"
	   href="javascript:location.replace(location.href);" title="刷新">刷新</a>
</blockquote>
<%--</form>--%>
<!-- 表格 -->
<table id="demo" lay-filter="testTable"></table>
<!-- 分页栏 -->
<div id="demo7" style="text-align: left;"></div>
<%--操作栏--%>
<script type="text/html" id="barDemo">
	<button class="layui-btn layui-btn-xs" lay-event="select"><i class="layui-icon">&#xe615;</i>查看</button>
	{{# if(d.verifty==0) { }}
	<button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update"><i class="layui-icon">&#xe642;</i>编辑</button>
	{{# } else if(d.verifty==6){  }}
	<button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="resCommit"><i class="layui-icon">&#xe642;</i>重新提交</button>
	{{# } }}
	<button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除
	</button>

</script>
<script type="text/html" id="veriftyTpl">
	{{# if(d.verifty==0){  }}
	<label style="color: #ff0000">未审核</label>
	{{# }else if(d.verifty==1){ }}
	<label style="color: #FF9800">一审通过</label>
	{{# }else if(d.verifty==5){ }}
	<label style="color: #009688">已发布</label>
	{{# }else if(d.verifty==6){ }}
	<label style="color: #ff0000">已被退回</label>
	{{# }}}
</script>
<script>
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        //常规用法
        var date1 = laydate.render({
            elem: '#start',
            done: function(value, date, endDate) {
                if($("#end").val() != "") {
                    var date_ = date2.config.dateTime;
                    date_.month++;
                    console.log(date_);
                    console.log(date);
                    if(new Date(date_.year, date_.month, date_.date).getTime() < new Date(date.year, date.month, date.date).getTime()) {
                        layer.msg("起始日期不能超过结束日期");
                        $("#start").val("");
                    }
                }
            }
        });
        var date2 = laydate.render({
            elem: '#end',
            done: function(value, date, endDate) {
                if($("#start").val() != "") {
                    var date_ = date1.config.dateTime;
                    date_.month++;
                    console.log(date_);
                    console.log(date);
                    if(new Date(date_.year, date_.month, date_.date).getTime() > new Date(date.year, date.month, date.date).getTime()) {
                        layer.msg("起始日期不能超过结束日期");
                        $("#end").val("");
                    }
                }
            }
        });
    });

    $(function() {
        getInitData(1);
    });

    //添加资讯
    function insertNews(url) {
        sx_showWin({
            width : '1000px',
            height : '800px',
            type : 2,
            title : '添加资讯',
            <%--url : '${ctx}sys/news/add.jsp'--%>
            url : url
        });
    }

    //删除资讯
    function deleteNews(data, obj) {
        parent.layer.confirm('确定删除' + data.title + '吗 ?', {
            btn : [ '确定', '取消' ]
            //按钮
        }, function() {
            var url = '${ctx }sys/news/delete?id=' + data.id;
            console.log(data.newsModule)
            if(data.newsModule == '党建工作'){
                url = '${ctx }sys/news_axhd/delete?id=' + data.id;
            }else if(data.newsModule == '政务公开'){
                url = '${ctx }sys/news_zzgk/delete?id=' + data.id;
            }
            console.log(url)
            $.ajax({
                type : 'post',
                url : url,
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

    //从字典里获取数据，以便将列表中的newTypeId字段解析成正确的中文
    var list;
    function getNewsType() {
        $.ajax({
            type : 'get',
            url : '${ctx }sys/dictionary/selectList',
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

    //获取资讯列表 (条件查询)
    var title = '', start = '', end = '',newsModule=null;
    function getInitData(pageNum) {
            title = $("#title").val();
            start = $("#start").val();
            end = $("#end").val();
            newsModule = $("#newsModule").val();
            var obj={
            pageNum:pageNum,
            title:title,
            date1:start,
            date2:end,
            verifty:6,
            newsModule:newsModule
        };
        $.ajax({
            type : 'get',
            url : '${ctx }sys/news/selectMyList',
            dataType : 'json',
            data:obj,
            success : function(result) {
                initTable(result.data.data);
                initPage(result.data);
            },
            error : function(msg) {
                console.log(msg);
                alert("数据初始化异常");
            }
        });
    }

    //初始化表格
    function initTable(tableData) {
        getNewsType();
        // console.log(list);

        for (var i = 0; i < tableData.length; i++) {
            // 时间转换
            tableData[i].createTime = formatDate_YMD_HMS(tableData[i].createTime);

            //资讯模块转换
            if(tableData[i].newsModule == "news"){
                tableData[i].newsModule = "新闻中心";
            }else if(tableData[i].newsModule == "news_axhd"){
                tableData[i].newsModule = "党建工作";
            }else if(tableData[i].newsModule == "news_zzgk"){
                tableData[i].newsModule = "政务公开";
            }

            //资讯类型转换
            for (var j = 0; j < list.length; j++) {
                if (tableData[i].newTypeId == list[j].value) {
                    tableData[i].newTypeId = list[j].name;
                }
            }
        }
        // console.log(tableData);
        layui.use(['table','element'], function() {
            var table = layui.table, form = layui.form;
            var element = layui.element;
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
                        field : 'title',
                        title : '标题',
                        align : 'center',
                    }, {
                        field : 'newsModule',
                        title : '资讯模块',
                        align : 'center',
                        width : 200
                    }, {
                        field : 'newTypeId',
                        title : '资讯类型',
                        align : 'center',
                        width : 200
                    }, {
                        field : 'editor',
                        title : '编辑者',
                        align : 'center',
                        width : 150
                    }
                    , {
                        field : 'author',
                        title : '作者',
                        align : 'center',
                        width : 150
                    }
                    , {
                        field : 'verifty',
                        title : '审核状态',
                        align : 'center',
                        width : 150,
                        templet: '#veriftyTpl'
                    }
                    , {
                        field : 'createTime',
                        title : '创建时间',
                        width : 200,
                        align : 'center',

                    }, {
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
                    var url = '${ctx}sys/news/toupdate?id=' + data.id;
                    if(data.newsModule == '党建工作'){
                        url = '${ctx}sys/news_axhd/toupdate?id=' + data.id;
                    }else if(data.newsModule == '政务公开') {
                        url = '${ctx}sys/news_zzgk/toupdate?id=' + data.id;
                    }
                    sx_showWin({
                        width : '1000px',
                        height : '800px',
                        type : 2,
                        title : '编辑资讯',
                        url : url
                    });
                } else if (layEvent === 'select') { //查看
                    var url = '${ctx}sys/news/news?id=' + data.id;
                    if(data.newsModule == '党建工作'){
                        url = '${ctx}sys/news_axhd/news?id=' + data.id;
                    }else if(data.newsModule == '政务公开') {
                        url = '${ctx}sys/news_zzgk/news?id=' + data.id;
                    }
                    sx_showWin({
                        width : '1000px',
                        height : '800px',
                        type : 2,
                        title : '查看资讯',
                        url : url,
                    });
                } else if (layEvent === 'delete') { //删除
                    deleteNews(data, obj);
                }else if (layEvent === 'resCommit') { //重新提交
                    var url = '${ctx}sys/news/toModify?id=' + data.id;
                    if(data.newsModule == '党建工作'){
                        url = '${ctx}sys/news_axhd/toModify?id=' + data.id;
                    }else if(data.newsModule == '政务公开') {
                        url = '${ctx}sys/news_zzgk/toModify?id=' + data.id;
                    }
                    sx_showWin({
                        width : '1000px',
                        height : '800px',
                        type : 2,
                        title : '编辑资讯',
                        url : url
                    });
                }
            });

        });
    }

    //初始化分页栏
    var pageCurr = 1;
    function initPage(pageData) {
        console.log(pageData);
        layui.use([ 'laypage', 'layer' ], function() {
            var laypage = layui.laypage, layer = layui.layer;
            laypage.render({
                elem : 'demo7',
                curr : pageCurr,
                count : pageData.count,
                layout : [ 'count', 'prev', 'page', 'next',
                    'skip' ],
                jump : function(obj, first) {
                    if (!first) {//首次不执行
                        getInitData(obj.curr);
                        pageCurr = obj.curr;
                    }
                }
            });
        });
    }
    ///初始化查询
    function selectByObjecy() {
        getInitData(1);
        pageCurr = 1;
    }


    //打开新窗口
    function sx_showWin(param) {
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
            },
            content: param.url,
            cancel : function(index, layero) {
                if (confirm('当前修改内容尚未保存，确定要关闭吗？')) { //只有当点击confirm框的确定时，该层才会关闭
                    parent.layer.close(index);
                }
                return false;
            },
            end:function () {
                getInitData(pageCurr);
            }
        });
    }


</script>

</body>
</html>