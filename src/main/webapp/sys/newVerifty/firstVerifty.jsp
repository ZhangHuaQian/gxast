<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
  <%@ include file="/commViews/head.jsp"%>
  <link rel="stylesheet" href="${ctxRes}css/global.css">
  <meta name="description" content="${news.description}">
  <meta name="keywords" content="HTML,CSS,XML,JavaScript">
  <title>${news.title}</title>

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
<body style="height: 100%;background-color: #f2f5f9">

  <form class="layui-form" id="main_form" method="post" style="padding-top: 50px;max-width: 677px;">
    <div class="layui-form-item">
      <input type="hidden" name="id" value="${news.id}">
      <label class="layui-form-label">作者：</label>
      <div class="layui-input-inline">
        <input type="text" disabled class="layui-input lm-disable-layui-input" value="${news.editor}">
      </div>
      <label class="layui-form-label">投稿日期：</label>
      <div class="layui-input-inline">
        <input type="text" disabled class="layui-input lm-disable-layui-input" value="${createTime}">
      </div>
    </div>
    <div class="layui-form-item">
      <input type="hidden" name="newsType" value="${newsType}">
      <label class="layui-form-label">资讯模块：</label>
      <div class="layui-input-inline">
        <input type="text" disabled class="layui-input lm-disable-layui-input" value="${typename}">
      </div>
      <label class="layui-form-label">资讯类型：</label>
      <div class="layui-input-inline">
        <input type="text" disabled class="layui-input lm-disable-layui-input" value="${newTypeValue}">
      </div>

    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">一审结果：</label>
      <div class="layui-input-block">
        <input type="radio" name="verifty" value="1" title="通过" checked="">
        <input type="radio" name="verifty" value="6" title="退回">
      </div>
    </div>
    <div class="layui-form-item layui-form-text">
      <label class="layui-form-label">一审批注：</label>
      <div class="layui-input-block">
        <textarea name="resultText" id="resultText" placeholder="请输入内容" class="layui-textarea"></textarea>
        <input type="hidden" name="remark" id="remark">
      </div>
    </div>
    <div class="layui-form-item">
      <div class="layui-input-block">
        <button class="layui-btn layui-btn-normal mycss_button_blue" lay-submit="" lay-filter="demo1" id="subBtn">提交处理</button>
      </div>
    </div>
  </form>

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

  <script>
    layui.use('form', function() {
        var form = layui.form;
        form.render();
        form.on('submit(demo1)', function () {
            sendData();
            return false;
        });
        var text=$("#details").text();
        $("#details").html(htmlspecialchars_decode(`${news.content}`));
    });
    function sendData(){
        $("#remark").val($("#resultText").val());
        var fromDate = $('#main_form').serialize();
        console.log(fromDate)
        $.ajax({
            type:'post',
            url:'${ctx }newsVerifty/firstVerifty',
            data:fromDate,
            async:false,
            success:function(result){
                if(result.status==0){
                    layer.msg(result.msg, {icon: 5});
                }else if(result.status==1){
                    layer.msg(result.msg, {icon: 6});
                    closeWindow();
                }else if(result.status==2){
                    layer.msg("发生错误："+result.msg, {icon: 5});
                }

            },
            error:function (msg){
                console.log(msg);
                alert("错误");
            }
        });
    };
    function htmlspecialchars_decode(str) {
        str = str.replace(/&lt;/g, '<');
        str = str.replace(/&gt;/g, '>');
        str = str.replace(/&#40;/g, "(");
        str = str.replace(/&#41;/g, ")");
        str = str.replace(/&#39;/g, "\'");
        return str;
    }
    function closeWindow() {
        if(window.parent.frames["资讯一审"]!=undefined)window.parent.frames["资讯一审"].location.reload();// 刷新父窗口
        setTimeout(function (){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
            //layer.closeAll(); //疯狂模式，关闭所有层
        },1000)
    }
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
    $(function () {

        if('${news.orignfrom}'.length>0){
            $("#orignfrom").html('来源:${fn:replace(news.orignfrom,'|0', '')}');
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

        var text=$("#details").text();
        $("#details").html(htmlspecialchars_decode(`${news.content}`));

        $("#file").hide();
        $("#downfile").hide();
        initContent();
    })
  </script>
</body>
</html>
