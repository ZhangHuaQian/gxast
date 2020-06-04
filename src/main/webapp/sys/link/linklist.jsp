<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>工人列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <%@ include file="/commViews/head.jsp" %>
</head>
<body style="padding-right: 20px;">

<!-- 用户添加 -->
<blockquote class="layui-elem-quote" style="padding:10px;margin-bottom:0px;">
    <button class="layui-btn layui-btn-normal1" onclick="insertUserShow()"><i class="layui-icon">&#xe608;</i>添加链接
    </button>
    <a class="layui-btn layui-btn-small" style="margin-right:5px;float:right"
       href="javascript:location.replace(location.href);" title="刷新">刷新</a>
</blockquote>

<!-- 表格 -->
<table id="demo" lay-filter="testTable"></table>
<!-- 分页栏 -->
<div id="demo7" style="text-align: left;"></div>
<%--操作栏--%>
<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update"><i class="layui-icon">&#xe642;</i>编辑
    </button>
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除
    </button>
</script>


<script>
    $(function () {
        getUserData(1);
        pageCurr = 1;
    });


    function getUserData(pageNum) {
        $.ajax({
            type : 'get',
            url : '${ctx }sys/link/selectList?pageNum='+pageNum,
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
                        title : 'id',
                        width : 80,
                        align : 'center',
                        fixed : 'left'
                    }, {
                        field : 'linkname',
                        title : '链接名称',
                        align : 'center',

                    }, {
                        field : 'link',
                        title : '链接',
                        align : 'center',

                    }, {
                        field : 'note',
                        title : '内容',
                        align : 'center'
                    }, {
                        fixed : 'right',
                        title : '操作',
                        align : 'center',
                        toolbar : '#barDemo',
                        width:250
                    } ] ],

            });

            //监听工具条
            table.on('tool(testTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'update') {   //编辑
                    cen_showWin({
                        width: '660px',
                        height: '450px',
                        type: 2,
                        title: '更新链接信息',
                        url: '${ctx}sys/link/verify.jsp?id='+data.id,
                    });
                } else if (layEvent === 'delete') {   //删除changepsw

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

    //添加用户窗口
    function insertUserShow() {
        cen_showWin({
            width: '660px',
            height: '450px',
            type: 2,
            title: '添加链接',
            url: '${ctx}sys/link/add.jsp'
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
            content: param.url,
            cancel : function(index, layero) {
                if (confirm('当前修改内容尚未保存，确定要关闭吗？')) { //只有当点击confirm框的确定时，该层才会关闭
                    parent.layer.close(index);
                }
                return false;
            }
        });
    }

    //删除
    function deleteUser(data, obj) {
        parent.layer.confirm('确定删除' + data.id + '吗 ?', {
            btn : [ '确定', '取消' ]
            //按钮
        }, function() {
            $.ajax({
                type : 'post',
                url : '${ctx }sys/link/delete?id=' + data.id,
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

                },
                error : function(msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });
        }, function() {
        });
    }



</script>

</body>
</html>