<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html> 
<html>
<head> 
  <meta charset="utf-8">
  <title>角色列表</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="">
  <meta name="description" content="">
  <%@ include file="/commViews/head.jsp"%>
  <link rel="stylesheet" href="${ctx }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
  <script type="text/javascript" src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.core.min.js"></script>
  <script type="text/javascript" src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.excheck.min.js"></script>
</head>
<body>

<div class="layui-tab-item layui-show"> 
    <blockquote class="layui-elem-quote" style="padding:10px;margin-bottom:0px;"> 
    	<button class="layui-btn layui-btn-normal" onclick="insertShow()"><i class="layui-icon">&#xe608;</i>添加角色</button>
        <a class="layui-btn layui-btn-small" style="margin-right:5px;float:right" href="javascript:location.replace(location.href);" title="刷新">刷新</a>
    </blockquote>
 </div>

<!-- 表格 -->
<table id="demo" lay-filter="testTable"></table>
<script type="text/html" id="barDemo">
<%--<button class="layui-btn layui-btn-xs" lay-event="select"><i class="layui-icon">&#xe615;</i>查看</button>--%>
<button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update"><i class="layui-icon">&#xe642;</i>编辑</button>
<button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除</button>
</script>

<script>

//添加用户窗口
function insertShow(){
	cen_showWin({width:'350px',height:'340px',type:2,title:'添加角色',url:'${ctx}sys/upms/role/insert.jsp'});
}

$(function(){
	getRoleData();
});

//获取角色列表
function getRoleData(){
	$.ajax({
		type:'get',
		url:'${ctx }sys/upms/role/selectAll.do',
		dataType:'json',
		success:function(result){
			if(result.list != undefined)initTable(result.list);
		},
		error:function (msg){
			console.log(msg);
			alert("数据初始化异常");
		}
	});
}

//删除角色
function deleteRole(role_data,obj){
    $.ajax({
        type:'post',
        url:'${ctx }sys/upms/role/update.do?id='+role_data.id+'&isDel=1',
        dataType:'json',
        success:function(result){
            if(result.status==1){
                obj.del();
                parent.layer.msg('删除成功', {icon: 1});
            }else{
                parent.layer.msg('操作失败', {icon: 1});
            }

        },
        error:function (msg){
            console.log(msg);
            alert("系统异常");
        }
    });
}

//初始化表格
function initTable(tableData){
	// 时间转换
    for (var i = 0; i < tableData.length; i++) {
    	var newTime = new Date(tableData[i].createTime);
    	tableData[i].createTime = newTime.toLocaleString().substring(0, newTime.toLocaleString().indexOf(" "));  
	}

	layui.use('table', function(){
	  var table = layui.table;
	  table.render({
	    elem: '#demo'
	    //,skin: 'line' //行边框风格
	    //,even: true //开启隔行背景
	    //,size: 'sm' //小尺寸的表格
	    //,height: 350 
	    //,width:'1100'
	    ,data:tableData
	    ,page: false //关闭分页
	    ,loading:true
	    //,count:200    
	    ,limit: tableData.length //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
	    //,limits:[10] 
	    ,cols:  [[ //表头
	     	      {field: 'id', title: 'ID', width:150, align:'center',fixed: 'left'}
	    	      ,{field: 'roleName', title: '角色名称', align:'left',width:150}
                    ,{field: 'power', title: '权限标识', align:'left',width: 150}
	    	      ,{field: 'orderNo', title: '排序', align:'center',width: 150, sort: true}
	    	      ,{field: 'createTime', title: '创建时间',align:'center', width: 135}
	    	      ,{field: 'description', title: '描述', align:'left'}
	    	      ,{fixed: 'right', title:'操作',width:200, align:'center', toolbar: '#barDemo'}
	    	    ]],
	    
	  });
	  
	  //监听工具条
	  table.on('tool(testTable)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
	    var data = obj.data; //获得当前行数据
	    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
	    var tr = obj.tr; //获得当前行 tr 的DOM对象
	    if(layEvent === 'update'){   //编辑
			cen_showWin({width:'650px',height:'340px',type:2,title:'编辑角色',url:'${ctx}sys/upms/role/update.jsp?id='+data.id});
	    }/*else if(layEvent === 'select'){   //查看
			cen_showWin({width:'600px',height:'400px',type:2,title:'查询角色',url:'${ctx}sys/ucenter/user/select.jsp'});	    
	    }*/else if(layEvent === 'delete'){   //删除
	    	parent.layer.confirm('确定删除 '+data.roleName+' 吗 ?', {
	    	  btn: ['确定','取消'] //按钮
	    	}, function(){
                deleteRole(data,obj);
	    	}, function(){});
	    }  
	  });
	  
	});
}

var indexWin ;
// 新建窗口
function cen_showWin(param){
	 indexWin = parent.layer.open({
       type: param.type, 
       area: [param.width, param.height],
       title: param.title,
       closeBtn: 1,
       //shade: [0.1, '#FFFFFF'],
       shadeClose: true,
       skin: 'yourclass',
       resize:true,
       success: function(layero, index){
      	    //console.log(layero, index);
       },  
       content: param.url
      }); 
}

//关闭窗口
function layerClose(){
	parent.layer.close(indexWin);
}

</script>


</body>
</html>