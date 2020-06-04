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
    .layui-upload-img{
	width: 90px;
	height: 90px;
	padding: 4px
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

<!-- 菜单添加 -->
<form class="layui-form layui-form-pane" id="main_form" style="">

    <div style="float: left;padding: 10px;">

        <div class="layui-form-item">
            <label class="layui-form-label">产品名称</label>
            <div class="layui-input-inline">
                <input type="text" name="pname" lay-verify="required" placeholder="产品名称" autocomplete="off"
                       class="layui-input">
            </div>
			<label class="layui-form-label">产品类型</label>
			<div class="layui-input-inline">
				<select name="type" id="type" lay-search="" lay-verify="required">
				</select>
				<%--<div class="layui-form-select layui-form-selected"><div class="layui-select-title"><input type="text" placeholder="直接选择或搜索选择" value="" class="layui-input"><i class="layui-edge"></i></div><dl class="layui-anim layui-anim-upbit"><dd lay-value="" class="layui-select-tips">直接选择或搜索选择</dd><dd lay-value="1" class="">layer</dd><dd lay-value="2" class="">form</dd><dd lay-value="3" class="">layim</dd><dd lay-value="4" class="">element</dd><dd lay-value="5" class="layui-this">laytpl</dd><dd lay-value="6" class="">upload</dd><dd lay-value="7" class="">laydate</dd><dd lay-value="8" class="">laypage</dd><dd lay-value="9" class="">flow</dd><dd lay-value="10" class="">util</dd><dd lay-value="11" class="">code</dd><dd lay-value="12" class="">tree</dd><dd lay-value="13" class="">layedit</dd><dd lay-value="14" class="">nav</dd><dd lay-value="15" class="">tab</dd><dd lay-value="16" class="">table</dd><dd lay-value="17" class="">select</dd><dd lay-value="18" class="">checkbox</dd><dd lay-value="19" class="">switch</dd><dd lay-value="20" class="">radio</dd></dl></div>--%>
			</div>
			</div>

        	<div class="layui-form-item">
			<label class="layui-form-label">库存</label>
			<div class="layui-input-inline">
				<input type="text" name="stock" lay-verify="required"
					placeholder="库存" autocomplete="off" class="layui-input">
			</div>

			<label class="layui-form-label">价格</label>
			<div class="layui-input-inline">
				<input type="text" name="price" lay-verify="required"
					placeholder="价格" autocomplete="off" class="layui-input">
			</div>
			</div>
        <div class="layui-form-item">
			<label class="layui-form-label">有效期</label>
			<div class="layui-input-inline">
          			<input class="layui-input" lay-verify="required" placeholder="起始日期" name="startTime" id="startTime">
       		</div>
      			 <div class="layui-input-inline">
         			<input class="layui-input" lay-verify="required" placeholder="截止日期" name="endTime" id="endTime">
       		</div>
       	</div>
        <!--显示图片-->
		<div class="layui-form-item">
			<label class="layui-form-label">图片文件
			</label>
			<div class="layui-input-inline"
				style="margin-right: 0px; width: 60%">
				<input type="hidden" id="image" class="layui-input" name="image"
					required lay-verify="required" placeholder="图片路径"
					autocomplete="off" style="display: none"/>
			</div>
			<%--<div class="layui-input-inline">--%>
			<div class="layui-input-block" style="float: left; margin-left: 0px">
				<a href="" class="content-a-upload" style="height: 36px;display: none"><input
					type="file" id="projectImgBtn" style="height: 36px; width: 100px" />选择图片</a>
			</div>
		</div>
		<div class="layui-form-item" style="display: none;" id="project_Img">
				<ul>
					<li style="margin-left: 15%"><img src=""
						style="width: 400px; height: 230px;" /></li>
				</ul>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">轮播图片 </label>
				<div class="layui-input-inline" style="width: 50%;display: none;">
					<input type="text" id="pic" placeholder="轮播图片"
						autocomplete="off" class="layui-input" name="slide">
				</div>
				<button type="button" class="layui-btn" id="test2" style="display: none">多图片上传</button>
				<button type="button" class="layui-btn" id="remove" style="display: none">清空轮播列表</button>
			</div>
			<div class="layui-upload">
				<blockquote class="layui-elem-quote layui-quote-nm"
					style="margin-top: 10px;">
					预览图：
					<div class="layui-upload-list" id="demo2"></div>
				</blockquote>
			</div>
		<!--产品链接-->
				<div class="layui-form-item">
					<label class="layui-form-label">产品链接
					</label>
					<div class="layui-input-inline" style="width:50%">
					<input type="text" name="link" 
						placeholder="产品链接" autocomplete="off" class="layui-input">
				</div>
				</div>
		<!-- <div style="padding: 3px 3px; width: 400px; height: 230px; margin: 10px auto; border: #9c9c9c solid 1px"> -->
			
		<!-- </div> -->

			<!-- 商品详情 -->
		<div class="layui-form-item layui-form-text" style="display: none;">
			<label class="layui-form-label">正文</label>
			<div class="layui-input-block">
				<textarea name="descript" placeholder="请输入内容" class="layui-textarea"
					id="contentTEXT"></textarea>
			</div>
		</div>
		<div class="layui-form-item" id="x-city">
            <label class="layui-form-label">地区</label>
            <div class="layui-input-inline">
              <select name="province" id="province" lay-filter="province">
                <option value="">请选择省</option>
              </select>
            </div>
            <div class="layui-input-inline">
              <select name="city" id="city" lay-filter="city">
                <option value="">请选择市</option>
              </select>
            </div>
            <div class="layui-input-inline">
              <select name="area" id="area" lay-filter="area">
                <option value="">请选择县/区</option>
              </select>
            </div>
			</div>
			<div class="layui-form-item">
					<label class="layui-form-label">联系电话
					</label>
					<div class="layui-input-inline" style="width:50%">
					<input type="text" name="phone" 
						placeholder="联系电话" autocomplete="off" class="layui-input">
				</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">联系人
					</label>
					<div class="layui-input-inline" style="width:50%">
					<input type="text" name="linkman" 
						placeholder="联系人" autocomplete="off" class="layui-input">
				</div>
				</div>
		<div class="layui-form-item">
			<label class="layui-form-label">内容</label>
			<div class="layui-input-block">
				<div id="editor"></div>
			</div>
		</div>
       
    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>
//轮播图清空
$("#remove").click(function(){
	  $(".layui-upload-img").remove();
	  $("#pic").val("");
});
layui.use('upload', function(){
	  var $ = layui.jquery
	  ,upload = layui.upload;
//多图片上传
  upload.render({
	  type : "POST",
    elem: '#test2'
    ,url: '${ctx}base/uploadfile'
    ,multiple: true
    ,before: function(obj){
      //预读本地文件示例，不支持ie8
      obj.preview(function(index, file, result){
        $('#demo2').append('<img  src="'+ result +'" alt="'+ file.name +'" class="layui-upload-img">');
      });
    }
    ,done: function(res){
    	if($("#pic").val()==null||$("#pic").val()=="") {
        	$("#pic").val(res.fileName)
        }
        else {
        	$("#pic").val($("#pic").val()+","+res.fileName);
        }
    	console.log(res)
      //上传完毕
    }
  });
});
layui.use('laydate', function() {
	var laydate = layui.laydate;
    
	//执行一个laydate实例
	laydate.render({
		elem : '#startTime', //指定元素
		format:'yyyy-MM-dd'
	});

	//执行一个laydate实例
	laydate.render({
		elem : '#endTime', //指定元素
		format:'yyyy-MM-dd'
	});
});
    //刷新父窗口
    function reloadParentWin() {
        if(window.parent.frames["产品列表"]!=undefined)window.parent.frames["产品列表"].location.reload();// 刷新父窗口
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
	
	 // 图片上传
    $('#projectImgBtn').change(function(){
        run1(this, function (data) {
            uploadImage1(data);
        });
    });
	
  //图片转码
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
                //hui.closeLoading();
                $("#project_Img img").attr("src",img)
               // $("#imageshow").attr("src",img);
               // $("#imageshow").show();
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
    
	var Types='';
    $(function () {
    	initUser();
    	getType();
    });
    
    //初始化用户信息
    function initUser() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/product/select?id=${param.id}',
            dataType: 'json',
            async : false,
            success: function (result) {
            	console.log(result);
                var product = result.product;
                Types = product.type;
                $("input[name='pname']").val(product.pname);
                $("input[name='stock']").val(product.stock);
                //$("input[name='type']").val(product.type);
                $("input[name='price']").val(product.price);
                $("input[name='link']").val(product.link);
                $("input[name='image']").val(product.image);
                $("input[name='startTime']").val(formatDate_YMD(product.startTime));
                $("input[name='endTime']").val(formatDate_YMD(product.endTime));
                $("input[name='phone']").val(product.phone);
                $("input[name='slide']").val(product.slide);
                $("input[name='linkman']").val(product.linkman);
                if(!(product.slide.split(",").length==1&&product.slide.split(",")[0]=="")){
                	var array=product.slide.split(",");
                	console.log(array.length)
                	for(var i = 0;i<array.length;i++){
                		$('#demo2').append("<img src='${ctx}uploadFiles/photo/"+ array[i] +"' class='layui-upload-img'>");
                	}
                }
                layui.use(['form'], function(){
                    form = layui.form;

                    //$('#x-city').xcity('广西','百色市','田东县');
                    $('#x-city').xcity(product.province,product.city,product.area);

                  });
                $("#project_Img img").attr("src","${ctx}uploadFiles/photo/"+product.image+"")
                $("#project_Img").show();
                var descript = htmlspecialchars_decode(product.descript);
                editor.txt.html(descript);
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
			url : '${ctx }sys/dictionary/selectList?type=type_cpxx',
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
	
    //渲染表单
        layui.use('form', function () {
            form = layui.form;
            //监听提交
            form.on('submit(formDemo)', function (data) {       	
            	$("#contentTEXT").val(editor.txt.html());           	
                $.ajax({
                    type: 'POST',
                    url: '${ctx }sys/product/update?id=${param.id}',
                    data: $('#main_form').serialize(),
                    dataType: 'json',
                    success: function (result) {
                        if(result.status==1){
                            layer.alert(result.msg, {icon: 6}, function () {
                                reloadParentWin();
                            });
                        }else{
                            layer.msg(result.msg, {icon: 5});
                        }
                    },
                    error: function (msg) {
                        console.log(msg);
                        alert("系统异常");
                    }
                }); 
                return false;
            });
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