<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>layout 后台大布局 - Layui</title>
 <%--<%@ include file="/commViews/head.jsp"%>--%>
  <link type="text/css" rel="stylesheet" href="${ctx }resource/css/demo.css">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/layui.css">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/modules/code.css">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/modules/laydate/default/laydate.css">

  <script src="${ctx }resource/js/jquery-1.11.1.min.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx }resource/plugins/layui2/layui.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx }resource/plugins/layui2/lay/modules/layedit.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctxRes }js/cen.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        .content-a-upload {
            text-align: center;
            position: relative;
            float: left;
            height: 30px;
            width: 100px;
            line-height: 35px;
            color: #FFFFFF;
            background: #EF4F4F !important;
            border-radius: 2px;
            display: inline-block;
        }

        .content-a-upload input {
            position: absolute;
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
  
  <div class="" id="div1">
    <!-- 内容主体区域 -->
    <div style="padding: 10px;">

        <form class="layui-form" id="main_form" accept-charset="utf-8">
            <div class="layui-form-item">
                <label class="layui-form-label">标题</label>
                <div class="layui-input-block">
                    <input type="text" name="title"  required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input" maxlength="40">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">来源</label>
                <div class="layui-input-inline">
                    <input type="text" name="orignfrom" id="orignfrom" placeholder="来源"  autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">编辑</label>
                <div class="layui-input-inline">
                    <input type="text" name="editor" id="editor" placeholder="编辑"  autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">作者</label>
                <div class="layui-input-inline">
                    <input type="text" name="author" id="author" placeholder="作者名"  autocomplete="off" class="layui-input" >
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">专题描述</label>
                <div class="layui-input-block">
                    <input type="text" name="description" maxlength="200" required  lay-verify="required" placeholder="专题描述" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text" style="display: none;">
                <label class="layui-form-label">专题正文</label>
                <div class="layui-input-block">
                    <textarea  placeholder="请输入内容" class="layui-textarea" id="contentTEXT" name="content"></textarea>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">专题内容</label>
                <div class="layui-input-block">
                    <textarea id="demo3" style="display: none;" ></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">专题类型</label>
                <div class="layui-input-block">
                    <select name="ztype" id="type"  lay-verify="required">
                    </select>
                </div>
            </div>

      <div class="layui-form-item">
          <label class="layui-form-label">图片</label>
          <div class="layui-input-inline">
              <input type="hidden" name="img" lay-verify="required"
                     autocomplete="off" class="layui-input" disabled >
          </div>
      </div>
      <div class="layui-form-item" style="display: none;" id="project_Img">
          <ul>
              <li >
                  <img src="" style="margin-left:120px;width: 120px; height:auto;" /></li>
          </ul>
      </div>
        </form>
    </div>
  </div>
  
<script type="text/javascript">


    var layedit;
    //富文本
    var layeditIndex;



    var ztype;
    $(function () {
	initContent();
	initNewsType();

    });

function initContent(){
	$.ajax({
		type:'get',
		url: '${ctx }sys/subject/select?id=${subject.id}',
        dataType: 'json',
        async:false, 
        success: function (result) {
            console.log(result);
            var subject=result.subject;
            $("input[name='title']").val(subject.title);
            $("input[name='description']").val(subject.description);
            $("input[name='editor']").val(subject.editor);
            $("input[name='author']").val(subject.author);
            $("input[name='orignfrom']").val(subject.orignfrom);
            ztype=subject.ztype;
            $("#demo3").html(htmlspecialchars_decode(subject.content));
            $("input[name='img']").val(subject.img);
            $("#project_Img img").attr("src","${ctx}uploadFiles/photo/"+subject.img+"")
            $("#project_Img").show();
            render();
        },
        error: function (msg) {
            console.log(msg);
            alert("系统异常");
        }
	});
}
//初始化资讯类型下拉列表
    function initNewsType(){
	    $.ajax({
		 type: 'get',
         url: '${ctx }sys/dictionary/selectList?type=type_zt',
         dataType: 'json',
        async:false, 
        success: function (result) {
        	if(result.count > 0){
				var list=result.list;
				var select="";
				var data="<option value=''>选择资讯类型</option>";
				for(var i=0;i<list.length;i++){
					if(ztype==list[i].value){
						var select="selected='selected'";
					}else{
						var select="";
					}
					data+="<option value="+list[i].value+" "+select+">"+list[i].name+"</option>";
				}
				}
				$("#type").append(data);
            render();
       },
        error: function (msg) {
            console.log(msg);
            alert("系统异常");
        }
	});
}

    //渲染表单
    function  render(){
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
        layui.use( 'form' , function() {
            var form = layui.form;
            form.render();

        });

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

</body>
</html>