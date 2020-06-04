<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑产品信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <%@ include file="/commViews/head.jsp" %>
    <link rel="stylesheet" href="${ctx }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
    <script src="${ctx }resource/plugins/wangEditor-3.1.1/release/wangEditor.min.js" type="text/javascript" charset="utf-8"></script>
     <style type="text/css">

          .content-a-upload {
              text-align: center;
              position: relative;
              /*padding:  4px 5px;*/
              float: left;
              height: 30px;
              width: 100px;
              line-height:35px;
              /*font: 400 16px/60px "宋体";*/
              /*cursor: pointer;*/
              color: #FFFFFF;
              background: #EF4F4F !important;
              /*border: 1px solid #ddd;*/
              border-radius: 2px;
              /*overflow: hidden;*/
              display: inline-block;
              /*text-decoration: none;*/
          }
          .content-a-upload input {
              position: absolute;
              /*font-size: 16px;*/
              /*height: 77px;*/
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
<body>
	<div id="bg"
		style="display: none; background-color: #ccc; width: 100%; position: absolute; height: 100%; opacity: 0.5; z-index: 1;">
	</div>
<!-- 菜单添加 -->
<form class="layui-form " id="main_form" method="post" enctype="multipart/form-data">

    <div style="float: left;padding: 10px;width:98%">

           <div class="layui-form-item">
				<label class="layui-form-label">标题</label>
				<div class="layui-input-block">
					<input type="text" name="title"
						required lay-verify="required" placeholder="文章标题"
						autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">描述</label>
				<div class="layui-input-block">
					<input type="text" name="descript"
						required lay-verify="required" placeholder="文章描述"
						autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item layui-form-text" style="display: none;">
				<label class="layui-form-label">正文</label>
				<div class="layui-input-block">
						<textarea name="content" placeholder="请输入内容"
								  class="layui-textarea" id="contentTEXT"></textarea>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">正文内容</label>
				<div class="layui-input-block">
					<div id="editor"></div>
			</div>
			<br>
            <div class="layui-form-item">
				<label class="layui-form-label">视频文件</label>
				<div class="layui-input-inline"
					style="margin-right: 0px; width: 60%">
					<input type="text" id="video" class="layui-input" name="video"
						placeholder="视频路径" autocomplete="off" style="display: none;"/>
				</div>

				<div class="layui-input-block" style="float: left; margin-left: 0px">
					<a href="" class="content-a-upload" style="height: 36px;"><input
						type="file" id="projectImgBtn" name="file"
						style="height: 36px; width: 100px" />选择视频</a>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-col-md5">
					<div class="layui-card">
						<div id="videoshow"
							style="top: 20px; width: 500px; height: 285px; display: none; margin-left:110px;">
							<video src="" preload="preload" controls="controls"
								style="background-color: #000000; width: 100%; height: 100%;">
								您的浏览器不支持播放该视频！
							</video>
						</div>
					</div>
				</div>
			</div>

		</div>

		<div class="layui-form-item" style="margin-bottom:4px ">
			<label class="layui-form-label">产品类型</label>
			<div class="layui-input-block">
				<select name="typeValue" id="type" lay-search="" lay-verify="required">
				</select>
			</div>
		</div>
<div id="popDiv"
		style="display:none;padding-left: 110px;z-index:1000; position: absolute; width: 70%;">
		<div class="layui-progress layui-progress-big" lay-showpercent="true"
			lay-filter="demo"
			style="width: 100%;">
			<div class="layui-progress-bar" lay-percent="0%"></div>
		</div>
	</div>
			<div class="layui-form-item" style="margin-top: 25px">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-warm" lay-submit lay-filter="formDemo">更新信息</button>
                <!-- <button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
            </div>
        </div>
    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>

	var videourl="";
	
	function showDiv() {
		if($("#video").val()!="" && $("#video").val()!=videourl){
		document.getElementById('popDiv').style.display = 'block';
		document.getElementById('bg').style.display = 'block';
		}
	}
	function closeDiv() {
		document.getElementById('popDiv').style.display = 'none';
		//document.getElementById('bg').style.display='none';
	}

    //刷新父窗口
    function reloadParentWin() {
        if(window.parent.frames["灾害防御列表"]!=undefined)window.parent.frames["灾害防御列表"].location.reload();// 刷新父窗口
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
        // layer.closeAll(); //疯狂模式，关闭所有层
    }
    
  //编辑框
	var E = window.wangEditor
	var editor = new E('#editor');
	editor.customConfig.uploadImgServer = '${ctx}base/uploadImgCommon.do';
	editor.customConfig.customUploadImg = function (files, insert) {
	    // files 是 input 中选中的文件列表
	    // insert 是获取图片 url 后，插入到编辑器的方法
		run(files, uploadImage,insert);
	}
	editor.create();
	$(".w-e-text-container").css("z-index",""); //解决编辑器下下拉不能选择问题  

	//编辑框图片转码
	function run(input_file,get_data,insert){
		/*input_file：文件按钮对象*/
        /*get_data: 转换成功后执行的方法*/
		if (typeof (FileReader) === 'undefined') {
            layer.alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！",{icon: 5});
        } else {
            try {
                /*图片转Base64 核心代码*/
                var file = input_file[0];
                //这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件
                if (!/image\/\w+/.test(file.type)) {
                    layer.alert("请确保文件为图像类型",{icon: 5});
                    return false;
                }
                var reader = new FileReader();
                reader.onload = function () {
                    get_data(this.result,insert);
                }
                reader.readAsDataURL(file);
            } catch (e) {
                //hui.closeLoading();
                layer.alert('图片转Base64出错啦！' + e.toString(),{icon: 5});
            }
        }
	}
	//编辑框图片上传 
	function uploadImage(img,insert) {
	    $.ajax({
	        type: "POST",
	        url: "${ctx}base/uploadImgCommon.do",
	        data: {base64Data: img},    //视情况将base64的前面字符串data:image/png;base64,删除
	        dataType: "text",
	        cache: false,
	        success: function(data) {
	            insert("${ctx}uploadFiles/photo/"+data+"");
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown) {
	            alert("上传失败，请检查网络后重试");
	        }
	    });
	}
    
	var Types='';
	var videoUrl='';
    $(function () {
    	initDisasters();
    	getType();
    });
    
    //初始化用户信息
     function initDisasters() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/disasters/select?id=${param.id}',
            dataType: 'json',
            async : false,
            success: function (result) {
            	
            	console.log(result);
                var disasters = result.disasters;
                var video = disasters.video;
                Types = disasters.typeValue;
                videoUrl = video;
                videourl = video;
              
                console.log(videoUrl);
                $("input[name='title']").val(disasters.title);
                $("input[name='descript']").val(disasters.descript);
                $("input[name='video']").val(video);
                if(video != null && video !=''){
                	$("#videoshow video").attr("src",'${ctx}uploadFiles/video/'+video);
                    $("#videoshow").show();
                }else{
                	$("#videoshow video").attr("src",'');
                	$("#videoshow").hide();
                }
                var content = htmlspecialchars_decode(disasters.content);
                editor.txt.html(content);
            },
            error: function (msg) {
                console.log(msg);
                alert("初始化异常");
            }
        });
    } 
    
  //获取产品类型
	function getType() {
		$.ajax({
			type : 'get',
			url : '${ctx }sys/dictionary/selectList?type=type_zhfy',
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result.count > 0) {
					var list = result.list;
					var select="";
					var data = "<option value=''>选择类型</option>";
					for (var i = 0; i < list.length; i++) {
						if(Types==list[i].value){
							 select="selected='selected'";
						}else{
							 select="";
						}
						data+="<option value="+list[i].value+" "+select+">"+list[i].name+"</option>";
					}
				} else {
				}
				$("#type").append(data);
			},
			error : function(msg) {
				console.log(msg);
				alert("数据初始化异常");
			}
		});
	}
  
	/**
	 * 视频上传
	 */
	 $("#video").click(function () {
	    $("#video").blur();
	    $('#projectImgBtn').click();
	}); 

	$('#projectImgBtn').change(function(){
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
	        //console.log(url);
	        $("#videoshow video").attr("src",url);
	        $("#videoshow").show();
	        //layer.msg('获取安全路径成功',{icon: 6});
	        console.log($('#projectImgBtn').val().toString());
	        $("#video").val(file.name);
	        return;
	    }else {
	        layer.msg('请转换为h264编码的mp4格式',{icon: 5});
	        file = null;
	        this.files = null;
	        return;
	    }
	}); 
	
	
	/**
	 渲染表单
	*/
	var active;
	layui.use(['form','layer','element'], function(){
		$ = layui.jquery;
		var form = layui.form
		,layer = layui.layer
		,element = layui.element;
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
	                     /*clearInterval(timer);*/
	                     //closeDiv();
	                 }
	             },
	             saving:function () {
	                 var index = layer.msg('视频保存中', {
	                     icon: 16,
	                     time:20000
	                 });
	             },
	             ending:function () {
	                 //closeDiv();
	                 layer.closeAll('loading'); //关闭加载层
	             }
	         };
		
	 form.on('submit(formDemo)', function() {
			$("#contentTEXT").val(editor.txt.html());
			if ($("#contentTEXT").val() == "<p><br></p>") {
				$("#contentTEXT").val("");
			}
			if ($("#contentTEXT").val() == "") {
				layer.msg("正文不能留空");
			} else {
				sendData();
			}
			active.ending();
			return false;
		}); 
	});
	
	
	function sendData(){
		var formDate = new FormData($('#main_form')[0]); 
		$.ajax({
			url:'${ctx }sys/disasters/updateVideo?id='+${param.id}+'&videoUrl='+videoUrl,
			type:'post',
			data:formDate,
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
	        success:function(result){
	        	active.ending();
	            console.log(result);
	            if(result==1){
	                layer.msg('提交成功',{icon: 6});
	                setTimeout(function(){
	                	reloadParentWin();
	                }, 2000);
	            }else{
	                layer.msg('更新失败',{icon: 5});
	            }
	        },
	        error:function (msg){
	            active.ending();
	            //layer.close(index);
	            layer.msg('错误',{icon: 5});
	        }
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