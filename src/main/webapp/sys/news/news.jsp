<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>layout 后台大布局 - Layui</title>
 <%@ include file="/commViews/head.jsp"%>
  <link type="text/css" rel="stylesheet" href="${ctx }resource/css/demo.css">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/layui.css">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/modules/code.css">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/modules/laydate/default/laydate.css">

  <script src="${ctx }resource/js/jquery-1.11.1.min.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx }resource/plugins/layui2/layui.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx }resource/plugins/layui2/lay/modules/layedit.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctxRes }js/cen.js" type="text/javascript" charset="utf-8"></script>
</head>
  
  <div class="" id="div1">
    <!-- 内容主体区域 -->
    <div style="padding: 10px;"> 
    
  <form class="layui-form" id="main_form" accept-charset="utf-8">
  <div class="layui-form-item" >
   	<label class="layui-form-label">标题</label>
   	<div class="layui-input-block">
    	 	<input readonly type="text" name="title"  required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
   	</div>
  </div>
      <div class="layui-form-item">
          <label class="layui-form-label">来源</label>
          <div class="layui-input-inline">
              <input readonly type="text" name="orignfrom" id="orignfrom" placeholder="请输入来源"  autocomplete="off" class="layui-input" >
          </div>
          <label class="layui-form-label">编辑</label>
          <div class="layui-input-inline">
              <input readonly type="text" name="editor" id="editor" placeholder="请输入编辑者"  autocomplete="off" class="layui-input" >
          </div>
          <label class="layui-form-label">作者</label>
          <div class="layui-input-inline">
              <input readonly type="text" name="author" id="author" placeholder="请输入作者名"  autocomplete="off" class="layui-input" >
          </div>
      </div>
  <div class="layui-form-item">
   	<label class="layui-form-label">文章描述</label>
   	<div class="layui-input-block">
    	 	<input readonly type="text"  name="description" required  lay-verify="required" placeholder="文章描述" autocomplete="off" class="layui-input">
   	</div>
  </div>
  <div class="layui-form-item layui-form-text" style="display: none;">
    <label class="layui-form-label">正文</label>
    <div class="layui-input-block">
      <textarea readonly name="content" placeholder="请输入内容" class="layui-textarea" id="contentTEXT" ></textarea>
    </div>
  </div>
  
  <div class="layui-form-item">
    <label class="layui-form-label">正文内容</label>
    <div class="layui-input-block">
	     <textarea id="demo3" style="display: none;" ></textarea>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">资讯类型</label>
    <div class="layui-input-block">
      <select name="newTypeId" id="type"  lay-verify="required">
      </select>
    </div>
  </div>
  <div class="layui-upload" style="width: 853px;float: right">

  <input type="text" id="file" name="file" style="width: 100%;display:none" >


    </div>
  </form>
    </div>
  </div>

