<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <link rel="stylesheet" href="${ctxRes}css/global.css">
    <title>我评论过的资讯-广西科普传播中心</title>
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
            left: 380px;
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
        .jie-row li span{
            margin-left: 15px;
            margin-right: 0px;
            padding: 0 6px;
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
                        <li data-type="mine-jie" lay-id="index" class="layui-this">论坛 - 我的评论</li>
                        <%--<li data-type="collection" data-url="/collection/find/" lay-id="collection">我收藏的帖（<span>16</span>）</li>--%>
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
            type: 'get',
            url: '${ctx }myForumCommentList?&pageNum='+pageNum,
            /* data: $('#main_form').serialize(),*/
            dataType: 'json',
            success: function (result) {
                console.log(result);
                var list=result.data;
                var str = "";

                if(list.length>0){
                    for (var i = 0; i < list.length; i++) {
                        var colorClass;
                        if(list[i].verify==0){
                            list[i].verify="未审核";
                            colorClass = "layui-bg-orange";
                        }else if(list[i].verify==1){
                            list[i].verify="审核通过"
                            colorClass = "layui-bg-green";
                        }else if(list[i].verify==2){
                            list[i].verify="审核未通过"
                            colorClass = "layui-bg-red";
                        }

                        str += '<li> <a class="jie-title" href="${ctx}topic/details?id='+list[i].tid +'"'+
                            ' target="_blank">' + htmlspecialchars_decode(list[i].content) + '</a>'+
                            '<em><i>'+list[i].createTime + '</i>'+
                            '<span id="statusAddClass" class="'+colorClass+'">'+list[i].verify+'</span>' +
                            '<a class="red-edit" href="javascript:void(0)" onclick="deleteComment('+list[i].id+','+list[i].pid+')">删除</a></em></li>';
                    }

                    $("#tiezi").append(str);
                    initPage(result.count);

                }else {
                    layer.msg("您还没有任何评论");
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

    function deleteComment(id,pid) {
        parent.layer.confirm('确定删除吗 ?', {
            btn : [ '确定', '取消' ]
            //按钮
        }, function() {
            var url = '${ctx }deleteMyForumComment?id='+ id;
            if (pid > 0){
                url += "&pid="+pid;
            }
            $.ajax({
                type : 'post',
                url : url,
                dataType : 'json',
                success : function(result) {
                    if (result.status == 1) {
                        parent.layer.msg('删除成功', {icon : 1},function () {
                            window.location.reload(true);
                        });
                    } else {
                        parent.layer.msg('操作失败', {icon : 5 });
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

    function updateTie(id) {
        cen_showWin({
            width : '1200px',
            height : '700px',
            type : 2,
            title : '编辑帖子',
            url : '${ctx}web/user/bbs/ucenterupdate.jsp?id=' +id
        });
    };

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
                        /*getUserData(obj.curr);*/
                        /*window.location.href= '${ctx }web/bbs/xczx_index.jsp?pageNum=' + obj.curr,*/
                        $("#tiezi").empty();
                        selectmytopic(obj.curr);
                        pageCurr = obj.curr;
                        console.log( obj.curr);

                    }
                }
            });
        });
    }
    // 新建窗口
    function cen_showWin(param) {
        parent.layer.open({
            type : param.type,
            area : [ param.width, param.height ],
            title : param.title,
            closeBtn : 1,
            //shade: [0.1, '#FFFFFF'],
            shadeClose : true,
            skin : 'yourclass',
            resize : true,
            success : function(layero, index) {
                //console.log(layero, index);
            },
            content : param.url,
            cancel : function(index, layero) {
                if (confirm('当前修改内容尚未保存，确定要关闭吗？')) { //只有当点击confirm框的确定时，该层才会关闭
                    parent.layer.close(index);
                }
                return false;
            }
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
</html>
