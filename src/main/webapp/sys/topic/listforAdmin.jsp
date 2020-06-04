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
    <title>置顶帖子列表</title>
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
        <input type="text" value="" placeholder="帖子标题" id="sname" autocomplete="off"
               class="layui-input">
    </div>
    <div class="layui-input-inline">
        <input type="text" value="" placeholder="帖子内容" id="sprofile" autocomplete="off"
               class="layui-input">
    </div>
    <button type="reset" class="layui-btn" onclick="selectByObjecy()"><i class="layui-icon">&#xe615;</i>查找</button>

    <!-- <button type="reset" class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe63f;</i>重置查询</button> -->
   <%-- <button class="layui-btn layui-btn-normal" onclick="insertUserShow()"><i class="layui-icon">&#xe608;</i>添加版块
    </button>--%>
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
    {{#  if(d.isTop == 1){ }}
    <button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="notTop"><i class="layui-icon">&#x1007;</i>取消置顶</button>
    {{#  } }}
    {{#  if(d.isTop != 1){ }}
    <button class="layui-btn layui-btn-xs" lay-event="isTop"><i class="layui-icon">&#x1005;</i>设置置顶</button>
    {{#  } }}
    <button class="layui-btn  layui-btn-warm layui-btn-xs" lay-event="updateStatus"><i class="layui-icon">&#xe642;</i>审核</button>
    <%--<button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="report"><i class="layui-icon"></i> 举报帖子--%>
    <button class="layui-btn layui-btn-xs" lay-event="select"><i class="layui-icon">&#xe615;</i>查看</button>
    <%--<button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update"><i class="layui-icon">&#xe642;</i>编辑
    </button>--%>
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i> 删除
    </button>
</script>
<script id="status" type="text/html">
    {{#if(d.status==1){}}
    <span style="color:orange">未审核</span>
    {{# }else if(d.status==0){ }}
    <span style="color:green">通过</span>
    {{# }else if(d.status==2){ }}
    <span style="color:red">不通过</span>
    {{#}}}
</script>
<%--锁定栏--%>
<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="{{d.name}}" value="{{d.id}}" title="锁定" lay-filter="lockDemo" {{ d.loginflag == 1 ? 'checked' : '' }}>
</script>

<script>

    /*审核帖子*/
    function updateStatus(data,obj) {
        $.ajax({
            type : 'post',
            url : '${ctx}topic/updateStatus?id='+data.tid,
            dataType : 'json',
            success : function(result) {
                console.log(result);
                if (result.status == 1) {
                    layer.msg("操作完成");
                    setTimeout(function (){
                        window.parent.frames["置顶帖子"].location.reload();//刷新父借口
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
    /*删除帖子*/
    function deleteUser(data,obj){
        parent.layer.confirm('确定删除 ' + data.title + ' 吗 ?', {
            btn: ['确定', '取消'] //按钮
        }, function () {
            console.log(data);
            //alert(data.tid);
            $.ajax({
                type: 'post',
                url: '${ctx }topic/delete?id='+data.tid,
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

    function notTop(data,obj) {
        parent.layer.confirm('确定取消文章置顶吗 ?', {
            btn : [ '确定', '取消' ]
            //按钮
        }, function() {
            console.log(data);
            /*alert(data.tid);*/
            $.ajax({
                type : 'post',
                url : '${ctx }topic/notTop?id='+ data.tid,
                dataType : 'json',
                success : function(result) {
                    if (result.status == 1) {
                        parent.layer.msg('取消置顶成功', {icon : 1});
                        window.location.reload(true);
                    } else if(result.status == 2) {
                        parent.layer.msg('帖子未审核,不能取消置顶', {icon : 5 });
                        window.location.reload(true);
                    }
                },
                error : function(msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });
        }, function() {
        });
    };
    function isTop(data,obj) {
        //alert(countoflimit);
        if(countoflimit>=5){
            parent.layer.alert("最大置顶数为 5 请删减后再进行操作");
            //alert(countoflimit);
        }else {
        parent.layer.confirm('确定将文章置顶吗 ?', {
            btn : [ '确定', '取消' ]
            //按钮
        }, function() {
            //console.log(data);
            $.ajax({
                type : 'post',
                url : '${ctx }topic/isTop?id=' + data.tid,
                dataType : 'json',
                success : function(result) {
                    if (result.status == 1) {
                        parent.layer.msg('置顶成功', {icon : 1});
                        window.location.reload(true);
                    } else if(result.status == 2){
                        parent.layer.msg('帖子未审核,不能置顶', {icon : 1});
                        window.location.reload(true);
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
    };


    //添加用户窗口
    function insertUserShow() {
        cen_showWin({
            width: '660px',
            height: '450px',
            type: 2,
            title: '添加数据字典',
            url: '${ctx}web/session/insert.jsp'
        });
    }

    $(function () {
        getUserData(1);
    });

    ///初始化查询
    function selectByObjecy() {
        sname=$('#sname').val();
        sprofile=$('#sprofile').val();
        getUserData(1);
        pageCurr = 1;
    }

    //获取用户列表 (条件查询)

    var countoflimit="";
    var sprofile="";
    var sname="";
    var userid = '${sessionScope.USER_SESSION_NAME.id}';
    function getUserData(pageNum) {
        $.ajax({
            type: 'Post',
            url: '${ctx }topic/selectAlltopicForCheck?pageNum='+pageNum+'&sname='+sname+'&sprofile='+sprofile,
            dataType: 'json',
            success: function (result) {
                console.log(result);
                if(result.count > 0){
                    countoflimit=result.countoflimit;
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
            tableData[i].content=htmlspecialchars_decode(tableData[i].content);
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
                    {field: 'tid', title: 'ID', width: 80, align: 'center', fixed: 'left'}
                    , {field: 'sSessionName', title: '所属板块', align: 'center', width: 100}
                    , {field: 'title', title: '标题', align: 'center', width: 350}
                   , {field: 'content', title: '内容', align: 'center'}
                    , {field: 'status', title: '审核状态', align: 'center',width:100,templet: '#status'}
                   /* , {field: 'smasterid', title: '版主', align: 'center', width:100}*/
                    /*,{field: 'code', title: '字典码', align:'center',width: 80}
                     , {field: 'orderNo', title: '排序', align: 'center', width: 80}
                     , {field: 'remark', title: '备注', align: 'center'}*/
                    , {fixed: 'right', title: '操作', align: 'center', width: 350, toolbar: '#barDemo'}

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
                        title: '编辑字典',
                        url: '${ctx}sys/session/verify.jsp?id='+data.id
                    });
                }else if (layEvent === 'select') {   //查看
                    window.open('${ctx}topic/details?id='+data.tid);
                } else if (layEvent === 'delete') {   //删除
                    deleteUser(data,obj);
                }else if (layEvent === 'isTop') {   //置顶
                    isTop(data,obj);
                }else if (layEvent === 'notTop') {   //取消置顶
                    notTop(data,obj);
                }else if(layEvent==='updateStatus'){//审核
                    // updateStatus(data,obj);

                   cen_showWin({
                        width : '350px',
                        height : '300px',
                        type : 2,
                        title : '审核',
                        url : '${ctx}sys/topic/verify.jsp?tid='+data.tid+'&status='+data.status,
                    });
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
    function htmlspecialchars_decode(str) {
        str = str.replace(/&lt;/g, '<');
        str = str.replace(/&gt;/g, '>');
        str = str.replace(/&#40;/g, "(");
        str = str.replace(/&#41;/g, ")");
        str = str.replace(/&#39;/g, "\'");
        return str;
    }
</script>

</body>
</html>