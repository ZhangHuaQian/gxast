<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>手机用户列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <%@ include file="/commViews/head.jsp" %>
</head>
<body>
    <blockquote class="layui-elem-quote" style="padding:10px;margin-bottom:0px;">
        <div class="layui-input-inline">
            <input type="text" value="" placeholder="名称" id="userName" autocomplete="off"
                   class="layui-input">
        </div>
        <div class="layui-input-inline">
            <input type="text" value="" placeholder="账号" id="loginName" autocomplete="off"
                   class="layui-input">
        </div>

        <button type="reset" class="layui-btn" onclick="getUserData(1)"><i class="layui-icon">&#xe615;</i>查找</button>
        <a class="layui-btn layui-btn-small" style="margin-right:5px;float:right"
           href="javascript:location.replace(location.href);" title="刷新">刷新</a>
    </blockquote>
    </div>

<!-- 表格 -->
<table id="demo" lay-filter="testTable"></table>
<!-- 分页栏 -->
<div id="demo7" style="text-align: left;"></div>
    <%-- 用户类型 --%>
    <script type="text/html" id="isVip">
        {{# if(d.isVip ==1){ }}
        <label style="color: orange">vip用户</label>
        {{# }else if(d.isVip ==0){ }}
        <label >普通用户</label>
        {{# } }}
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

    //删除用户
    function deleteUser(data,obj){
        parent.layer.confirm('确定删除' + data.name + '吗 ?', {
            btn: ['确定', '取消'] //按钮
        }, function () {
            //console.log(data);
            $.ajax({
                type: 'post',
                url: '${ctx }sys/ucenter/update?id='+data.id+'&isDel=1',
                dataType: 'json',
                success: function (result) {
                    //console.log(result);
                    if(result.status==1){
                        obj.del();
                        parent.layer.msg('删除成功', {icon: 1});
                        window.location.reload();
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
            width: '660px',
            height: '450px',
            type: 2,
            title: '添加用户',
            url: '${ctx}sys/ucenter/user/insert.jsp'
        });
    }

    $(function () {
        getUserData(1);
    });

    //获取用户列表 (条件查询)
    var loginName = '',userName = '';
    function getUserData(pageNum) {
        loginName = $("#loginName").val();
        userName = $("#userName").val();
        <%--console.log('${ctx }sys/ucenter/selectListPhoneUser?pageNum='+pageNum+'&loginname='+loginName+'&name='+userName);--%>
        $.ajax({
            type: 'get',
            url: '${ctx }sys/ucenter/selectListPhoneUser?&pageNum='+pageNum+'&loginname='+loginName+'&name='+userName,
            dataType: 'json',
            success: function (result) {
                console.log(result);
                if(result.count > 0){
                initTable(result.list);
                initPage(result);
                }else{
                	initTable([]);
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
            tableData[i].createdate = formatDate_YMD_HMS(tableData[i].createdate);
        }

        layui.use('table', function () {
            var table = layui.table,form = layui.form;
            table.render({
                elem: '#demo'
                , data: tableData
                , page: false //关闭分页
                , loading: true
                , cols: [[ //表头
                    {field: 'id', title: 'ID', width: 80, align: 'center', fixed: 'left'}
                    , {field: 'name', title: '名称', align: 'center', width: 150}
                    , {field: 'loginname', title: '账号', align: 'center', width: 250}
                    , {field: 'phonenum', title: '手机', align: 'center'}
                    , {field: 'isVip', title: '用户类型', align: 'center',templet:'#isVip'}
                    , {field: 'createdate', title: '创建时间', align: 'center', sort: true}
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
                        width: '660px',
                        height: '450px',
                        type: 2,
                        title: '编辑用户',
                        url: '${ctx}sys/ucenter/user/update-phone.jsp?id='+data.id
                    });
                }else if (layEvent === 'select') {   //查看
                    cen_showWin({
                        width: '660px',
                        height: '470px',
                        type: 2,
                        title: '查看用户',
                        url: '${ctx}sys/ucenter/user/select-phone.jsp?id='+data.id
                    });
                } else if (layEvent === 'delete') {   //删除
                    deleteUser(data,obj);
                }
            });

            //监听锁定操作
            form.on('checkbox(lockDemo)', function(obj){
                //layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
                var loginflag = obj.elem.checked?1:0;
                $.ajax({
                    type: 'post',
                    url: '${ctx }sys/ucenter/update?id=' +this.value+'&loginflag='+loginflag,
                    data: $('#main_form').serialize(),
                    dataType: 'json',
                    success: function (result) {
                        if(result.status!=1){
                            layer.msg(result.msg, {icon: 5});
                        }
                    },
                    error: function (msg) {
                        console.log(msg);
                        alert("系统异常");
                    }
                });
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
            shadeClose: true,
            skin: 'yourclass',
            resize: true,
            success: function (layero, index) {
                //console.log(layero, index);
            },
            end:function(){
                getUserData(pageCurr);
            },
            content: param.url
        });
    }

</script>

</body>
</html>