<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <link rel="stylesheet" href="${ctxRes}css/global.css">
    <title>发布帖子-广西科普传播中心</title>
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
        .layui-btn-warm {
            background-color: #1e9fff;
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
        <div style="width:80%;margin-top:15px;height:601px;float: right;border: 1px solid #E8E8E8">


            <div class="fly-panel" pad20="" style="padding-top: 5px;">
                <!--<div class="fly-none">没有权限</div>-->
                <div class="layui-form layui-form-pane">
                    <div class="layui-tab layui-tab-brief" lay-filter="user">
                        <ul class="layui-tab-title">
                            <li class="layui-this">发表新帖<!-- 编辑帖子 --></li>
                        </ul>
                        <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                            <div class="layui-tab-item layui-show">
                                <form method="post" class="layui-form" id="main_form">
                                    <div class="layui-row layui-col-space15 layui-form-item">
                                        <div class="layui-col-md3">
                                            <label class="layui-form-label">所在专栏</label>
                                            <div class="layui-input-block">
                                                <select lay-verify="required" id="ssession" name="ssession" lay-filter="ssession">
                                                    <option></option>
                                                    <%--<option value="0">提问</option>
                                                    <option value="99">分享</option>
                                                    <option value="100">讨论</option>
                                                    <option value="101">建议</option>
                                                    <option value="168">公告</option>
                                                    <option value="169">动态</option>--%>
                                                </select>
                                               <div class="layui-unselect layui-form-select">
                                                   <div class="layui-select-title">
                                                       <input type="text" placeholder="请选择" value="" readonly="" class="layui-input layui-unselect">
                                                       <i class="layui-edge"></i>
                                                   </div>
                                                   <%--<dl class="layui-anim layui-anim-upbit">
                                                   <dd lay-value="" class="layui-select-tips">请选择</dd>
                                                   <dd lay-value="0" class="">提问</dd>
                                                   <dd lay-value="99" class="">分享</dd>
                                                   <dd lay-value="100" class="">讨论</dd>
                                                   <dd lay-value="101" class="">建议</dd>
                                                   <dd lay-value="168" class="">公告</dd>
                                                   <dd lay-value="169" class="">动态</dd>--%>
                                               </dl></div>
                                           </div>
                                        </div>
                                        <div class="layui-col-md9">
                                            <label for="L_title" class="layui-form-label">标题</label>
                                            <div class="layui-input-block">
                                                <input type="text" id="L_title" name="title" required="" lay-verify="required" maxlength="200" autocomplete="off" class="layui-input">
                                                <!-- <input type="hidden" name="id" value="{{d.edit.id}}"> -->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-row layui-col-space15 layui-form-item layui-hide" id="LAY_quiz">
                                        <div class="layui-col-md3">
                                            <label class="layui-form-label">所属产品</label>
                                            <div class="layui-input-block">
                                                <select name="project">
                                                    <option></option>
                                                    <%--<option value="layui">layui</option>
                                                    <option value="独立版layer">独立版layer</option>
                                                    <option value="独立版layDate">独立版layDate</option>
                                                    <option value="LayIM">LayIM</option>
                                                    <option value="Fly社区模板">Fly社区模板</option>--%>
                                                </select><div class="layui-unselect layui-form-select"><div class="layui-select-title"><input type="text" placeholder="请选择" value="" readonly="" class="layui-input layui-unselect"><i class="layui-edge"></i></div><dl class="layui-anim layui-anim-upbit"><dd lay-value="" class="layui-select-tips">请选择</dd><dd lay-value="layui" class="">layui</dd><dd lay-value="独立版layer" class="">独立版layer</dd><dd lay-value="独立版layDate" class="">独立版layDate</dd><dd lay-value="LayIM" class="">LayIM</dd><dd lay-value="Fly社区模板" class="">Fly社区模板</dd></dl></div>
                                            </div>
                                        </div>
                                        <div class="layui-col-md3">
                                            <label class="layui-form-label" for="L_version">版本号</label>
                                            <div class="layui-input-block">
                                                <input type="text" id="L_version" value="" name="version" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                        <div class="layui-col-md6">
                                            <label class="layui-form-label" for="L_browser">浏览器</label>
                                            <div class="layui-input-block">
                                                <input type="text" id="L_browser" value="" name="browser" placeholder="浏览器名称及版本，如：IE 11" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-form-item layui-form-text">
                                        <div class="layui-input-block" >
                                            <textarea id="demo3" style="display:none;" ></textarea>
                                        </div>
                                    </div>
                                    <div class="layui-form-item layui-form-text" style="display: none">
                                        <div class="layui-input-block">
                                            <textarea id="L_content" name="content"  placeholder="详细描述" class="layui-textarea fly-editor"></textarea>
                                        </div>
                                    </div>
                                    <%--<div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">悬赏飞吻</label>
                                            <div class="layui-input-inline" style="width: 190px;">
                                                <select name="experience">
                                                    <option value="20">20</option>
                                                    <option value="30">30</option>
                                                    <option value="50">50</option>
                                                    <option value="60">60</option>
                                                    <option value="80">80</option>
                                                </select><div class="layui-unselect layui-form-select"><div class="layui-select-title"><input type="text" placeholder="请选择" value="20" readonly="" class="layui-input layui-unselect"><i class="layui-edge"></i></div><dl class="layui-anim layui-anim-upbit"><dd lay-value="20" class="layui-this">20</dd><dd lay-value="30" class="">30</dd><dd lay-value="50" class="">50</dd><dd lay-value="60" class="">60</dd><dd lay-value="80" class="">80</dd></dl></div>
                                            </div>
                                            <div class="layui-form-mid layui-word-aux">发表后无法更改飞吻</div>
                                        </div>
                                    </div>--%>
                                    <div class="layui-form-item">
                                        <label for="id" class="layui-form-label">验证码</label>
                                        <div class="layui-input-inline">
                                            <input type="text" id="code" name="ValidateCode" required="" lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input">
                                        </div>
                                        <div class="layui-form-mid" style="padding: 0px 0!important">
                                            <img id="imgObj" alt="验证码" src="${ctx}base/validateCode.jpg" onclick="javascript:reset_validateCode()">

                                        </div>
                                    </div>
                                    <div class="layui-form-item" >
                                        <button  class="layui-btn layui-btn-warm" id="insert" lay-filter="insert" lay-submit="submit">立即发布</button>
                                    </div>
                                </form>
                            </div>
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
    var layedit;
    //富文本
    var layeditIndex;
    //富文本上传图片，视频
    layui.use('layedit', function(){
        layedit = layui.layedit;
        layeditIndex = layedit.build('demo3', {

            height: 250,
            tool: [
                'strong' //加粗
                ,'italic' //斜体
                ,'underline' //下划线
                ,'del' //删除线

                ,'|' //分割线

                ,'left' //左对齐
                ,'center' //居中对齐
                ,'right' //右对齐
                ,'link' //超链接
                ,'unlink' //清除链接
                ,'face' //表情
                ,'image' //插入图片
            ],
            uploadImage: {
                url: '${ctx}base/uploadfile'
                ,type: 'post' //默认post
            },
            /*uploadVideo: {
                url: '${ctx}base/uploadVideoCommon',
                accept: 'video',
                acceptMime: 'video/!*',
                exts: 'mp4|flv|avi|rm|rmvb',
                size: '20480'
            }*/
        });
    });
    //
    var userid = '${sessionScope.USER_SESSION_NAME.id}';
    function insert(){
        $('#L_content').text(layedit.getContent(layeditIndex));

        var fromDate = $('#main_form').serialize();

        /* alert(fromDate.constructor(photo));
         alert($('#photo').val());*/
        $.ajax({
            type:'post',
            url:'${ctx }topic/insert?userid='+userid,
            data:fromDate,
            dataType:'json',
            success:function(data){
                console.log(data);
                if(data.status=="1"){

                    layer.msg(data.msg);
                    setTimeout('refresh()',2000);

                }else if(data.status=="5"){
                    layer.msg("评论不可为空哦，亲", {
                        offset:['200px,200px'] ,
                        anim: 6
                    });
                }else{
                    layer.msg(data.msg);
                    reset_validateCode();
                }
            },
            error:function (msg){
                console.log(msg);
                alert("错误!");
            }
        });
    }
    function refresh() {
        window.location.reload();
    }
    // reset 验证码
    function reset_validateCode(){
        $("#imgObj").attr('src','${ctx}base/validateCode.jpg?t='+Math.random());
    }

    var form;

        layui.use('form', function () {
            form = layui.form;
            form.render();
            //监听提交
            form.on('submit(insert)', function (data) {
                insert();
                return false;
            });
        });

    // 初始化角色下拉
    function initRoleSelect() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/session/selectAll',
            //data:$('#main_form').serialize(),
            dataType: 'json',
            success: function (result) {
                var list = result.list;
                console.log(result);
                var str = "";
                for (var i = 0; i < list.length; i++) {
                    str += '<option value="' + list[i].sid + '">' + list[i].sname + '</option>';
                }
                $("#ssession").append(str);
                form.render();
            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }
    $(function () {
        initRoleSelect();
    });

</script>
<script>
    //刷新图片
  /*  function changeImg() {
        var imgSrc=$("#imgObj");
        var src=imgSrc.attr("src");
        imgSrc.attr("src",changeUrl(src));

    }
    //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
    function changeUrl(url) {
        var timestamp = (new Date()).valueOf();
        var index = url.indexOf("?",url);
        if (index > 0) {
            url = url.substring(0, url.indexOf(url, "?"));
        }
        if ((url.indexOf("&") >= 0)) {
            url = url + "×tamp=" + timestamp;
        } else {
            url = url + "?timestamp=" + timestamp;
        }
        return url;
    }*/






</script>

</html>
