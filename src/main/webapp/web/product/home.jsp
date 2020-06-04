<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title id="title">订书订报-广西科普传播中心</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="keywords" content="">
		<meta name="description" content="">
		<link rel="stylesheet" href="${ctx }resource/plugins/layui/css/layui.css">
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

	<body style="background-color: white">
		<div id="main" style="margin-top: 0px">
			<div style="width:100%;background-image: url('${ctxRes}images/news_top.png');min-width:1302px;">
				<div id="main_center" style="width: 70%; min-width: 1302px; margin: 0px auto; padding-top: 20px;">
					<%@ include file="/web/include/head.jsp"%>
				</div>
			</div>
			<div class="bg" style="margin-top: 10px">
				<div  style="width: 100%;min-width: 1162px;background-color: white; margin: 10px 0px;height: 40px; border: 1px solid #E8E8E8">
					<div id="app" style="margin: 13px;">
						<el-breadcrumb separator-class="el-icon-arrow-right">
						<el-breadcrumb-item> <i class="layui-icon">&#xe68e;
						</i> 您当前的位置</el-breadcrumb-item> <el-breadcrumb-item> <a
							href="${ctx }">首页</a></el-breadcrumb-item>                                         
							<el-breadcrumb-item>商城</el-breadcrumb-item>
							 </el-breadcrumb>                                             
					</div>                                 
				</div>                
				<div style="display: flex; width: 100%; min-width: 1162px;">
					<div>
						<div class="layui-tab" style="margin-top: 0px">
							<div style="display: flex;border-bottom: 3px solid #a4df8d" id="xbsb">
								<div style="display: flex">             
									<a  href="${ctx }web/product/SelectList?pageNum=1&pageSize=16">
										<p style="margin: auto;font-size: 20px;color: #a4df8d;font-weight: bold;">小博士报</p>
									</a>
								</div>                
								<ul class="layui-tab-title" style="margin-left: auto;">
									<li style="float: right;">热门推荐</li>
									<li style="float: right;" class="layui-this">最新上架</li>
								</ul>
							</div>
							<div class="layui-tab-content">
                                <%--热门推荐--%>
								<div class="layui-tab-item"></div>
								<%--最新上架--%>
								<div class="layui-tab-item layui-show">             
									<div class="product" style="display: flex; width: 1025px; height: 500px; margin-top: 10px; flex-wrap: wrap; border-left: 1px solid #CDD5CA; border-top: 1px solid #CDD5CA;">
										<div style="background-color: #DEEED4; height: 100%; flex: 1; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box;">
											<a href="${ctx}web/product/details/${recommend[0].id}.html" style="" target="_blank" title="${i.description}">
												<div style="width: 100%; height: 25%; display: flex">
													<div style="margin: 70px 30px auto 30px; text-align: left;">
														<p style="font-size: 18px; font-weight: bold;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">${recommend[0].name}</p>
														<p style="color: gray;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">${recommend[0].description}</p>                 
													</div>     
												</div>         
												<div style="width: 100%; height: 75%; display: flex">          
													<img style="height: 57%; width: auto; margin: auto" alt="" src="${ctxUphoto}${recommend[0].image}">
												</div>               
											</a>
										</div>
										<div style="height: 100%; flex: 3; display: flex; flex-wrap: wrap;">
											<div style="height: 50%; width: 50%; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box; display: flex; flex-flow: column;">
												<div style="width: 100%; height: 85%; display: flex">
													<img style="margin: auto; height: 80%; width: auto" src="${ctxUphoto}${recommend[1].image}">
												</div>             
												<div style="width: 100%; height: 15%; background-color: #A9DC8D; border-top: 1px solid #CDD5CA; display: flex">
													<p style="margin: auto; color: white;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 1;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">${recommend[1].description}</p>
												</div>     
											</div>
											<c:forEach var="i" end="7" begin="2" items="${list}" varStatus="status">
												<div class="small_list">
													<img class="small_list_img" src="${ctxUphoto}${i.image}">
													<img class="white2" src="${ctxUphoto}${i.image}" onerror="this.src='${ctxRes}/images/404-img.jpg'">
													<p>数字化时代</p>
												</div>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="layui-tab">
							<div style="display: flex;border-bottom: 3px solid #FBB49E" id="nfkj">
								<div style="display: flex">
									<p style="margin: auto;font-size: 20px;color: #FBB49E;font-weight: bold;">南方科技</p>
								</div>
								<ul class="layui-tab-title" style="margin-left: auto;">
									<li style="float: right;">热门推荐</li>
									<li style="float: right;" class="layui-this">最新上架</li>
								</ul>
							</div>
							<div class="layui-tab-content">      
								<div class="layui-tab-item"></div>
								<div class="layui-tab-item layui-show">
									<div class="product" style="display: flex; width: 1025px; height: 500px; margin-top: 10px; flex-wrap: wrap; border-left: 1px solid #CDD5CA; border-top: 1px solid #CDD5CA;">
										<div style="background-color: #F6D4CB; height: 100%; flex: 1; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box;">
											<div style="width: 100%; height: 25%; display: flex">
												<div style="margin: 70px 30px auto 30px; text-align: left;">
													<p style="font-size: 18px; font-weight: bold;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">高尔基自传三部曲</p>
													<p style="color: gray;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;font-size: 16px;">语文新课标必读</p>
												</div>       
											</div>
											<div style="width: 100%; height: 75%; display: flex ">
												<img style="height: 57%; width: auto; margin: auto" src="${ctx }resource/images/home/01.png">
											</div>         
										</div>        
										<div style="height: 100%; flex: 3; display: flex; flex-wrap: wrap;">
											<div style="height: 50%; width: 50%; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box; display: flex; flex-flow: column;">
												<div style="width: 100%; height: 85%; display: flex">
													<a href="www.baidu.com"><img style="margin: auto; height: 80%; width: auto" src="${ctx }resource/images/home/02.png"></a>
												</div>
												<div style="width: 100%; height: 15%; background-color: #FBB49E; border-top: 1px solid #CDD5CA; display: flex">
													<p style="margin: auto; color: white;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 1;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">愿为你赴一场前路不明的旅途</p>
												</div>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/03.png">
												<p>数字化时代</p>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/04.png">
												<p>数字化时代</p>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/05.png">
												<p>数字化时代</p>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/06.png">
												<p>数字化时代</p>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/07.png">
												<p>数字化时代</p>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/08.png">
												<p>数字化时代</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="layui-tab">
							<div style="display: flex;border-bottom: 3px solid #4DAFDC" id="jtyy">
								<div style="display: flex">
									<p style="margin: auto;font-size: 20px;color: #4DAFDC;font-weight: bold;">家庭医药</p>
								</div>
								<ul class="layui-tab-title" style="margin-left: auto;">
									<li style="float: right;">热门推荐</li>
									<li style="float: right;" class="layui-this">最新上架</li>
								</ul>
							</div>
							<div class="layui-tab-content">
								<div class="layui-tab-item"></div>
								<div class="layui-tab-item layui-show">
									<div class="product" style="display: flex; width: 1025px; height: 500px; margin-top: 10px; flex-wrap: wrap; border-left: 1px solid #CDD5CA; border-top: 1px solid #CDD5CA;">
										<div style="background-color: #D3E5EF; height: 100%; flex: 1; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box;">
											<div style="width: 100%; height: 25%; display: flex">
												<div style="margin: 70px 30px auto 30px; text-align: left;">
													<p style="font-size: 18px; font-weight: bold;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">高尔基自传三部曲</p>
													<p style="color: gray;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;font-size: 16px;">语文新课标必读</p>
												</div>
											</div>
											<div style="width: 100%; height: 75%; display: flex">
												<img style="height: 57%; width: auto; margin: auto" alt="" src="${ctx }resource/images/home/01.png">
											</div>
										</div>
										<div style="height: 100%; flex: 3; display: flex; flex-wrap: wrap;">
											<div style="height: 50%; width: 50%; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box; display: flex; flex-flow: column;">
												<div style="width: 100%; height: 85%; display: flex">
													<img style="margin: auto; height: 80%; width: auto" src="${ctx }resource/images/home/02.png">
												</div>
												<div style="width: 100%; height: 15%; background-color: #4DAFDC; border-top: 1px solid #CDD5CA; display: flex">
													<p style="margin: auto; color: white;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 1;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">愿为你赴一场前路不明的旅途</p>
												</div>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/03.png">
												<p>数字化时代</p>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/04.png">
												<p>数字化时代</p>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/05.png">
												<p>数字化时代</p>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/06.png">
												<p>数字化时代</p>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/07.png">
												<p>数字化时代</p>
											</div>
											<div class="small_list">
												<img class="small_list_img" src="${ctx }resource/images/home/08.png">
												<p>数字化时代</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div style="display:flex;margin-left: 30px; flex: 2; background-color: #F5F5F5; height: 10%; width: 100%; flex-direction: column;">
						<div class="layui-tab layui-tab-card" style="display:flex;margin:0px;flex-direction: column;height: auto;">
							<ul class="layui-tab-title">
								<li class="layui-this" style="border-top: 3px solid #085099;">热门推荐</li>
							</ul>
							<div class="layui-tab-content" style="flex:auto;background-color: white;">
								<div class="layui-tab-item layui-show" style="height: 100%;">
									<c:forEach var="i" begin="0" items="${recommend}" varStatus="status">
										<a href="${ctx}web/product/details/${i.id}.html" style="" target="_blank" title="${i.description}">
											<div class="popular_recommendations" onmousemove="showImg(this)" onmouseleave="hideImg(this)">
												<p style="margin: auto 0px auto 5px">${status.index+1}.</p>
												<p style="margin: auto 5px auto 0px;"><img alt="" class="popular_recommendations_img" src="${ctxUphoto}${i.image}"> ${i.name}</p>
											</div>
										</a>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="/web/include/footer.jsp"%>
	</body>
	<script>                  
		new Vue().$mount('#app'); 
		function showImg(x) {
			$($(x).find("img")[0]).show();
		}

		function hideImg(x) {
			$($(x).find("img")[0]).hide();
		}
		//注意：选项卡 依赖 element 模块，否则无法进行功能性操作
		layui.use('element', function() {
			var element = layui.element;

			//…
		});
	</script>
	<style>
		.small_list>p {
			overflow: hidden;
			/* white-space: nowrap; */
			text-overflow: ellipsis;
			-webkit-line-clamp: 2;
			word-break: break-all;
			display: -webkit-box;
			-webkit-box-orient: vertical;
		}
		
		.layui-tab {
			margin: 30px 0;
		}
		
		#xbsb .layui-tab-title .layui-this:after {
				border: 3px solid #a4df8d;border-bottom: 4px solid #ffffff;top: 3px;margin-top: -3px;
		}

		#nfkj .layui-tab-title .layui-this:after {
			border: 3px solid #FBB49E;border-bottom: 4px solid #ffffff;top: 3px;margin-top: -3px;
		}

		#jtyy .layui-tab-title .layui-this:after {
			border: 3px solid #4DAFDC;border-bottom: 4px solid #ffffff;top: 3px;margin-top: -3px;
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
	</style>
	<style>
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
			width: 1250px;
			height: auto;
			min-height: 275px;
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
			border: 0px solid #dedede;
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
		
		.layui-btn-warm {
			background-color: #1e9fff;
		}
		
		.details {
			border: 1px solid #dedede;
			float: left;
			margin: 50px 0px;
			width: 950px;
			height: auto;
		}
		
		.product2 {
			border-top: 1px solid #dedede;
			margin-top: 10px;
			width: 240px;
			height: 330px;
			float: left;
			margin-right: 20px;
			background-color: white;
			border: 1px solid white;
		}
		
		.product2:hover,
		.product3:hover {
			border: 1px solid orange;
			border-radius: 2px;
		}
		
		.product3 {
			border-top: 0px solid #dedede;
			margin-top: 10px;
			width: 100%;
			height: 300px;
			background-color: white;
			border: 1px solid white;
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
		
		.small_list {
			height: 50%;
			width: 25%;
			border: 1px solid #CDD5CA;
			box-sizing: border-box;
			border-top: 0px;
			border-left: 0px;
			display: flex;
			text-align: center;
			flex-flow: column
		}
		
		.small_list_img {
			margin: 20% auto 10% auto;
			height: 60%;
			width: auto;               
			max-width: 80%;
		}
		/* .layui-tab-title {
	border-bottom: 3px solid #A4DF8D;
} */
		
		.layui-tab-content {
			padding: 0px
		}
		/* .layui-this {
	border-bottom: 3px solid white;
}
 */
		
		.layui-badge-rim {
			border-color: #a4df8d;
		}
		
		.popular_recommendations {
			/*热门推荐*/
			display: flex;
			min-height: 40px;
			height: auto;
			border-bottom: 1px solid #f2f2f2;
		}
		
		.popular_recommendations_img {
			display: none;
			margin: 5px 0px;
			height: auto;
			width: 80px
		}
		.layui-tab-title>li{                                       
			background-color: #f2f2f2;
			margin-top: 3px;height: 38px;
		}
		.layui-this{                                  
			background-color: white !important;
		}
	</style>

</html>