<div style="padding: 10px 50px;">
    <div class="page-hd" style="background-color: #00000000">
        <h1 class="page-hd-title" style="border-bottom: 1px solid #f0f0f0;">
        </h1>
        <p class="page-hd-desc"></p>
        <div class="layui-row">
            <div class="layui-btn-group">
                <button type="button" class="layui-btn" id="review" onclick="reviewlist()">审核</button>
                <button type="button" class="layui-btn layui-btn-primary" id="comment" onclick="commentlist()">评论</button>
            </div>
        </div>
    </div>
    <div class="page-bd-15" id="reviewlist" style="background-color: #00000000;">
        <div class="weui_cells_title">审核</div>
        <table class="layui-table" lay-filter="parse-table-demo">
            <thead>
            <tr>
                <th lay-data="{field:'username'}" >序号</th>
                <th lay-data="{field:'joinTime'}">审核时间</th>
                <th lay-data="{field:'sign'}">审核状态</th>
                <th lay-data="{field:'sign'}">审核说明</th>
                <th lay-data="{field:'sign'}">审核人</th>
                <th lay-data="{field:'sign'}">编辑人</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${verify}" var="verify"  varStatus="index">
                <tr>
                    <td>${index.index+1}</td>
                    <td>${verify.create_time}</td>
                    <td>${verify.status}</td>
                    <td>${verify.remark}</td>
                    <td>${verify.receiver}</td>
                    <td>${verify.initiator}</td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
    <div class="page-bd-15" id="commentlist" style="background-color: #00000000;display: none">
        <div class="weui_cells_title">评论</div>
        <ul class="weui-comment">
            <c:forEach items="${commentList}" var="commentList">
                <li class="weui-comment-item" style="padding: 5px 0px;" onclick="Cclick('${commentList.fromUid}','${commentList.name}',${commentList.id})">
                    <div class="userinfo">

                        <span class="userID" style="display: none">${commentList.fromUid}</span>
                        <strong class="nickname">${commentList.name}</strong>
                        <img class="avatar" src="${ctxUphoto}${commentList.photo}">
                    </div>
                    <div class="weui-comment-msg">
                        <span class="status"></span> ${commentList.content}
                    </div>
                    <p class="time"><fmt:formatDate value="${commentList.time}" pattern="yyyy-MM-dd HH:mm:ss"/> </p>
                    <c:set value="${commentList.replayList }" var="replayList"/>
                    <c:forEach items="${commentList.replayList}" var="replayList">
                        <div class="weui-comment-reply">
                            <img class="avatar" src="${ctxUphoto}${replayList.uphoto}" style="margin-top: 8px">
                            <div class="nickname" style="margin-left: 45px;">${replayList.uname}</div>
                            <div class="weui-comment-msg" style="margin-left: 45px;"> ${replayList.content}</div>
                            <p class="time" style="margin-left: 45px;"><fmt:formatDate value="${replayList.time}" pattern="yyyy-MM-dd HH:mm:ss"/> </p>
                        </div>
                    </c:forEach>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>



<script type="text/javascript">

    //查看审核或查看评论
    function reviewlist() {
        $('#reviewlist').css('display','')
        $('#commentlist').css('display','none')

        $("#review").removeClass("layui-btn-primary");
        $("#comment").addClass("layui-btn-primary");
    }
    function commentlist() {
        $('#commentlist').css('display','')
        $('#reviewlist').css('display','none')

        $("#comment").removeClass("layui-btn-primary");
        $("#review").addClass("layui-btn-primary");
    }





    var layedit;
    //富文本
    var layeditIndex;



layui.use('upload', function(){
	  var $ = layui.jquery
	  ,upload = layui.upload;
//多文件列表示例
var filesize = new Map();
		var demoListView = $('#demoList')
		,uploadListIns = upload.render({
		  elem: '#testList'
		  ,url: '${ctx}base/uploadMultiFile'
		  ,accept: 'file'
		  ,multiple: true
		  ,auto: false
		  ,bindAction: '#testListAction'
		  ,choose: function(obj){   
		    var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
		    //读取本地文件
		    obj.preview(function(index, file, result){
		    	filesize.set(index, (file.size/1014).toFixed(1));
		      var tr = $(['<tr id="upload-'+ index +'">'
		        ,'<td>'+ file.name +'</td>'
		        ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
		        ,'<td>等待上传</td>'
		        ,'<td>'
		          ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
		          ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
		        ,'</td>'
		      ,'</tr>'].join(''));
		      
		      //单个重传
		      tr.find('.demo-reload').on('click', function(){
		        obj.upload(index, file);
		      });
		      
		      //删除
		      tr.find('.demo-delete').on('click', function(){
		        delete files[index]; //删除对应的文件
		        tr.remove();
		        uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
		      });
		      
		      demoListView.append(tr);
		    });
		  }
		  ,done: function(res, index, upload){
		    if(res.status == 1){ //上传成功
		      var tr = demoListView.find('tr#upload-'+ index)
		      ,tds = tr.children();
                var filename = (res.fileName).match(/(--!(.+)!--)/);
                console.log(filename);
                if(filename!=null&&filename.length>1){
                    filename = (res.fileName).match(/(--!(.+)!--)/)[2];
                }else {
                    filename = res.fileName;
                }
                console.log(filename);
                tds.eq(0).html(filename);
                tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                tds.eq(3).html('<a href="${ctx }appsite/downLoadFile?fileName='+res.fileName+'&newname='+filename+' target="_blank">下载</a>'); //清空操作
		      if($("#file").val()==null||$("#file").val()=="") {
		        	$("#file").val(res.fileName+"@"+filesize.get(index))
		        }
		        else {
		        	$("#file").val($("#file").val()+","+res.fileName+"@"+filesize.get(index));
		        }
			      return delete this.files[index]; //删除文件队列已经上传成功的文件
			    }
		    this.error(index, upload);
		  }
		  ,error: function(index, upload){
		    var tr = demoListView.find('tr#upload-'+ index)
		    ,tds = tr.children();
		    tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
		    tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
		  }
		});
})

