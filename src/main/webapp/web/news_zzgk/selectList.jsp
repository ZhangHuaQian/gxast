<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>政务公开-广西科普传播中心</title>
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
        .layui-btn-warm {
            background-color: #1e9fff;
        }

        .news_list{
            padding-left: 10px;
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
    </style>
</head>
<body style="background-color: #f2f5f9">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <div style="width:100%;background-image: url('${ctxRes}images/news_top.png');min-width:1302px;">

        <div id="main_center" style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 20px;">
            <%--<div id="banner" style="width: 100%;height: auto;display: block;">
                <div id="logoarea" style="float: left">
                    <img src="${ctxRes}images/logo.png">
                </div>
                <div id="index_info" style="float: left;margin-top:9px;margin-left: 40px;border-left:1px solid;padding-left:20px;border-left-color:#FFFFFF">
                    <p style="color: #FFFFFF">今天（2018年11月2日 星期五）</p>
                    <p style="color: #FFFFFF">南宁 10~19℃ 多云</p>
                </div>
                <div id="search" style="float: right;border: #66aede 5px solid;border-radius:25px;background-color: #FFFFFF;margin-top: 5px;">
                    <div class="search_input_div" style="float: left;border: #FFFFFF 5px solid;border-radius:25px;">
                        <input class="search_input" style="height: 20px;border-width:0px;" maxlength="2048" type="text" autocomplete="off" autocorrect="off" role="combobox" spellcheck="false" title="搜索"aria-label="搜索">
                    </div>
                    <div class="search_button_div" style="float: left;background-color: #FFFFFF;border: #2377cd 5px solid;border-radius:25px;">
                        <button class="search_button" type="button" style="height: 20px;border-width:0px;background-color: #2377cd;color: #FFFFFF;" aria-label="搜索" >
                            &nbsp;&nbsp;搜&nbsp;索&nbsp;&nbsp;
                        </button>
                    </div>
                </div>
                <div class="clearDiv"></div>
            </div>
            <div id="main_main" style="width: 100%;height: auto;display: block;margin-top: 20px;min-width: 1162px;">
                <div id="label" style="width: 100%;background-color: #085099;">
                    <div id="label_div">
                        <ul><a href="${ctx}xczx_index.jsp"><div class="label_title white">网站首页</div></a></ul>
                        <ul><a href="${ctx}web/news/selectList.jsp"><div class="label_title white">新闻中心</div></a></ul>
                        <ul><div class="label_title white">中心简介</div></ul>
                        <ul><div class="label_title white">党建工作</div></ul>
                        <ul><div class="label_title white">政务公开</div></ul>
                        <ul><div class="label_title white">订书订报</div></ul>
                    </div>
                    <div id="login_info" class="white" style="float: right;margin-right:5px;">
                        <p style="padding: 10px 25px;">下午好，欢迎你，请<a href="#" style="color: #FFFFFF">&nbsp;登录&nbsp;</a>或<a href="#" style="color: #FFFFFF">&nbsp;注册&nbsp;</a></p>
                    </div>
                    <div class="clearDiv"></div>
                </div>

            </div>--%>
                <%@ include file="/web/include/head.jsp"%>
        </div>
    </div>
    <div id="newslistdiv" style="width:70%;min-width:1302px;margin: 10px auto;">
        <div id="newslist_div" style="width:77%;float: left;background-color: #ffffff">
            <div id="newslist_area" style="margin-left: 10px;">
                <div id="newslist_header" style="color: GRAY;">
                    <div style="padding-top: 8px;padding-bottom: 25px;border-bottom: 2px solid #E8E8E8;margin-right: 10px;">
                        <img src=""><span><i class="layui-icon">&#xe68e;
                    </i>你当前位置 > <a href="${ctx }">首页</a> > <a href="${ctx }web/news_zzgk/selectList">政务公开</a> <a id="zhuti"></a></span>
                        <sapn style="float: right">

                            <div class="layui-input-inline" style="width: 150px;">
                                <input  type="text" id="title" required value="${param.title}"
                                        lay-verify="required" placeholder="请输入标题关键字" autocomplete="off"
                                        class="layui-input" >
                            </div>
                            <button style="border-radius: 4px;"
                                    class="layui-btn layui-btn-warm" onclick="search()">搜索</button></sapn>
                    </div>
                </div>
                <div id="newslist" style="margin-top: 10px;">
                    <div id="newslists" style="margin-right: 10px;">
                        <c:forEach items="${list}" var="list">
                            <ul><div class="news_list"><a target="_blank" href="${ctx}web/news_zzgk/details/${list.id}.html"><span style="">${list.title}</span></a><span class="news_list_time"><fmt:formatDate value="${list.createTime}" pattern="yyyy-MM-dd"/></span></div></ul>
                        </c:forEach>
                    </div>
                    <div class="clearDiv"></div>
                </div>
                <div id="newslist_footer" style="background-color: #FFFFFF;text-align: center">
                    <div id="pagecontroller" >
                        <%--<div style="float: left;padding: 5px 10px;margin: 0px 2px">
                            <a><span>上一页</span></a>
                        </div>
                        <div style="float: left;padding: 5px 10px;margin: 0px 2px;background-color: #2377cd;">
                            <a><span style="color: #FFFFFF">1</span></a>
                        </div>
                        <div style="float: left;padding: 5px 10px;margin: 0px 2px;background-color: #ececec">
                            <a><span>2</span></a>
                        </div>
                        <div style="float: left;padding: 5px 10px;margin: 0px 2px;background-color: #ececec">
                            <a><span>3</span></a>
                        </div>
                        <div style="float: left;padding: 5px 10px;margin: 0px 2px;">
                            <a><span>下一页</span></a>
                        </div>--%>
                            <div id="demo7" ></div>
                        <div class="clearDiv"></div>
                    </div>
                </div>
                <div class="clearDiv"></div>
            </div>
            <div class="clearDiv"></div>
        </div>
        <div id="chippings" style="height: 100%;width:21%;float:right;">
            <div id="dictionary" style="background-color: #FFFFFF;font-size: 15px">
                <ul>
                    <div style="background-color:#2377cd;color:#FFFFFF;border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">
                        <div style="margin-left: 10px;">
                            <div style="float: left">
                                <img src="${ctxRes}images/11.png" style="width:19px;height: 17px;margin-top: 2px;">
                            </div>
                            <span style="margin-left: 2px;">政务公开</span>
                        </div>

                    </div>
                </ul>
                <%--<ul>
                    <div style="border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">
                        <div style="margin-left: 10px;">
                            <div style="float: left;" ></div>
                            <span style="margin-left: 21px;">时政要闻</span>
                        </div>

                    </div>
                </ul>
                <ul>
                    <div style="color:#2377cd;border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">
                        <div style="margin-left: 10px;">
                            <div style="float: left"></div>
                            <span style="margin-left: 21px;">工作动态</span>
                        </div>
                    </div>
                </ul>--%>
            </div>

        <div class="clearDiv"></div>
    </div>
    <div class="clearDiv"></div>
</div>
<%@ include file="/web/include/footer.jsp"%>
<script>
    var zhuti='${param.newTypeId}';
    if(zhuti.indexOf("0") !=-1){
        $("#zhuti").html(">财政信息");
    }else if(zhuti.indexOf("1") !=-1){
        $("#zhuti").html(">采购");
    }else if(zhuti.indexOf("2") !=-1){
        $("#zhuti").html(">通知公告");
    }else if(zhuti.indexOf("3") !=-1){
        $("#zhuti").html(">预算");
    } else if(zhuti.indexOf("4") !=-1){
        $("#zhuti").html(">政策法规");
    } else{
        $("#zhuti").hide();
    }

    $("body").keydown(function() {
        if (event.keyCode == "13") {//keyCode=13是回车键
            search();
        }
    });

    function search(){

        if("${param.newTypeId}"==""||"${param.newTypeId}"==null||"${param.newTypeId}"==undefined){
            window.location.href="${ctx}web/news_zzgk/selectList?pageNum="+1+"&title="+$("#title").val();

        }else{

            window.location.href="${ctx}web/news_zzgk/selectList?pageNum="+1+"&title="+$("#title").val()+"&newTypeId=${param.newTypeId}";

        }

    }


    // 分类
    function dictionary(){
        $.ajax({
            type: "get",
            url: "${ctx}appsite/selectList",
            data: {type: 'type_zzgk'},    //视情况将base64的前面字符串data:image/png;base64,删除
            dataType: "json",
            error: function(msg) {
                console.log(msg)
                alert("请检查网络后重试");
            },
            success: function(data) {
                console.log(data)
                var str = "";
                for (var i=0;i<data.list.length;i++){
                    str += '<ul>'
                        +'<div style="cursor:pointer;color:#2377cd;border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">'
                        +'<div style="margin-left: 10px;">'
                        +'<div style="float: left"></div>'
                        +'<span style="margin-left: 21px;" class="commentsBtn" comid="'+data.list[i].value+'" >'+data.list[i].name+'</span>'
                        +'</div>'
                        +'</div>'
                        +'</ul>';
                }
                $("#dictionary").append(str);
                initPage(0);
                com_even_bind();
            }
        });
    }
    function com_even_bind(){
        $(".commentsBtn").click(function () {
            //alert($(this).attr("comid"));
            window.location.href='${ctx}web/news_zzgk/selectList?pageNum='+1+'&newTypeId='+$(this).attr("comid");
        })
    }

    $(function() {
        dictionary();

        initadv();
    });

    //初始化分页栏
    function initPage(pageData) {
        layui.use([ 'laypage', 'layer' ], function() {
            var laypage = layui.laypage, layer = layui.layer;
            laypage.render({
                elem : 'demo7',
                curr : ${pageNum},//页码
                count : ${count},//行数
                theme: '#1E9FFF',
                layout : [ 'count', 'prev', 'page', 'next', 'refresh',
                    'skip' ],
                jump : function(obj, first) {
                    if (!first) {//首次不执行

                        window.location.href= '${ctx }web/news_zzgk/selectList?pageNum=' + obj.curr+'&newTypeId=${param.newTypeId}';
                            console.log( obj.curr);

                    }
                }
            });
        });
    }
    function loop() {
        layui.use('carousel', function(){
            var carousel = layui.carousel;
            //建造实例
            carousel.render({
                elem: '#test1'
                ,width: '100%' //设置容器宽度
                ,height:'70px'
                ,arrow: 'always' //始终显示箭头
                //,anim: 'updown' //切换动画方式
            });
            carousel.render({
                elem: '#test2'
                ,width: '100%' //设置容器宽度
                ,height:'70px'
                ,arrow: 'always' //始终显示箭头
                //,anim: 'updown' //切换动画方式
            });
        });
    }
    var photozise=3;//图片数量
    var photonum=2;//广告位数
    var phototype="zwgk";
    function initadv() {
        $.ajax({
            type: 'POST',
            url: '${ctx }topic/selectadvphoto?phototype='+phototype+'&photozise='+photozise+'&photonum='+photonum,
            /* data: $('#main_form').serialize(),*/
            dataType: 'json',
            success: function (result) {
                console.log(result)
                var str = "";
                if(result.list1.length>0){
                    for (var i = 0; i < result.list1.length; i++) {
                        str += '<div onclick="'+result.list1[i].htmlUrl+'" ><img style="width:100%;height:70px;" src="${ctxUphoto}'+result.list1[i].projectImg+'"/></div>';
                        str+='';
                    }
                    $("#photo1").append(str);
                }else {
                    /*str+='<div><img src="${ctxUphoto}/2019/01/15//04f49f2e-4db4-4515-9b18-122a79b195e3.jpg"/>';*/
                    str+='<div><img src="${ctxRes}/images/404-img.jpg"  style="width:100%;height:70px;"/>';
                    $("#photo1").append(str);
                };
                var str2 = "";
                if(result.list2.length>0){
                    for (var i = 0; i < result.list1.length; i++) {
                        str2 += '<div onclick="'+result.list2[i].htmlUrl+'" ><img style="width:100%;height:70px;" src="${ctxUphoto}'+result.list2[i].projectImg+'"/></div>';
                        str2+='';
                    }
                    $("#photo2").append(str2);
                }else {
                    //str2+='<div><img src="${ctxUphoto}/2019/01/15//04f49f2e-4db4-4515-9b18-122a79b195e3.jpg"/>';
                    str2+='<div><img src="${ctxRes}/images/404-img.jpg" style="width:100%;height:70px;"/>';
                    $("#photo2").append(str2);
                }
                loop();
            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }
</script>
</body>
</html>
