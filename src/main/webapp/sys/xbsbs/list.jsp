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
        <a class="layui-btn layui-btn-small" style="margin-right:5px;float:right"
           href="javascript:history.go(0);" title="刷新">刷新</a>
    </blockquote>
    </div>
<%--</form>--%>

<!-- 表格 -->
<table id="demo" lay-filter="testTable"></table>
<!-- 分页栏 -->
<div id="demo7" style="text-align: left;"></div>                                
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

<script type="text/html" id="barDemo">                           
    <button class="layui-btn layui-btn-xs" lay-event="select"><i class="layui-icon">&#xe615;</i>查看</button>
	<%--<button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="download"><i class="layui-icon">&#xe601;</i> 下载附件
	</button>--%>
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
            url: '${ctx }sys/xbsbs/selectList?pageNum='+pageNum,          
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
        // 时间转换
        for (var i = 0; i < tableData.length; i++) {
            tableData[i].createtime = formatDate_YMD_HMS(tableData[i].createtime);
        }
        layui.use('table', function () {
            var table = layui.table,form = layui.form;
            table.render({
                elem: '#demo'
                , data: tableData
                , page: false //关闭分页
                , loading: true          
                , cols: [[ //表头
                    {field: 'id', title: '编号', width: 80, align: 'center', fixed: 'left'}
                    , {field: 'name', title: '收货人', align: 'center', width: 150}                         
                    , {field: 'sex', title: '性别', align: 'center', width: 80}                                                                     
                    , {field: 'area', title: '地区', align: 'center',width: 400} 
                    , {field: 'school', title: '学校年级', align: 'center',width:250}
                    , {field: 'createtime', title: '下单时间', align: 'center',width:160}
                    , {field: 'phone', title: '手机号', align: 'center',width:250},
                    {                                                          
						fixed : 'right',
						title : '操作',
						align : 'center',
						toolbar : '#barDemo',
						width: 250
					} 
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
                        url: '${ctx}sys/order/verify.jsp?id='+data.id
                    });
                }else if (layEvent === 'delete') {   //删除
                    deleteUser(data,obj);
                }else if (layEvent === 'select'){                                                
                	cen_showWin({                                                                              
                        width: '600px',                   
                        height: '600px',                                                                       
                        type: 2,                                            
                        title: '小博士报订单信息',                                                                                     
                        url: '${ctx}sys/xbsbs/select.jsp?code='+data.code+'&password='+data.password+'&goods='+encodeURIComponent(data.goods)+"&remark="+data.remark +
                            "&area="+data.area + "&school="+data.school+"&classes="+data.classes+"&name="+data.name+"&phone="+data.phone
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