//图片转码
function run(input_file, get_data,insert) {
    /*input_file：文件按钮对象*/
    /*get_data: 转换成功后执行的方法*/
    if (typeof (FileReader) === 'undefined') {
        alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！");
    } else {
        try {
            /*图片转Base64 核心代码*/
            var file = input_file[0];
            //这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件  
            if (!/image\/\w+/.test(file.type)) {
                alert("请确保文件为图像类型");
                return false;
            }
            var reader = new FileReader();
            reader.onload = function () {
                get_data(this.result,insert);
            }
            reader.readAsDataURL(file);
        } catch (e) {
            alert('图片转Base64出错啦！' + e.toString())
        }
    }
}

//图片上传
function uploadImage(img,insert) {   
    $.ajax({
        type: "POST",
        url: "${ctx}uploadImgCommon.do",
        data: {base64Data: img},    //视情况将base64的前面字符串data:image/png;base64,删除
        cache: false,
        dataType: "text",
        success: function(data) {
            insert("${ctx}uploadFiles/photo/"+data+"");
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert("上传失败，请检查网络后重试");
        }
    });

}
var NewsTypeId;
$(function () {
	initContent();
	initNewsType();

});

//关闭当前弹出窗口
function closeWindow() {
    window.parent.frames["新闻中心"].location.reload() ;// 刷新父窗口
    setTimeout(function (){
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
        //layer.closeAll(); //疯狂模式，关闭所有层
    },1000)
}
function initContent(){
	$.ajax({
		type:'get',
		url: '${ctx }sys/news/select?id=${news.id}',
        //data:$('#main_form').serialize(),
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

        	$("#file").val(news.file);
        	if( news.file !=null){
                var files = news.file.split(",");
                var demoListView = $('#demoList');
                if(files[0]!=""){
                    for(var i = 0;i<files.length;i++){
                        var data = files[i].split('@');
                        var filename = (data[0]).match(/&#40;--!(.+)!--&#41;/);
                        if(filename!=null&&filename.length>1){
                            filename = (data[0]).match(/&#40;--!(.+)!--&#41;/)[1];
                        }else {
                            filename = data[0];
                        }
                        var tr = $(['<tr">'
                            ,'<td>'+ filename +'</td>'
                            ,'<td>'+ data[1]+'kb</td>'
                            ,"<td><span style='color:#5FB878'>上传成功</td>"
                            ,'<td>'
                            ,'<a href="${ctx }appsite/downLoadFile?fileName='+data[0]+'&newname='+filename+'" target="_blank">下载</a>'
                            ,'</td>'
                            ,'</tr>'].join(''));
                        demoListView.append(tr);
                    }
                }

            }
            render();
       },
        error: function (msg) {
            alert("系统异常");
        }
	});
}
//初始化资讯类型下拉列表
function initNewsType(){
	$.ajax({
		type: 'get',
        url: '${ctx }sys/dictionary/selectList?type=type_zx',
        //data:$('#main_form').serialize(),
        dataType: 'json',
        async:false, 
        success: function (result) {
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