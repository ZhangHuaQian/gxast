<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>灾防信息列表</title>
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
           <input class="layui-input" placeholder="起始日" id="startTime" autocomplete="off">
        </div>
        
        <div class="layui-input-inline">
          <input class="layui-input" placeholder="截止日" id="endTime" autocomplete="off">
        </div>
        
        <div class="layui-input-inline">
            <input type="text" value="" placeholder="标题" name='title' id="title" autocomplete="off"
                   class="layui-input">
        </div>
        
       	<div class="layui-form layui-input-inline" style="width:150px;">
      		<select name="typeValue" id="typeValue" lay-search="">
            </select>
        </div>
        <button type="reset" class="layui-btn" onclick="selectByObjecy()"><i class="layui-icon">&#xe615;</i>查找</button>

        <button class="layui-btn layui-btn-normal" onclick="insertUserShow()"><i class="layui-icon">&#xe608;</i>添加防御灾害资讯
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
    <button class="layui-btn layui-btn-xs" lay-event="select"><i class="layui-icon">&#xe615;</i>查看</button>
    <button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update"><i class="layui-icon">&#xe642;</i>编辑
    </button>
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除
    </button>
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

    //删除资讯
    function deleteUser(data,obj){
        parent.layer.confirm('确定删除' + data.title+ '吗 ?', {
            btn: ['确定', '取消'] //按钮
        }, function () {
            //console.log(data);
            $.ajax({
                type: 'post',
                url: '${ctx }sys/disasters/delete?id='+data.id,
                dataType: 'json',
                success: function (result) {
                    //console.log(result);
                    if(result.status==1){
                        obj.del();
                        parent.layer.msg('删除成功', {icon: 1});
                    }else{parent.layer.msg('操作失败', {icon: 5});}

                },
                error: function (msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });
        }, function () {});
    }

    //添加用户窗口
    function insertUserShow() {
        cen_showWin({
            width: '1000px',
            height: '600px',
            type: 2,
            title: '添加灾防信息',
            url: '${ctx}sys/disasters/add.jsp'
        });
    }

    $(function () {  
    	getType();
        getUserData(1);
    });

    ///初始化查询
    function selectByObjecy() {
        getUserData(1);
        pageCurr = 1;
    }
    
  //获取资讯类型
  	var list;
    function getType(){
    	$.ajax({
    		type: 'get',
            url: '${ctx }sys/dictionary/selectList?type=type_zhfy',
            dataType: 'json',
            async:false, 
            success: function (result) {
            	if(result.count > 0){
    				list=result.list;
    				var data="<option value=''>选择灾防类型</option>";
    				for(var i=0;i<list.length;i++){
    					data+="<option value="+list[i].value+">"+list[i].name+"</option>";
    				}
    				}else{
    					
    				}
    				$("#typeValue").append(data);
           },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
    	});
    }

    //获取用户列表 (条件查询)
    var startTime = '', endTime = '', title = '',typeValue='';
    function getUserData(pageNum) {
    	   title = $("#title").val();
           startTime = $("#startTime").val();
   		   endTime = $("#endTime").val();
   		   typeValue=$('#typeValue').val();
/*         console.log('${ctx }sys/client/selectList?pageNum='+pageNum+'&name='+userName);
 */        $.ajax({
            type: 'get',
            url: '${ctx }sys/disasters/selectList?pageNum='+pageNum+'&title='+title+'&date1='+startTime
			+'&date2='+endTime+'&typeValue='+typeValue,
            dataType: 'json',
            success: function (result) {
                console.log(result);
                if(result.count > 0){
                initTable(result.list);
                initPage(result);
                }else{
                	initTable(0);
                    initPage(0);
                }
            },
            error: function (msg) {
                console.log(msg);
                alert("数据初始化异常");
            }
        });
    }
 

    //初始化表格
    function initTable(tableData) {
    	//资讯类型
    	console.log(list); 
        // 时间转换
        for (var i = 0; i < tableData.length; i++) {
            tableData[i].createtime = formatDate_YMD_HMS(tableData[i].createtime);
            for(var j=0;j<list.length;j++){
            	if(tableData[i].typeValue==list[j].value){
            		tableData[i].typeValue=list[j].name;
            	}
            } 
        }
		console.log(tableData);
        layui.use('table', function () {
            var table = layui.table,form = layui.form;
            table.render({
                elem: '#demo'
                //,skin: 'line' //行边框风格
                //,even: true //开启隔行背景
                //,size: 'sm' //小尺寸的表格
                //,height: 345
                //,width:'auto'
                , data: tableData
                , page: false //关闭分页
                , loading: true
                //,count:200
                //,limit: 10 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
                //,limits:[10]
                , cols: [[ //表头
                    {field: 'id', title: '编号', width: 80, align: 'center', fixed: 'left'}
                    , {field: 'title', title: '标题', align: 'center', width: 250}
                   // , {field: 'price', title: '价格', align: 'center', width: 160}
                    , {field: 'typeValue', title: '类型', align: 'center',width: 160}
                    //,{field: 'orderNo', title: '排序', align:'center',width: 80, sort: true}
                    //, {field: 'orderNo', title: '所属部门', align: 'center', width: 200}
                    //, {field: 'orderNo', title: '用户角色', align: 'center', width: 150}
                    , {field: 'descript', title: '描述', align: 'center'}
                    //, {field: 'loginflag', title: '状态', align: 'center', width: 150}
                    //,{field:'macAddress', title:'MAC 地址', width:150, align: 'center'}
                    ,{field: 'username', title: '作者', align:'center',width:150}
                    , {field: 'createtime', title: '创建时间', width: 200, align: 'center',sort: true}
                    //, {field: 'image', title: '图片',align: 'center',templet: '#showImg'}
                    , {fixed: 'right', title: '操作', width: 250, align: 'center', toolbar: '#barDemo'}
                ]],

            });

            //监听工具条
            table.on('tool(testTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'update') {   //编辑
                    cen_showWin({
                        width: '1000px',
                        height: '600px',
                        type: 2,
                        title: '编辑灾防信息',
                        url: '${ctx}sys/disasters/verify.jsp?id='+data.id
                    });
                }else if (layEvent === 'select') {   //查看
                    cen_showWin({
                        width: '1000px',
                        height: '600px',
                        type: 2,
                        title: '查看灾防信息',
                        url: '${ctx}sys/disasters/select.jsp?id='+data.id
                    });
                } else if (layEvent === 'delete') {   //删除
                    deleteUser(data,obj);
                }
            });

        });
    }

    //初始化分页栏
    var pageCurr = 1;
    function initPage(pageData) {
        layui.use(['laypage', 'layer'], function () {
            var laypage = layui.laypage
                , layer = layui.layer;
            laypage.render({
                elem: 'demo7'
                , curr: pageCurr
                , count: pageData.count
                , layout: ['count', 'prev', 'page', 'next', 'refresh', 'skip']
                , jump: function (obj, first) {
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