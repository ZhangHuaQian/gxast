<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>机构职能-广西科普传播中心</title>
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
        img {
            max-width: 100%;
            max-height: 100%;
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
        #details img{
            max-width: 100%;
        }
        #details *{
            max-width: 100%;
            height: auto;
            width: auto;
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
                    <div style="padding-top: 8px;padding-bottom: 10px;border-bottom: 2px solid #E8E8E8;margin-right: 10px;">
                        <img src=""><span>你当前位置 > <a href="${ctx }">首页</a> > <a href="${ctx }web/zxjjindex">中心简介</a> > 机构职能及机构设置</span>
                    </div>
                </div>
                <div id="newstitle" style="margin-top: 30px;text-align: center;">
                    <h1 id="title">${jgzn.title}</h1>
                    <h3 id="createTime" style="margin-top: 10px;color: #9c9c9c"><fmt:formatDate value="${jgzn.createTime}" pattern="yyyy年MM月dd日"/></h3>
                </div>
                <div id="newslist" style="margin-top: 30px;">
                    <div id="details" style="margin-right: 10px;color: #404040;font-size: 16px;line-height: 2">${jgzn.content}</div>
                    <div class="clearDiv"></div>
                </div>

                <div class="clearDiv"></div>
            </div>
            <div class="clearDiv"></div>

        </div>
        <%--<div id="chippings" style="width:21%;float:right;">--%>
            <%--<div style="background-color: #FFFFFF;font-size: 15px">--%>
                <%--<div style="border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">--%>
                    <%--<span style="margin-left: 10px;">专题推荐</span>--%>
                <%--</div>--%>
                <%--<div>--%>

                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="clearDiv"></div>
    </div>
    <div class="clearDiv"></div>
</div>
<div style="position: absolute;bottom: 0px;width: 100%;" >
    <%@ include file="/web/include/footer.jsp"%>
</div>
<script>
    $(function () {
        var text=$("#details").text();
        $("#details").html(text);
    })
    function htmlspecialchars_decode(str) {
        str = str.replace(/&lt;/g, '<');
        str = str.replace(/&gt;/g, '>');
        str = str.replace(/&#40;/g, "(");
        str = str.replace(/&#41;/g, ")");
        str = str.replace(/&#39;/g, "\'");
        return str;
    }
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //常规用法
        laydate.render({
            // elem: '#createTime'
        })

    });


    $(function () {
        initadv();
    });

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
    var phototype="zxjj";
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
                        str += '<div onclick="" ><img style="width:100%;height:70px;"  src="${ctxUphoto}'+result.list1[i].projectImg+'"/></div>';
                        str+='';
                    }
                    $("#photo1").append(str);
                }else {
                    <%--/*str+='<div><img src="${ctxUphoto}/2019/01/15//04f49f2e-4db4-4515-9b18-122a79b195e3.jpg"/>';*/--%>
                    str+='<div><img style="width:100%;height:70px;" src="${ctxRes}/images/404-img.jpg"/>';
                    $("#photo1").append(str);
                };
                var str2 = "";
                if(result.list2.length>0){
                    for (var i = 0; i < result.list1.length; i++) {

                        str2 += '<div onclick="" ><img style="width:100%;height:70px;"  src="${ctxUphoto}'+result.list2[i].projectImg+'"/></div>';
                        str2+='';
                    }
                    $("#photo2").append(str2);
                }else {
                    //str2+='<div><img src="${ctxUphoto}/2019/01/15//04f49f2e-4db4-4515-9b18-122a79b195e3.jpg"/>';
                    str2+='<div><img style="width:100%;height:70px;" src="${ctxRes}/images/404-img.jpg"/>';
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
<script>

</script>
</body>
</html>
