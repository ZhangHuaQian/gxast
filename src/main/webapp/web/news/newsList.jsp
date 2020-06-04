<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>新闻中心-广西科普传播中心</title>
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
            <%@ include file="/web/include/head.jsp"%>
        </div>
    </div>
    <div id="newslistdiv" style="width:70%;min-width:1302px;margin: 10px auto;">
        <div id="newslist_div" style="width:77%;float: left;background-color: #ffffff">
            <div id="newslist_area" style="margin-left: 10px;">
                <div id="newslist_header" style="color: GRAY;">
                    <div style="padding-top: 8px;padding-bottom: 25px;border-bottom: 2px solid #E8E8E8;margin-right: 10px;">
                        <img src=""><span><i class="layui-icon">&#xe68e;
                    </i>你当前位置 > <a href="${ctx }">首页</a> > <a href="${ctx }web/news/toNewsList">新闻中心</a> <a id="zhuti"></a> </span>
                        <sapn style="float: right">

                            <div class="layui-input-inline" style="width: 150px;">
				<input  type="text" id="title" required value="${param.title}"
                       lay-verify="required" placeholder="请输入标题关键字" autocomplete="off"
                       class="layui-input" >
			</div>
			<button type="button" style="border-radius: 4px;" class="layui-btn layui-btn-warm" onclick="searchTitle()">搜索</button>

                        </sapn>
                    </div>
                </div>
                <div id="newslist" style="margin-top: 10px;">
                    <div id="newslists" style="margin-right: 10px;">
                        <%--<c:forEach items="${list}" var="list">--%>
                            <%--<ul><div class="news_list"><a target="_blank" href="${ctx}web/news/details/${list.id}.html"><span style="">${list.title}</span></a><span class="news_list_time"><fmt:formatDate value="${list.createTime}" pattern="yyyy-MM-dd"/></span></div></ul>--%>
                        <%--</c:forEach>--%>
                    </div>
                    <div class="clearDiv"></div>
                </div>

                <div id="newslist_footer" style="background-color: #FFFFFF;text-align: center">
                    <div id="pagecontroller" >
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
                            <span style="margin-left: 2px;">新闻中心</span>
                        </div>

                    </div>
                </ul>
            </div>
            <div style="background-color: #FFFFFF;margin-top: 20px;font-size: 15px">
                <%--<div style="border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">--%>
                    <%--<span style="margin-left: 10px;">专题推荐</span>--%>
                <%--</div>--%>
<%--                <div>--%>
<%--                    <div style="margin: 10px 10px;padding-bottom: 10px;">--%>
<%--                        <div class="layui-carousel" id="test1">--%>
<%--                            <div carousel-item id="photo1">--%>

<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div style="margin-top: 10px" class="layui-carousel" id="test2">--%>
<%--                            <div carousel-item id="photo2">--%>

<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
            </div>
        </div>
        <div class="clearDiv"></div>
    </div>
    <div class="clearDiv"></div>
</div>
<%@ include file="/web/include/footer.jsp"%>
<script>

    $(function() {

        dictionary();

        initadv();
        //初始化页面资讯
        initData(1,10,$("#title").val());
    });

    var zhuti='${param.newTypeId}';
    if(zhuti.indexOf("1") !=-1){
        $("#zhuti").html(">时政要闻");
    }else if(zhuti.indexOf("2") !=-1){
        $("#zhuti").html(">工作动态")
    }else{
        $("#zhuti").hide();
    }
    $("body").keydown(function() {
        if (event.keyCode == "13") {//keyCode=13是回车键
            console.log(111)
            searchTitle();
        }
    });

    function searchTitle(){

        if("${param.newTypeId}"==""||"${param.newTypeId}"==null||"${param.newTypeId}"==undefined){
            window.location.href="${ctx}web/news/toNewsList?pageNum="+1+"&title="+$("#title").val();
        }else{
            <%--window.location.href="${ctx}web/news/toNewsList?pageNum="+1+"&title="+$("#title").val()+"&newTypeId=${param.newTypeId}";--%>
        }

    }


    // 分类
    function dictionary(){
        $.ajax({
            type: "get",
            url: "${ctx}appsite/selectList",
            data: {type: 'type_zx'},    //视情况将base64的前面字符串data:image/png;base64,删除
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
                        +'<span style="margin-left: 21px;" id="t1" class="commentsBtn" comid="'+data.list[i].value+'" >'+data.list[i].name+'</span>'
                        +'</div>'
                        +'</div>'
                        +'</ul>';
                }

                $("#dictionary").append(str);
                com_even_bind();
            }
        });
    }

    function com_even_bind(){
        $(".commentsBtn").click(function () {
            //alert($(this).attr("comid"));
            window.location.href='${ctx}web/news/selectList?pageNum='+1+'&newTypeId='+$(this).attr("comid");
        })
    }

    //初始化页面资讯
    function initData(pageNum,pageSize,title) {
        var url = '${ctx }web/news/selectList?pageNum='+ pageNum +'&newTypeId=${param.newTypeId}'+"&pageSize="+pageSize;
        if(title != undefined && title != ""){
            url += "&title="+title;
        }
        $.ajax({
            type: "get",
            url: url,
            dataType: "json",
            success: function(data) {
                var list = data.list;
                var str = "";
                for(var i=0; i< list.length; i++){
                    var time = formatDate_YMD_HMS(list[i].createTime);
                        str +='<ul><div class="news_list">\n' +
                            '<a target="_blank" href="${ctx}web/news/details/'+list[i].id+'.html">\n' +
                            '<span style="">'+list[i].title+'</span>\n' +
                            '</a>\n' +
                            '<span class="news_list_time">'+ time + '</span>\n' +
                            '</div></ul>'
                }

                initPage(data);
                $("#newslists").html(str);
            },
            error: function(msg) {
                console.log(msg)
                alert("请检查网络后重试");
            },
        });
    }

    //初始化分页栏
    var limit = 10;
    // var page = 1
    function initPage(pageData) {
        // console.log(pageData);

        layui.use([ 'laypage', 'layer' ], function() {
            var laypage = layui.laypage, layer = layui.layer;
            laypage.render({
                elem : 'demo7',
                curr :pageData.pageNum,
                count : pageData.count,
                theme: '#1E9FFF',
                limit:limit,
                groups:5,
                limits:[5,10, 20, 30, 40, 50,100,200],
                layout : [ 'count', 'prev', 'page', 'next', 'refresh','limit',
                    'skip' ],
                jump : function(obj, first) {
                    if (!first) {//首次不执行
                        limit = obj.limit;
                        initData(obj.curr, limit,$("#title").val());
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
    var phototype="xwzx";
    function initadv() {
        $.ajax({
            type: 'POST',
            url: '${ctx }topic/selectadvphoto?phototype='+phototype+'&photozise='+photozise+'&photonum='+photonum,
            /* data: $('#main_form').serialize(),*/
            dataType: 'json',
            success: function (result) {
                var str = "";
                if(result.list1.length>0){
                    for (var i = 0; i < result.list1.length; i++) {
                        str += '<div onclick="'+result.list1[i].htmlUrl+'" ><img style="width:100%;height:70px;" src="${ctxUphoto}'+result.list1[i].projectImg+'"/></div>';
                        str+='';
                    }
                    $("#photo1").append(str);
                }else {
                    str+='<div><img src="${ctxRes}/images/404-img.jpg" style="width:100%;height:70px;"/>';
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
                   // str2+='<div><img src="${ctxUphoto}/2019/01/15//04f49f2e-4db4-4515-9b18-122a79b195e3.jpg"/>';
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
