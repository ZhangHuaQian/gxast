<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>广西青少年科普知识竞赛</title>
</head>
<style>
    body{
        margin: 0px;
        background: url('${ctx}resource/images/answer/pc/PCbeij.png');
        background-size:100% 100%;
        position:fixed;
        top: 0;
        left: 0;
        width:100%;
        height:100%;
        min-width: 1000px;
        z-index:-10;
        zoom: 1;
        background-color: #fff;
        background-repeat: no-repeat;
        background-size: cover;
        -webkit-background-size: cover;
        -o-background-size: cover;
        background-position: center 0;
    }
    .body{
        background-color: rgba(76, 150, 234, 0.6);
        margin: auto;
        margin-top: 16%;
        border-radius: 5px;
        height: 47%;
        width: 50%;
        border: 1px solid #58C8F7;
    }
    .footer{
        background-color: rgba(76, 150, 234, 0.6);
        margin: auto;
        margin-top: 1%;
        border-radius: 5px;
        height: 15%;
        width: 50%;
        border: 1px solid #58C8F7;
    }
    form{
        margin-left: 2%;
        padding: 5%;
        padding-top: 3.5%;
        width: 70%;
    }
    .layui-form-label{
        color: white;
    }
    .layui-input{
        border-radius: 5px;
    }
    .layui-form-item {
        margin-bottom: 20px;
    }
    .content{
        padding: 2.3% 2%;
    }
    .layui-row{
        margin: 10px 0px;
        color: #FFFFFF;
    }
</style>
<body>
    <div class="body">
        <form class="layui-form" lay-filter="form">
            <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="sName" lay-verify="required|sName" lay-reqtext="姓名不能为空" autocomplete="off" placeholder="必填，请输入内容" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">学校名称</label>
                <div class="layui-input-block">
                    <input type="text" name="school" lay-verify="required|school" lay-reqtext="学校名称不能为空" autocomplete="off" placeholder="必填，请输入内容" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">班级/年级</label>
                <div class="layui-input-block">
                    <input type="text" name="sClass" lay-verify="required|sClass" lay-reqtext="班级/年级不能为空" autocomplete="off" placeholder="必填，请输入内容" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">指导老师</label>
                <div class="layui-input-block">
                    <input type="text" name="tName" lay-verify="required|tName" lay-reqtext="指导老师不能为空" autocomplete="off" placeholder="必填，请输入内容" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">手机号码</label>
                <div class="layui-input-block">
                    <input type="number" name="tTel" lay-verify="required|tTel" lay-reqtext="手机号码不能为空" autocomplete="off" placeholder="必填，请输入内容" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">联系地址</label>
                <div class="layui-input-block">
                    <input type="text" name="address" lay-verify="required|address" lay-reqtext="联系地址不能为空" autocomplete="off" placeholder="必填，请输入内容" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" style="background-color: #FEDD26;color: #CF7C1F;width: 200px;height: 40px" class="layui-btn" lay-submit="" lay-filter="submit">我要答题</button>
                </div>
            </div>
        </form>
    </div>
    <div class="footer">
        <div class="content">
            <div class="layui-row">
                <p>主办单位：广西科学技术协会</p>
            </div>
            <div class="layui-row">
                <p>承办单位：广西科学技术普及传播中心</p>
            </div>
            <div class="layui-row">
                <p>活动时间：2019年11月15日-12月15日 </p>
            </div>
        </div>
    </div>
</body>
</html>
<script>
    $(function () {
        if(IsPC()){

        }
        else{
            //这里执行的是移动端的代码；
            window.location.href="${ctx}web/answer/app/personal.jsp"
            return
        }
    })
    layui.use(['form'], function(){
        var form = layui.form
        var layer = layui.layer

        form.verify({
            tTel: function(value){
                if(value.toString().length<11){
                    return '手机号码格式错误！';
                }
            }
        });

        form.on('submit(submit)', function(data){
            $.ajax({
                type: "POST",
                url: "${ctx}appsite/itemBank/selectUserInfo",
                data: $('form').serialize(),
                dataType: "json",
                success: function(data) {
                    switch (data.status) {
                        case 0:
                            window.location.href = 'question.jsp?uid='+ data.uId
                        case 1:
                            layer.msg(data.msg);
                        case 2:
                            layer.msg(data.msg);
                    }
                },
                error: function(msg) {
                    console.log(msg)
                    layer.msg("网络连接错误，请检查网络后重试");
                },
            });
            return false;
        });
    })

    function IsPC() {
        var userAgentInfo = navigator.userAgent;
        var Agents = ["Android", "iPhone",
            "SymbianOS", "Windows Phone",
            "iPad", "iPod"];
        var flag = true;
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) {
                flag = false;
                break;
            }
        }
        return flag;
    };
</script>