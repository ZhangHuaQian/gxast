<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>订单列表</title>
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
        
        <button type="reset" class="layui-btn" onclick="selectByObjecy()"><i class="layui-icon">&#xe615;</i>查找</button>

        <a class="layui-btn layui-btn-small" style="margin-right:5px;float:right"
           href="javascript:history.go(0);" title="刷新">刷新</a>
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
	{{# if(d.status==1){  }}
    <button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update"><i class="layui-icon">&#xe642;</i>填写物流单号
    </button>             
	{{# } }}
	{{# if(d.status==0){  }}
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除
    </button>
	{{# } }}        
</script>
<script type="text/html" id="showImg">       
   
   <a href="#"><img onclick="whole(this)" style="height:26px;width:50px;" src="${ctx}uploadFiles/photo/{{d.productImage}}"/></a>
</script>
<script type="text/html" id="state">  
	{{# if(d.status==0){  }}                    
    <label style="color: gray">待付款</label>
    {{# }else if(d.status==1) { }}
    <label style="color: red">待发货</label>
	{{# }else if(d.status==2) { }}
    <label style="color: blue">发货中</label>
	{{# }else if(d.status==3) { }}           
    <label style="color: green">已完成</label>      
    {{# } }}     
</script>
<script>
	
	function whole(image){
		console.log(image.src)
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
			  content: "<img style='height:100%;width:100%;' src='"+image.src+"'/>"
		});
	}
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
        parent.layer.confirm('确定删除' + data.productName+ '吗 ?', {  
            btn: ['确定', '取消'] //按钮
        }, function () {
            //console.log(data);
            $.ajax({
                type: 'post',
                url: '${ctx }sys/order/delete?id='+data.id,
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
            title: '添加商品',
            url: '${ctx}sys/product/insert.jsp'
        });
    }

    $(function () {
        getUserData(1);
    });
    ///初始化查询
    function selectByObjecy() {
        getUserData(1);
        pageCurr = 1;
    }
    
  //获取资讯类型
  	var list;

    //获取用户列表 (条件查询)
    var startTime = '', endTime = '', pname = '',type='',isUp='';                               
    function getUserData(pageNum) {
            $.ajax({
            type: 'get',
            url: '${ctx }sys/order/selectList?pageNum='+pageNum+"&date1="+$("#startTime").val()+"&date2="+$("#endTime").val(),          
            dataType: 'json',            
            success: function (result) {
                console.log(result);
                if(result.count > 0){
	                initTable(result.orders,result.products);
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
    function initTable(tableData,products) {           
        // 时间转换
        for (var i = 0; i < tableData.length; i++) {
        	tableData[i].createtime = formatDate_YMD_HMS(tableData[i].createtime); 
        	tableData[i].total = "<span style='color:red'>￥"+tableData[i].total+"</span> ";          
        }
		console.log(tableData);
        layui.use('table', function () {
            var table = layui.table,form = layui.form;
            table.render({
                elem: '#demo'
                , data: tableData
                , page: false //关闭分页
                , loading: true          
                , cols: [[ //表头
                    {field: 'id', title: '编号', width: 100, align: 'center', fixed: 'left'}
                    , {field: 'productName', title: '商品名称', align: 'center', width: 250}
                    , {field: 'total', title: '总价', align: 'center', width: 100} 
                    , {field: 'remarks', title: '备注', align: 'center',width: 160} 
                    , {field: 'address', title: '地址', align: 'center',width:200}
                    , {field: 'username', title: '购买者', align: 'center',width:150}                
                    , {field: 'status', title: '状态', align: 'center',templet: '#state'}         
                    , {field: 'createtime', title: '创建时间', width: 200, align: 'center',sort: true}
                    , {field: 'productImage', title: '图片',align: 'center',templet: '#showImg'}
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
                        width: '500px',              
                        height: '150px',       
                        type: 2,     
                        title: '编辑订单信息',
                        url: '${ctx}sys/order/update.jsp?id='+data.id
                    });
                }else if (layEvent === 'delete') {   //删除
                    deleteUser(data,obj);
                }else if (layEvent === 'select'){
                	cen_showWin({                            
                        width: '1100px',
                        height: '600px',
                        type: 2,     
                        title: '查看订单信息',
                        url: '${ctx}sys/order/select.jsp?id='+data.id
                    });
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
                    	console.log("page:"+obj.curr);                 
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
            //skin: 'yourclass',
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