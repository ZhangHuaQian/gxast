<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<html>
<head>
    <%@ include file="/commViews/head.jsp" %>
    <link rel="stylesheet" href="${ctxRes}css/global.css">
    <title>帖子列表-广西科普传播中心</title>
    <style>
        /*为添加的空div设置的样式*/
        .clearDiv {
            clear: both;
        }

        .white {
            color: #FFFFFF;
        }

        .label_title {
            display: inline;
            float: left;
            border-right: #2377cd 1px solid;
            padding: 10px 25px;
        }

        .lm_label {
            display: inline;
            float: left;

            padding: 10px 25px;
        }

        .lm_label_select {
            display: inline;
            float: left;
            background-color: #2377cd;
            padding: 10px 25px;
        }

        .div0_col0 {
            width: 60%;
            float: left;
        }

        .div0_col1 {
            width: 40%;
        }

        #index_main_div0_row0 {
            height: 57%;
        }

        #index_main_div0_row1 {
            height: 43%;
        }

        .news_list {
            font-size: 16px;
            display: table-cell;
            vertical-align: middle;
            width: 100%;
        }

        .news_list_time {
            color: #ababab;
            float: right;
            margin-right: 15px;

        }

        #newslists > ul {
            width: 100%;
            padding-top: 10px;
            padding-bottom: 10px;
            color: #696969;
            display: table;
            width: 100%;
            height: 40px;
        }

        #newslists > ul:nth-child(odd) {
            background-color: #f2f7fb;
        }

        #newslists > ul:nth-child(even) {
            background-color: #ffffff;
        }

        .fly-list-one dd span {
            float: right;
        }

        .laypage-main {
            border: 0px;
        }

        .laypage-main * {
            padding: 0px;
            line-height: 30px;
            border: 0px;
        }

        .layui-btn-warm {
            background-color: #1e9fff;
        }

        .img_icon{
            padding-bottom: 8px;
            margin-left: 8px;
        }
    </style>

