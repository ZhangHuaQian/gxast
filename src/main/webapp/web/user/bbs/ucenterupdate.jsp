<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑收货地址</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <%@ include file="/commViews/head.jsp" %>
    <%--<link rel="stylesheet" href="${ctx }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">--%>
    <%--<script type="text/javascript" src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.core.js"></script>--%>
    <%--<script src="${ctx }resource/plugins/wangEditor-3.1.1/release/wangEditor.min.js" type="text/javascript" charset="utf-8"></script>--%>
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
<div id="bg"
     style="display: none; background-color: #ccc; width: 100%; position: absolute; height: 100%; opacity: 0.5; z-index: 1;">
</div>
<!-- 菜单添加 -->
<form class="layui-form "  id="main_form" method="post" enctype="multipart/form-data">

    <div style="float: left;padding: 10px;width:95%">

        <div class="layui-form-item">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input type="text" name="title"
                       required lay-verify="required" placeholder="标题"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" id="mycity">
            <label class="layui-form-label">版块</label>
            <div class="layui-input-inline" style="width: 120px;">
                <select id="ssession" name="ssession"  lay-filter="select" lay-verify="required">

                </select>
            </div>
        </div>

        <%--<div class="layui-form-item layui-form-text" >--%>
            <%--<label class="layui-form-label">内容</label>--%>
            <%--<div class="layui-input-block">--%>
                <%--<textarea placeholder="最大输入300个字符" content="" id="content" maxlength="300" name="content" lay-verify="required" class="layui-textarea"></textarea>--%>
                <%--&lt;%&ndash;<input type="text" value="${topic.title}" name="content"--%>
                       <%--required lay-verify="required" placeholder="内容"--%>
                       <%--autocomplete="off" class="layui-input">&ndash;%&gt;--%>
            <%--</div>--%>
        <%--</div>--%>

        <div class="layui-form-item layui-form-text" style="display: none;">
            <label class="layui-form-label">正文</label>
            <div class="layui-input-block">
                <textarea  placeholder="请输入内容" class="layui-textarea" id="contentTEXT" name="content"></textarea>

            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">正文内容</label>
            <div class="layui-input-block">
                <textarea id="demo3" style="display: none;"></textarea>
            </div>
        </div>


        <div class="layui-form-item" style="margin-top: 25px">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-warm" lay-submit lay-filter="formDemo">更新信息</button>
                <!-- <button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
            </div>
        </div>
    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/mycity.js"></script>
<script>

    //刷新父窗口
    function reloadParentWin() {
            window.parent.location.href = "${ctx}web/user/bbs/list.jsp";
       /* window.opener.location.href = "${ctx}web/user/bbs/list.jsp";*/
        /*
        if(window.parent.frames["收货地址"]!=undefined)window.parent.frames["收货地址"].location.reload();// 刷新父窗口*!/*/
        //window.opener.location.reload();
        //window.opener.location.href=window.opener.location.href;
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
        // layer.closeAll(); //疯狂模式，关闭所有层
    }

    var from;
    //渲染表单
    layui.use('form', function () {
        form = layui.form;
        form.render();
        // $('#mycity').mycity('广西','百色市','田东县');
        //监听提交
        form.on('submit(formDemo)', function (data) {
            $('#contentTEXT').text(layedit.getContent(layeditIndex));
            $.ajax({
                type: 'post',
                url: '${ctx }topic/update?id='+'${param.id}',
                data: $('#main_form').serialize(),
                dataType: 'json',
                success: function (result) {
                    if(result.status==1){
                        layer.alert(result.msg, {icon: 6}, function () {
                            reloadParentWin();
                        });
                    }else{
                        layer.msg(result.msg, {icon: 5});
                    }
                },
                error: function (msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });
            return false;
        });
    });
    var layedit;
    //富文本
    var layeditIndex;

    //富文本上传图片，视频
    layui.use('layedit', function(){
        layedit = layui.layedit;
        layeditIndex = layedit.build('demo3', {
            height: 600,
            uploadImage: {
                url: '${ctx}base/uploadfile'
                ,type: 'post' //默认post

            },
            uploadVideo: {
                url: '${ctx}base/uploadVideoCommon',
                accept: 'video',
                acceptMime: 'video/*',
                exts: 'mp4|flv|avi|rm|rmvb',
                size: '20480'
            }

        });
    });
    //初始化用户信息
    function inittopic() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/session/selectAll',
            dataType: 'json',
            async:false,
            success: function (result) {
                var list=result.list;
                console.log(list);
                for(var i = 0; i < result.list.length; i++){
                    var str  ='<option value="'+ list[i].sid+ '">'+ list[i].sname+'</option>';
                    $("#ssession").append(str)
                }
            },
            error: function (msg) {
                console.log(msg);
                alert("初始化异常");
            }
        });
    }
    function initContent(){
    $.ajax({
            type: 'get',
            url: '${ctx }topic/toupdate?id='+'${param.id}',
            dataType: 'json',
            async:false,
        success: function (result) {
                console.log(result);
                //var ssession = result.ssession;
                var topic = result.topic;
                $("#demo3").html(htmlspecialchars_decode(topic.content));
                $("input[name='title']").val(topic.title);
                /*$("textarea[name='content']").val(a);*/
                $("select[name='ssession']").val(topic.ssession);
                $("select[name='sname'] option").each(function(){
                    if($(this).html()==topic.ssession){
                        $(this).attr("selected","selected")
                    }
                })
            },
            error: function (msg) {
                console.log(msg);
                alert("初始化异常");
            }
        });
    }
    // 初始化角色下拉
    <%--function initRoleSelect() {--%>

        <%--$.ajax({--%>
            <%--type: 'get',--%>
            <%--url: '${ctx }sys/session/selectAll',--%>
            <%--//data:$('#main_form').serialize(),--%>
            <%--dataType: 'json',--%>
            <%--success: function (result) {--%>
                <%--var list = result.list;--%>
                <%--console.log(result);--%>
                <%--var str = "";--%>
                <%--for (var i = 0; i < list.length; i++) {--%>
                    <%--str += '<option value="' + list[i].sid + '">' + list[i].sname + '</option>';--%>
                <%--}--%>
                <%--$("#ssession").append(str);--%>
                <%--// form.render('select');--%>
            <%--},--%>
            <%--error: function (msg) {--%>
                <%--console.log(msg);--%>
                <%--alert("系统异常");--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>
    $(function () {
        //initRoleSelect();
        inittopic();
        initContent()
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

</body>
</html>