<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>layout -轮播图- Layui</title>
<%@ include file="/commViews/head.jsp"%>
<script type="text/javascript" src="../../resource/js/xcity.js"></script>
<link rel="stylesheet"
	href="${ctx }resource/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript"
	src="${ctx }resource/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
<script
	src="${ctx }resource/plugins/wangEditor-3.1.1/release/wangEditor.min.js"
	type="text/javascript" charset="utf-8"></script>
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

.layui-form-item .layui-input-inline {
	float: left;
	width: 350px;
	margin-right: 10px;
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

</style>
</head>

<div class="" id="div1">
	<!-- 内容主体区域 -->
	<div style="padding: 10px;">

		<form class="layui-form" id="main_form">
			<div class="layui-form-item">
				<label class="layui-form-label"><span class="x-red">* </span>标题</label>
				<div class="layui-input-inline">
					<input type="text" name="header" required lay-verify="required"
						placeholder="标题" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label"><span class="x-red">* </span>链接</label>
				<div class="layui-input-inline">
					<input type="text" name="htmlUrl" id="htmlUrl" lay-verify="url"
						   placeholder="链接" autocomplete="off" lay-verType="tips"  class="layui-input">
                    <%--placeholder="链接" autocomplete="off" lay-verType="tips"  lay-verify="url" class="layui-input">--%>
				</div>
			</div>
			<div class="layui-form-item">
				<%--<label class="layui-form-label">序号</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input type="number" name="serial" required lay-verify="required"--%>
						   <%--placeholder="序号" autocomplete="off" class="layui-input">--%>
				<%--</div>--%>

				<label class="layui-form-label">结束时间</label>
				<div class="layui-input-inline">
					<input type="text" name="endTime" id="endTime"
						   placeholder="结束时间"  autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label"><span class="x-red">* </span>广告位置</label>
				<div class="layui-input-inline">
					<select name="type" lay-verify="required" lay-search="">
						<option value="">--广告位置--</option>
						<option value="zy_#01">主页#1</option>
						<option value="zy_#02">主页#2</option>
						<option value="zy_#03">主页#3</option>
						<option value="zy_#04">主页#4</option>
						<option value="zy_#05">主页#5</option>
						<option value="zy_#06">主页#6</option>
						<option value="zy_#07">主页#7</option>
						<option value="zy_#08">主页#8</option>
						<%--<option value="zy_#10">主页#10</option>--%>
						<%--<option value="zy_#11">主页#11</option>--%>
						<%--<option value="zy_#12">主页#12</option>--%>
						<%--<option value="zy_#13">主页#13</option>--%>
						<%--<option value="zy_#14">主页#14</option>--%>
						<%--<option value="zy_#15">主页#15</option>--%>
						<%--<option value="zy_#16">主页#16</option>--%>
						<%--<option value="zy_#17">主页#17</option>--%>
						<%--<option value="zy_#18">主页#18</option>--%>
						<%--<option value="zy_#19">主页#19</option>--%>
						<%--<option value="zy_#20">主页#20</option>--%>
						<%--<option value="zy_#21">主页#21</option>--%>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">描述</label>
				<div class="layui-input-inline">
					<input type="text" name="photoDescribe"
						   placeholder="描述" autocomplete="off" class="layui-input">
				</div>
			</div>

			<!--显示图片-->
			<div class="layui-form-item">
				<label class="layui-form-label"><span class="x-red">* </span>图片地址 </label>
				<div class="layui-input-inline"
					style="margin-right: 0px; width: 40%">
					<input type="hidden" id="projectImg" class="layui-input" name="projectImg"
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
				<div class="layui-input-block">
					<!--  <button class="layui-btn" lay-submit lay-filter="formDemo" >立即提交</button> -->
					<button class="layui-btn layui-btn-normal" lay-submit="" lay-filter="demo1" id="subBtn">提交并使用</button>
				</div>
			</div>
		</form>
	</div>

</div>

<script type="text/javascript">
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
	/*$(function() {
		init();
		initNewsType();
	});*/

    //关闭当前弹出窗口
    function closeWindow() {
        window.parent.frames["广告管理"].location.reload() ;// 刷新父窗口
        setTimeout(function (){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
            //layer.closeAll(); //疯狂模式，关闭所有层
        },1000)
    }
    layui.use('form', function(){
        var form = layui.form;

        form.verify({
            url:function (value,item) {
                var myreg= /^((^$)|((ht|f)tps?):\/\/[\w\-]+(\.[\w\-]+)+([\w\-.,@?^=%&:\/~+#]*[\w\-@?^=%&\/~+#]))?$/;
                // var myreg= /^((ht|f)tps?):\/\/[\w\-]+(\.[\w\-]+)+([\w\-.,@?^=%&:\/~+#]*[\w\-@?^=%&\/~+#])?$/;
                if(!myreg.test(value)){
                    return '请输入正确的网址';
                }
            }
        });
        form.on('submit(demo1)', function () {
            $.ajax({
                type : 'post',
                url : '${ctx }sys/loopphoto/insert',
                data :$('#main_form').serialize(),
                async : false,
                headers:{
                    endTime2:$("#endTime").val()
                },
                success : function(result) {
                    if(result.status==1){
                        closeWindow();
                        layer.msg(result.msg);
                    }

                },
                error : function(msg) {
                    alert("错误");
                }
            });
            return false;
        });
        form.render();
    });
    //渲染表单
    function renderForm() {
        layui.use('form', function () {
            form = layui.form;
            //监听提交
            form.on('submit(demo1)', function (data) {
                $.ajax({
                    type: 'post',
                    url : '${ctx }sys/loopphoto/insert',
                    data: $('#main_form').serialize(),
                    dataType: 'json',
                    success: function (result) {
                        closeWindow();
                        console.log(result);
                        layer.msg(result.msg);
                    },
                    error: function (msg) {
                        console.log(msg);
                        alert("系统异常");
                    }
                });
                return false;
            });
        });
    }
    // layui.use('form', function(){
    //     var form = layui.form;
    //     form.verify({
    //         url:function (value,item) {
    //             var myreg= /^((ht|f)tps?):\/\/[\w\-]+(\.[\w\-]+)+([\w\-.,@?^=%&:\/~+#]*[\w\-@?^=%&\/~+#])?$/;
    //             if(!myreg.test(value)){
    //                 return '请输入正确的网址';
    //             }
    //         }
    //     });
    //     form.on('submit(formDemo)', function () {
    //         var htmlUrl=$("#htmlUrl").val();
    //         console.log(htmlUrl);
    //         sendData();
    //     });
    //     form.render();
    // });
    // $(function () {
    //     renderForm();
    // });
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        date = laydate.render({
            elem : '#endTime', //指定元素
            format : 'yyyy-MM-dd HH:mm:ss',
            min: getNowFormatDate(),
            type: 'datetime',
            trigger: 'click',
            change: function (value) {
                date.hint("请点击左下角选择时分秒"); //在控件上弹出提示值
            }
        });

    });
    //获取当前日期时间
    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var seperator2 = ":";
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        var hour = date.getHours();
        var min = date.getMinutes();
        var sec = date.getSeconds()
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        if (hour >= 0 && hour <= 9) {
            hour = "0" + hour;
        }
        if (min >= 0 && min <= 9) {
            min = "0" + min;
        }
        if (sec >= 0 && sec <= 9) {
            sec = "0" + sec;
        }

        var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + hour + seperator2 + min
            + seperator2 + sec;
        return currentdate;
    }

</script>
</body>
</html>