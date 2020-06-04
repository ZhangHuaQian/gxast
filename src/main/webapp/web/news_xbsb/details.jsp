<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <link rel="stylesheet" href="${ctxRes}css/global.css">
    <meta name="description" content="${news.description}">
    <meta name="keywords" content="HTML,CSS,XML,JavaScript">
    <title>${news.title}-广西科普传播中心</title>

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
        .like{
             color:#1E9FFF; cursor:pointer;
            margin-left: 1em;
        }
        .comments {
            width: 98%; /*自动适应父布局宽度*/
            overflow: auto;
            word-break: break-all;
        }
        .commentsBtn{
            padding-right: 20px;
            color: #999;
            cursor: pointer;
        }

        #details img{
            max-width: 100%;
        }
        #details *{
            max-width: 100%;
            height: auto;
            width: auto;
        }
        #details p{
            text-indent: 2em;
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
                        <span><i class="layui-icon">&#xe68e;
                    </i>你当前位置 > <a href="${ctx }">首页</a> > 小博士报 <a id="zhuti"></a> > ${news.title}</span>
                    </div>
                </div>
                <div id="newstitle" style="margin-top: 30px;text-align: center;">
                    <h1>${news.title}</h1>
                    <h3 style="margin-top: 10px;color: #393d49;font-size:10px">
                        <fmt:formatDate value="${news.createTime}" pattern="yyyy年MM月dd日"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="orignfrom"></span>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="author"></span>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="editor"></span>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;浏览量：&nbsp;${news.page_view}
                        <span id="like" class="like">点赞</span>
                        <span id="span">${news.praise_view}</span>
                    </h3>
                </div>
                <div id="newslist" style="margin-top: 30px;">
                    <div  style="margin-right: 10px;color: #404040;font-size: 16px;line-height: 2;max-width: 982px" id="details">
                         ${news.content}
                    </div>

                    <div  style="float: left;font-family: 宋体;letter-spacing: 10px" id="downfile">
                        <p>附件下载</p>
                    </div>
                    <div  style="float: left" id="file" >
                    </div>

                    <div class="fly-panel detail-box" id="flyReply">
                       <fieldset class="layui-elem-field layui-field-title" style="text-align: center">
                            <h3>留言版</h3>
                        </fieldset>
                        <ul class="jieda" id="baojun"></ul>
                        <ul class="jieda" id="jieda"></ul>

                        <div class="layui-form layui-form-pane" accept-charset="utf-8">
                            <form  class="layui-form" id="main_form">
                                <div class="layui-form-item layui-form-text">
                                    <a name="comment"></a>
                                    <div class="layui-input-block">
                                        <textarea id="comment" name="content" required lay-verify="required" autocomplete="off"
                                                  placeholder="请输入内容" class="layui-textarea fly-editor" maxlength="500"
                                                  style="height: 150px;"></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item" style="text-align: center">
                                    <button class="layui-btn layui-btn-normal" id="subBut" lay-filter="formDemo" lay-submit="submit"  >发表评论</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="clearDiv"></div>
                </div>

                <div class="clearDiv"></div>
            </div>
            <div class="clearDiv"></div>

        </div>
        <div id="chippings" style="width:21%;float:right;">
            <div id="dictionary" style="background-color: #FFFFFF;font-size: 15px">
                <ul>
                    <div style="background-color:#2377cd;color:#FFFFFF;border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">
                        <div style="margin-left: 10px;">
                            <div style="float: left">
                                <img src="${ctxRes}images/11.png" style="width:19px;height: 17px;margin-top: 2px;">
                            </div>
                            <span style="margin-left: 2px;">小博士报</span>
                        </div>

                    </div>
                </ul>
            </div>
            <div style="background-color: #FFFFFF;margin-top: 20px;font-size: 15px">
                <%--<div style="border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">
                    <span style="margin-left: 10px;">专题推荐</span>
                </div>
                <div>
                    <div style="margin: 10px 10px;padding-bottom: 10px;">
                        <div class="layui-carousel" id="test1">
                            <div carousel-item id="photo1">

                            </div>
                        </div>
                        <div style="margin-top: 10px" class="layui-carousel" id="test2">
                            <div carousel-item id="photo2">

                            </div>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
        <div class="clearDiv"></div>
    </div>
    <div class="clearDiv"></div>
</div>
<%@ include file="/web/include/footer.jsp"%>

