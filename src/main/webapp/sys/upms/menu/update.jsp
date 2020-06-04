<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>编辑菜单</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="keywords" content="">
	<meta name="description" content="">
	<%@ include file="/commViews/head.jsp" %>
</head>
<body>

<!-- 菜单添加 -->
<form class="layui-form layui-form-pane" id="main_form" style="">

	<div style="padding: 5px;">
		<div class="layui-row layui-col-space15">
			<div class="layui-col-md12">
				<div class="layui-card">
					<%--<div class="layui-card-header">添加菜单</div>--%>
					<div class="layui-card-body">
						<div class="layui-form-item">
							<label class="layui-form-label">菜单名称</label>
							<div class="layui-input-inline">
								<input type="text" name="menuName" lay-verify="required" placeholder="请输入"
									   autocomplete="off" class="layui-input">
							</div>
							<label class="layui-form-label">排序</label>
							<div class="layui-input-inline">
								<input type="number" name="orderNo" lay-verify="required" placeholder="请输入"
									   autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">URL</label>
							<div class="layui-input-inline">
								<input type="text" name="url" lay-verify="required" placeholder="请输入" autocomplete="off"
									   class="layui-input">
							</div>
							<label class="layui-form-label">权限标识</label>
							<div class="layui-input-inline">
								<input type="text" name="power" lay-verify="required" placeholder="请输入"
									   autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">Icon</label>
							<div class="layui-input-block">
								<input type="hidden" name="icon" value="default_icon_menu.jpg" id="icon_upload_val"/>
								<img id="icon_upload_img" src="${ctx}uploadFiles/photo/default_icon_menu.jpg" style="margin-left:10px;height:30px;width:auto;">
								<a id="icon_upload" class="layui-btn layui-btn-primary" style="margin-left: 5px;"><i class="layui-icon"></i></a>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">类型</label>
							<div class="layui-input-block">
								<input type="radio" name="isMenu" value="1" title="菜单">
								<input type="radio" name="isMenu" value="0" title="模块">
								<input type="radio" name="isMenu" value="2" title="手机菜单">
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-input-block">
								<input type="hidden" name="id" value="${param.id}">
								<button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</form>

<script>

    //渲染表单
    function renderForm() {
		layui.use('form', function () {
			var form = layui.form;

			//监听提交
			form.on('submit(formDemo)', function (data) {
				$.ajax({
					type: 'post',
					url: '${ctx }sys/upms/menu/update',
					data: $('#main_form').serialize(),
					success: function (result) {
						if (result.status == 1) {
							parent.layer.alert(result.msg, {icon: 1}, function () {
								window.parent.frames["菜单管理"].location.reload();// 刷新父窗口
								parent.layer.closeAll();
							});
						} else {
							alert("操作失败");
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
	}

    //初始化菜单
    function initRole(){
        $.ajax({
            type:'post',
            url:'${ctx }sys/upms/menu/selectById?mid=${param.id}',
            //data:$('#main_form').serialize(),
            dataType:"json",
            success:function(result){
				$("input[name='menuName']").val(result.menu.menuName);
                $("input[name='orderNo']").val(result.menu.orderNo);
                $("input[name='url']").val(result.menu.url);
                $("input[name='power']").val(result.menu.power);
                $("input[name='icon']").val(result.menu.icon);
                $("#icon_upload_img").attr("src","${ctx}uploadFiles/photo/"+result.menu.icon);

                $("input[name='isMenu']").each(function (){
                    if($(this).val()==result.menu.isMenu) $(this).attr("checked","checked");
				});
                renderForm(); //重新渲染表单
            },
            error:function (msg){
                alert("菜单初始化异常");
            }
        });
    }


    $(document).ready(function () {
        initRole();
    });


    layui.use('upload', function(){
        var $ = layui.jquery
            ,upload = layui.upload;
        //多图片上传
        upload.render({
            type : "POST",
            elem: '#icon_upload'
            ,url: '${ctx}base/uploadfile'
            ,multiple: true
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#icon_upload_img').attr("src",result);
                });
            }
            ,done: function(res){
                $("#icon_upload_val").val(res.fileName)
                //$("#icon_upload_val").val("${ctx}uploadFiles/photo/"+res.fileName)
                console.log(res)//上传完毕
            }
        });
    });

</script>

</body>


</html>