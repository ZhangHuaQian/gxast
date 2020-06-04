<!doctype html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="format-detection" content="telephone=no, email=no"/>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>图片裁剪</title>
    <%@ include file="/commViews/head.jsp" %>
    <link href="${ctx }resource/plugins/cropper/cropper.css" rel="stylesheet">
    <script src="${ctx }resource/plugins/cropper/cropper.js"></script>
</head>
<body>
<img id="img" src=""/>
<div class="layui-btn-container">
    <button onclick="zhengjia()" type="button" class="layui-btn layui-btn-sm layui-btn-primary">放大</button>
    <button onclick="jianxiao()" type="button" class="layui-btn layui-btn-sm layui-btn-primary">缩小</button>
    <button onclick="shunshizhen()" type="button" class="layui-btn layui-btn-sm layui-btn-primary">顺时针</button>
    <button onclick="nishizhen()" type="button" class="layui-btn layui-btn-sm layui-btn-primary">逆时针</button>
    <button onclick="fuyuan()" type="button" class="layui-btn layui-btn-sm layui-btn-primary">复原</button>
</div>
<h2>预览图：</h2>
<div class="preview" style="height: 100px;overflow: hidden"></div>
<button type="button" id="submit" class="layui-btn" style="margin: 20px 0px 0px 20px">确认</button>
<button type="button" onclick="guanbi()" class="layui-btn" style="margin: 20px 0px 0px 20px">关闭</button>
</body>
<script>
    var srcFromParent=''
    $(function () {
        // $('#img').error(function() {
        //     parent.layer.msg('图片存在跨域问题，请先自行下载，并通过上传至本服务器，再进行修改。',{icon: 5});
        //     guanbi()
        //     return
        // })
    })
    
    function zhengjia() {
        $('#img').cropper('zoom', 0.1);
    }
    function jianxiao() {
        $('#img').cropper('zoom', -0.1);
    }
    function shunshizhen() {
        $('#img').cropper('rotate', 5);
    }
    function nishizhen() {
        $('#img').cropper('rotate', -5);
    }
    function fuyuan(){
        $('#img').cropper('reset');
    }
    function guanbi(){
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);//关闭当前页
    }
    $('#submit').click(function () {
        var cav = $('#img').cropper('getCroppedCanvas',{
            imageSmoothingEnabled: false,
            imageSmoothingQuality: 'high',
        })
        var base64url;
        try {
            base64url = cav.toDataURL('image/png');
        }catch (e) {
            parent.layer.msg('图片存在跨域问题，请先自行下载，并通过上传至本服务器，再进行修改。',{icon: 5});
            guanbi()
        }
        uploadImage(base64url);
    })


    function setSrc(src) {
        srcFromParent = src;
        $('#img').attr('src',src)
        cropper()
    }

    function cropper() {
        $('#img').cropper({
            viewMode: 2,
            aspectRatio: NaN,
            checkCrossOrigin: false,
            preview:".preview",
            modal: true,
            background: true,
            movable: false,
            minCanvasWidth: 100,
            minCanvasHeight: 100,
            minCropBoxWidth: 100,
            minCropBoxHeight: 100,
            crop: function(event) {
                // console.log(event.detail.x);
                // console.log(event.detail.y);
                // console.log(event.detail.width);
                // console.log(event.detail.height);
                // console.log(event.detail.rotate);
                // console.log(event.detail.scaleX);
                // console.log(event.detail.scaleY);
            }
        });
    }


    // //图片上传
    // $('#projectImgBtn').change(function(){
    //     run(this, function (data) {
    //         uploadImage(data);
    //     });
    // });

    //图片上传
    function uploadImage(base64url) {
        $.ajax({
            type: "POST",
            url: "${ctx}base/uploadImgCommon.do",
            data: {base64Data: base64url},    //视情况将base64的前面字符串data:image/png;base64,删除
            cache: false,
            dataType: "text",
            success: function(data) {
                parent.getImgSrc(data,srcFromParent)
                guanbi()
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //hui.closeLoading();
                console.log(XMLHttpRequest);
                console.log(textStatus);
                console.log(errorThrown);
                layui.layer.msg('请检查网络后重试',{icon: 5});
            }
        });
    }

    // function run(input_file, get_data) {
    //     /*input_file：文件按钮对象*/
    //     /*get_data: 转换成功后执行的方法*/
    //     if (typeof (FileReader) === 'undefined') {
    //         layer.alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！",{icon: 5});
    //         //alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！");
    //     } else {
    //         try {
    //             /*图片转Base64 核心代码*/
    //             var file = input_file.files[0];
    //             //这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件
    //             if (!/image\/\w+/.test(file.type)) {
    //                 layer.alert("请确保文件为图像类型",{icon: 5});
    //                 return false;
    //             }
    //             var reader = new FileReader();
    //             reader.onload = function () {
    //                 get_data(this.result);
    //             }
    //             reader.readAsDataURL(file);
    //         } catch (e) {
    //             layer.alert('图片转Base64出错啦！' + e.toString(),{icon: 5});
    //         }
    //     }
    // }


</script>
<style>

</style>
</html>