</head>
<body style="background-color: #f2f5f9">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <div style="width:100%;background-image: url('${ctxRes}images/news_top.png');min-width:1302px;">

        <div id="main_center" style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 20px;">
            <%@ include file="/web/include/head.jsp" %>
        </div>
    </div>
    <div id="newslistdiv" style="width:70%;min-width:1302px;margin: 10px auto;">

        <div class="layui-row layui-col-space15">
            <div class="layui-col-md8">
                <div class="fly-panel" id="zhiding_parent_div">
                    <div class="fly-panel-title fly-filter">
                        <a>置顶</a>
                        <a href="#signin" class="layui-hide-sm layui-show-xs-block fly-right" id="LAY_goSignin"
                           style="color: #FF5722;">去签到</a>
                    </div>
                    <ul id="zhiding" class="fly-list">

                    </ul>
                </div>

                <div class="fly-panel" style="margin-bottom: 0;">

                    <div class="fly-panel-title fly-filter">
                        <a href="#" class="layui-this" id="zongge">综合</a>
                        <%--<span class="fly-mid"></span>
                        <a href="">未结</a>
                        <span class="fly-mid"></span>
                        <a href="">已结</a>
                        <span class="fly-mid"></span>
                        <a href="">精华</a>--%>
                        <%--             <span class="fly-filter-right layui-hide-xs">
                     <a href="" class="layui-this">按最新</a>
                     <span class="fly-mid"></span>
                     <a href="">按热议</a>
                   </span>--%>
                        <sapn style="float: right">

                            <div class="layui-input-inline" style="width: 150px;">
                                <input type="text" id="title"
                                       lay-verify="required" placeholder="请输入标题关键字" autocomplete="off"
                                       class="layui-input">
                            </div>
                            <button style="border-radius: 4px;"
                                    class="layui-btn layui-btn-warm" onclick="selectByObjecy()">搜索
                            </button>
                            <button style="border-radius: 4px;" class="layui-btn layui-btn-warm" onclick="insertBbs()">
                                发帖
                            </button>
                        </sapn>

                    </div>

                    <ul id="tiezi" class="fly-list">
                    </ul>
                    <div style="text-align: center">
                        <div class="laypage-main" id="demo7">
                            <%--<span class="laypage-curr">1</span>
                            <a href="/jie/page/2/">2</a>
                            <a href="/jie/page/3/">3</a>
                            <a href="/jie/page/4/">4</a>
                            <a href="/jie/page/5/">5</a>
                            <span>…</span>
                            <a href="/jie/page/148/" class="laypage-last" title="尾页">尾页</a>
                            <a href="/jie/page/2/" class="laypage-next">下一页</a>--%>
                        </div>
                    </div>

                </div>

            </div>
            <div class="layui-col-md4">

                <div class="fly-panel">
                    <h3 class="fly-panel-title">热门板块</h3>
                    <div class="layui-row fly-panel-main" style="padding: 15px;">
                        <div class="layui-clear fly-list-quick" id="ssession">
                            <%--<div class="layui-col-xs6"> <div> <a href="/extend/" target="_blank"> 走进科协 </a> </div> </div>
                            <div class="layui-col-xs6"> <div> <a href="/case/2019/" target="_blank"> 学术学会 </a> </div> </div>
                            <div class="layui-col-xs6"> <div> <a href="http://fly.layui.com/jie/30227/" target="_blank"> 生活动态 </a> </div> </div>
                            <div class="layui-col-xs6"> <div> <a href="http://fly.layui.com/jie/4281/" target="_blank"> 学会动态 </a> </div> </div>
                            <div class="layui-col-xs6"> <div> <a href="/store/" target="_blank"> 专题特区 </a> </div> </div>
                            <div class="layui-col-xs6"> <div> <a href="http://fly.layui.com/jie/13435/" target="_blank"> 党建园地 </a> </div> </div>--%>
                            <a name="signin"> </a>
                        </div>
                    </div>
                </div>

                <%-- <div class="fly-panel fly-signin">
                     <div class="fly-panel-title">
                         签到
                         <i class="fly-mid"></i>
                         <a href="javascript:;" class="fly-link" id="LAY_signinHelp">说明</a>
                         <i class="fly-mid"></i>
                         <a href="javascript:;" class="fly-link" id="LAY_signinTop">活跃榜<span class="layui-badge-dot"></span></a>
                         <span class="fly-signin-days">已连续签到<cite>16</cite>天</span>
                     </div>
                     <div class="fly-panel-main fly-signin-main">
                         <button class="layui-btn layui-btn-danger" id="LAY_signin">今日签到</button>
                         <span>可获得<cite>5</cite>飞吻</span>

                         <!-- 已签到状态 -->
                         <!--
                         <button class="layui-btn layui-btn-disabled">今日已签到</button>
                         <span>获得了<cite>20</cite>飞吻</span>
                         -->
                     </div>
                 </div>--%>

                <div class="fly-panel fly-rank fly-rank-reply" id="LAY_replyRank">
                    <h3 class="fly-panel-title">回帖周榜</h3>
                    <dl id="rubackuser">
                        <!--<i class="layui-icon fly-loading">&#xe63d;</i>-->
                        <%--  <dd>
                              <a href="user/home.html">
                                  <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                              </a>
                          </dd>--%>

                    </dl>
                </div>

                <dl id="commentnum" class="fly-panel fly-list-one">
                    <dt class="fly-panel-title">本周热议</dt>
                    <%-- <dd>
                         <a href="${ctx}web/bbs/details.jsp" target="_blank">广西科技馆与南宁二中共同开启物理乐学活动</a>
                         <span><i class="iconfont icon-pinglun1"></i> 16</span>
                     </dd>--%>

                    <!-- 无数据时 -->
                    <!--
                    <div class="fly-none">没有相关数据</div>
                    -->
                </dl>

                <%--<div class="fly-panel">--%>
                    <%--&lt;%&ndash;<div class="fly-panel-title">--%>
                        <%--这里可作为广告区域--%>
                    <%--</div>&ndash;%&gt;--%>
                    <%--<div class="fly-panel-main">--%>
                        <%--<div class="layui-carousel" id="test1">--%>
                            <%--<div carousel-item id="photo1">--%>

                            <%--</div>--%>
                        <%--</div>--%>
                        <%--<div style="margin-top: 10px" class="layui-carousel" id="test2">--%>
                            <%--<div carousel-item id="photo2">--%>

                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>

                <div class="fly-panel fly-link">
                    <h3 class="fly-panel-title">友情链接</h3>

                    <div style="padding: 15px 0px;vertical-align: middle">
                        <c:forEach items="${list}" var="LK">
                            <span class="lkclass"><a target="_blank" href="${LK.link}"> ${LK.linkname}</a></span>
                        </c:forEach>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="clearDiv"></div>
