
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp"%>
<%@ include file="/commViews/head.jsp"%>
<html>
<head>
    <title>我的消息列表</title><meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="${ctxRes}css/font.css">
    <link rel="stylesheet" href="${ctxRes}css/xadmin.css">
    <link rel="stylesheet" href="${ctxRes}plugins/layui/css/layui.css">
    <link rel="stylesheet" href="${ctxRes}css/mylayui.css">
    <script src="${ctxRes}plugins/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctxRes}js/util.js"></script>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>

</head>

<body>

<div class="x-body" style="padding: 5px;width: 98%;">

    <table class="layui-table" lay-data="{url:'${ctx}sys/Message/getMyMessageTB', page:true, id:'message',limit:10,limits:[10],height:472}" lay-filter="message">
        <thead>
        <tr>
            <th lay-data="{field:'id',width:80,align:'center'}">编号</th>
            <th lay-data="{field:'sendName',width:100,align:'center'}">发送人</th>
            <th lay-data="{field:'title',width:200,align:'center'}">标题</th>
            <th lay-data="{field:'message',align:'center'}">内容</th>
           <%-- <th lay-data="{field:'type',width:120,align:'center'}">消息类型</th>--%>
            <th lay-data="{field:'postDate',width:200,align:'center',templet: '#postdate'}">发送时间</th>
            <th lay-data="{field:'statue',width:100,align:'center',templet: '#statue'}">状态</th>
            <th lay-data="{width:190, align:'center', toolbar: '#barDemo'}">操作</th>
        </tr>
        </thead>
    </table>
</div>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs " lay-event="del">删除</a>
   <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="read">已读</a>
</script>
<script type="text/javascript">
    function stampToTime(timestamp) {

        return timestampToTime(timestamp);
    }
</script>
<script id="postdate" type="text/html">
    {{ stampToTime(d.postDate) }}
</script>
<script id="statue" type="text/html">
    {{#if(d.statue==1){}}
    <span style="color:#009688">已读</span>
    {{# }else{ }}
    <span style="color:#FF5722">未读</span>
    {{#}}}
</script>
<script>
    var dataArray = new Object();
    var active;
    layui.use(['table'], function(){
        var table = layui.table;
        //监听表格复选框选择
        table.on('checkbox(message)', function(obj){
            console.log(obj)
        });
        //监听工具条
        table.on('tool(message)', function(obj){
            var data = obj.data;
            if(obj.event=='read'){
             read(data);
         }else if(obj.event=='del'){
             deleteUser(data, obj);
         }
        });
        var tablereload;
        var datas = new Object();
        var $ = layui.$;
        active = {
            getCheckData: function(){ //获取选中数据
                var checkStatus = table.checkStatus('message')
                    ,data = checkStatus.data;
                datas = data;
            }
            ,getCheckLength: function(){ //获取选中数目
                var checkStatus = table.checkStatus('message')
                    ,data = checkStatus.data;
                datas = data;
            }
            ,isAll: function(){ //验证是否全选
                var checkStatus = table.checkStatus('message');
            },
            reload: function(){//表格重载
                console.log("执行重载");
                //执行重载
                tablereload = table.reload('message', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        searchtype:$('#searchtype').val(),
                        search:$('#search').val(),

                    },done: function(res, curr, count){
                        //this.where={};
                    }
                });
            },
            reset:function () {
                //条件重载
                $('#searchtype').val("");
                $('#search').val("");
                if(tablereload!=undefined){
                    tablereload.config.where={};
                    active.reload();
                }
            }
        };
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

    });


    //删除用户
    function deleteUser(data, obj) {
        parent.layer.confirm('确定删除ID为' + data.id + '的数据吗 ?', {
            btn : [ '确定', '取消' ]
            //按钮
        }, function() {
            $.ajax({
                    type : 'post',
                    url : '${ctx}sys/Message/delete?id=' + data.id,
                    dataType : 'json',
                    success : function(result) {
                        console.log(result);
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
                        active.reload();
                    },
                    error : function(msg) {
                        console.log(msg);
                        alert("系统异常");
                    }
                });
        }, function() {
        });
    }


    //修改
    function read(data) {
        console.log(data);
        $.ajax({
            type : 'post',
            url : '${ctx}sys/Message/read?id='+data.id,
            dataType : 'json',
            success : function(result) {
                console.log(result)
                if (result.status == 1) {
                    layer.msg("操作完成");
                    setTimeout(function (){
                        window.parent.frames["消息列表"].location.reload();//刷新父借口
                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index);
                    },1000)
                } else {
                    parent.layer.msg('修改失败', {
                        icon : 5
                    });
                }
                active.reload();
            },
            error : function(msg) {
                console.log(msg);
                alert("系统异常");
            }
        });

    }


</script>
</body>
</html>

