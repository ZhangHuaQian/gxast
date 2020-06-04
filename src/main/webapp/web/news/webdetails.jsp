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
    </style>
</head>
<body style="background-color: #f2f5f9">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->

    <div id="newslistdiv" style="width:70%;min-width:1302px;margin: 10px auto;">
        <div id="newslist_div" style="width:77%;float: left;background-color: #ffffff">
            <div id="newslist_area" style="margin-left: 30px;margin-right: 30px;">
                <div id="newstitle" style="margin-top: 30px;text-align: center;">
                    <h1>${news.title}</h1>
                    <h3 style="margin-top: 10px;color: #393d49;font-size:10px">
                        <fmt:formatDate value="${news.createTime}" pattern="yyyy年MM月dd日 "/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="orignfrom"></span>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="editor"></span>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="author"></span>
                    </h3>
                </div>
                <div id="newslist" style="margin-top: 30px;">
                    <div  style="margin-right: 10px;color: #404040;font-size: 16px;line-height: 2;max-width: 982px" id="details">

                    </div>
                    <div  style="float: left;font-family: 宋体;letter-spacing: 10px" id="downfile">
                        <p>附件下载</p>
                    </div>
                    <div  style="float: left" id="file" >
                    </div>

                    <div class="clearDiv"></div>
                </div>
                <div class="clearDiv"></div>
            </div>
            <div class="clearDiv"></div>
        </div>

    </div>
    <div class="clearDiv"></div>
</div>

<script>
   window.onload=function () {

       if('${news.orignfrom}'.length>0){
           $("#orignfrom").html('来源:${news.orignfrom}');
       }else{
           $("#orignfrom").hide();
       }
       if('${news.editor}'.length>0){
           $("#editor").html('编辑:${news.editor}');
       }else{
           $("#editor").hide();
       }
       if('${news.author}'.length>0){
           $("#author").html('作者:${news.author}');
       }else{
           $("#author").hide();
       }

   $(function () {
       var text=$("#details").text();
       $("#details").html(htmlspecialchars_decode(`${news.content}`));
   })

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
    $(function () {
        $("#file").hide();
        $("#downfile").hide();
        //initContent();
    })


    function initContent(){
        var files = "${news.file}".split(",");
        var demoListView = $('#file');
        if(files[0]!=""){
            $("#file").show();
            $("#downfile").show();
            for(var i = 0;i<files.length;i++){
                        var data = files[i].split('@');
                var filename = (data[0]).match(/&#40;--!(.+)!--&#41;/);
                if(filename!=null&&filename.length>1){
                    filename = (data[0]).match(/&#40;--!(.+)!--&#41;/)[1];
                }else {
                    filename = data[0];
                }
                var tr ='<p>'+data[0]+'<a href="${ctx}appsite/downloadFile?fileName='+data[0]+'&newname='+filename+'" target="_blank" >&nbsp&nbsp下载</a></p>';

              demoListView.append(tr);
            }
        }
    }

</script>


</body>
</html>
