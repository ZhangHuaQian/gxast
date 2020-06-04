<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2019/1/17
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>数据字典列表</title>
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
        <input type="text" value="" placeholder="版块名称" id="sname" autocomplete="off"
               class="layui-input">
    </div>
    <div class="layui-input-inline">
        <input type="text" value="" placeholder="版块主题" id="sprofile" autocomplete="off"
               class="layui-input">
    </div>
    <button type="reset" class="layui-btn" onclick="selectByObjecy()"><i class="layui-icon">&#xe615;</i>查找</button>

    <!-- <button type="reset" class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe63f;</i>重置查询</button> -->
    <button class="layui-btn layui-btn-normal" onclick="insertUserShow()"><i class="layui-icon">&#xe608;</i>添加版块
    </button>
   <%-- <b style="color: #FF5722;margin-left: 10px;">提示：</b>非系统管理员请勿随意更改、删除版块、否则会造成版块缺失--%>
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
    <%--<button class="layui-btn layui-btn-xs" lay-event="select"><i class="layui-icon">&#xe615;</i>查看</button>--%>
    <button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update"><i class="layui-icon">&#xe642;</i>编辑
    </button>
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除
    </button>
</script>
<%--锁定栏--%>
<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="{{d.name}}" value="{{d.id}}" title="锁定" lay-filter="lockDemo" {{ d.loginflag == 1 ? 'checked' : '' }}>
</script>

<script>

    //删除
    function deleteUser(data,obj){
        parent.layer.confirm('确定删除ID为' + data.sid + '吗 ?', {
            btn: ['确定', '取消'] //按钮
        }, function () {
            //console.log(data);
            $.ajax({
                type: 'post',
                url: '${ctx }sys/session/delete?id='+data.sid,
                dataType: 'json',
                success: function (result) {
                    console.log(result);
                    if(result.status==1){
                        parent.layer.msg('删除成功', {icon: 1});
                        location.reload();
                    }else{
                        parent.layer.msg('操作失败', {icon: 5});}

                },
                error: function (msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });
        }, function () {});
    }

    //添加窗口
    function insertUserShow() {
        cen_showWin({
            width: '860px',
            height: '750px',
            type: 2,
            title: '添加版块',
            url: '${ctx}web/user/session/insert.jsp'
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

    //获取用户列表 (条件查询)
    var sname = '',sprofile = '';
    function getUserData(pageNum) {
        sname = $("#sname").val();
        sprofile = $("#sprofile").val();
        console.log('${ctx }sys/session/selectList?pageNum='+pageNum+'&name='+sname+'&type='+sprofile);
        $.ajax({
            type: 'get',
            url: '${ctx }sys/session/selectList?pageNum='+pageNum+'&name='+sname+'&type='+sprofile,
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
            var newTime = new Date(tableData[i].createdate);
            tableData[i].createdate = newTime.toLocaleString().substring(0, newTime.toLocaleString().indexOf(" "));
        }

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
                    {field: 'sid', title: 'ID', width: 80, align: 'center', fixed: 'left'}
                    , {field: 'sname', title: '版块名称', align: 'center', width: 250}
                    , {field: 'sprofile', title: '主题', align: 'center'}
                    , {field: 'smaster', title: '版主', align: 'center', width:300}
                    , {fixed: 'right', title: '操作', width: 230, align: 'center', toolbar: '#barDemo'}

                ]],

            });

            //监听工具条
            table.on('tool(testTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                console.log(data);
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'update') {   //编辑
                    cen_showWin({
                        width: '660px',
                        height: '450px',
                        type: 2,
                        title: '编辑板块',
                        url: '${ctx}sys/session/update?id='+data.sid
                    });
                }else if (layEvent === 'select') {   //查看
                    cen_showWin({
                        width: '660px',
                        height: '470px',
                        type: 2,
                        title: '查看板块',
                        url: '${ctx}sys/session/select.jsp?id='+data.sid
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