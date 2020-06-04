<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title></title>
  <%@ include file="/commViews/head.jsp"%>
  <style type="text/css">
    .content-a-upload {
      text-align: center;
      position: relative;
      float: left;
      height: 30px;
      width: 100px;
      line-height: 35px;
      color: #FFFFFF;
      background: #1E9FFF !important;
      border-radius: 2px;
      display: inline-block;
    }
    .layui-upload-img {
      width: 90px;
      height: 90px;
      padding: 4px
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
      background: #1E9FFF !important;
      border-color: #ccc;
      text-decoration: none
    }

    .layui-upload-img {
      width: 90px;
      height: 90px;
      padding: 4px
    }
  </style>
  <script type="text/javascript">
      function showDiv() {
          if($("#video").val()!="" ){
              document.getElementById('popDiv').style.display = 'block';
              document.getElementById('bg').style.display = 'block';
          }
      }
      function closeDiv() {
          document.getElementById('popDiv').style.display = 'none';

      }
  </script>
</head>
<div id="bg"
     style="display: none; background-color: #ccc; width: 100%; position: absolute; height: 100%; opacity: 0.5; z-index: 1;">
</div>
  <div class="" id="div1">
    <!-- 内容主体区域 -->
    <div style="padding: 10px;"> 
    
  <form class="layui-form" id="main_form" method="post" enctype="multipart/form-data">
  <div class="layui-form-item" >
   	<label class="layui-form-label"><span class="x-red"> * </span>标题</label>
   	<div class="layui-input-block">
    	 	<input type="text" name="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
   	</div>
  </div>
    <div class="layui-form-item">
      <label class="layui-form-label"><span class="x-red"> </span>来源</label>
      <div class="layui-input-inline">
        <input type="text" name="orignfrom" id="orignfrom" required  lay-verify="required" placeholder="请输入来源"  autocomplete="off" class="layui-input" >
      </div>

      <label class="layui-form-label"><span class="x-red">  </span>作者</label>
      <div class="layui-input-inline">
        <input type="text" name="author" id="author" required  lay-verify="required" placeholder="请输入作者名"  autocomplete="off" class="layui-input" >
      </div>
    </div>
    <div class="layui-form-item">
    <label class="layui-form-label"><span class="x-red"> * </span>编辑</label>
    <div class="layui-input-inline">
      <input type="text" name="editor" required  lay-verify="required"  id="editor" placeholder="请输入编辑者"  autocomplete="off" class="layui-input" >
    </div>
    </div>
  <div class="layui-form-item">
   	<label class="layui-form-label">文章描述</label>
   	<div class="layui-input-block">
    	 	<input type="text"  name="description"  placeholder="文章描述" autocomplete="off" class="layui-input">
   	</div>
  </div>
  <div class="layui-form-item layui-form-text" style="display: none;">
    <label class="layui-form-label">正文</label>
    <div class="layui-input-block">
      <textarea  placeholder="请输入内容" class="layui-textarea" id="contentTEXT" name="content"></textarea>
    </div>
  </div>
  
  <div class="layui-form-item">
    <label class="layui-form-label"><span class="x-red"> * </span>正文内容</label>
    <div class="layui-input-block" id="zwnr">
	     <textarea id="demo3" style="display: none;"></textarea>
    </div>
  </div>

    <div class="layui-form-item">
      <label class="layui-form-label">视频文件</label>
      <div class="layui-input-inline"
           style="margin-right: 0px; width: 60%">
        <input type="hidden" id="video" class="layui-input" name="nfile"
               placeholder="视频路径" style="display: none;"
               autocomplete="off" />
      </div>

      <div class="layui-input-block" style="float: left; margin-left: 0px">
        <a href="" class="content-a-upload" style="height: 36px;"><input type="file" id="videoBtn" name="files"
                                                                         style="height: 36px; width: 100px" />选择视频</a>

      </div>

    </div>
    <div class="layui-form-item">
      <div class="layui-col-md5">
        <div class="layui-card">
          <div id="videoshow"
               style="top: 20px; width: 500px; height: 285px;display: none;margin-left:110px;">
            <video src="" preload="preload" controls="controls"
                   style="background-color: #000000; width: 100%; height: 100%;">
              您的浏览器不支持播放该视频！
            </video>
          </div>
        </div>
      </div>
    </div>

  <div class="layui-form-item">
    <label class="layui-form-label"><span class="x-red"> * </span>资讯类型</label>
    <div class="layui-input-block">
      <select name="newTypeId" id="type"  lay-verify="required">
      </select>
    </div>
  </div>

    <div class="layui-form-item">
      <label class="layui-form-label">封面图片 </label>
      <button type="button" class="layui-btn layui-btn-normal" id="test2">多图片上传</button>
      <button type="button" class="layui-btn layui-btn-normal" id="getImg">提取文章图片</button>
    </div>
    <div class="layui-upload">
      <blockquote class="layui-elem-quote layui-quote-nm"
                  style="margin-top: 10px;margin-left: 30px">
        预览图：
        <div class="layui-upload-list" id="demo2" style="display: flex;">
        </div>
      </blockquote>
    </div>
    <%--      内容图片隐藏域--%>
    <input type="hidden" name="imgs" value="">


  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn layui-btn-warm" lay-submit="" lay-filter="formDemo" id="subBtn">立即提交</button>
    </div>
  </div>

    <div id="popDiv"
         style="display:none; padding-left: 120px;z-index:1000; position: absolute; width: 80%;">
      <div class="layui-progress layui-progress-big" lay-showpercent="true"
           lay-filter="demo"
           style="width: 100%;">
        <div class="layui-progress-bar" lay-percent="0%"></div>
      </div>
    </div>
	</form>
    </div>
     
  </div>
  
