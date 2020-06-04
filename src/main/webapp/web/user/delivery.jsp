<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/12/28
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
<%@ include file="/commViews/head.jsp"%>
<title>收货地址-广西科普传播中心</title>
<style>
/*为添加的空div设置的样式*/
.clearDiv {
	clear: both;
}

.white {
	color: #FFFFFF;
}

.label_title {
	display: inline;
	float: left;
	border-right: #2377cd 1px solid;
	padding: 10px 25px;
}

.lm_label {
	display: inline;
	float: left;
	padding: 10px 25px;
}

.lm_label_select {
	display: inline;
	float: left;
	background-color: #2377cd;
	padding: 10px 25px;
}

.div0_col0 {
	width: 60%;
	float: left;
}

.div0_col1 {
	width: 40%;
}

#index_main_div0_row0 {
	height: 57%;
}

#index_main_div0_row1 {
	height: 43%;
}

.news_list {
	font-size: 16px;
	display: table-cell;
	vertical-align: middle;
	width: 100%;
}

.news_list_time {
	color: #ababab;
	float: right;
	margin-right: 15px;
}

#newslists>ul {
	width: 100%;
	padding-top: 10px;
	padding-bottom: 10px;
	color: #696969;
	display: table;
	width: 100%;
	height: 40px;
}

#newslists>ul:nth-child(odd) {
	background-color: #f2f7fb;
}

#newslists>ul:nth-child(even) {
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
	border-top: 1px solid #efefef;
}

.header .txt {
	color: #333333;
	font-size: 19px;
	vertical-align: -4px;
	margin-left: 10px;
	margin-right: 10px;
}

.triangle-tip-up {
	width: 200px;
	background: #ffffff;
	border-radius: 4px;
	position: relative;
}

