<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>欢迎页</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
        <%@ include file="/commViews/head.jsp"%>
        <link rel="stylesheet" href="../resource/css/font.css">
		<link rel="stylesheet" href="../resource/css/xadmin.css">
    </head>
    <style>
        #clock{
            line-height: 60px;
            margin:0px auto;
            width: 500px;
            height: 60px;
            font-size: 18px;
            text-align: center;
        }
        #welcome{
            font-size: 18px;
            padding: 0px 20px;
        }
    </style>
    <script>
        /*当前时间*/
        var element
        $(function () {
            comment_ajax();
            report_ajax();
            selectListStatus();
            setInterval(function () {
                //comment_ajax();
                //report_ajax();
            },20000);
            setInterval(function () {
                $("#clock").html(formatDate_YMD_HMS(new Date()))
            },1000);



            layui.use(['form','element'], function() {
                    element = layui.element;

                    element.on('tab(xbs_tab)', function(data){
                        //console.log(this); //当前Tab标题所在的原始DOM元素
                        //console.log(data.index); //得到当前Tab的所在下标
                        //console.log(data.elem); //得到当前的Tab大容器
                    });
            });

        })

        function addTag(id,title,url) {
            parent.element.tabAdd('xbs_tab', {
                title: title
                ,content: '<iframe name="'+title+'" tab-id="'+id+'" frameborder="0" src="'+url+'" scrolling="yes" class="x-iframe"></iframe>'
                ,id: id
            })
            parent.element.tabChange('xbs_tab', id);
        }

        /*查询待举报的数量*/
        function report_ajax(){
            $.ajax({
                type : 'get',
                url : '${ctx}report/selectReportCount',
                dataType : 'json',
                success : function(data) {
                    $("#thisReportText").html(data.count)
                },
                error : function(msg) {
                    console.log(msg);

                }
            });
        };
        //根据状态查询待处理订单
        function selectListStatus(){                            
            $.ajax({                     
                type : 'get',
                url : '${ctx}sys/order/selectListStatus?status='+1,
                dataType : 'json',                    
                success : function(data) {                                        
                    $("#order").html(data.count);
                },
                error : function(msg) {
                    console.log(msg);

                }
            });
        };
        //查询待审核的评论数
        function comment_ajax(){
            $.ajax({
                type : 'post',
                url : '${ctx}sys/news_comment/comment_two',
                dataType : 'json',
                success : function(data) {
                    console.log(data);
                    $("#thisCommentText").html(data.count)
                },
                error : function(msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });
        };
    </script>
    <body>
    <div class="x-body layui-anim layui-anim-up">
        <blockquote class="layui-elem-quote" id="welcome">欢迎用户：
            <span class="x-red">${sessionScope.USER_SESSION_NAME.name}</span>  当前时间：<span id="clock"></span></blockquote>
        <fieldset class="layui-elem-field">
            <legend>数据统计</legend>
            <div class="layui-field-box">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-body">
                            <div class="layui-carousel x-admin-carousel x-admin-backlog" lay-anim="" lay-indicator="inside" lay-arrow="none" style="width: 100%; height: 90px;">
                                <div carousel-item="">
                                    <ul class="layui-row layui-col-space10 layui-this">
                                        <li class="layui-col-xs2">
                                            <a onclick="addTag(97,'待处理举报','${ctx}sys/topic/undoreportList.jsp')" class="x-admin-backlog-body">
                                                <h3>待处理举报</h3>
                                                <p><cite id="thisReportText"></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs2">
                                            <a onclick="addTag(98,'待审核评论','${ctx}sys/news_comment/todolist.jsp')" class="x-admin-backlog-body">
                                                <h3>待审核评论</h3>
                                                <p><cite id="thisCommentText"></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs2">
                                            <a onclick="addTag(99,'待处理订单','${ctx}sys/order/list.jsp')" class="x-admin-backlog-body">
                                                <h3>待处理订单</h3>
                                                <p><cite id="order" style="color: red">0</cite></p>
                                            </a>
                                        </li>
                                        <%--<li class="layui-col-xs2">
                                            <a href="javascript:;" class="x-admin-backlog-body">
                                                <h3>用户数</h3>
                                                <p><cite>0</cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs2">
                                            <a href="javascript:;" class="x-admin-backlog-body">
                                                <h3>发布数</h3>
                                                <p><cite>0</cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs2">
                                            <a href="javascript:;" class="x-admin-backlog-body">
                                                <h3>失败数</h3>
                                                <p><cite style="color: red">0</cite></p>
                                            </a>
                                        </li>--%>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
        <%--<fieldset class="layui-elem-field">
            <legend>系统通知</legend>
            <div class="layui-field-box">
                <table class="layui-table" lay-skin="line">
                    <tbody>
                        <tr>
                            <td >
                                <a class="x-a" href="">新版 《CFrameWord V1.1》 上线了</a>
                            </td>
                        </tr>
                        <tr>
                            <td >
                                <a class="x-a" href="">交流群:(88888888)</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>--%>
        <fieldset class="layui-elem-field">
            <legend>系统信息</legend>
            <div class="layui-field-box">
                <table class="layui-table">
                    <tbody>
                        <tr>
                            <th>系统版本</th>
                            <td>${properties["os.version"]}</td>
                        </tr>
                        <tr>
                            <th>服务器地址</th>
                            <%--<td><%=InetAddress.getLocalHost().getHostAddress() %></td>--%>
                            <td> 10.158.85.56</td>
                        </tr>
                        <tr>
                            <th>操作系统</th>
                            <td>${properties["os.name"]}</td></tr>
                        <tr>
                            <th>运行环境</th>
                            <td><%=application.getServerInfo() %></td></tr>
                        <tr>
                            <th>JAVA版本</th>
                            <td>${properties['java.runtime.version']}</td></tr>
                        <tr>
                            <th>MYSQL版本</th>
                            <td>5.5.38</td></tr>
                        <tr>
                            <th>Spring</th>
                            <td>4.2.0</td></tr>
                        <tr>
                            <th>上传附件限制</th>
                            <td>20M</td></tr>
                        <tr>
                            <th>执行时间限制</th>
                            <td>30s</td></tr>
                        <tr>
                            <th>剩余空间</th>
                            <td><%=Runtime.getRuntime().freeMemory() %></td></tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
        <fieldset class="layui-elem-field">
            <legend>开发团队</legend>
            <div class="layui-field-box">
                <table class="layui-table">
                    <tbody>
                        <tr>
                            <th>版权所有</th>
                            <td>CFrameWord V1.1</td>
                        </tr>
                         <tr>
                            <th>开发团队</th>
                            <td>CFrameWord</td>
                         </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
    </div>
    </body>
</html>