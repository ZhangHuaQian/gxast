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
   /* function  closeWindow() {
        window.parent.frames[""].location.reload() ;// 刷新父窗口
            setTimeout(function (){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
            //layer.closeAll(); //疯狂模式，关闭所有层
        },1000)
    }*/

    $(function () {
        //提交用户评论
        $("#subBut").click(function () {
            $.ajax({
                type : "post",
                url : '${ctx}web/news_axhd/news_reply?',
                data:{
                    type:'djgz',
                    id:'${param.comid}',
                    content:$("#comment").val()
                },
                dataType:'json',
                error : function(data) {
                    alert('网络异常');
                },
                success : function(data) {
                    if(data.status==1){
                        layer.alert("回复成功!",function () {
                            window.parent.location.reload();
                            parent.layer.close(index);
                        })
                    }

                }
            });
        })
    })




</script>
</body>
</html>