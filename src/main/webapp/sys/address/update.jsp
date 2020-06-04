<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑收货地址</title>
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

    <div style="float: left;padding: 10px;width:95%">

           <div class="layui-form-item">
				<label class="layui-form-label">收件人</label>
				<div class="layui-input-block">
					<input type="text" name="name"
						required lay-verify="required" placeholder="收件人"
						autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">地址</label>
				<div class="layui-input-block">
					<input type="text" name="address"
						required lay-verify="required" placeholder="地址"
						autocomplete="off" class="layui-input">
				</div>
			</div>
		<div class="layui-form-item" id="mycity">
			<label class="layui-form-label">地区选择</label>
			<div class="layui-input-inline" style="width: 120px;">
				<select id="province"  lay-verify="required">
					<%--<option value="450">广西壮族自治区</option>--%>
				</select>
			</div>
			<div class="layui-input-inline" style="width: 120px">
				<select id="city"  lay-verify="required"
						lay-filter="filter">
				</select>
			</div>
			<div class="layui-input-inline" style="width: 120px">
				<select id="area"  lay-verify="required"
						lay-filter="filter">
				</select>
			</div>

		</div>

			<div class="layui-form-item layui-form-text" >
				<label class="layui-form-label">详细地址</label>
				<div class="layui-input-block">
					<input type="text" name="detailaddress"
						   required lay-verify="required" placeholder="详细地址"
						   autocomplete="off" class="layui-input">
				</div>
			</div>
		<div class="layui-form-item layui-form-text" >
				<label class="layui-form-label">邮政编码</label>
				<div class="layui-input-block">
					<input type="text" name="mailNum"
						   required lay-verify="required" placeholder="邮政编码"
						   autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">电话</label>
				<div class="layui-input-block">
					<input type="text" name="phone"
						   required lay-verify="required" placeholder="地址"
						   autocomplete="off" class="layui-input">
			</div>
			<br>
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

	<script type="text/javascript" src="${ctx}resource/js/mycity.js"></script>
	<script>

        //刷新父窗口
        function reloadParentWin() {
            if(window.parent.frames["收货地址"]!=undefined)window.parent.frames["收货地址"].location.reload();// 刷新父窗口*/
            //window.opener.location.reload();
            //window.opener.location.href=window.opener.location.href;
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
            // layer.closeAll(); //疯狂模式，关闭所有层
        }

        //渲染表单
        layui.use('form', function () {
            form = layui.form;
            //$('#x-city').xcity('广西','百色市','田东县');
            $('#mycity').mycity('广西');

            //监听提交
            form.on('submit(formDemo)', function (data) {
                $.ajax({
                    type: 'post',
                    url: '${ctx }address/update?id='+'${param.id}',
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

        //初始化用户信息
        function initAddress() {
            $.ajax({
                type: 'get',
                url: '${ctx }address/toupdate?id='+'${param.id}',
                dataType: 'json',
                success: function (result) {
                    layui.use([ 'form' ], function() {
                        form = layui.form;

                        //$('#x-city').xcity('广西','百色市','田东县');
                        $('#mycity').mycity(result.address.province,result.address.city,result.address.area);

                    });
                    var address = result.address;

                    $("input[name='name']").val(address.name);
                    $("input[name='type']").val(address.type);
                    $("input[name='address']").val(address.address);
                    $("input[name='detailaddress']").val(address.detailaddress);
                    $("input[name='phone']").val(address.phone);
                    $("input[name='mailNum']").val(address.mailNum);
                    $("input[name='province']").val(address.province);
                    $("input[name='city']").val(address.city);
                    $("input[name='area']").val(address.area);
                },
                error: function (msg) {
                    console.log(msg);
                    alert("初始化异常");
                }
            });
        }

        $(function () {
            initAddress();
        });

	</script>

</body>
</html>