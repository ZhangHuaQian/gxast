<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>layout 后台大布局 - Layui</title>
<%-- <%@ include file="/commViews/head.jsp"%>--%>
  <link rel="shortcut icon" href="${ctx}favicon.ico" type="image/x-icon">
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
            <input type="hidden" name="img" class="layui-input" id="image"
                   autocomplete="off"  style="display: none"/>
          </div>
          <div class="layui-input-block" style="float: left; margin-left: 0px">
            <a href="" class="content-a-upload" style="height: 36px;"><input
                    type="file" id="projectImgBtn" style="height: 36px; width: 100px" />选择图片</a>
          </div>
        </div>
        <div class="layui-form-item" style="display: none;" id="project_Img">
          <ul>
            <li >
              <img src="" style="margin-left:120px;width: 120px; height:auto;" /></li>
          </ul>
        </div>
        <div class="layui-form-item">
          <div class="layui-input-block">
            <button class="layui-btn layui-btn-warm" lay-submit="" lay-filter="formDemo" id="subBtn">立即提交</button>
          </div>
        </div>
      </form>
    </div>
     
  </div>
  
<script type="text/javascript">

    var layedit;
    //富文本
    var layeditIndex;

   function run1(input_file, get_data) {
       /*input_file：文件按钮对象*/
       /*get_data: 转换成功后执行的方法*/
       if (typeof (FileReader) === 'undefined') {
           layer.alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！",{icon: 5});
           //alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！");
       } else {
           try {
               /*图片转Base64 核心代码*/
               var file = input_file.files[0];
               //这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件
               if (!/image\/\w+/.test(file.type)) {
                   layer.alert("请确保文件为图像类型",{icon: 5});
                   return false;
               }
               var reader = new FileReader();
               reader.onload = function () {
                   get_data(this.result);
               }
               reader.readAsDataURL(file);
           } catch (e) {
               layer.alert('图片转Base64出错啦！' + e.toString(),{icon: 5});
           }
       }
   }


   //图片上传
   function uploadImage1(img) {
       //判断是否有选择上传文件
       var imgPath = $("#projectImgBtn").val();
       if (imgPath == "") {
           layer.alert('请选择上传图片！',{icon: 5});
           return;
       }
       //判断上传文件的后缀名
       var strExtension = imgPath.substr(imgPath.lastIndexOf('.') + 1);
       if (strExtension != 'jpg' && strExtension != 'gif'
           && strExtension != 'png' && strExtension != 'bmp'&&strExtension != 'jpeg') {
           layer.alert("这不是图片文件!",{icon: 5});
           return;
       }
       $.ajax({
           type: "POST",
           url: "${ctx}base/uploadImgCommon.do",
           data: {base64Data: img,width:260,height:260},    //视情况将base64的前面字符串data:image/png;base64,删除
           cache: false,
           dataType: "text",
           success: function(data) {
               console.log(data);
               //$("#pic_img").attr("src",img).show()
               $("#project_Img img").attr("src",img)
               if($("#project_Img img")[0].src !=null && $("#project_Img img")[0].src != ''){
                   $("#project_Img").show();
               }else{
                   $("#project_Img").hide();
               }
               $("#recordCertificate").val(data);
               $("#image").val(data.replace("uploadFiles/photo/",""));
               layer.msg('图片上传成功',{icon: 6});
           },
           error: function(XMLHttpRequest, textStatus, errorThrown) {
               //hui.closeLoading();
               console.log(XMLHttpRequest);
               console.log(textStatus);
               console.log(errorThrown);
               layer.msg('请检查网络后重试',{icon: 5});
           }
       });
   }
   //图片上传
   $('#projectImgBtn').change(function(){
       run1(this, function (data) {
           uploadImage1(data);
       });
   });


//关闭当前弹出窗口
  function closeWindow() {
	  if($(window.parent.frames["专题列表"]).length>0){
		 window.parent.frames["专题列表"].location.reload() ;// 刷新父窗口
		  setTimeout(function (){
		        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		        parent.layer.close(index); //再执行关闭
		        //layer.closeAll(); //疯狂模式，关闭所有层
		    },1000)
	 }
  }
    var ztype;
    $(function () {
        initContent();
        initNewsType();

    });

  function initContent(){
      $.ajax({
          type:'get',
          url: '${ctx }sys/subject/select?id=${param.id}',
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

    function sendData(){
        $('#contentTEXT').text(layedit.getContent(layeditIndex));
        $.ajax({
            type : 'post',
            url : '${ctx }sys/subject/update?id=${param.id}',
            data : $('#main_form').serialize(),
            dataType : 'json',
            success : function(result) {
                if (result.status == 1) {
                    closeWindow();
                    layer.msg(result.msg);
                } else if (result.status == 0) {
                    layer.msg(result.msg);
                }
            },
            error : function(msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }


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
        layui.use([ 'form' ], function() {
            var form = layui.form;
            form.render();
            form.on('submit(formDemo)', function(data) {
                sendData();
                closeWindow();
                return false;
            })

        });

    }



</script>
<script>
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