<script>

    var zhuti=${news.newTypeId};
    if(zhuti==14){
        $("#zhuti").html(">科普天地");
    }else if(zhuti==15){
        $("#zhuti").html(">语文大观园");
    }else if(zhuti==16){
        $("#zhuti").html(">作文乐满地");
    }else if(zhuti==17){
        $("#zhuti").html(">数学小巧手");
    }

   window.onload=function () {
        var text=$("#details").text();
        $("#details").html(htmlspecialchars_decode(text));
       if('${news.orignfrom}'.length>0){
           $("#orignfrom").html('来源：${news.orignfrom}');
       }else{
           $("#orignfrom").hide();
       }
        if('${news.editor}'.length>0){
            $("#editor").html('编辑：${news.editor}');
        }else{
            $("#editor").hide();
        }
       if('${news.author}'.length>0){
           $("#author").html('作者：${news.author}');
       }else{
           $("#author").hide();
       }
    }

    function htmlspecialchars_decode(str) {
        str = str.replace(/&lt;/g, '<');
        str = str.replace(/&gt;/g, '>');
        str = str.replace(/&#40;/g, "(");
        str = str.replace(/&#41;/g, ")");
        str = str.replace(/&#39;/g, "\'");
        return str;
    }
</script>
<script>

    // 分类
    function dictionary(){
        $.ajax({
            type: "get",
            url: "${ctx}appsite/selectList",
            data: {type: 'type_xbsb'},    //视情况将base64的前面字符串data:image/png;base64,删除
            dataType: "json",
            error: function(msg) {
                console.log(msg)
                alert("请检查网络后重试");
            },
            success: function(data) {
                var str = "";
                for (var i=0;i<data.list.length;i++){
                    str += '<ul>'
                        +'<div style="cursor:pointer;color:#2377cd;border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">'
                        +'<div style="margin-left: 10px;">'
                        +'<div style="float: left"></div>'
                        +'<span style="margin-left: 21px;" class="find" detailid="'+data.list[i].value+'">'+data.list[i].name+'</span>'
                        +'</div>'
                        +'</div>'
                        +'</ul>';
                }

                $("#dictionary").append(str);
                detailid_find();
            }
        });
    }
    function detailid_find(){
        $(".find").click(function () {
            window.location.href='${ctx}web/news_xbsb/selectList?pageNum='+1+'&newTypeId='+$(this).attr("detailid");
        })

    }
    //用户提交评论
    layui.use([ 'form' ], function() {
        form = layui.form;
        form.on('submit(formDemo)', function(data) {
            $.ajax({
                type : "POST",
                url : '${ctx}web/news_xbsb/commitcomment.do?topic_type=xbsb',
                data:{id:${news.id},
                    content:$("#comment").val()
                },
                dataType:'json',
                success : function(data) {
                    comment();
                    comment_two();
                    if(data==1){
                        layer.msg('评论成功,审核中！', {
                            offset:['200px,200px'] ,
                            anim: 6
                        });
                    }else if(data==2){
                        layer.msg('评论前先登录！', {
                            offset:['200px,200px'] ,
                            anim: 6
                        });
                    }
                },
                error : function(msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });

            return false;
        })
    });
    function comment(){
        //评论初始化----->已审核的
        $.ajax({
            type : "POST",
            url : "${ctx}web/news_xbsb/comment.do?id=${news.id}&topic_type=xbsb",
            error : function(data) {
                layer.msg('网络异常');
            },

            success : function(data) {
                console.log(data);
                var str = "";

                for(var i=0;i<data.news_comment.length;i++){
                    data.news_comment[i].time=new Date(data.news_comment[i].time).format("yyyy-MM-dd hh:mm:ss");
                    str += '<li style="padding-top: 15px;border-top: 1px dashed #E8E8E8;" data-id="111">\n' +
                        '                        <a name="item-1111111111"></a>\n' +
                        '                        <div class="detail-about detail-about-reply">\n' +
                        '                        <a class="fly-avatar" >\n' +
                        '                        <img src="${ctxUphoto}'+data.news_comment[i].photo+'"\n' +
                        '                    alt=" ">\n' +
                        '                        </a>\n' +
                        '                        <div class="fly-detail-user">\n' +
                        '                        <a  class="fly-link">\n' +
                        '                        <cite>'+data.news_comment[i].name +'</cite>\n' +
                        '                        </a>\n' +
                        '                        </div>\n' +
                        '                        <div class="detail-hits">\n' +
                        '                        <span id="time">'+data.news_comment[i].time+'</span>\n' +
                        '                        </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="detail-body jieda-body photos">\n' +
                        '                        <p id="get">'+data.news_comment[i].content+'</p>\n' +
                        '                        </div>\n' +
                        '                        <div class="jieda-reply">\n' +
                        /*  '                        <span type="reply" class="commentsBtn" comid="'+data.news_comment[i].id+'"><i class="iconfont icon-svgmoban53"></i>回复</span>\n' +*/
                        '                    </div>\n' +
                        '<div class="detail-body jieda-body photos">\n';

                    /*for(var j=0;j<data.news_comment[i].replayList.length;j++){
                        data.news_comment[i].replayList[j].time=new Date(data.news_comment[i].replayList[j].time).format("yyyy-MM-dd hh:mm:ss");
                        str += '<div class="detail-about detail-about-reply" style="margin-left:15px"> <a class="fly-avatar" href=""> <img src="${ctxUphoto}'+data.news_comment[i].replayList[j].photo+'"></a><div class="fly-detail-user"> <a href="" class="fly-link"><cite>'+data.news_comment[i].replayList[j].name +'</cite></a></div> <div class="detail-hits"><span id="time">'+data.news_comment[i].replayList[j].time+'</span></div><p>&nbsp;&nbsp;<span style="color:#01AAED;font-style: italic">@'+data.news_comment[i].replayList[j].username+'</span>&nbsp;&nbsp;'+data.news_comment[i].replayList[j].content+'&nbsp;&nbsp;<span type="reply" class="commentsBtn" comid="'+data.news_comment[i].id +'"><i class="iconfont icon-svgmoban53"></i>&nbsp;&nbsp;回复</span></p></div>';

                    }*/
                    str +='</div></li>';
                }
                $("#jieda").empty();
                $("#jieda").append(str);

                //com_even_bind();
            }
        });
    }

    function comment_two() {
        //评论初始化----->未审核的
        $.ajax({
            type : "POST",
            url : "${ctx}web/news_xbsb/comment_two.do?id=${news.id}&topic_type=xbsb",
            error : function(data) {
                layer.msg('网络异常');
            },
            success : function(data) {
                $("#comment").val("");
                console.log(data);
                var str = "";
                for(var i=0;i<data.length;i++){
                    data[i].time=formatDate_YMD_HMS(data[i].time);
                    str += '<li data-id="111" class="jieda-daan">\n' +
                        '                                <a name="item-1111111111"></a>\n' +
                        '                                <div class="detail-about detail-about-reply">\n' +
                        '                                    <a class="fly-avatar" >\n' +
                        '                                        <img src="${ctxUphoto}'+data[i].photo+'"\n' +
                        '                                             alt=" ">\n' +
                        '                                    </a>\n' +
                        '                                    <div class="fly-detail-user">\n' +
                        '                                        <a  class="fly-link">\n' +
                        '                                            <cite>'+data[i].name+'</cite>\n' +
                        '                                           <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>\n' +
                        '                                            <i class="layui-badge fly-badge-vip">审核中</i>\n' +
                        '                                        </a>\n' +
                        '\n' +
                        '                                    </div>\n' +
                        '                                    <div class="detail-hits">\n' +
                        '                                        <span id="time_two">'+data[i].time+'</span>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                                <div class="detail-body jieda-body photos">\n' +
                        '                                  <p id="get">'+data[i].content+'</p>\n' +
                        '                                </div>\n' +
                        '                                <div class="jieda-reply">\n' +
                        '                                </div>\n' +
                        '                            </li>';

                }
                $('#baojun').empty();
                $("#baojun").append(str);
            }
        });
    }
</script>

<script>
    $(function () {
        //点赞
        $("#like").click(function () {
            //console.log("点赞");
            /* $(this).toggleClass('cs');  */
            $.ajax({
                type : "POST",
                url : "${ctx}web/news_xbsb/insert?id=${news.id}&news_type=xbsb",
                error : function(data) {
                    alert("网络异常 ！");
                },

                success : function(data) {
                    console.log(data);
                    select();
                    if(data==2){
                        layer.msg('请先登录哦，亲！', {
                            offset:['200px,200px'] ,
                            anim: 6
                        });
                    }else if(data !=2){
                        $("#span").html(data.news_xbsb.praise_view);
                    }
                }
            });

        })
        select();
    })

    function select() {
        //查询
        $.ajax({
            type : "POST",
            url : "${ctx}web/praise/select?id=${news.id}&news_type=xbsb",
            error : function(data) {
            },
            success : function(data) {
                console.log(data);
                if(data==1){
                    $("#like").toggleClass('cs');
                    $("#like").text("已赞");
                }else if(data==0){
                    $("#like").toggleClass('cs');
                    $("#like").text("点赞");
                }else if(data==2){

                }

            }
        });
    }
    $(function () {
        dictionary();
        comment();//已审核的
        comment_two();//未审核的
        $("#file").hide();
        $("#downfile").hide();
        //alert('${news.author}'.length);
    })
</script>













</body>
</html>
