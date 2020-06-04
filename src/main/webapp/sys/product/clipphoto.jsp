<!doctype html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="format-detection" content="telephone=no, email=no" />
<meta name="keywords" content="">
<meta name="description" content="">
<title>图片裁剪</title>
<style>
body {
	margin: 0;
	text-align: center;
}

#clipArea {
	margin: 20px;
	height: 300px;
}

#file, #clipBtn {
	margin: 20px;
}

#view {
	margin: 0 auto;
	width: 460px;
	height: 260px;
}
</style>
</head>
<body ontouchstart="">
	<div id="clipArea"></div>
	<input type="file" id="file">
	<button id="clipBtn">上传图片</button>
	<script src="${ctxRes}photoclip/jquery-2.1.3.min.js"></script>
	<script src="${ctxRes}photoclip/hammer.js"></script>
	<script src="${ctxRes}photoclip/iscroll-zoom.js"></script>
	<script src="${ctxRes}photoclip/lrz.all.bundle.js"></script>
	<script src="${ctxRes}photoclip/jquery.photoClip.js"></script>
	<script>
		var dataurl;
		var clipArea = new bjj.PhotoClip("#clipArea", {
			size : [ 260, 260 ],
			outputSize : [ 0, 0 ],
			file : "#file",
			ok : "#clipBtn",
			loadStart : function() {
				console.log("照片读取中");
			},
			loadComplete : function() {
				console.log("照片读取完成");
			},
			clipFinish : function(dataURL) {
				console.log(dataURL);
				uploadImage1(dataURL);
			}
		});
		function subphoto() {
			if (dataurl != '' && dataurl != null) {
				uploadImage1(dataurl);
			} else {
				alert(请先选择图片);
			}

		}
		//图片上传
		function uploadImage1(img) {
			$.ajax({
				type : "POST",
				url : "${ctx}base/uploadImgCommon",
				data : {
					base64Data : img,
					width : 260,
					height : 260
				}, //视情况将base64的前面字符串data:image/png;base64,删除
				cache : false,          
				dataType : "text",                                                                     
				success : function(data) {                          
					parent.ImageClip(data);                                                               
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					console.log(XMLHttpRequest);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});

		}
	</script>
</body>
</html>
