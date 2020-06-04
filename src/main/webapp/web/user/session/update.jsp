<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑版块</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
   <%-- <%@ include file="/commViews/head.jsp" %>--%>
    <link rel="stylesheet" href="${ctx }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="shortcut icon" href="${ctx}favicon.ico" type="image/x-icon">
    <link type="text/css" rel="stylesheet" href="${ctx }resource/css/demo.css">
    <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/layui.css">
    <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/modules/code.css">
    <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/modules/laydate/default/laydate.css">
    <script src="${ctx }resource/js/jquery-1.11.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${ctx }resource/plugins/layui2/layui.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="${ctx }resource/plugins/layui2/lay/modules/layedit.js" type="text/javascript" charset="utf-8"></script>
    <script src="${ctxRes }js/cen.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}resource/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
    <script src="${ctx}resource/plugins/layui2/tableSelect.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>

<!-- 菜单添加 -->
<form class="layui-form layui-form-pane" id="main_form" style="">

    <div style="float: left;padding: 10px;">

        <div class="layui-form-item">
            <label class="layui-form-label">版块名称</label>
            <div class="layui-input-inline">
                <input type="text" name="sname" lay-verify="required" placeholder="版块名称" autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">版块类型</label>
            <div class="layui-form layui-input-inline">
                <select name="type" id="type" lay-search="">
                    <option value="0">普通版块</option>
                    <option value="1">vip版块</option>
                </select>
            </div>

        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">版主</label>
            <div class="layui-input-inline">
                <input lay-filter="testFilter" name="smaster" id="testFilter" lay-search="" class="layui-input" ts-selected="testFilter"></input>
            </div>
            <label class="layui-form-label">主题</label>
            <div class="layui-input-inline">
                <input type="text" name="sprofile" lay-verify="required" placeholder="版块主题" autocomplete="off"
                       class="layui-input">
            </div>

        </div>


        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-warm" lay-submit lay-filter="formDemo">保存版块</button>
                <!-- <button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
            </div>
        </div>
    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>
    //关闭当前弹出窗口
    function closeWindow() {
        window.parent.frames["论坛版块"].location.reload() ;// 刷新父窗口
        setTimeout(function (){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
        },1000)
    }
    //渲染表单
    var form;
    function renderForm() {
        layui.use('form', function () {
            form = layui.form;
            form.render();
            //监听提交
            form.on('submit(formDemo)', function (data) {
                console.log($('#main_form').serialize());
                $.ajax({
                    type: 'POST',
                    url: '${ctx }sys/session/update?id=${param.id}',
                    data: $('#main_form').serialize(),
                    dataType: 'json',
                    success: function (result) {
                        if(result.status==1){
                            console.log(result.status);
                            closeWindow();

                        }
                    },
                    error: function (msg) {
                        console.log(msg);
                        alert("系统异常");
                    }
                });
                return false;
            });
            var tableSelect = layui.tableSelect;
            tableSelect.render({
                elem: '#testFilter',	//定义输入框input对象
                checkedKey: 'testFilter', //表格的唯一建值，非常重要，影响到选中状态 必填
                searchKey: 'keyword',	//搜索输入框的name值 默认keyword
                searchPlaceholder: '关键词搜索',	//搜索输入框的提示文字 默认关键词搜索
                table: {	//定义表格参数，与LAYUI的TABLE模块一致，只是无需再定义表格elem
                    type:'get',
                    url:'${ctx }sys/ucenter/selectUserList',
                    page:true,
                    dataType: 'json',
                    cols: [[
                        {
                            type:'checkbox'
                        },
                        {
                            field : 'id',
                            title : 'ID',
                            width : 150,
                        }, {
                            field : 'name',
                            title : '姓名',
                            width : 200
                        }, {
                            field : 'loginflag',
                            title : '性别',
                            width : 80
                        }
                    ]]
                },
                done: function (elem, data) {
                    //选择完后的回调，包含2个返回值 elem:返回之前input对象；data:表格返回的选中的数据 []
                    //拿到data[]后 就按照业务需求做想做的事情啦~比如加个隐藏域放ID...
                    var NEWJSON = []
                    layui.each(data.data, function (index, item) {
                        NEWJSON.push(item.name);

                    })
                    elem.val(NEWJSON.join(","))
                }
            })
        });




    }

    //初始化版主下拉列表
    function initType(){
        $.ajax({
            type: 'get',
            url: '${ctx }sys/ucenter/selectUserList',
            dataType: 'json',
            async:false,
            success: function (result) {
                console.log(result);
                var list=result.list;
                var data="<option value=''>选择用户</option>";
                for(var i=0;i<list.length;i++){
                    data+="<option value="+list[i].id+">"+list[i].name+"</option>";
                }
                $("#type").append(data);
            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }
    //初始化
    function initContent(){
        $.ajax({
            type:'get',
            url: '${ctx }sys/session/select?id=${param.id}',
            dataType: 'json',
            async:false,
            success: function (result) {
                console.log(result);
                var session=result.session;
                $("input[name='sname']").val(session.sname);
                $("input[name='sprofile']").val(session.sprofile);
                $("input[name='smaster']").val(session.smaster);
                $("#type").val(session.type);

            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }

    $(function () {
        initContent();
        renderForm();
    });

</script>

</body>
</html>