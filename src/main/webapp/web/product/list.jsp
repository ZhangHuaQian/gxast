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

	<body style="background-color:white">                        
		<div id="main" style="margin-top: 0px">
			<div style="width:100%;background-image: url('${ctxRes}images/news_top.png');min-width:1302px;">
				<div id="main_center" style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 20px;">
					<%@ include file="/web/include/head.jsp"%>
				</div>
			</div>
			<div class="bg" style="margin-top: 10px">
				<div style="width: 100%;min-width: 1162px;background-color: white; margin: 10px 0px;height: 40px; border: 1px solid #E8E8E8">
					<div id="app" style="margin: 13px;">
						<span><i class="layui-icon">&#xe68e;</i> 您当前的位置<i class="layui-icon" style="margin-left: 5px;color: #c0c4cc">&#xe602;</i></span>
						<span><a href="${ctx }">首页<i class="layui-icon" style="margin-left: 5px;color: #c0c4cc">&#xe602;</i></a></span>
						<span>商城</span>

						<div style="float: right;position: relative">
							<a style="position: absolute;right: 13px;padding: 7px;top: -8px;" href="javascript:void(0)" onclick="productSearch()"><i class="layui-icon">&#xe615;</i></a>
							<input type="text" id="keyWord"  placeholder="请输入商品名称" class="layui-input search">
						</div>
					</div>
				</div>

				<div style="display: flex;width: 100%;min-width: 1162px;">
					<div class="product" style="width: 1030px;height: auto;margin-right: 20px;">
						<div>
							<%-- 小博士报 --%>
							<div class="layui-tab" style="margin-top: 0px">
								<div style="display: flex;border-bottom: 3px solid #a4df8d" id="xbsb">
									<div style="display: flex">
										<p style="margin: auto;font-size: 20px;color: #a4df8d;font-weight: bold;">小博士报</p>
									</div>
									<ul class="layui-tab-title" style="margin-left: auto;">
										<li style="float: right;" class=""><a href="${ctx}web/product/selectMore.jsp?type=${xbsb[0].type}">查看更多</a></li>
										<li style="float: right;" class="layui-this">最新上架</li>
									</ul>
								</div>
								<div class="layui-tab-content">
									<div class="layui-tab-item layui-show">
										<div class="product" style="display: flex; width: 1029px; height: 500px; margin-top: 10px; flex-wrap: wrap; border-left: 1px solid #CDD5CA; border-top: 1px solid #CDD5CA;">
											<div style="background-color: #DEEED4; height: 100%; flex: 1; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box;">
												<a href="${ctx}web/product/details/${xbsb[0].id}.html" style="" target="_blank" title="">
													<div style="width: 100%; height: 25%; display: flex">
														<div style="margin: 70px 30px auto 30px; text-align: left;">
															<p style="font-size: 18px; font-weight: bold;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">${xbsb[0].name}</p>
															<p style="color: gray;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">${xbsb[0].description}</p>
														</div>
													</div>
													<div style="width: 100%; height: 75%; display: flex">
														<img style="height: 57%; width: auto; margin: auto" alt="" src="${ctxUphoto}${xbsb[0].image}">
													</div>
												</a>
											</div>
											<div style="height: 100%; flex: 3; display: flex; flex-wrap: wrap;">
												<a href="${ctx}web/product/details/${xbsb[1].id}.html" target="_blank" style="height: 50%; width: 50%; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box; display: flex; flex-flow: column;">
														<div style="width: 100%; height: 85%; display: flex">
															<img style="margin: auto; height: 80%; width: auto"
																 src="${ctxUphoto}${xbsb[1].image}">
														</div>
														<div style="width: 100%; height: 15%; background-color: #A9DC8D; border-top: 1px solid #CDD5CA; display: flex">
															<p style="margin: auto; color: white;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 1;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">${xbsb[1].name}</p>
														</div>
												</a>
												<c:forEach var="i" begin="2" end="7" items="${xbsb}" varStatus="status">
													<a class="small_list" href="${ctx}web/product/details/${i.id}.html" target="_blank">
														<img class="small_list_img" src="${ctxUphoto}${i.image}">
														<p>${i.name}</p>
													</a>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
							</div>
								<%--南方科技报--%>
							<div class="layui-tab">
								<div style="display: flex;border-bottom: 3px solid #FBB49E" id="nfkj">
									<div style="display: flex">
										<p style="margin: auto;font-size: 20px;color: #FBB49E;font-weight: bold;">南方科技报</p>
									</div>
									<ul class="layui-tab-title" style="margin-left: auto;">
										<li style="float: right;"><a href="${ctx}web/product/selectMore.jsp?type=${nfkj[0].type}">查看更多</a></li>
										<li style="float: right;" class="layui-this">最新上架</li>
									</ul>
								</div>
								<div class="layui-tab-content">
									<div class="layui-tab-item">
										<div class="product" style="display: flex; width: 1029px; height: 500px; margin-top: 10px; flex-wrap: wrap; border-left: 1px solid #CDD5CA; border-top: 1px solid #CDD5CA;">
											<a href="${ctx}web/product/details/${nfkj[0].id}.html" style="background-color: #F6D4CB; height: 100%; flex: 1; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box;" target="_blank">
													<div style="width: 100%; height: 25%; display: flex">
														<div style="margin: 70px 30px auto 30px; text-align: left;">
															<p style="font-size: 18px; font-weight: bold;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">${nfkj[0].name}</p>
															<p style="color: gray;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;font-size: 16px;">${nfkj[0].description}</p>
														</div>
													</div>
													<div style="width: 100%; height: 75%; display: flex ">
														<img style="height: 57%; width: auto; margin: auto"
															 src="${ctxUphoto}${nfkj[0].image}">
													</div>
											</a>
											<div style="height: 100%; flex: 3; display: flex; flex-wrap: wrap;">
												<a href="${ctx}web/product/details/${nfkj[1].id}.html" style="height: 50%; width: 50%; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box; display: flex; flex-flow: column;" target="_blank">
														<div style="width: 100%; height: 85%; display: flex">
															<img style="margin: auto; height: 80%; width: auto"
																 src="${ctxUphoto}${nfkj[1].image}">
														</div>
														<div style="width: 100%; height: 15%; background-color: #FBB49E; border-top: 1px solid #CDD5CA; display: flex">
															<p style="margin: auto; color: white;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 1;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">${nfkj[1].name}</p>
														</div>
												</a>
												<c:forEach var="i" begin="2" end="7" items="${nfkj}" varStatus="status">
													<a class="small_list" href="${ctx}web/product/details/${i.id}.html" target="_blank">
														<img class="small_list_img" src="${ctxUphoto}${i.image}">
														<p>${i.name}</p>
													</a>
												</c:forEach>
											</div>
										</div>
									</div>
									<div class="layui-tab-item layui-show">
										<div class="product" style="display: flex; width: 1029px; height: 500px; margin-top: 10px; flex-wrap: wrap; border-left: 1px solid #CDD5CA; border-top: 1px solid #CDD5CA;">
											<a href="${ctx}web/product/details/${nfkj[0].id}.html" style="background-color: #F6D4CB; height: 100%; flex: 1; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box;" target="_blank">
													<div style="width: 100%; height: 25%; display: flex">
														<div style="margin: 70px 30px auto 30px; text-align: left;">
															<p style="font-size: 18px; font-weight: bold;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">${nfkj[0].name}</p>
															<p style="color: gray;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;font-size: 16px;">${nfkj[0].description}</p>
														</div>
													</div>
													<div style="width: 100%; height: 75%; display: flex ">
														<img style="height: 57%; width: auto; margin: auto"
															 src="${ctxUphoto}${nfkj[0].image}">
													</div>
											</a >
											<div style="height: 100%; flex: 3; display: flex; flex-wrap: wrap;">
												<a href="${ctx}web/product/details/${nfkj[1].id}.html" style="height: 50%; width: 50%; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box; display: flex; flex-flow: column;" target="_blank">
														<div style="width: 100%; height: 85%; display: flex">
															<img style="margin: auto; height: 80%; width: auto"
																 src="${ctxUphoto}${nfkj[1].image}">
														</div>
														<div style="width: 100%; height: 15%; background-color: #FBB49E; border-top: 1px solid #CDD5CA; display: flex">
															<p style="margin: auto; color: white;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 1;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">${nfkj[1].name}</p>
														</div>
												</a>
												<c:forEach var="i" begin="2" end="7" items="${nfkj}" varStatus="status">
													<a class="small_list" href="${ctx}web/product/details/${i.id}.html" target="_blank">
														<img class="small_list_img" src="${ctxUphoto}${i.image}">
														<p>${i.name}</p>
													</a>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
							</div>
								<%--家庭医药--%>
							<div class="layui-tab">
								<div style="display: flex;border-bottom: 3px solid #4DAFDC" id="jtyy">
									<div style="display: flex">
										<p style="margin: auto;font-size: 20px;color: #4DAFDC;font-weight: bold;">家庭医药</p>
									</div>
									<ul class="layui-tab-title" style="margin-left: auto;">
										<li style="float: right;"><a href="${ctx}web/product/selectMore.jsp?type=${jtyy[0].type}">查看更多</a></li>
										<li style="float: right;" class="layui-this">最新上架</li>
									</ul>
								</div>
								<div class="layui-tab-content">
									<div class="layui-tab-item"></div>
									<div class="layui-tab-item layui-show">
										<div class="product" style="display: flex; width: 1029px; height: 500px; margin-top: 10px; flex-wrap: wrap; border-left: 1px solid #CDD5CA; border-top: 1px solid #CDD5CA;">
											<a href="${ctx}web/product/details/${jtyy[0].id}.html" style="background-color: #D3E5EF; height: 100%; flex: 1; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box;" target="_blank">
													<div style="width: 100%; height: 25%; display: flex">
														<div style="margin: 70px 30px auto 30px; text-align: left;">
															<p style="font-size: 18px; font-weight: bold;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">${jtyy[0].name}</p>
															<p style="color: gray;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;font-size: 16px;">${jtyy[0].description}</p>
														</div>
													</div>
													<div style="width: 100%; height: 75%; display: flex">
														<img style="height: 57%; width: auto; margin: auto" alt=""
															 src="${ctxUphoto}${jtyy[0].image}">
													</div>
											</a>
											<div style="height: 100%; flex: 3; display: flex; flex-wrap: wrap;">
												<a href="${ctx}web/product/details/${jtyy[1].id}.html" style="height: 50%; width: 50%; border: 1px solid #CDD5CA; border-left: 0px; border-top: 0px; box-sizing: border-box; display: flex; flex-flow: column;">
														<div style="width: 100%; height: 85%; display: flex">
															<img style="margin: auto; height: 80%; width: auto"
																 src="${ctxUphoto}${jtyy[1].image}">
														</div>
														<div style="width: 100%; height: 15%; background-color: #4DAFDC; border-top: 1px solid #CDD5CA; display: flex">
															<p style="margin: auto; color: white;overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 1;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;">
																${jtyy[1].name}</p>
														</div>
												</a>
												<c:forEach var="i" begin="2" end="7" items="${jtyy}" varStatus="status">
													<a class="small_list" href="${ctx}web/product/details/${i.id}.html" target="_blank">
														<img class="small_list_img" src="${ctxUphoto}${i.image}">
														<p>${i.name}</p>
													</a>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<%-- 小博士报  热门推荐--%>
					<div>
						<div style="height: 555px;width: 100%;display: block">
							<div style="background-color: #F5F5F5; width: 148%; flex-direction: column;">
								<div class="layui-tab" style="border: 1px solid #f2f2f2;border-radius: 2px;display:flex;margin:0px;flex-direction: column;height: auto;">
									<ul class="layui-tab-title">
										<li class="layui-this" style="margin-top: 0px;border-top: 3px solid #a4df8d;">热门推荐</li>
									</ul>
									<div class="layui-tab-content" style="flex:auto;background-color: white;">
										<div class="layui-tab-item layui-show" style="height: 100%;">
											<c:forEach var="i" begin="0" items="${recommend_xbsb}" varStatus="status">
												<a href="${ctx}web/product/details/${i.id}.html" style="" target="_blank" title="${i.description}" target="_blank">
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
						<%-- 南方科技报 热门推荐--%>
						<div style="height: 555px;width: 100%;display: block;margin-top: 10px;">
							<div style="background-color: #F5F5F5; height: 10%; width: 148%; flex-direction: column;">
								<div class="layui-tab" style="border: 1px solid #f2f2f2;border-radius: 2px;display:flex;margin:0px;flex-direction: column;height: auto;">
									<ul class="layui-tab-title">
										<li class="layui-this" style="margin-top: 0px;border-top: 3px solid #fbb49e;">热门推荐</li>
									</ul>
									<div class="layui-tab-content" style="flex:auto;background-color: white;">
										<div class="layui-tab-item layui-show" style="height: 100%;">
											<c:forEach var="i" begin="0" items="${recommend_nfkj}" varStatus="status">
												<a href="${ctx}web/product/details/${i.id}.html" style="" target="_blank" title="${i.description}" target="_blank">
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
						</div >
						<%-- 家庭医药  热门推荐--%>
						<div style="height: 555px;width: 100%;margin-top: 10px;">
							<div style="background-color: #F5F5F5; height: 10%; width: 148%; flex-direction: column;">
								<div class="layui-tab" style="border: 1px solid #f2f2f2;border-radius: 2px;display:flex;margin:0px;flex-direction: column;height: auto;">
									<ul class="layui-tab-title">
										<li class="layui-this" style="margin-top: 0px;border-top: 3px solid #4dafdc;">热门推荐</li>
									</ul>
									<div class="layui-tab-content" style="flex:auto;background-color: white;">
										<div class="layui-tab-item layui-show" style="height: 100%;">
											<c:forEach var="i" begin="0" items="${recommend_jtyy}" varStatus="status">
												<a href="${ctx}web/product/details/${i.id}.html" style="" target="_blank" title="${i.description}" target="_blank">
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
<%--				<div id="app2" style="display: flex;margin-top: 20px">                   --%>
<%--					<el-pagination style="margin: 0px 33%;" background :current-page.sync="currentPage" @current-change="handleCurrentChange" layout="prev, pager, next" :page-size="16" :total="count"></el-pagination>--%>
<%--				</div>                                                                                                  --%>
			</div>                                                                
		</div>
		<%@ include file="/web/include/footer.jsp"%>

		<script>
            <%-- 商品搜索 start --%>
            //搜索框 -- 点击搜索按钮
            function productSearch() {
                var key = $("#keyWord").val().trim();
                if(key.length > 0){
                    window.location.href="${ctx}web/product/search.jsp?key="+key;
                }
            };
            //搜索框 -- 回车事件
            $("#keyWord").bind('keydown',function(event){
                if(event.keyCode == 13){
                    var key = $("#keyWord").val().trim();
                    if(key.length > 0){
                        window.location.href="${ctx}web/product/search.jsp?key="+key;
                    }
                }
            });
            <%-- 商品搜索 end --%>
		</script>
	</body>
	<script>
		$(function () {
			//注意：选项卡 依赖 element 模块，否则无法进行功能性操作
			layui.use('element', function() {
				console.log("star")
				var element = layui.element;
				$(".layui-tab-title li").hover(function(){
					console.log("ing")
					$(this).click()
				});
				console.log("end")
			});
		})()

		function showImg(x) {
			$($(x).find("img")[0]).show();
		}

		function hideImg(x) {
			$($(x).find("img")[0]).hide();
		}

		$("body").keydown(function() {
			if(event.keyCode == "13") { //keyCode=13是回车键
				search();
			}
		});

		function search() {
			window.location.href = "${ctx}web/product/SelectList?pageNum=" + 1 + "&pageSize=16&name=" + $("#name").val();
		}
		var Main = {        
		    methods: {
		      handleCurrentChange(val) {                                                  
		        console.log(this.currentPage);    
		        window.location.href = "${ctx}web/product/SelectList?pageNum=" + this.currentPage + "&pageSize=16&name=${param.name}"
		      }
		    },
		    data() { 
		      return {
		    	  count:${count},                        
		    	  currentPage:${param.pageNum}
		      };                       
		    }
		}             
		var Ctor = Vue.extend(Main)
		new Ctor().$mount('#app2');
		new Vue().$mount('#app');

		function go(url) {
			window.open(url);
		}
	</script>

</html>
<style>
	/*为添加的空div设置的样式*/

	.search{
		float: right;
		width: 300px;
		margin-top:-10px;
		border-radius: 20px;
		height: 34px;
		padding-right: 45px;
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
		border: 1px solid #cecece;
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
		border-bottom: 1px solid #cecece;
	}                  
	
	.white1 {
		width: 100%;
		height: 25%;
		background-color: white;
		border-bottom: 1px solid #cecece;                          
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

	.layui-tab-content {
		padding: 0px;
	}
	.layui-tab-title>li{
		background-color: #f2f2f2;
		margin-top: 3px;
		height: 38px;
	}
	.layui-this{
		background-color: white !important;
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
</style>