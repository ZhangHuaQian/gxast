<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <link rel="stylesheet" href="${ctxRes}css/global.css">
    <title>我的消息</title>
    <style>
        /*为添加的空div设置的样式*/
        .clearDiv {
            clear: both;
        }
        .white{
            color: #FFFFFF;
        }
        .label_title{
            display: inline;
            float: left;
            border-right: #2377cd 1px solid;
            padding: 10px 25px;
        }
        .lm_label{
            display: inline;
            float: left;

            padding: 10px 25px;
        }
        .lm_label_select{
            display: inline;
            float: left;
            background-color: #2377cd;
            padding: 10px 25px;
        }
        .div0_col0{
            width: 60%;
            float: left;
        }
        .div0_col1{
            width: 40%;
        }
        #index_main_div0_row0{
            height: 57%;
        }
        #index_main_div0_row1{
            height: 43%;
        }


        .news_list{
            font-size: 16px;
            display: table-cell;
            vertical-align: middle;
            width: 100%;
        }
        .news_list_time{
            color: #ababab;
            float: right;
            margin-right: 15px;

        }
        #newslists>ul{
            width: 100%;
            padding-top: 10px;
            padding-bottom: 10px;
            color: #696969;
            display: table;
            width: 100%;
            height: 40px;
        }
        #newslists>ul:nth-child(odd){
            background-color: #f2f7fb;
        }
        #newslists>ul:nth-child(even){
            background-color: #ffffff;
        }

        .header {
            height: 60px;
            line-height: 60px;
            text-align: center;
        }
        .header .line {
            display: inline-block;
            width: 105px;
            border-top: 1px solid #efefef ;
        }
        .header .txt {
            color: #333333;
            font-size: 19px;
            vertical-align: -4px;
            margin-left: 10px;
            margin-right: 10px;
        }
        .triangle-tip-up{
            width: 200px;
            height: 30px;
            background:#ffffff;
            border-radius: 4px;
            position: relative;
        }
        .triangle-tip-up:before{
            content:'';
            width: 0;
            height: 0;
            border-width: 0 10px 10px;
            border-style: solid;
            border-color: transparent transparent #ffffff;
            position: absolute;
            left: 450px;
            top: -10px;
        }
        .layui-progress-big, .layui-progress-big .layui-progress-bar {
            height: 13px;
            line-height: 13px;
        }
        .jie-row li .red-edit{
            margin-left: 15px;
            padding: 0 6px;
            background-color: #ff5722;
            color: #fff;
            font-size: 12px;
        }
        .jie-row li .yellow-edit{
            margin-left: 15px;
            padding: 0 6px;
            background-color: #ffb800;
            color: #fff;
            font-size: 12px;
        }
        .jie-row li .green-edit{
            margin-left: 15px;
            padding: 0 6px;
            background-color: #01aaed;
            color: #fff;
            font-size: 12px;
        }
    </style>
</head>
<body style="background-color: #ffffff">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <%@ include file="/web/include/ucenter-head.jsp"%>
    <div id="newslistdiv" class="triangle-tip-up" style="width:70%;min-width:1302px;margin: 0px auto;height:auto;min-height:700px;background-color: #FFFFFF">
        <%@ include file="/web/include/ucenter-left-menu.jsp"%>
        <div style="width:80%;margin-top:15px;height:600px;float: right;border: 1px solid #E8E8E8">
            <div class="fly-panel fly-panel-user" pad20="">

                <%--<div class="fly-msg" style="margin-top: 15px;">
                  您的邮箱尚未验证，这比较影响您的账号安全，<a href="activate.html">立即去激活？</a>
                </div>--%>
                <div class="layui-tab layui-tab-brief" lay-filter="user">
                    <ul class="layui-tab-title" id="LAY_mine">
                        <li data-type="mine-jie" lay-id="index" class="layui-this">消息列表</li>
                    </ul>
                    <div class="layui-tab-content" style="padding: 20px 0;">
                        <div class="layui-tab-item layui-show">
                            <ul id="tiezi" class="mine-view jie-row">
                            </ul>
                            <div id="demo7" ></div>
                            <div id="LAY_page"></div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="clearDiv"></div>
    </div>
    <div class="clearDiv"></div>
</div>
<%@ include file="/web/include/footer.jsp"%>
</body>
<script>
    //注意进度条依赖 element 模块，否则无法进行正常渲染和功能性操作
    layui.use('element', function(){
        var element = layui.element;
    });
    var userid = '${sessionScope.USER_SESSION_NAME.id}';
    function selectmytopic(pageNum) {
        $.ajax({
            type: 'POST',
            url: '${ctx }web/selectmyMessage?pageNum='+pageNum,
            dataType: 'json',
            success: function (result) {
                var list=result.list;
                console.log(list);
                var str = "";
                if(result.list.length>0){

                    for (var i = 0; i < result.list.length; i++) {
                        if(result.list[i].statue=="1"){
                            result.list[i].statue="已读";
                        }else if(result.list[i].statue=="0"){
                            result.list[i].statue="未读";
                        }
                        list[i].message=htmlspecialchars_decode(list[i].message);
                        list[i].postDate=new Date(list[i].postDate).format("yyyy-MM-dd hh:mm:ss");
                        str += '<li> <a href="${ctx}web/user/message_details.jsp?id='+list[i].id+'" class="jie-title" ' +
                            ' target="_blank">' + list[i].message + '</a>' +
                            '<a id="read" style="float: right;" class="'+(list[i].statue=="已读"?"mine-edit":"red-edit")+'" >'+list[i].statue+'</a><a style="float: right;" class="red-edit" href="javascript:void(0)" onclick="deleteTie('+list[i].id+')">删除</a> ' +
                            '<i style="float: right;">' + list[i].postDate + '</i>'+
                            '</li>';

                    }


                    $("#tiezi").append(str);
                    initPage(result.count);
                }else {
                    initPage(0);
                }

            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }
    $(function () {
        selectmytopic(1);

    });

    function htmlspecialchars_decode(str) {
        str = str.replace(/&lt;/g, '<');
        str = str.replace(/&gt;/g, '>');
        str = str.replace(/&#40;/g, "(");
        str = str.replace(/&#41;/g, ")");
        str = str.replace(/&#39;/g, "\'");
        return str;
    }

    //删除用户
    function deleteTie(id) {
        parent.layer.confirm('确定删除吗 ?', {
            btn : [ '确定', '取消' ]
            //按钮
        }, function() {
            $.ajax({
                type : 'post',
                url : '${ctx}sys/Message/delete?id=' + id,
                dataType : 'json',
                success : function(result) {
                    console.log(result);
                    if (result.status == 1) {
                        parent.layer.msg('删除成功', {
                            icon : 1
                        });
                        window.location.reload(true);
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




    //初始化分页栏
    var pageCurr=1;
    function initPage(pageData) {
        console.log(pageData);
        layui.use([ 'laypage', 'layer' ], function() {
            var laypage = layui.laypage, layer = layui.layer;
            laypage.render({
                elem : 'demo7',
                curr :pageCurr,
                count :pageData,
                theme: '#1E9FFF',
                layout : [ 'count', 'prev', 'page', 'next', 'refresh',
                    'skip' ],
                jump : function(obj, first) {
                    if (!first) {//首次不执行
                        $("#tiezi").empty();
                        selectmytopic(obj.curr);
                        pageCurr = obj.curr;
                        console.log( obj.curr);

                    }
                }
            });
        });
    }


</script>
</html>