<script type="text/javascript">

    var array1;
    var content_img=[]
    var imgnum = 0
 var layedit;
  //富文本
  var layeditIndex;

    var NewsTypeId;
    $(function () {
      initContent();
      initNewsType();
    });


  $("#video").click(function () {
      $("#video").blur();
      $('#videoBtn').click();
  });



  $('#videoBtn').change(function(){
      var file = this.files[0];
      console.log(file);
      if(file.type=="video/mp4"){
          if(file.size>=524288000){
              layer.msg('请上传小于500M大小的视频',{icon: 5});
              file = null;
              this.files = null;
              return;
          }
          var url = URL.createObjectURL(file);
          $("#videoshow video").attr("src",url);
          $("#videoshow").show();
          //layer.msg('获取安全路径成功',{icon: 6});
          console.log($('#videoBtn').val().toString());
          $("#video").val(file.name);
          return;
      }else {
          layer.msg('请转换为h264编码的mp4格式',{icon: 5});
          file = null;
          this.files = null;
          return;
      }

  });

//关闭当前弹出窗口
function closeWindow() {
	if($(window.parent.frames["资讯管理"]).length>0){
		window.parent.frames["资讯管理"].location.reload() ;// 刷新父窗口
		 setTimeout(function (){
		        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		        parent.layer.close(index); //再执行关闭
		        //layer.closeAll(); //疯狂模式，关闭所有层
		    },1000)
	}
}