.triangle-tip-up:before {
	content: '';
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

.address_table>tbody>tr>td {
	border: 1px solid #e6e6e6;
	text-align: center;
	vertical-align: middle;
}

.address_table>tbody>tr:nth-child(odd) {
	border: 1px solid #e6e6e6;
	text-align: center;
	vertical-align: middle;
}

.address_table>tbody>tr:nth-child(even) {
	border: 1px solid #e6e6e6;
	text-align: center;
	vertical-align: middle;
}
</style>
</head>

<script type="text/javascript" src="${ctx}resource/js/mycity.js"></script>

<body style="background-color: #ffffff">
	<div id="main" style="margin-top: 0px">
		<!-- 主体居中 -->
		<!-- 主体分三个部分 banner label 主页信息主题区域 -->
		<%@ include file="/web/include/ucenter-head.jsp"%>

		<div id="newslistdiv" class="triangle-tip-up"
			style="width: 70%; min-width: 1302px; margin: 0px auto; height: auto; min-height: 700px; background-color: #FFFFFF">
			<%@ include file="/web/include/ucenter-left-menu.jsp"%>
			<div id="newslistdiv_right"
				style="width: 80%; margin-top: 15px; float: right; border: 1px solid #e8e8e8">
				<div style="width: 100%; background-color: #FAFAFA">
					<div style="color: #858585; margin-left: 15px; padding: 8px 0px;">
						<span><strong>收货地址</strong></span>
					</div>
				</div>

				<div
					style="width: 96%; padding: 0px 0px; margin: 20px auto; color: #343434">
					<div id="d1"
						style="font-size: 16px; margin-bottom: 20px; cursor: pointer;">
						<img src="${ctxRes}images/tj.png"
							style="margin-left: 5px; margin-right: 5px;"><span>新增收货地址</span>
					</div>
					<div id="d2" style="font-size: 14px; display: none">
						<form method="post" class="layui-form" id="main_form">
							<table style="color: #333333">
								<tr style="height: 45px">
									<td style="text-align: right"><span
										style="color: #E85958;">*</span><span style="font-size: 14px">收货人：</span></td>
									<td style="text-align: left"><input type="text"
										name="name" maxlength="20" placeholder=" 请输入收货人"
										lay-verify="required"
										style="font-size: 14px; width: 250px; border: 1px solid #e2e1e1; height: 32px; vertical-align: middle; line-height: 32px;">
									</td>
								</tr>
								<tr style="height: 45px">
									<td style="text-align: right"><span style="color: #E85958">*</span><span
										style="font-size: 14px">地址信息：</span></td>
									<td style="text-align: left">
										<%--<select name="address" style="color:#757575;font-size:14px;width:250px;border:1px solid #e2e1e1;height: 32px;vertical-align:middle;line-height: 32px;padding: 5px 0;">
                                    <option style="color: #757575;vertical-align:middle;">
                                        请选择省/市/区/街道
                                    </option>
                                </select>--%>
										<div class="layui-form-item" id="mycity">
											<div class="layui-input-inline" style="width: 200px;">
												<select id="province" name="province" lay-filter="province"
													lay-verify="required">
													<option value="">请选择省</option>
												</select>
											</div>
											<div class="layui-input-inline" style="width: 200px">
												<select id="city" name="city" lay-filter="city"
													lay-verify="required">
													<option value="">请选择市</option>
												</select>
											</div>
											<div class="layui-input-inline" style="width: 200px">
												<select id="area" lay-filter="area"
													lay-verify="required">
													<option value="">请选择区</option>
												</select>
											</div>
										</div>

									</td>
								</tr>
								<tr style="height: 45px">
									<td style="text-align: right"><span style="color: #E85958">*</span><span
										style="font-size: 14px">详细地址：</span></td>
									<td style="text-align: left"><input type="text"
										maxlength="100" lay-verify="required" name="detailaddress"
										placeholder=" 请输入详细地址"
										style="font-size: 14px; width: 250px; border: 1px solid #e2e1e1; height: 32px; vertical-align: middle; line-height: 32px;">
									</td>
								</tr>
								<tr style="height: 45px">
									<td style="text-align: right"><span style="color: #E85958">*</span><span
										style="font-size: 14px">手机号码：</span></td>
									<td style="text-align: left"><input id="phone"
										maxlength="11"  name="phone"
										placeholder=" 请输入你的手机号码"
										style="font-size: 14px; width: 250px; border: 1px solid #e2e1e1; height: 32px; vertical-align: middle; line-height: 32px;">
									</td>
								</tr>
								<tr style="height: 45px">
									<td style="text-align: right"><span style="font-size: 14px">邮政编码：</span></td>
									<td style="text-align: left"><input id="postcode"
										 maxlength="6" name="mailNum"
										placeholder=" 请输入邮政编码"
										style="font-size: 14px; width: 250px; border: 1px solid #e2e1e1; height: 32px; vertical-align: middle; line-height: 32px;">
									</td>
								</tr>
								<tr style="height: 45px; display: none">
									<td style="text-align: right"><span
										style="color: #E85958;"></span><span style="font-size: 14px">邮政编码：</span></td>
									<td style="text-align: left"><input type="text"
										name="userid" value="${sessionScope.USER_SESSION_NAME.id}"
										placeholder=" "
										style="font-size: 14px; width: 250px; border: 1px solid #e2e1e1; height: 32px; vertical-align: middle; line-height: 32px;">
									</td>
								</tr>
								<tr style="height: 45px">
									<td style="text-align: right"></td>
									<td style="text-align: left;"><input type="checkbox"
										name="state" value="1"
										style="background-color: #FFFFFF; vertical-align: middle;"><span
										style="font-size: 12px; vertical-align: middle;">设置为默认收货地址</span>
									</td>
								</tr>
								<tr style="height: 45px">
									<td style="text-align: right"></td>
									<td style="text-align: left;">
										<button id="insert" class="layui-btn" lay-submit
											lay-filter="insert" type="submit"
											style="font-size: 14px; color: #FFFFFF; background-color: #3683D1; border: 0px; border-radius: 2px;">保存</button>
									</td>
								</tr>
							</table>
						</form>
					</div>
					<div style="width: 100%; background-color: #f6f6f6">
						<div style="float: left"></div>
						<div
							style="float: left; margin-left: 10px; color: #9B9B9B; padding: 8px 0; vertical-align: middle">
							<span style="vertical-align: middle"><img
								src="${ctxRes}images/a.png"
								style="margin-left: 5px; margin-right: 5px; vertical-align: middle">最多只能保
								10 条最新地址，当前已经保存 <span id="tiao"></span> 条</span>
						</div>
						<div class="clearDiv"></div>
					</div>
					<div style="font-size: 14px;">
						<table id="demo" lay-filter="testTable" class="address_table"
							style="width: 1000px; margin-top: 10px;">
						</table>
					</div>

				</div>
			</div>
			<div class="clearDiv"></div>
		</div>
		<div class="clearDiv"></div>
	</div>
	<%@ include file="/web/include/footer.jsp"%>
</body>
<script type="text/html" id="barDemo">
    {{#  if(d.state == 1){ }}
    <button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="cancelState"><i class="layui-icon">&#x1007;</i>取消默认地址</button>
    {{#  } }}
    {{#  if(d.state == 0){ }}
    <button class="layui-btn layui-btn-xs" lay-event="changestate"><i class="layui-icon">&#x1005;</i>设为默认地址</button>
    {{#  } }}
    <button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update"><i class="layui-icon">&#xe642;</i>编辑</button>
    <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i>删除</button>
</script>
<script>
	//注意进度条依赖 element 模块，否则无法进行正常渲染和功能性操作
	layui.use('element', function() {
		var element = layui.element;
		$("#newslistdiv_left").height($("#newslistdiv_right").height() + 15);
	});
	layui.use([ 'form' ], function() {
		form = layui.form;

		$('#mycity').mycity('广西壮族自治区', '南宁市', '西乡塘区');

	});
</script>
<script>
	function ischeck(postcode){
           if (postcode != "") {   //邮政编码判断
               var pattern = /^[0-9]{6}$/;
               flag = pattern.test(postcode);
               if (!flag) {
                   return false;
               }else{
            	   return true;
               }
           }else{
        	   return false;
           }
	}
	function isPoneAvailable(phone) {
	    var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
	    if (!myreg.test(phone)) {                           
	        return false;
	    } else {
	        return true;
	    }
	}
	function deleteAddress(data, obj) {
		parent.layer.confirm('确定删除【' + data.name + '】吗 ?', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			//console.log(data);
			$.ajax({
				type : 'post',
				url : '${ctx }address/delete?id=' + data.id,
				dataType : 'json',
				success : function(result) {
					//console.log(result);
					if (result.status == 1) {
						obj.del();
						parent.layer.msg('删除成功', {
							icon : 1
						});
						location.reload();
					} else {
						parent.layer.msg('操作失败', {
							icon : 5
						});
					}

				},
				error : function(msg) {
					console.log(msg);
					alert("系统异常");
				}
			});
		}, function() {
		});
	}

	//设置默认地址
	function changestate(data, obj) {
		parent.layer.confirm('确定将【' + data.address + '】设置为默认地址吗?', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			//console.log(data);
			$.ajax({
				type : 'post',
				url : '${ctx }address/changestate?id=' + data.id + '&userid='
						+ userid,
				dataType : 'json',
				success : function(result) {
					//console.log(result);
					if (result.status == 1) {
						obj.del();
						parent.layer.msg('修改成功', {
							icon : 1
						});
						window.location.reload(true);
					} else {
						parent.layer.msg('操作失败', {
							icon : 5
						});
					}

				},
				error : function(msg) {
					console.log(msg);
					alert("系统异常");
				}
			});
		}, function() {
		});
	}

	//取消默认地址
    function cancelState(data, obj) {
        parent.layer.confirm('确定取消【' + data.address + '】默认地址吗?', {
            btn : [ '确定', '取消' ]
            //按钮
        }, function() {
            //console.log(data);
            $.ajax({
                type : 'post',
                url : '${ctx }address/cancelState?id=' + data.id,
                dataType : 'json',
                success : function(result) {
                    //console.log(result);
                    if (result.status == 1) {
                        obj.del();
                        parent.layer.msg('修改成功', {
                            icon : 1
                        });
                        window.location.reload(true);
                    } else {
                        parent.layer.msg('操作失败', {
                            icon : 5
                        });
                    }

                },
                error : function(msg) {
                    console.log(msg);
                    alert("系统异常");
                }
            });
        }, function() {
        });
    }

	$(function() {
		$('#d1').click(function() {//给d1绑定一个点击事件;

			/*这个判断的意义是,如果d2是隐藏的,那么让它显示出来,并将d1的文本内容替换成收起,
			 如果是显示的,那么就隐藏它并将d1的文本内容替换为展开;*/
			if ($('#d2').is(':hidden')) {
				$('#d2').slideDown('slow');
				$(this).find("span").text("收起收货地址");
			} else {
				$('#d2').slideUp('slow');
				$(this).find("span").text("新增收货地址");
			}

			/*这是一个很简单的事件处理,如果还需要跟上图片的变换,就在判断的对应位置写入图片或者背景变换的代码,*/
		});
	});
	function insert() {
		var fromDate = $('#main_form').serialize();
		var kk = $("#tiao");
		var a = kk.text();
		console.log("a:"+a);   
		if(!isPoneAvailable($("#phone").val())){
			layer.msg("手机号格式不正确");                          
			return false;
		}
		if ($("#postcode").val()) {
            if(!ischeck($("#postcode").val())){
                layer.msg("邮编格式不正确");
                return false;
            }
		}
		if (a < 10) {                                                           
			var area = $("#area").val().split(",");                
			fromDate+="&area="+area[0]+"&regioncode="+area[1];    
			$.ajax({                                                
				type : 'post',
				url : '${ctx }address/insert',
				data : fromDate,
				dataType : 'json',                                                  
				success : function(data) {
					if (data.status == 1) {           
						layer.msg(data.msg);
						window.location.reload(true);
					} else {
						layer.msg(data.msg, {
							icon : 5
						});                                          
					}
				},                           
				error : function(msg) {
					console.log(msg);
					alert("登录异常");
				}
			});
		} else {
			layer.msg("最多只能保存10条数据");
		}
	}
	///初始化查询
	function selectByObjecy() {
		getUserData(1);
		pageCurr = 1;
	}
	//获取用户列表 (条件查询)
	var userid = '${sessionScope.USER_SESSION_NAME.id}';
	function getUserAddress(pageNum) {
		/*userid = $("#userid").val();*/
		$.ajax({
			type : 'get',
			url : '${ctx }address/selectList?pageNum=' + pageNum + '&userid='
					+ userid,
			dataType : 'json',
			success : function(result) {
				console.log("jieguo:" + result);
				$("#tiao").append(result.count);
				if (result.count > 0) {
					initTable(result.list);
					initPage(result);
				} else {
					initTable([]);
					initPage(0);
				}
			},
			error : function(msg) {
				console.log(msg);
				alert("数据初始化异常");
			}
		});
	}
	//初始化表格
	function initTable(tableData) {
		layui.use('table', function() {
			var table = layui.table, form = layui.form;
			table.render({
				elem : '#demo'
				//,skin: 'line' //行边框风格
				//,even: true //开启隔行背景
				//,size: 'sm' //小尺寸的表格
				//,height: 345
				//,width:'auto'
				,
				data : tableData,
				page : false //关闭分页
				,
				loading : true
				//,count:200
				//,limit: 10 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
				//,limits:[10]
				,
				cols : [ [ //表头
				/*{
				    field : 'id',
				    title : '编号',
				    width : 80,
				    align : 'center',
				    fixed : 'left',
				    sort : true,
				    hidden:false
				},*/{
					field : 'name',
					title : '收货人',
					align : 'center',
				}, {
					field : 'address',
					title : '收货地址',
					align : 'center',
					sort : true
				}, {
					field : 'detailaddress',
					title : '详细地址',
					align : 'center',
					sort : true
				}, {
					field : 'mailNum',
					title : '邮编',
					align : 'center',
					sort : true
				}, {
					field : 'phone',
					title : '手机',
					align : 'center',
					sort : true
				}, {
					fixed : 'right',
					title : '操作',
					width : 280,
					align : 'center',
					// templet : '#stateTpl',
					toolbar : '#barDemo'
				} ] ],

			});

			//监听工具条
			table.on('tool(testTable)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
				var data = obj.data; //获得当前行数据
				var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				var tr = obj.tr; //获得当前行 tr 的DOM对象
				if (layEvent === 'update') { //编辑
					cen_showWin({
						width : '700px',
						height : '500px',
						type : 2,
						title : '编辑收货地址',
						url : '${ctx}web/user/address/update.jsp?id=' + data.id
					});
				} else if (layEvent === 'delete') { //删除
					deleteAddress(data, obj);
				} else if (layEvent === 'changestate') { //设置默认收货
					changestate(data, obj);
				}else if (layEvent === 'cancelState') { //取消默认收货
               		cancelState(data, obj);
				}
			});

		});
	}
	//初始化分页栏
	var pageCurr = 1;
	function initPage(pageData) {
		layui.use([ 'laypage', 'layer' ], function() {
			var laypage = layui.laypage, layer = layui.layer;
			laypage
					.render({
						elem : 'demo7',
						curr : pageCurr,
						count : pageData.count,
						layout : [ 'count', 'prev', 'page', 'next', 'refresh',
								'skip' ],
						jump : function(obj, first) {
							if (!first) {//首次不执行
								getUserAddress(obj.curr);
								pageCurr = obj.curr;
							}
						}
					});
		});
	}
	$(function() {
		getUserAddress(1);
	});

	$("#insert").on("click", function() {
		layui.use('form', function() {
			var form = layui.form;
			//监听提交
			form.on('submit(insert)', function(data) {
				insert();
				return false;
			});
		});
	})

	// 新建窗口
	function cen_showWin(param) {
		parent.layer.open({
			type : param.type,
			area : [ param.width, param.height ],
			title : param.title,
			closeBtn : 1,
			//shade: [0.1, '#FFFFFF'],
			shadeClose : true,
			skin : 'yourclass',
			resize : true,
			success : function(layero, index) {
				//console.log(layero, index);
			},
			content : param.url
		});
	}
</script>

</html>