</div>
<%@ include file="/web/include/footer.jsp" %>
</body>
<script>
    var vip_icon = "<img src='${ctx}resource/images/topic-vip.png' style='margin-left: 5px;'>";
    var vip_user_icon = "<img class='img_icon' src='${ctx}resource/images/default_vip_icon.png' style='margin-left: 5px;'>";
    var userid = '${sessionScope.USER_SESSION_NAME.id}';

    function getUserData(pageNum) {
        //console.log('${ctx }sys/link/selectList?pageNum='+pageNum)
        $.ajax({
            type: 'get',
            url: '${ctx }sys/link/selectList?pageNum=' + pageNum,
            dataType: 'json',
            success: function (result) {
                // console.log(result);
                var list = result.list;

            },
            error: function (msg) {
                //console.log(msg);
                alert("数据初始化异常");
            }
        });
    }


    function selectByObjecy() {
        selectAlltopic(1);
        pageCurr = 1;
    }


    function insertBbs() {
        if (userid.length > 0) {
            window.open("${ctx}web/user/bbs/insert.jsp");

        } else {
            layer.msg('请先登录哦，亲！', {
                offset: ['200px,200px'],
                anim: 6
            });
        }
    }

    var ssession = "";

    /**分页加载文章列表**/
    function selectAlltopic(pageNum) {
        $.ajax({
            type: 'POST',
            url: '${ctx }topic/selectAlltopic?pageNum=' + pageNum + '&ssession=' + ssession + '&title=' + $("#title").val(),
            /* data: $('#main_form').serialize(),*/
            dataType: 'json',
            success: function (result) {
                var list = result.list;
                var str = "";
                $("#tiezi").empty();
                if (result.list.length > 0) {
                    for (var i = 0; i < result.list.length; i++) {
                        var img = "";
                        var vip_user = "";
                        if (list[i].type == 1) {
                            // vip版块
                            img = vip_icon;
                        }
                        if (list[i].userType == 1) {
                            // vip用户
                            vip_user = vip_user_icon;
                        }
                        list[i].create_time = new Date(list[i].create_time).format("yyyy-MM-dd hh:mm:ss");
                        /*var unixTimestamp = new Date(list[i].create_time) ;
                        commonTime = unixTimestamp.toLocaleString();*/
                        /*alert(commonTime);*/
                        str += '<li><a  class="fly-avatar">';
                        str += '<img src="${ctxUphoto}' + list[i].photo + '" alt="' + list[i].name + '"></a><h2><a class="layui-badge">' + list[i].sname + '</a>';
                        str += '<a href="javascript:void(0);" onclick="detail(' + list[i].tid + ',' + list[i].type + ')"' + '">' + list[i].title + img + '</a></h2><div class="fly-list-info">';
                        str += '<a  link=""><cite>' + list[i].name +'<img class="img_icon" src="${ctx}resource/images/'+list[i].forumGradeIcon+'">'+vip_user+ '</cite>';
                        str += '</a><span>' + list[i].create_time + '</span><span class="fly-list-kiss layui-hide-xs" title="点赞"><i class="iconfont icon-zan"></i> ' + list[i].like_num + '</span>';
                        str += '<span class="fly-list-nums"><i class="iconfont icon-pinglun1" title="回答"></i> ' + list[i].comment + '</span></div>';
                        str += '<div class="fly-list-badge"</div></li>';
                        str += '';
                    }
                    $("#tiezi").append(str);
                    initPage(result.count);
                } else {
                    initPage(result.count);
                    layer.msg("没有发过帖子");
                }

            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }

    /***查看帖子详情**/
    function detail(id, type) {
        if (type == 1) {
            $.ajax({
                type: 'get',
                url: '${ctx}topic/checkVip',
                data: {
                    id: id
                },
                dataType: 'json',
                success: function (result) {
                    console.log(result);
                    if (result.status == 0) {
                        layer.msg(result.msg, {
                            offset: ['400px,400px'],
                            anim: 6
                        });
                    } else {
                        window.open("${ctx}topic/details?id="+id);
                    }
                },
                error: function (msg) {
                    console.log(msg);
                    layer.msg('数据初始化异常', {
                        offset: ['200px,400px'],
                        anim: 6
                    });
                }
            });
        }else{
            window.open("${ctx}topic/details?id="+id);
        }
    }

    /***加载置顶帖子**/
    function selectIsTop() {
        $.ajax({
            type: 'POST',
            url: '${ctx }topic/selectIsTop',
            /* data: $('#main_form').serialize(),*/
            dataType: 'json',
            success: function (result) {
                // console.log(result);
                var list = result.list;
                var str = "";
                if (result.list.length > 0) {
                    for (var i = 0; i < result.list.length; i++) {
                        var img = "";
                        var vip_user = "";
                        if (list[i].type == 1) {
                            // vip版块
                            img = vip_icon;
                        }
                        if (list[i].userType == 1) {
                            // vip用户
                            vip_user = vip_user_icon;
                        }
                        list[i].create_time = new Date(list[i].create_time).format("yyyy-MM-dd hh:mm:ss");
                        /*var unixTimestamp = new Date(list[i].create_time) ;
                        commonTime = unixTimestamp.toLocaleString();*/
                        /*alert(commonTime);*/
                        str += '<li><a  class="fly-avatar">';
                        str += '<img src="${ctxUphoto}' + list[i].photo + '" alt="' + list[i].name + '"></a><h2><a class="layui-badge">' + list[i].sname + '</a>';
                        str += '<a href="javascript:void(0);" onclick="detail(' + list[i].tid + ',' + list[i].type + ')"' + '">' + list[i].title + img + '</a></h2><div class="fly-list-info">';
                        str += '<a href="#" link=""><cite>' + list[i].name +'<img class="img_icon" src="${ctx}resource/images/'+list[i].forumGradeIcon+'">'+ vip_user + '</cite>';
                        str += '</a><a>' + list[i].create_time + '</a><a class="fly-list-kiss layui-hide-xs" title="点赞"><i class="iconfont icon-zan"></i> ' + list[i].like_num + '</a>';
                        str += '<a class="fly-list-nums"><i class="iconfont icon-pinglun1" title="回答"></i> ' + list[i].comment + '</a></div>';
                        str += '<div class="fly-list-badge"</div></li>';
                        str += '';
                    }
                    $("#zhiding").append(str);
                } else {
                    //layer.msg("没有置顶的帖子");
                    $("#zhiding").append("还没有置顶的帖子");
                }

            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }

    /***加载本周热议**/
    function selectBycommentnum() {
        $.ajax({
            type: 'POST',
            url: '${ctx }topic/selectBycommentnum',
            /* data: $('#main_form').serialize(),*/
            dataType: 'json',
            success: function (result) {
                var list = result.list;
                var str = "";
                if (result.list.length > 0) {
                    for (var i = 0; i < result.list.length; i++) {
                        var img = "";
                        if (list[i].type == 1) {
                            // vip版块
                            img = vip_icon;
                        }
                        str += '<dd><a href="javascript:void(0);" onclick="detail(' + list[i].tid + ',' + list[i].type + ')"' + '">' + list[i].title + img + '</a>';
                        str += '<span><i class="iconfont icon-pinglun1"></i> ' + list[i].comment + '</span></dd>';
                        str += '';
                    }
                    $("#commentnum").append(str);
                } else {
                    console.log("无本周热议");
                }

            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }

    /**查询活跃人员信息**/
    function rubackUser() {
        $.ajax({
            type: 'POST',
            url: '${ctx }topic/rubackUser',
            /* data: $('#main_form').serialize(),*/
            dataType: 'json',
            success: function (result) {
                var list = result.list;
                // console.log(list);
                var str = "";
                if (result.list.length > 0) {
                    for (var i = 0; i < result.list.length; i++) {
                        str += '<dd><a ><img src="${ctxUphoto}' + list[i].photo + '"><cite>' + list[i].name + '</cite><i>' + list[i].Repetitions + '次回答</i></a></dd>';
                        str += '';
                    }
                    $("#rubackuser").append(str);
                } else {
                    console.log("无活跃人员");
                }
            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }

    /***加载站内版块**/
    function innitsession() {
        $.ajax({
            type: 'POST',
            url: '${ctx }topic/innitsession',
            dataType: 'json',
            success: function (result) {
                var list = result.list;
                console.log(list);
                var str = "";
                if (result.list.length > 0) {
                    for (var i = 0; i < result.list.length; i++) {
                        str += '<div class="layui-col-xs6"> <div><a href="javascript:void(0);" onclick="selecrBysession(' + list[i].sid + ',\'' + list[i].sname + '\')"> ' + list[i].sname + '</a> </div> </div>';
                        str += '';
                    }
                    $("#ssession").append(str);
                } else {
                    console.log("无站内版块");
                }
            },
            error: function (msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }

    /**根据版块查询帖子 -- 热门版块 **/
    function selecrBysession(sessionid, name) {
        $("#zhiding_parent_div").css("display", "none")
        console.log("name = " + sessionid + "  " + name)
        $("#zongge").html(name);
        ssession = sessionid;
        selectAlltopic(0);

    }


    $(function () {
        selectAlltopic(0);
        initadv();
        selectBycommentnum();
        selectIsTop();
        innitsession();
        rubackUser();
        //getUserData(1);
    });
    //初始化分页栏
    var pageCurr = 1;

    function initPage(pageData) {
        //console.log(pageData);
        layui.use(['laypage', 'layer'], function () {
            var laypage = layui.laypage, layer = layui.layer;
            laypage.render({
                elem: 'demo7',
                curr: pageCurr,
                count: pageData,
                theme: '#1E9FFF',
                layout: ['count', 'prev', 'page', 'next', 'refresh',
                    'skip'],
                jump: function (obj, first) {
                    if (!first) {//首次不执行
                        /*getUserData(obj.curr);*/
                        /*window.location.href= '
                        ${ctx }web/bbs/xczx_index.jsp?pageNum=' + obj.curr,*/
                        $("#tiezi").empty();
                        selectAlltopic(obj.curr);
                        pageCurr = obj.curr;
                        console.log(obj.curr);
                    }
                }
            });
        });
    }

    /***广告轮播**/
    function loop() {
        layui.use('carousel', function () {
            var carousel = layui.carousel;
            //建造实例
            carousel.render({
                elem: '#test1'
                , width: '100%' //设置容器宽度
                , height: '70px'
                , arrow: 'always' //始终显示箭头
                //,anim: 'updown' //切换动画方式
            });
            carousel.render({
                elem: '#test2'
                , width: '100%' //设置容器宽度
                , height: '70px'
                , arrow: 'always' //始终显示箭头
                //,anim: 'updown' //切换动画方式
            });
        });
    }

    var photozise = 3;//图片数量
    var photonum = 2;//广告位数
    var phototype = "lt";

    /***加载广告图片**/
    function initadv() {
        $.ajax({
            type: 'POST',
            url: '${ctx }topic/selectadvphoto?phototype=' + phototype + '&photozise=' + photozise + '&photonum=' + photonum,
            dataType: 'json',
            success: function (result) {
                console.log(result);
                var str = "";
                if (result.list1.length > 0) {
                    for (var i = 0; i < result.list1.length; i++) {
                        str += '<a href="' + result.list1[i].htmlUrl + '" ><img style="width:100%;height:70px;" src="${ctxUphoto}' + result.list1[i].projectImg + '"/></a>';
                        str += '';
                    }
                    $("#photo1").append(str);
                } else {
                    $("#photo1").html("");
                }
                ;
                var str2 = "";
                if (result.list2.length > 0) {
                    for (var i = 0; i < result.list1.length; i++) {

                        str2 += '<a href="' + result.list2[i].htmlUrl + '" ><img style="width:100%;height:70px;" src="${ctxUphoto}' + result.list2[i].projectImg + '"/></a>';
                        str2 += '';
                    }
                    $("#photo2").append(str2);
                } else {
                    $("#photo2").html("");
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
</html>
