<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <meta charset="utf-8">
    <title>回复</title>
    <meta name="renderer" content="webkit">



</head>
<body>
<div class="" id="div1">
    <!-- 内容主体区域 -->
    <div style="padding: 15px;">

        <%--<form class="layui-form-pane" id="main_form">--%>
            <div class="layui-form-item layui-form-text">
                <div class="" >
                    <textarea placeholder="请输入内容" class="layui-textarea" id="comment"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal" lay-filter="formDemo" id="subBut" >立即提交</button>
                </div>
            </div>
        <%--</form>--%>
    </div>
</div>


<script>

    $(function () {
        //提交用户回复
        $("#subBut").click(function () {

            $.ajax({
                    type : "post",
                    url : '${ctx}web/news_jtyy/news_reply?',
                    data:{
                        type:'jtyy',
                        id:'${param.comid}',
                        content:$("#comment").val()
                        },
                dataType:'json',
                    error : function(data) {
                    alert('网络异常');
                    //console.log(data);
                },
                success : function(data) {
                   console.log(data);
                   if(data.status==1){
                    layer.alert("回复成功!",function () {
                    window.parent.location.reload();
                    parent.layer.close(index);
                     })
                   }

                }
            })


        })
    })




</script>
</body>
</html>