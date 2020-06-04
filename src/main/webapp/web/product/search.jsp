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
						<span><a href="${ctx }/web/product/home">商城<i class="layui-icon" style="margin-left: 5px;color: #c0c4cc">&#xe602;</i></a></span>
						<span>商品搜索</span>

						<div style="float: right;position: relative">
							<a style="position: absolute;right: 13px;padding: 7px;top: -8px;" href="javascript:void(0)" onclick="productSearch()"><i class="layui-icon">&#xe615;</i></a>
							<input type="text" id="keyWord"  placeholder="请输入商品名称" class="layui-input search">
						</div>
					</div>
				</div>

				<%-- 搜索结果 --%>
				<div id="center" style="margin: 10px 0px;border: 1px solid #E8E8E8;padding: 15px;">
					<div id="searchList">
					</div>
					<div style="border-bottom: 1px solid #CCCCCC;padding:28px 0px;text-align: center;"  id="no_product" >
						<span style="color: #b1acac">暂无商品</span>
					</div>
					<div id="demo2"></div>
				</div>

			</div>
		</div>

		<%@ include file="/web/include/footer.jsp"%>
	</body>
	<script>

		var key = "";
		$(function () {


			//搜索
			key = $("#keyWord").val().trim();
		    if(key.length <= 0){
		        //其他页面传key
                key = '${param.key}';
                $("#keyWord").val(key)
			}
            initData(1,key);
            setDivHeight(0);
        })

		//动态设置 id=center div 的高度
		function setDivHeight(offset) {
            $("#center").height("100%");
            setTimeout(function () {
                var h_cen = $("#center").height();
                var h_win = parseInt($(window).height() * 0.6);
                if(h_cen <= h_win ){
                    $("#center").height(h_win)
                }else{
                    $("#center").height("100%");
                }
            },200)
        }
		//搜索框 -- 点击搜索按钮
		function productSearch() {
		    key = $("#keyWord").val().trim();
            if(key.length > 0){
                kkk = key;
                initData(1,key);
			}
        }
		//搜索框 -- 回车事件
		$("#keyWord").on('keypress',function(event){
            if(event.keyCode == 13){
                key = $("#keyWord").val().trim();
                if(key.length > 0){
                    kkk = key;
                    initData(1,key);
                }
			}
        });

        //初始化页面数据
        function initData(pageNum,key) {
            if(key.length > 0){
                $.ajax({
                    type:'get',
                    url:'${ctx }/web/product/productSearch?pageNum='+pageNum+"&key="+key,
                    dataType:'json',
                    success:function(data) {
                        // console.log(data)
						if(data.count == 0){
						    $("#no_product").css("display","block")
                        }else{
                            $("#no_product").css("display","none")
                        }
                        var str = "";
                        for(var i=0; i<data.data.length; i++){
                            var product = data.data[i];
                            str += "<a href='${ctx}/web/product/details/"+product.id+".html' target='_blank'><div style='height: 100px;'>\n" +
                                "<div style='display: inline;float: left;'>\n" +
                                "<img onerror='imgerrorfun();' style='margin-right:10px;height:80px;width:80px' src='${ctxUphoto}"+product.image+" '>\n" +
                                "</div>\n" +
                                "<div style='display: inline;float: left;font-size: 12px;width:60%'>\n" +
                                "<h3 style='margin-bottom: 5px;font-weight: 600;'>"+product.name+"</h3>\n" +
                                "<p>"+product.description+"</p>\n" +
                                "</div>\n" +
                                "</div></a><hr>"
                        }
                        $("#searchList").html(str)
                        initPage(data);
                    },
                    error: function (e) {
                        console.log(e);
                        layer.msg("系统异常");
                    }
                });
                setDivHeight();
            }
        }

        //初始化分页栏
        var pageCurr = 1;
        function initPage(pageData) {
            // console.log(pageData);
            layui.use([ 'laypage', 'layer' ], function() {
                var laypage = layui.laypage, layer = layui.layer;
                laypage.render({
                    elem : 'demo2',
                    curr : pageCurr,
                    count : pageData.count,
                    layout : [ 'count', 'prev', 'page', 'next', 'refresh',
                        'skip' ],
                    jump : function(obj, first) {
                        if (!first) {//首次不执行
                            initData(obj.curr,key);
                            pageCurr = obj.curr;
                        }
                    }
                });
            });
        }

        function imgerrorfun(){
            var img=event.srcElement;
            img.src="${ctxRes}/images/404-img.jpg";
            img.onerror=null;
        }
	</script>

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
</html>
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