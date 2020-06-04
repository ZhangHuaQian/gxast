<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>订单支付-广西科普传播中心</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="keywords" content="">
<meta name="description" content="">
<link rel="stylesheet"
	href="${ctx }resource/plugins/layui/css/layui.css">
<link rel="stylesheet" href="${ctx }resource/css/css.css">
<%@ include file="/commViews/head.jsp"%>
<script src="${ctxRes}js/index.js"></script>
<!-- vue -->
<script src="${ctxRes}plugins/vue/vue.js"></script>
<!--ajax  -->
<script src="${ctxRes}plugins/vue/vue-resource.min.js"></script>
<!-- 引入样式 -->
<link rel="stylesheet" href="${ctxRes}plugins/vue/index.css">
<!-- 引入组件库 -->
<script src="${ctxRes}plugins/vue/index.js"></script>
</head>
<style>
.remark{
    border: 1px solid #ccc;
    padding: 7px 0px;
    border-radius: 3px;
    padding-left:5px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
}
.remark:focus{
    border-color: #66afe9;
    outline: 0;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
}
.bg {
	margin: 10px auto;
	width: 70%;
	height: auto;
	min-width: 1302px;
}

h2 {
	margin-left: 15px;
	font-size: 18px;
	font-family: NSimSun;
	float: left;
}

img {
	width: 100%;
	height: 100%;
}

.bottom {
	color: #c1c0c0;            
	margin-top: 50px;
	background-color: #565656;
	text-align: center;  
	height: 20%;
	display: block;
}

.w {
	padding: 5px;
}

.product {
	width: 1300px;
	height: auto;
	min-height: 400px;
}

.pictrue {
	width: 500px;
	height: 100%;
	float: left;
}

.price {
	width: 698px;
	height: 100%;
	float: left;
	margin-left: 50px;
	border: 0px 1px solid #dedede;
}

.left_list {
	background-color: white;
	border: 1px solid #dedede;
	margin: 50px 40px 0px 0px;
	width: 260px;
	float: left;
	margin: 50px 40px 0px 0px;
	width: 260px;
	float: left;
	height: auto;
}

.details {
	border: 1px solid #dedede;
	float: left;
	margin: 50px 0px;
	width: 998px;
	height: auto;
}

.product2 {
	border-top: 1px solid #dedede;
	margin-top: 10px;
	width: 100%;
	height: 252px;
	float: left;
}

.white2 {
	width: 100%;
	height: 75%;
}

.white1 {
	width: 100%;
	height: 25%;
	background-color: white;
}

.orange {
	font-size: 12px;
	color: #f00;
	float: right;
	border: 1px solid #f00;
	border-radius: 5px;
	margin: 4px 8px 0px 0px
}

.buy {
	border-radius: 5px;
	border: 0px;
	flex: 1;
	background-color: #E64346;
	height: 50px;
	width: 170px;
	text-align: center;
}

.list {
	font-size: 18px;
	padding: 2px
}

.ripple {
	position: relative; // 此处不需要设置overflow: hidden, 因为after元素需要溢出显示
}

.ripple:focus {
	outline: none;
}

.ripple:after {
	content: "";
	display: block;
	position: absolute; //扩大伪类元素4个方向各10px top: -10px;
	left: -10px;
	right: -10px;
	bottom: -10px;
	pointer-events: none;
	background-color: #333;
	background-repeat: no-repeat;
	background-position: 50%;
	opacity: 0;
	transition: all .3s;
}

.ripple:active:after {
	opacity: .3; //
设置初始状态 top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	transition: 0s;
}
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

.tabhead {
	margin-top: 20px;
	background-color: #f2f2f2;
	width: 100%;
	height: 40px;
	border: 1px solid #e8e8e8;
	background-color: #f2f2f2;
}

.tabcontent {
	background: white;
	border-right: 1px solid #e8e8e8;
}

.pay-btn{
	background-color: #24a838;
	border: 0px;
	width: 100px;
	height: 35px;
	color: white;
}
.pay-btn:hover{
	background-color: #079e19;
	cursor:pointer;
}

.layui-layer-title {
	padding: 0px;
	height: 20px;
	line-height: 20px;
	font-size: 14px;
	overflow: hidden;
	cursor: move;
	position: absolute;
	bottom: 20px;
	left: 75px;
	border-bottom: 0px;
	background-color: white;
	border-radius: 2px 2px 0 0;
	z-index: 19991019;
}

</style>
<body style="background-color: white;min-height: 1000px">
	<div
		style="width:100%;background-image: url('${ctxRes}images/news_top.png');min-width:1302px;">
		<div id="main_center"
			style="height: 120px; width: 70%; min-width: 1302px; margin: 0px auto; padding-top: 20px;">
			<%@ include file="/web/include/head.jsp"%>
		</div>
	</div>
	<div class="bg" style="margin-top: 10px;margin-bottom: 100px ">          
		<div                            
			style="width: 100%;min-width: 1162px;background-color: white; margin: 10px 0px;height: 40px; border: 1px solid #E8E8E8">
			<div id="app" style="margin: 13px;">                
				<el-breadcrumb separator-class="el-icon-arrow-right">
				<el-breadcrumb-item> <i class="layui-icon">&#xe68e;
				</i> 您当前的位置<i class="layui-icon" style="margin-left: 5px;color: #c0c4cc">&#xe602;</i> </el-breadcrumb-item> <el-breadcrumb-item> <a
						href="${ctx }/web/product/home">商城首页<i class="layui-icon" style="margin-left: 5px;color: #c0c4cc">&#xe602;</i></a></el-breadcrumb-item> <el-breadcrumb-item>支付成功</el-breadcrumb-item>
				</el-breadcrumb>
			</div>
		</div>

		<div id="main" style="">                                                  
   		</div>                      
   		<hr style="margin:20px 0px;width: 100%; margin-top: 15px; background-color: #e8e8e8; height: 1px; border: none" />

		<div style="border: 1px solid #e8e8e8; padding: 10px;height: 50px;">
			<div style="float: left;padding-left: 10px;font-weight: 900;">
				<i class="layui-icon" style="font-size: 40px;color: #24a838;">&#xe605;</i>
			</div>
			<div style="float: left;padding: 10px;font-size: 20px;font-weight: 500;">
				支付成功
			</div>

			<div style="padding: 13px;">
				<input style="margin-left: 10px;height: 25px;" class="pay-btn" type="button" value="查看订单" onclick="orderDetail()">
			</div>

		</div>

	</div>

</body>        
<script>                                 

    function orderDetail() {
        window.location.href = "${ctx }web/user/order_details.jsp?id=${param.id}"
    }

</script>
</html>
