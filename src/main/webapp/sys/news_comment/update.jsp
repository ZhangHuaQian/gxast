<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改状态</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <%@ include file="/commViews/head.jsp" %>
    <style type="text/css">
        .content-a-upload {
            text-align: center;
            position: relative;
            /*padding:  4px 5px;*/
            float: left;
            height: 30px;
            width: 100px;
            line-height:35px;
            /*font: 400 16px/60px "宋体";*/
            /*cursor: pointer;*/
            color: #FFFFFF;
            background: #EF4F4F !important;
            /*border: 1px solid #ddd;*/
            border-radius: 2px;
            /*overflow: hidden;*/
            display: inline-block;
            /*text-decoration: none;*/
        }
        .content-a-upload input {
            position: absolute;
            /*font-size: 16px;*/
            /*height: 77px;*/
            float: left;
            right: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
        }
        .content-a-upload:hover {
            color: #FFFFFF;
            background: #EF4F4F !important;
            border-color: #ccc;
            text-decoration: none
        }
    </style>
</head>
<body>

<form class="layui-form layui-form-pane" id="main_form" style="" >

    <div style="float: left;padding: 10px;">
        <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-inline">
               <select name="commentstate" id="t1" >
                  <%-- <option value="0">未审核</option>--%>
                   <option value="1">通过</option>
                   <option value="2">不通过</option>
               </select>
            </div>
        </div>
        <div class="layui-form-item" >
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-warm" lay-submit lay-filter="formDemo">提交</button>

            </div>
        </div>
    </div>

</form>


<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>

    //关闭当前弹出窗口
    function closeWindow() {
        setTimeout(function (){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
            //layer.closeAll(); //疯狂模式，关闭所有层
        },1000);
    }

    //渲染表单
    layui.use('form', function () {
        $("#t1").val(${param.commentstate});
        form = layui.form;
        form.render();
        //监听提交
        form.on('submit(formDemo)', function (data) {

            $.ajax({
                type: 'POST',
                url: "${ctx }sys/news_comment/updateStatus?id=${param.id}"+'&commentstate='+$("#t1").val(),

                dataType: 'json',
                success: function (result) {
                    closeWindow();
                    layer.msg("操作成功");
                    //window.parent.frames["评论列表"].location.reload();

                },
                error: function (msg) {
                    console.log(msg);
                    layer.msg("系统异常");
                }
            });
            return false;
        });
    });

</script>


</body>
</html>