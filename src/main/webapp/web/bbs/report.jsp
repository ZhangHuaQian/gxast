<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <link rel="stylesheet" href="${ctxRes}css/global.css">
    <title>发布帖子-广西科普传播中心</title>
    <style>
        /*为添加的空div设置的样式*/


    </style>
</head>
<body style="background-color: #ffffff">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->

    <div id="newslistdiv" class="triangle-tip-up" style="width:70%;min-width:1302px;margin: 0px auto;height:auto;background-color: #FFFFFF">

        <div style="width:60%">
            <div class="fly-panel" pad20="" style="padding-top: 5px;">
                <div class="layui-form layui-form-pane">
                    <div class="layui-tab layui-tab-brief" lay-filter="user">

                        <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 10px;">
                            <div class="layui-tab-item layui-show">
                                <form method="post" class="layui-form" id="main_form">
                                    <div class="layui-row layui-col-space15 layui-form-item">
                                        <div class="layui-col-md3">
                                            <label class="layui-form-label">举报分类</label>
                                            <div class="layui-input-inline">
                                                <select lay-verify="required" id="report_type" name="report_type" lay-filter="report_type">
                                                    <option ></option>
                                                    <option >低俗色情</option>
                                                    <option >垃圾广告</option>
                                                    <option >辱骂攻击</option>
                                                    <option >其他违法信息</option>
                                                    <option >抄袭我的内容</option>
                                                    <option >暴露我的隐私</option>
                                                    <option >内容里有关于我的不实描述</option>
                                                </select>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="layui-form-item layui-form-text">
                                        <div class="layui-input-block">
                                            <textarea id="content" maxlength="200" onKeyUp="keypress()" onblur="keypress()"  name="content" required="" lay-verify="required" placeholder="描述理由不要超过200字哦" class="layui-textarea fly-editor" style="height: 260px;width: 700px"></textarea>
                                            <div style="color: #969696">
                                                <span>剩余可录入字数：</span>
                                                <span id="length">200</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="" style="margin-left:300px">
                                        <button class="layui-btn layui-btn-normal" id="insert" lay-filter="insert" lay-submit="submit">提交</button>
                                    </div>
                                </form>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script>

    //textarea 录入字数监听
    function keypress(){
        var text1= $("#content").val();
        var maxLen=200;
        var len;//记录剩余字符串的长度
        if(text1.length>=maxLen)
        {
            $("#content").val(text1.substr(0,maxLen));//只显示起始位-末尾；substr（起始位，末尾)
            len=0;
        }else{
            len=maxLen-text1.length;
        }
        // document.getElementById("pinglun").innerText=len;
        $("#length").text(len);
    }

    //注意进度条依赖 element 模块，否则无法进行正常渲染和功能性操作
    layui.use('element', function(){
        var element = layui.element;
    });

    var form;
    layui.use('form', function () {
        form = layui.form;
            //监听提交
        form.on('submit(insert)', function (data) {
            reportTopic();
            return false;
        });
    });

    function reportTopic() {
        var fromDate = $('#main_form').serialize();
        $.ajax({
            type:'post',

            url:'${ctx}report/reportTopic?topicId=${param.id}&commentId=${param.cid}',
            data:fromDate,
            dataType:'json',
            success:function (result) {
                console.log(result);
                if(result.status==1){
                    layer.alert("举报成功，处理中",function () {
                        window.parent.location.reload();
                        parent.layer.close(index);
                    })

                }else if(result.status==2){
                    layer.msg('亲请登录哦!');
                }

            },
            error : function(msg) {
                console.log(msg);
                alert("系统异常");
            }
        });


    }






</script>

</html>
