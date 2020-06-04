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
		<select name="newsType" id="type" lay-search="">
			<option value="">选择资讯模块</option>
			<option value="news">新闻中心</option>
			<option value="axhd">党建工作</option>
			<option value="zzgk">政务公开</option>
		</select>
	</div>
	<button type="reset" class="layui-btn" onclick="selectByObjecy()">
		<i class="layui-icon">&#xe615;</i>查找
	</button>

	<a class="layui-btn layui-btn-small"
	   href="javascript:location.replace(location.href);" title="刷新">刷新</a>
</blockquote>
<%--</form>--%>
<!-- 表格 -->
<table id="tableData" lay-filter="tableDataFilter"></table>
<!-- 分页栏 -->
<div id="myPageTool" style="text-align: left;"></div>
<%--操作栏--%>
<script type="text/html" id="barTool">
	<button class="layui-btn layui-btn-xs" lay-event="select"><i class="layui-icon">&#xe615;</i>查看</button>
	<%--<button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除
	</button>--%>
	<button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="verifty"><i class="layui-icon">&#xe642;</i>审核
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
<script type="text/html" id="newsTpl">
	{{# if(d.newsType=='news'){  }}
	新闻中心
	{{# }else if(d.newsType=='axhd'){ }}
	党建工作
	{{# }else if(d.newsType=='zzgk'){ }}
	政务公开
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


    //获取资讯列表 (条件查询)
    var title = '', start = '', end = '', newsType='';
    function getInitData(pageNum) {
        title = $("#title").val();
        start = $("#start").val();
        end = $("#end").val();
        newsType = $("#type").val();
        var obj={
            pageNum:pageNum,
            title:title,
            date1:start,
            date2:end,
            newsType:newsType
        };
        $.ajax({
            type : 'get',
            //url : '${ctx }newsVeriftyUser/selectMySecondVeriftyList?'+parseParam(obj),
            url : '${ctx }newsVeriftyUser/selectMySecondVeriftyList',
            data:parseParamObjNotNull(obj),
            dataType : 'json',
            success : function(result) {
                var resultData = result.data;
                if (resultData!=undefined&&resultData!=null&&resultData.count>0) {
                    initTable(resultData.data);
                    initPage(resultData);
                }else {
                    initTable([]);
                    initPage(0);
                }
            },
            error : function(msg) {
                console.log(msg);
                alert("数据初始化异常");
            }
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

    //初始化表格
    function initTable(tableData) {
        //获取资讯类型字典对照
        getNewsType();
        console.log(list);
        // 将资讯类型id  newTypeId 转换成对应的中文
        for (var i = 0; i < tableData.length; i++) {
            for (var j = 0; j < list.length; j++) {
                if (tableData[i].newTypeId == list[j].value) {
                    tableData[i].newTypeId = list[j].name;
                }
            }
        }
        //将所有记录渲染成表格
        layui.use('table', function() {
            var table = layui.table, form = layui.form;
            table.render({
                elem : '#tableData'
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
                        width : 300
                    }, {
                        field : 'newsType',
                        title : '资讯模块',
                        align : 'center',
                        templet: '#newsTpl',
                        width : 200
                    }, {
                        field : 'newTypeId',
                        title : '类型',
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
                        toolbar : '#barTool'
                    } ] ],

            });

            //监听工具条
            table.on('tool(tableDataFilter)', function(obj) {
                //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'verifty') { //编辑
                    var params={
                        id:data.id,
                        newsType:data.newsType
                    }
                    showWin({
                        width : '1000px',
                        height : '800px',
                        type : 2,
                        title : '审核资讯',
                        url : '${ctx}newsVerifty/toSecondVerifty?'+parseParam(params)
                    });
                } else if (layEvent === 'select') { //查看
                    showWin({
                        width : '1000px',
                        height : '800px',
                        type : 2,
                        title : '查看资讯',
                        url : '${ctx}web/'+data.allTypeName+'/webdetails/'+data.id+'.html'
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
                elem : 'myPageTool',
                curr : pageCurr,
                count : pageData.count,
                layout : [ 'count', 'prev', 'page', 'next',
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
    ///初始化查询
    function selectByObjecy() {
        getInitData(1);
        pageCurr = 1;
    }

</script>

</body>
</html>