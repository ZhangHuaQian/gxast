<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>layout 后台大布局 - Layui</title>
 <%@ include file="/commViews/head.jsp"%>

</head>
  
  <div class="" id="div1">
    <!-- 内容主体区域 -->
    <div style="padding: 10px;">
    
  <form class="layui-form" id="main_form" accept-charset="utf-8">
  <div class="layui-form-item" >
   	<label class="layui-form-label">标题</label>
   	<div class="layui-input-block">
    	 	<input type="text" name="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
   	</div>
  </div>
    <div class="layui-form-item" >
      <label class="layui-form-label">创建日期</label>
      <div class="layui-input-block">
        <input type="text" name="createTime" id="createTime"  placeholder="请输入日期" autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-form-item layui-form-text" style="display: none;">
    <label class="layui-form-label">正文</label>
    <div class="layui-input-block">
      <textarea  placeholder="请输入内容" class="layui-textarea" id="contentTEXT" name="content"></textarea>
    </div>
  </div>
  
  <div class="layui-form-item">
    <label class="layui-form-label">正文内容</label>
    <div class="layui-input-block">
	     <textarea id="demo3" style="display: none;"></textarea>
    </div>
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

    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //常规用法
        laydate.render({
            elem: '#createTime'
        })

    });

  var layedit;
  //富文本
  var layeditIndex;

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
//关闭当前弹出窗口
function closeWindow() {
	if($(window.parent.frames["新闻中心"]).length>0){
		window.parent.frames["新闻中心"].location.reload() ;// 刷新父窗口
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
		url: '${ctx }sys/zxjj/select?id=1',
        dataType: 'json',
        async:false, 
        success: function (result) {
            console.log(result);
            var zxjj=result.zxjj;
            zxjj.createTime=formatDate_YMD_HMS(zxjj.createTime);
            $("input[name='title']").val(zxjj.title);
            $("input[name='createTime']").val(zxjj.createTime);
            $("#demo3").html(htmlspecialchars_decode(zxjj.content));
            // console.log(htmlspecialchars_decode(zxjj.content));
            // console.log($("#demo3").html())


        	
       },
        error: function (msg) {
            console.log(msg);
            alert("系统异常");
        }
	});
}


    function formatDate_YMD_HMS(timestamp) {
        var curTime = new Date(timestamp).format("yyyy-MM-dd");
        return curTime;
    }

  $(function () {
      initContent();
  });

  layui.use([ 'form' ], function() {
      form = layui.form;
      form.on('submit(formDemo)', function(data) {
          $('#contentTEXT').text(layedit.getContent(layeditIndex))
          $.ajax({
              type : 'post',
              url : '${ctx }sys/zxjj/update?id=1',
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
          return false;
      })
  });


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