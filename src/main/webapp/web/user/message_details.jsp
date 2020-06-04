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

        #details table tr{
            border-bottom: 1px solid #CCCCCC;
            height: auto;
        }
        #details table tr td{
            padding: 10px;
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

                <div class="layui-tab layui-tab-brief" lay-filter="user">
                    <ul class="layui-tab-title" id="LAY_mine">
                        <li data-type="mine-jie" lay-id="index" class="layui-this">消息详情</li>
                    </ul>
                </div>

                    <div style="margin: 25px" id="details">

                    </div>
                </div>
                  <%-- <ul class="layui-tab-title" >
                        <li style="width: 300px">消息主题</li>
                   </ul>
                    <ul class="layui-tab-title" ><li style="width: 300px">内容</li></ul>
                    <ul class="layui-tab-title" ><li style="width: 300px">发布时间</li></ul>--%>
                    <%--<table>
                        <tr>
                            <td>消息主题</td>
                        </tr>
                        <tr>
                            <td>内容</td>
                        </tr>
                        <tr>
                            <td>发送时间</td>
                        </tr>
                    </table>--%>
                    <%--<ul class="layui-tab-title" id="details">
                    </ul>--%>






    </div>

</div>
<%@ include file="/web/include/footer.jsp"%>
</body>
<script>


   function selectMessageDetails() {
        $.ajax({
            type: 'POST',
            url: '${ctx}web/message/select?id=${param.id}',
            dataType: 'json',
            success:function (data) {
                console.log(data);
                var str="";
                data.data.postdate=new Date(data.data.postdate).format("yyyy-MM-dd hh:mm:ss");
                data.data.message=htmlspecialchars_decode(data.data.message);
                str=' <table style="color: #6A6A6A;" border="0">\n' +
                    '                            <tr style="height: auto">\n' +
                    '                                <td style="text-align: right;">消息主题：</td>\n' +
                    '                                <td >'+data.data.title+'</td>\n' +
                    '                            </tr>\n' +
                    '                            <tr style="height: auto">\n' +
                    '                                <td style="text-align: right;">消息内容：</td>\n' +
                    '                                <td >'+data.data.message+'</td>\n' +
                    '                            </tr>\n' +
                    '\n' +
                    '                            <tr  style="cursor: pointer;height: auto">\n' +
                    '                                <td style="text-align: right;">发布时间：</td>\n' +
                    '                                <td >'+data.data.postdate+'</td>\n' +
                    '                            </tr>\n' +
                    '                        </table>';


                $("#details").html(str);
            }
        })
   }

   $(function () {
       selectMessageDetails();
   });
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
