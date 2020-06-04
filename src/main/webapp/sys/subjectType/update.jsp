<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>更新图片</title>
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

	.x-red{
		color: red;
	}


	.layui-form-item .layui-input-inline {
		float: left;
		width: 800px;
		margin-right: 10px;
	}

	</style>
</head>
<body>

<!-- 菜单添加 -->
<form class="layui-form" id="main_form" style="">

	<div class="layui-form-item" style="margin-top: 15px;">
		<label class="layui-form-label"><span class="x-red">* </span>专题名称</label>
		<div class="layui-input-inline">
			<input type="text" name="title" required lay-verify="required"
				   placeholder="专题名称" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label"><span class="x-red">* </span>专题链接</label>
		<div class="layui-input-inline">
			<input type="text" name="url" id="htmlUrl" lay-verify="url"
				   placeholder="专题链接" autocomplete="off" lay-verType="tips"  class="layui-input">
			<%--placeholder="链接" autocomplete="off" lay-verType="tips"  lay-verify="url" class="layui-input">--%>
		</div>
	</div>

	<!--显示图片-->
	<div class="layui-form-item">
		<label class="layui-form-label"><span class="x-red">* </span>图片地址 </label>
		<div class="layui-input-inline"
			 style="margin-right: 0px; width: 40%">
			<input type="hidden" id="projectImg" class="layui-input" name="image"
				   required lay-verify="required" placeholder="图片路径"
				   autocomplete="off" />
		</div>
		<div class="layui-input-block" style="float: left; margin-left: 0px">
			<a href="" class="content-a-upload" style="height: 36px;"><input
					type="file" id="projectImgBtn" style="height: 36px; width: 100px" />上传相片</a>
		</div>
	</div>
	<div class="layui-form-item" style="display: none;" id="project_Img">
		<ul>
			<li><img src="" style="margin-left: 110px; width: 280px; height: auto;" /></li>
		</ul>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">专题简介</label>
		<div class="layui-input-inline">
			<textarea type="text" name="introduction" style="height: 200px;padding: 10px;"class="layui-input"></textarea>
		</div>
	</div>
	</div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-warm" lay-submit lay-filter="formDemo">立即更新</button>
                <!-- <button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
            </div>
        </div>
    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>


layui.use('laydate',function(){
    var laydate = layui.laydate;

    //同时绑定多个
    lay('.test-item').each(function(){
        laydate.render({
            elem: this
            ,trigger: 'click',

        });
    });
});
//关闭当前弹出窗口
function closeWindow() {
    window.parent.frames["外网专题"].location.reload();// 刷新父窗口
    setTimeout(function() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
        //layer.closeAll(); //疯狂模式，关闭所有层
    }, 1000)
}


function ImageClip(path){
    $("#project_Img img").attr("src","${ctx}uploadFiles/photo/" + path);
    $("input[name='projectImg']").val(path);
    $("#project_Img").show();
    layer.close(index3);
}


//图片转码
function run1(input_file, get_data) {
    /*input_file：文件按钮对象*/
    /*get_data: 转换成功后执行的方法*/
    if (typeof (FileReader) === 'undefined') {
        layer.alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！", {
            icon : 5
        });
        //alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！");
    } else {
        try {
            /*图片转Base64 核心代码*/
            var file = input_file.files[0];
            //这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件
            if (!/image\/\w+/.test(file.type)) {
                layer.alert("请确保文件为图像类型", {
                    icon : 5
                });
                return false;
            }
            var reader = new FileReader();
            reader.onload = function() {
                get_data(this.result);
            }
            reader.readAsDataURL(file);
        } catch (e) {
            layer.alert('图片转Base64出错啦！' + e.toString(), {
                icon : 5
            });
        }
    }
}
//图片上传
function uploadImage1(img) {
    //判断是否有选择上传文件
    var imgPath = $("#projectImgBtn").val();
    if (imgPath == "") {
        layer.alert('请选择上传图片！', {
            icon : 5
        });
        return;
    }
    //判断上传文件的后缀名
    var strExtension = imgPath.substr(imgPath.lastIndexOf('.') + 1);
    if (strExtension != 'jpg' && strExtension != 'gif'
        && strExtension != 'png' && strExtension != 'bmp'
        && strExtension != 'jpeg') {
        layer.alert("这不是图片文件!", {
            icon : 5
        });
        return;
    }
    $.ajax({
        type : "POST",
        url : "${ctx}base/uploadImgCommon.do",
        data : {
            base64Data : img,
            width : 260,
            height : 260
        }, //视情况将base64的前面字符串data:image/png;base64,删除
        cache : false,
        dataType : "text",
        success : function(data) {
            console.log(data);

            if ($("#project_Img img")[0].src != null
                && $("#project_Img img")[0].src != '') {
                $("#project_Img").show();
            } else {
                $("#project_Img").hide();
            }

            $("#projectImg").val(data.replace("uploadFiles/photo/", ""));
            if(data == '2'){
                layer.msg('图片上传失败', {
                    icon : 5
                });
            }else{
                $("#project_Img img").attr("src", img)
                layer.msg('图片上传成功', {
                    icon : 6
                });
            }
        },
        error : function(XMLHttpRequest, textStatus, errorThrown) {
            //hui.closeLoading();
            console.log(XMLHttpRequest);
            console.log(textStatus);
            console.log(errorThrown);
            layer.msg('请检查网络后重试', {
                icon : 5
            });
        }
    });
}
//图片上传
$('#projectImgBtn').change(function() {
    run1(this, function(data) {
        uploadImage1(data);
    });
});
    
	var Types='';
    $(function () {
    	initUser();
    	//getType();
    });
    
    //初始化信息
    function initUser() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/subjectType/select?id=${param.id}',
            dataType: 'json',
            async : false,
            success: function (data) {
            	// console.log(data);
            	var subjectType = data.data;
                $("input[name='title']").val(subjectType.title);
                $("input[name='url']").val(subjectType.url);
                $("textarea[name='introduction']").text(subjectType.introduction);
                $("input[name='image']").val(subjectType.image);

                $("#project_Img img").attr("src","${ctx}uploadFiles/photo/"+subjectType.image)
                $("#project_Img").show();

            },
            error: function (msg) {
                console.log(msg);
                alert("初始化异常");
            }
        });
    }
    

layui.use('form', function () {
    form = layui.form;
    form.verify({
        url: function (value, item) {
            var myreg= /^((^$)|((ht|f)tps?):\/\/[\w\-]+(\.[\w\-]+)+([\w\-.,@?^=%&:\/~+#]*[\w\-@?^=%&\/~+#]))?$/;
            if (!myreg.test(value)) {
                return '请输入正确的网址';
            }
        }
    });
    //监听提交
    form.on('submit(formDemo)', function (data) {
        //$("#contentTEXT").val(editor.txt.html());
		console.log($('#main_form').serialize()+"&endTime2"+$("#endTime").val())
        $.ajax({
            type: 'POST',
            url: '${ctx }sys/subjectType/update?id=${param.id}',
            data: $('#main_form').serialize(),
            dataType: 'json',
            success: function (result) {
                if (result.status == 1) {
                    closeWindow();
                } else {
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
</body>
</html>