function initContent(){
	$.ajax({
		type:'get',
		url: '${ctx }sys/news/select?id=${news.id}',
        dataType: 'json',
        async:false, 
        success: function (data) {
            console.log(data);
            var news=data.news;

            $("input[name='title']").val(news.title);
            $("input[name='orignfrom']").val(news.orignfrom);
            $("input[name='editor']").val(news.editor);
            $("input[name='author']").val(news.author);
            $("input[name='description']").val(news.description);
            NewsTypeId=news.newTypeId;
            $("#demo3").html(htmlspecialchars_decode(news.content));
            if(news.imgs !=null &&news.imgs !=''){
                $("input[name='imgs']").val(news.imgs);
                if (!(news.imgs.split(",").length == 1 && news.imgs.split(",")[0] == "")) {
                    array1 = news.imgs.split(",");
                    for (var i = 0; i < array1.length; i++) {
                        $('#demo2').append('<div style="position: relative">' +
                                '<img onclick="toCropper(this)" src="'+ array1[i] +'" class="layui-upload-img content-img"><i onclick="deleteImg(this)" class="layui-icon layui-icon-close-fill" style="position: absolute;left: 73px;top: 4px;font-size: 20px;color: red"></i></div>');
                      content_img.push(array1[i])
                    }
                }
            }


            $("input[name='nfile']").val(news.nfile);
            if(news.nfile !=null &&news.nfile !=''){
                $("#videoshow video").attr("src","${ctx}uploadFiles/video/"+news.nfile+"")

                $("#videoshow").show();
            }else{
                $("#videoshow video").attr("src",'')

                $("#videoshow").hide();
            }

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
        url: '${ctx }sys/dictionary/selectList?type=type_dzkp',
        //data:$('#main_form').serialize(),
        dataType: 'json',
        async:false, 
        success: function (result) {
            console.log(result);
        	if(result.count > 0){
				var list=result.list;
                var select="";
                var data="<option value=''>选择资讯类型</option>";
				for(var i=0;i<list.length;i++){
                    if(NewsTypeId==list[i].value){
                        var select="selected='selected'";
                    }else{
                        var select="";
                    }
                    data+="<option value="+list[i].value+" "+select+">"+list[i].name+"</option>";
                }
				}else{
					
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
    var active;
    var form;

  function sendData(){
      $('#contentTEXT').text(layedit.getContent(layeditIndex));
      var formDate = new FormData($('#main_form')[0]);
      $.ajax({
          type : 'post',
          url : '${ctx }sys/news/update?id=${news.id}',
          data : formDate,
          processData: false,
          contentType: false,
          cache:false,
          xhr: function(){
              myXhr = $.ajaxSettings.xhr();
              if(myXhr.upload){
                  myXhr.upload.addEventListener('progress',function(e) {
                      if (e.lengthComputable) {
                          var percent = Math.floor(e.loaded/e.total*100);
                          console.log(percent);
                          if(percent <=100){
                              console.log(percent);
                              setTimeout(active.loading(percent),1000);
                          }
                          if(percent >= 100){
                              active.saving();
                          }
                      }
                  }, false);
              }
              return myXhr;
          },
          success : function(result) {
              active.ending();

              if (result.status == 1) {
                  layer.msg(result.msg);

              } else if (result.status == 0) {

                  layer.msg(result.msg);
              }
          },
          error : function(msg) {
              active.ending();
              console.log(msg);
              alert("系统异常");
          }
      });
  }

    //轮播图清空
    $("#remove").click(function() {
      imgsrc=[];
      content_img=[]
      $('input:hidden[name="imgs"]').val("")
    });


    var imgsrc =[]
    layui.use('upload', function () {
      var $ = layui.jquery, upload = layui.upload;
      //多图片上传
      upload.render({
        type: "POST",
        elem: '#test2',
        url: '${ctx}base/uploadfile',
        multiple: true,
        number: 5,
        choose: function (obj) {
          obj.preview(function (index, file, result) {
            if ($("#demo2").find("img").size() >= 5 || imgsrc.length+content_img.length>=5) {
              layer.msg('不能超过5张', {icon: 5});
              return false;
            }
            $('#demo2').append('<div style="position: relative"><img onclick="toCropper(this)" lay-src="' + result + '" alt="' + file.name + '" class="layui-upload-img uploadImg" index="' + index + '">' +
                    '<i onclick="deleteImg(this)" class="layui-icon layui-icon-close-fill" style="position: absolute;left: 73px;top: 4px;font-size: 20px;color: red;"></i></div>');
          });
        },
        allDone: function (obj) { //当文件全部被提交后，才触发
          // console.log(obj.total); //得到总文件数
          // console.log(obj.successful); //请求成功的文件数
          // console.log(obj.aborted); //请求失败的文件数
        },
        before: function (obj) {
          // obj.preview(function (index, file, result) {
          //   var li = 'img[src="' + result + '"]'
          //   if ($('#demo2').find(li).length <= 0) {
          //     delete files[index]
          //   }
          // });
          imgsrc=[];
          if (isNaN($('#demo2').find('img').length)) {
            imgnum = $('#demo2').find('img').length
          }
        },
        done: function (res, index, upload) {
          var img = 'img[index='+index+']'
          $('#demo2').find(img).attr('imgsrc', res.data.src)
          if (imgnum<5){
            imgsrc.push(res.data.src)
            imgnum++
          }else {
            return
          }
        }
      });
    });



  function  render(){

      //富文本上传图片，视频
      layui.use('layedit', function(){
          layedit = layui.layedit;
          layeditIndex = layedit.build('demo3', {
              height: 600,
              uploadImage: {
                  url: '${ctx}base/uploadGif'
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
      layui.use([ 'form','layer','element','flow' ], function() {
          form = layui.form;
          var layer=layui.layer;
           var element = layui.element;
          form.render();
          active = {
              loading: function(n){
                  console.log(n);
                  //模拟loading
                  if(n<=100){
                      showDiv();
                      element.progress('demo', n+'%');
                  }
                  if(n>=100){
                      n = 100;
                  }
              },
              saving:function () {

              },
              ending:function () {
                  layer.closeAll('loading'); //关闭加载层
              }
          };
          form.on('submit(formDemo)',function() {
              sendData();
              closeWindow();
              return false;
          });

        //图片懒加载
        var flow = layui.flow;
        flow.lazyimg();

      });
  }


    var imgcount=0;
    //提取文章其中5张图片
    $("#getImg").click(function () {
      if (layedit.getContent(layeditIndex) != null || layedit.getContent(layeditIndex) != "" || layedit.getContent(layeditIndex) != undefined) {
        try {
          var inside = $(layedit.getContent(layeditIndex)).filter('img')
          var outside = $(layedit.getContent(layeditIndex)).find('img')
        }catch (e) {
          layer.msg('文字与图片请先分行再获取', {icon: 5});
        }
        imgcount = outside.length + inside.length
        content_img = []
        if (inside.length>0) {
          for (let i = 0; i < inside.length; i++) {
            if ($('#demo2').find('img').length == 5) {
              break;
            }
            content_img.push(inside.eq(i).attr("src"))
            var li = 'img[src="' + inside.eq(i).attr("src") + '"]'
            $('#demo2').find(li).parent().remove()
            $('#demo2').append('<div style="position: relative"><img onclick="toCropper(this)" src="' + inside.eq(i).attr("src") + '" alt="" class="layui-upload-img content-img">' +
                    '<i onclick="deleteImg(this)" class="layui-icon layui-icon-close-fill" style="position: absolute;left: 73px;top: 4px;font-size: 20px;color: red"></i></div>');
          }
        }
        if (outside.length>0){
          for (let i = 0; i < outside.length; i++) {
            if ($('#demo2').find('img').length == 5) {
              break;
            }
            content_img.push(outside.eq(i).attr("src"))
            var li = 'img[src="' + outside.eq(i).attr("src") + '"]'
            $('#demo2').find(li).parent().remove()
            $('#demo2').append('<div style="position: relative"><img onclick="toCropper(this)" src="' + outside.eq(i).attr("src") + '" alt="" class="layui-upload-img content-img">' +
                    '<i onclick="deleteImg(this)" class="layui-icon layui-icon-close-fill" style="position: absolute;left: 73px;top: 4px;font-size: 20px;color: red"></i></div>');
          }
        }
      }
    })

    //清除指定上传图片
    function deleteImg(e) {
      if ($(e).prev().hasClass('uploadImg')) {
        var src = $(e).prev().attr('imgsrc');
        for (var i = 0; i <imgsrc.length ; i++) {
          if (imgsrc[i]===src) {
            imgsrc.splice(i,1)
            break
          }
        }
      }else if ($(e).prev().hasClass('content-img')) {
        var src = $(e).prev().attr('src');
        for (var i = 0; i <content_img.length ; i++) {
          if (content_img[i]===src) {
            content_img.splice(i,1)
            break
          }
        }
      }else {
        return
      }
      $(e).parent().remove()
    }

    //鼠标在提交按钮上时
    $("#subBtn").mouseenter(function(){
      $('input:hidden[name="imgs"]').val(content_img.concat(imgsrc))
    });


    //裁剪图片
    function toCropper(e) {
      var src = $(e).attr('src');
      if($(e).hasClass('uploadImg')){
        src = $(e).attr('imgsrc');
      }
      layui.layer.open({
        type: 2,
        area: ['600px', '700px'],
        title: '裁剪图片',
        closeBtn: 1,
        shadeClose: false,
        resize: true,
        content: '${ctx}sys/news/cropper.jsp',
        success: function (layero, index) {
          var iframe = window['layui-layer-iframe' + index]
          iframe.setSrc(src)
        },
        end: function () {

        }
      });
    }


    function getImgSrc(imgFromChild,oldImgsrc){
      if (content_img.indexOf(oldImgsrc)>=0) {
        var num = content_img.indexOf(oldImgsrc)
        content_img.splice(num,1,imgFromChild)
      }else if (imgsrc.indexOf(oldImgsrc)>=0){
        var num = imgsrc.indexOf(oldImgsrc)
        imgsrc.splice(num,1,imgFromChild)
      }
      var img1 = "img[src='"+oldImgsrc+"']"
      var img2 = "img[imgsrc='"+oldImgsrc+"']"
      $('#demo2').find(img1).attr('src',imgFromChild)
      $('#demo2').find(img2).attr('src',imgFromChild)
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

    //数组去重
    function distinct(arr) {
      let result = []
      let obj = {}

      for (let i of arr) {
        if (!obj[i]) {
          result.push(i)
          obj[i] = 1
        }
      }

      return result
    }
</script>
</body>
</html>