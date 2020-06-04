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
    </style>
</head>
<body>

<!-- 菜单添加 -->
<form class="layui-form layui-form-pane" id="main_form" style="">

    <div style="float: left;padding: 10px;">

        <div class="layui-form-item">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-inline">
                <input type="text" name="header" lay-verify="required" placeholder="标题"  autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">图片链接</label>
            <div class="layui-input-inline">
                <input type="text" name="htmlUrl" lay-verify="required" placeholder="图片链接"  autocomplete="off"
                       class="layui-input">
            </div>
            <label class="layui-form-label">创建时间</label>
            <div class="layui-input-inline">
                <input type="text" name="createTime" lay-verify="required"
                       placeholder="创建时间" autocomplete="off" class="layui-input">
            </div>

        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">图片类型</label>
            <div class="layui-input-inline">
                <%--<input type="text" name="type" lay-verify="required" placeholder="图片类型"  autocomplete="off"
                       class="layui-input">--%>
                    <select name="type" lay-verify="required" lay-search="">
                        <option value="">--选择类型--</option>
                        <option value="loop_sy">主界面首页#1</option>
                        <option value="loop_jzfp">精准扶贫首页#1</option>
                    </select>
            </div>
            <label class="layui-form-label">序号</label>
            <div class="layui-input-inline">
                <input class="layui-input" lay-verify="required" placeholder="序号" name="serial" >
            </div>
            <label class="layui-form-label">结束时间</label>
            <div class="layui-input-inline">
                <input type="text" name="endTime" lay-verify="required"
                       placeholder="结束时间" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
        <label class="layui-form-label">描述</label>
        <div class="layui-input-inline">
            <input type="text" name="photoDescribe" lay-verify="required"
                   placeholder="描述" autocomplete="off" class="layui-input">
        </div>
        </div>
        <!--显示图片-->
        <div class="layui-form-item">
            <label class="layui-form-label">图片文件
            </label>
            <div class="layui-input-inline"
                 style="margin-right: 0px; width: 60%">
                <input type="hidden" id="projectImg" class="layui-input" name="projectImg"
                       required lay-verify="required" placeholder="图片路径"
                       autocomplete="off" style="display: none"/>
            </div>
            <%--<div class="layui-input-inline">--%>
            <%--<div class="layui-input-block" style="float: left; margin-left: 0px">
                <a href="" class="content-a-upload" style="height: 36px;"><input
                        type="file" id="projectImgBtn" style="height: 36px; width: 100px" />选择图片</a>
            </div>--%>
        </div>
        <div class="layui-form-item" style="display: none;" id="project_Img">
            <ul>
                <li style="margin-left: 15%"><img src=""
                                                  style="width: 400px; height: 230px;" /></li>
            </ul>
        </div>

    </div>
    </div>


    <%--<div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-warm" lay-submit lay-filter="formDemo">更新图片信息</button>
            <!-- <button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
        </div>
    </div>--%>
    </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script>

    layui.use('laydate', function() {
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem : '#createTime', //指定元素
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
        if(window.parent.frames["轮播图"]!=undefined)window.parent.frames["轮播图"].location.reload();// 刷新父窗口
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
        // layer.closeAll(); //疯狂模式，关闭所有层
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
                $("#projectImg").val(data.replace("uploadFiles/photo/",""));
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
        //getType();
    });

    //初始化用户信息
    function initUser() {
        $.ajax({
            type: 'get',
            url: '${ctx }sys/loopphoto/toupdate?id=${param.id}',
            dataType: 'json',
            async : false,
            success: function (result) {
                console.log(result);
                var loopphoto = result.loopphoto;
                Types = loopphoto.type;
                $("input[name='header']").val(loopphoto.header);
                $("input[name='photoDescribe']").val(loopphoto.photoDescribe);
                //$("input[name='type']").val(loopphoto.type);
                $("select[name='type'] option").each(function () {
                    if($(this).val()==loopphoto.type){
                        $(this).attr("selected","selected");
                    }
                })
                //$("input[name='price']").val(loopphoto.price);
                //$("input[name='num']").val(loopphoto.num);
                $("input[name='projectImg']").val(loopphoto.projectImg);
                $("input[name='createTime']").val(formatDate_YMD(loopphoto.createTime));
                $("input[name='endTime']").val(formatDate_YMD(loopphoto.endTime));
                $("input[name='serial']").val(loopphoto.serial);
                $("input[name='htmlUrl']").val(loopphoto.htmlUrl);
                console.log(loopphoto.projectImg.split(","));
                if(loopphoto.projectImg.split(",")!=null){
                    var array=loopphoto.projectImg.split(",");
                    for(var i = 0;i<array.length;i++){
                        $('#demo2').append("<img src='${ctx}uploadFiles/photo/"+ array[i] +"' class='layui-upload-img'>");
                    }
                }
                /*layui.use(['form'], function(){
                 form = layui.form;

                 //$('#x-city').xcity('广西','百色市','田东县');
                 $('#x-city').xcity(product.province,product.city,product.area);

                 });*/
                $("#project_Img img").attr("src","${ctx}uploadFiles/photo/"+loopphoto.projectImg+"")
                $("#project_Img").show();
                var photoDescribe = htmlspecialchars_decode(loopphoto.photoDescribe);
                editor.txt.html(photoDescribe);
            },
            error: function (msg) {
                console.log(msg);
                alert("初始化异常");
            }
        });
    }

    //获取产品类型
    /*function getType() {
     $.ajax({
     type : 'get',
     url : '${ctx }sys/loopphoto/selectType',
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
     }*/

    //渲染表单
    layui.use('form', function () {
        form = layui.form;
        //监听提交
        form.on('submit(formDemo)', function (data) {
            //$("#contentTEXT").val(editor.txt.html());
            $.ajax({
                type: 'POST',
                url: '${ctx }sys/loopphoto/update?id=${param.id}',
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