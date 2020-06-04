<!doctype html>
<html lang="zh-CN" id="index">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui" />
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
        #file,
        #clipBtn {
            margin: 20px;
        }
        #view {
            margin: 0 auto;
            width:460px;
            height: 260px;
        }
    </style>
</head>
<body ontouchstart="">
<div id="clipArea"></div>
<input type="file"  id="file">
<input type="text" hidden value="${param.userimg}" id="test">
<input type="text" hidden name="userid"   value="${param.userid}" id="userid">
<button id="clipBtn">上传头像</button>
<%--<button id="subBtn" onclick="subphoto()" >确定使用图片</button>--%>
<%--<div id="view"></div>--%>
<%--<script src="http://www.jq22.com/jquery/2.1.1/jquery.min.js"></script>
<script src="js/iscroll-zoom.js"></script>
<script src="js/hammer.js"></script>
<script src="js/lrz.all.bundle.js"></script>
<script src="js/jquery.photoClip.js"></script>--%>
<script src="${ctxRes}photoclip/jquery-2.1.3.min.js"></script>
<script src="${ctxRes}photoclip/hammer.js"></script>
<script src="${ctxRes}photoclip/iscroll-zoom.js"></script>
<script src="${ctxRes}photoclip/lrz.all.bundle.js"></script>
<script src="${ctxRes}photoclip/jquery.photoClip.js"></script>
<script>
    //document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
    var dataurl;
    var clipArea = new bjj.PhotoClip("#clipArea", {
        size: [260, 260],
        outputSize: [460, 460],
        file: "#file",
      /*  view: "#view",*/
        ok: "#clipBtn",
        loadStart: function() {
            console.log("照片读取中");
        },
        loadComplete: function() {
            console.log("照片读取完成");
        },
        clipFinish: function(dataURL) {
            console.log(dataURL);
            uploadImage1(dataURL);
           /* dataurl=dataURL;*/

        }
    });
    function subphoto() {
        if(dataurl!=''&&dataurl!=null){
            uploadImage1(dataurl);
        }else {
            alert(请先选择图片);
        }

    }
    //图片上传
    function uploadImage1(img) {
        /*//判断是否有选择上传文件
        var imgPath = $("#projectImgBtn").val();
        /!* alert(imgPath);*!/
        if (imgPath == "") {
            layer.alert('请选择上传图片！',{icon: 5});
            return;
        }
        //判断上传文件的后缀名
        var strExtension = imgPath.substr(imgPath.lastIndexOf('.') + 1);
        if (strExtension != 'jpg' && strExtension != 'gif'
            && strExtension != 'png' && strExtension != 'bmp'&&strExtension != 'jpeg') {
            layer.alert("这不是图片文件!",{icon: 5});
            //hui.closeLoading();
            return;
        }*/
        $.ajax({
            type: "POST",
            url: "${ctx}base/uploadImgCommon.do",
            data: {base64Data: img,width:260,height:260},    //视情况将base64的前面字符串data:image/png;base64,删除
            //data: {base64Data: img,width:130,height:100},    //视情况将base64的前面字符串data:image/png;base64,删除
            cache: false,
            dataType: "text",
            success: function(data) {
                console.log(data);
                updateheaderphoto(data.replace("uploadFiles/photo/",""));
                //hui.closeLoading();
               /* $("#photoimg img").attr("src",img)

                $("#photo").val(data.replace("uploadFiles/photo/",""));*/
                /*layer.msg('图片上传成功',{icon: 6});*/
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //hui.closeLoading();
                console.log(XMLHttpRequest);
                console.log(textStatus);
                console.log(errorThrown);
                /*layer.msg('请检查网络后重试',{icon: 5});*/
            }
        });

    }
    function updateheaderphoto(url) {
        var uid=$("#userid").val();
        $.ajax({
            type:'post',
            url:'${ctx }updateheaderphoto?id='+uid+'&url='+url,
            dataType:'json',
            success:function(data){
                if(data.status==1){
                    alert("更新头像成功");
                        window.parent.location.reload();
                        parent.layer.close(index);
                    //window.location.href = "${ctx}web/user/user_index.jsp";
                   /* layer.msg(data.msg, {icon: 5});
                    window.location.reload(true);*/
                }else{
                   /* layer.msg(data.msg, {icon: 5});*/
                }
            },
            error:function (msg){
                console.log(msg);
                alert("登录异常");
            }
        });
    }
    //clipArea.destroy();
</script>
</body>
</html>
