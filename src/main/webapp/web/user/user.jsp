<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/12/28
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>广西科普传播中心-个人信息</title>
    <style>
        /*为添加的空div设置的样式*/
        .clearDiv {
            clear: both;
        }
        .white{
            color: #FFFFFF;
        }
        .label_title{
            display: inline;
            float: left;
            border-right: #2377cd 1px solid;
            padding: 10px 25px;
        }
        .lm_label{
            display: inline;
            float: left;

            padding: 10px 25px;
        }
        .lm_label_select{
            display: inline;
            float: left;
            background-color: #2377cd;
            padding: 10px 25px;
        }
        .div0_col0{
            width: 60%;
            float: left;
        }
        .div0_col1{
            width: 40%;
        }
        #index_main_div0_row0{
            height: 57%;
        }
        #index_main_div0_row1{
            height: 43%;
        }


        .news_list{
            font-size: 16px;
            display: table-cell;
            vertical-align: middle;
            width: 100%;
        }
        .news_list_time{
            color: #ababab;
            float: right;
            margin-right: 15px;

        }
        #newslists>ul{
            width: 100%;
            padding-top: 10px;
            padding-bottom: 10px;
            color: #696969;
            display: table;
            width: 100%;
            height: 40px;
        }
        #newslists>ul:nth-child(odd){
            background-color: #f2f7fb;
        }
        #newslists>ul:nth-child(even){
            background-color: #ffffff;
        }

        .header {
            height: 60px;
            line-height: 60px;
            text-align: center;
        }
        .header .line {
            display: inline-block;
            width: 105px;
            border-top: 1px solid #efefef ;
        }
        .header .txt {
            color: #333333;
            font-size: 19px;
            vertical-align: -4px;
            margin-left: 10px;
            margin-right: 10px;
        }
        .triangle-tip-up{
            width: 200px;
            height: 30px;
            background:#ffffff;
            border-radius: 4px;
            position: relative;
        }
        .triangle-tip-up:before{
            content:'';
            width: 0;
            height: 0;
            border-width: 0 10px 10px;
            border-style: solid;
            border-color: transparent transparent #ffffff;
            position: absolute;
            left: 380px;
            top: -10px;
        }
        .layui-progress-big, .layui-progress-big .layui-progress-bar {
            height: 13px;
            line-height: 13px;
        }
        .content-a-upload {
            /*margin-left: 15px;*/
            margin-top:5px;
            text-align: center;
            position: relative;
            float: left;
            height: 22px;
            width: 80px;
            line-height: 22px;
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

        .content-a-upload:hover {
            color: #FFFFFF;
            background: #EF4F4F !important;
            border-color: #ccc;
            text-decoration: none
        }
    </style>
</head>
<body style="background-color: #ffffff">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <%@ include file="/web/include/ucenter-head.jsp"%>
    <div id="newslistdiv" class="triangle-tip-up" style="width:70%;min-width:1302px;margin: 0px auto;height:auto;min-height:700px;background-color: #FFFFFF">
        <%@ include file="/web/include/ucenter-left-menu.jsp"%>
        <div style="width:80%;margin-top:15px;height:600px;float: right;border: 1px solid #E8E8E8">
            <div style="width: 100%;background-color: #FAFAFA">
                <div style="color: #858585;margin-left: 15px;padding: 8px 0px;"><span><strong>个人信息</strong></span></div>
            </div>
            <div style="width: 80%;padding:25px 0px;border-bottom: 1px solid #E8E8E8;margin-left: 40px;">
                <div id="photoimg" onclick="updateuserphoto()"  style="float: left">
                    <img onerror="this.src='${ctxRes}/images/404-img.jpg'" style="height: 80px;width: auto;border-radius: 4px;" src="${ctxUphoto}${sessionScope.USER_SESSION_NAME.photo}"><br>
                   <%-- <div class="layui-input-block" style="float: left;margin-left: 0px">
                        <a href="#"  style="height: 22px;"><input type="button" onclick="updateuserphoto()" value="选择图片" id="projectImgBtn" style="height: 36px;width: 100px;text-align: center;"/></a>
                    </div>--%>
                </div>
                <div style="float: left;margin-left:20px;color: #6A6A6A;height: 67px;padding-top: 13px;">
                    <div style="font-size: 18px"><span>用户名 ：</span><span id="loginName"></span></div>
                    <div style="font-size: 16px;margin-top: 10px;vertical-align:middle;">
                        <span style="float: left">账户安全 ：</span>
                        <div style="float: left;width: 150px;vertical-align:middle;margin-top: 3px;">
                            <div class="layui-progress layui-progress-big">
                                <div class="layui-progress-bar layui-bg-blue" lay-percent="60%"></div>
                            </div>
                            <div class="clearDiv"></div>
                        </div>
                        <span style="float: left;margin-left: 5px;color: #3683D1">中</span>
                        <%--<span style="float: left;margin-left: 10px;color: #3683D1">（立即提升）</span>--%>
                        <div class="clearDiv"></div>
                    </div>
                    <%--<div style="font-size: 16px;margin-top: 10px;">--%>
                        <%--<a href="${ctx}web/user/delivery.jsp" title="点击打开" style="color: #6A6A6A">--%>
                            <%--<span>我的收货地址 ></span>--%>
                        <%--</a>--%>
                    <%--</div>--%>
                </div>
                <div class="clearDiv"></div>
            </div>
            <form method="post" class="layui-form" id="main_form">
            <div style="width: 80%;padding:25px 0px;border-bottom: 1px solid #E8E8E8;margin-left: 40px;">
                <table style="color: #6A6A6A;" border="0">
                    <tr style="height: 45px">
                        <td style="text-align: right"><span style="color: #E85958">*&nbsp;</span>昵称：</td>
                        <td style="text-align: left">
                            <input type="text" maxlength="15" class="layui-input" name="name" id="name" style="vertical-align:middle;line-height: 25px;display: inline;width: 250px;">
                            <button type="button" onclick="updateName()" class="layui-btn layui-btn-normal" style="border: 0px;border-radius:2px;height: 36px;">保存</button>
                        </td>
                    </tr>
                    <tr style="height: 45px">
                        <td style="text-align: right"><span style="color: #E85958">*&nbsp;</span>手机号码：</td>
                        <td name="phonenum" class="phonenum" style="text-align: left;line-height: 45px;  ">
                            <span  class="write" style="float:left;" id="phone"></span>
                            <a href="javascript:updatePhone()" style="margin-left: 20px;color: #3683D1;float: left;">修改</a>
                        </td>
                    </tr>

                    <tr title="点击修改收货地址" onclick="window.location.href='${ctx}web/user/delivery.jsp'" style="cursor: pointer;height: 45px">
                        <td style="text-align: right"><span style="color: #E85958">*&nbsp;</span>收货地址：</td>
                        <td id="getaddress" style="text-align: left">
                        </td>                      
                    </tr>
                </table>
            </div>
                <div>
                    <input type="hidden" name="id" id="uId" >
                </div>
                <div>
                    <input type="hidden"  name="photo" id="photo"   >
                </div>
            </form>
        </div>

        <div class="clearDiv"></div>
    </div>
    <div class="clearDiv"></div>
</div>
<%@ include file="/web/include/footer.jsp"%>
</body>
<script>

    $(function () {
        initUserInfo();
    })

    function initUserInfo() {
        $.ajax({
            type:'get',
            url:'${ctx }getUserInfo',
            dataType:'json',
            success:function(data){
                var user = data.user;
                console.log(user)
                if(data.status==0){
                    layer.msg(data.msg);
                }else{
                    $("#loginName").text(user.loginname)
                    $("#name").val(user.name);
                    $("#phone").text(user.phonenum)
                }
            },
            error:function (msg){
                console.log(msg);
                // layer.msg("登录异常");
            }
        });
    }

	function isPoneAvailable(phone) {//手机号验证
	    var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
	    if (!myreg.test(phone)) {                           
	        return false;
	    } else {
	        return true;
	    }
	}
    //注意进度条依赖 element 模块，否则无法进行正常渲染和功能性操作
    layui.use('element', function(){
        var element = layui.element;
    });
    //修改昵称
    function updateName(){
        var name = $("#name").val().trim();
        if(name.length > 0){
            $.ajax({
                type:'post',
                url:'${ctx }updateName?name='+name,
                dataType:'json',
                success:function(data){
                    if(data.status==1){
                        layer.msg(data.msg, {icon: 6});
                    }else{
                        layer.msg(data.msg, {icon: 5});
                    }
                },
                error:function (msg){
                    console.log(msg);
                    layer.msg("登录异常", {icon: 5});
                }
            });
        }else{
            layer.msg("昵称不能为空");
        }
    }

    //修改手机号
    function updatePhone(){
        sx_showWin({
            width : '300px',
            height : '280px',
            type : 2,
            title : "修改手机号",
            url : '${ctx}web/user/session/update_phone.jsp',
        });
    }

    // 图片上传
    function updateuserphoto(){
        var userimg="${ctxUphoto}${sessionScope.USER_SESSION_NAME.photo}";

        sx_showWin({
            width: '460px',
            height: '460px',
            type: 2,
            title: '更改图片',
            url: '${ctx}web/user/bbs/clipphoto.jsp?userid='+userid+'&userimg='+userimg
        });
       /* run1(this, function (data) {
            console.log(data);
            uploadImage1(data);
        });*/
    }
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
                //hui.loading('图片上传中...');
                var file = input_file.files[0];
                //这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件
                if (!/image\/\w+/.test(file.type)) {
                    layer.alert("请确保文件为图像类型",{icon: 5});
                    //hui.closeLoading();
                    return false;
                }
                var reader = new FileReader();
                reader.onload = function () {
                    get_data(this.result);
                }
                reader.readAsDataURL(file);
            } catch (e) {
                //hui.closeLoading();
                layer.alert('图片转Base64出错啦！' + e.toString(),{icon: 5});
            }
        }
    }

    //图片上传
    function uploadImage1(img) {
        //判断是否有选择上传文件
        var imgPath = $("#projectImgBtn").val();
       /* alert(imgPath);*/
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
        }
        $.ajax({
            type: "POST",
            url: "${ctx}base/uploadImgCommon.do",
            data: {base64Data: img,width:260,height:260},    //视情况将base64的前面字符串data:image/png;base64,删除
            //data: {base64Data: img,width:130,height:100},    //视情况将base64的前面字符串data:image/png;base64,删除
            cache: false,
            dataType: "text",
            success: function(data) {
                // console.log(data);
                //hui.closeLoading();
                $("#photoimg img").attr("src",img)

                $("#photo").val(data.replace("uploadFiles/photo/",""));
                layer.msg('图片上传成功',{icon: 6});
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //hui.closeLoading();
                // console.log(XMLHttpRequest);
                // console.log(textStatus);
                // console.log(errorThrown);
                layer.msg('请检查网络后重试',{icon: 5});
            }
        });

    }
    var userid = '${sessionScope.USER_SESSION_NAME.id}';
    $(function (){

        $.ajax({
            type: "POST",
            url: "${ctx}address/getuserAddress?userid="+userid,
            //data: {base64Data: img,width:260,height:260},    //视情况将base64的前面字符串data:image/png;base64,删除
            cache: false,
            dataType: "json",
            success: function(data) {
                // console.log(data.address == null)
            	if(data.address != null){
            		$("#getaddress").html(data.address.address+data.address.detailaddress+" (默认)");
            	}else{           
            		$("#getaddress").html("暂无默认收货地址");                                       
            	}
                
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

                layer.msg('请检查网络后重试',{icon: 5});
            }
        });

    } );
    // 新建窗口
    function sx_showWin(param) {
        parent.layer.open({
            type: param.type,
            area: [param.width, param.height],
            title: param.title,
            closeBtn: 1,
            //shade: [0.1, '#FFFFFF'],
            shadeClose: true,
            skin: 'yourclass',
            resize: true,
            success: function (layero, index) {
                //console.log(layero, index);
            },
            end: function(){
              window.location.reload();
            },
            content: param.url
        });
    }
</script>
</html>
