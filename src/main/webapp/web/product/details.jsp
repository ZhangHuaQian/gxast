<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>${product.name }</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="keywords" content="">
<meta name="description" content="">
<link rel="stylesheet"
	href="${ctx }resource/plugins/layui/css/layui.css">
<link rel="stylesheet"
	href="${ctx }resource/css/css.css">   
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

	<%--//网页百度地图定位--%>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=G6ivzLv99GrKXSF99Lx3VkihMIKcN0zn"></script>
</head>
<style>  
.son{                         
   background-color:#f9f9f9;        
   position:absolute;
   left:0px;                            
   top:0px;
}
.layui-btn {
	margin-top: 5px;
	margin-left: 10px;
}            
.bg {  
	margin: 10px auto;
	width:70%;      
	height: auto;    
	min-width:1302px;
}

h2 {
	margin-left: 15px;
	font-size: 18px;
	font-family: NSimSun;
	float: left;
}

#details img {
	width:auto;
	height: auto;
	max-width: 100%;
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
	overflow:hidden;
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
	border:0px solid #E8E8E8;
}

.left_list {
	/*background-color:#E8E8E8;*/
	border-top: 1px solid #E8E8E8;
	margin:20px 0px 0px 0px;
	width: 260px;
	float: left;
	height: auto;
	flex:none;
}

.details {
	background-color: white;
	border: 1px solid #E8E8E8;
	float: left;
	margin: 20px 0px 0px 20px;
	min-width: 1000px;
	width: auto;
	height: auto;
	flex:1;
}   

.product2 {
	margin-bottom: 10px;
	width: 100%;
	height: 252px;
	float: left;                      
	border: 1px solid #e8e8e8;
	border-left: 0px;
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
	border-radius:5px;                  
	border:0px;               
	flex:1;
	background-color: #E64346;
	height: 50px;
	width: 170px;              
	text-align: center;                  
} 
.buy:hover {
	background-color:#d23e41;                     
}
.buy:active {                              
	position:relative;
	top:1px;
}  

.buy3 {
	border-radius:5px;                  
	border:0px;               
	flex:1;
	background-color: #cecece;
	height: 50px;
	width: 170px;
	max-width:170px;
	text-align: center;   
}                    
.buy2 {
	border-radius:5px;                  
	border:0px;               
	flex:1;
	background-color: #FF5500;
	height: 50px;
	width: 170px;
	text-align: center;                  
} 
.buy2:hover {
	background-color:#dc4a02;                                          

.buy2:active {                              
	position:relative;
	top:1px;
}

.list {
	font-size: 18px;
	padding: 2px
}
</style>
<style>
.ripple {
    position: relative;
    //此处不需要设置overflow:hidden,因为after元素需要溢出显示
}
.ripple:focus{
    outline: none;
}

.ripple:after {
    content: "";
    display: block;
    position: absolute;
    //扩大伪类元素4个方向各10px
    top: -10px;
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
    opacity: .3;
    //设置初始状态
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    transition: 0s;
}
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
#p_detail{
	padding-left: 10px;
	display: inline;
	padding: 8px 10px;
	cursor:pointer;
}
#p_comment{
	border-right: 1px solid #E8E8E8;
	padding-left: 10px;
	display: inline;
	padding: 8px 10px;
	cursor:pointer;
}

.comment{
	background-color: #ff5500;
	color: white;
}
.comment_context{
	padding-left: 50px;
	font-size: 12px;
	width: 60%;
	padding-bottom: 20px;
	border-bottom: 1px solid #E8E8E8;
	margin-bottom: 10px;
	padding-left: 50px;
	font-size: 13px;
	width: 90%
}
/*收藏*/
.star{
	color: #f50;
}
/*搜索框*/
#keyWord{
	float: right;
	width: 300px;
	margin-top:-10px;
	border-radius: 20px;
	height: 34px;
	padding-right: 45px;
}


</style>
<body style="background-color: #F5F5F5">
	<div style="width:100%;background-image: url('${ctxRes}images/news_top.png');min-width:1302px;">
        <div id="main_center" style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 20px;">
            <%@ include file="/web/include/head.jsp"%>
        </div>
    </div>
	<div class="bg"  style="margin-top: 10px">
		<div style="width: 100%;min-width: 1162px;background-color: white;margin: 15px 0px;  height: 40px; border: 1px solid #E8E8E8;position: relative">
			<div id="app" style="margin: 13px;">
				<span><i class="layui-icon">&#xe68e;</i> 您当前的位置<i class="layui-icon" style="margin-left: 5px;color: #c0c4cc">&#xe602;</i></span>
				<span><a href="${ctx }">首页<i class="layui-icon" style="margin-left: 5px;color: #c0c4cc">&#xe602;</i></a></span>
				<span><a href="${ctx }/web/product/home">商城<i class="layui-icon" style="margin-left: 5px;color: #c0c4cc">&#xe602;</i></a></span>
				<span>${type}</span>
			</div>
			<div style="float: right;position: absolute;top: 13px;right: 13px;">
				<div style="float:left;position: relative">
					<a style="position: absolute;right: 13px;padding: 7px;top: -8px;" href="javascript:void(0)" onclick="productSearch()"><i class="layui-icon">&#xe615;</i></a>
					<input type="text" id="keyWord" placeholder="请输入商品名称" class="layui-input">
				</div>
				<div style="float: right;line-height: 10px;margin: 0px 20px;">
					<i class="layui-icon" style="font-size: 16px; color: #ff4104;">&#xe715;</i>
					<span id="city">&nbsp;</span>
				</div>

			</div>
		</div>
		<div class="product" style="width: 100%;min-width: 1162px;background-color: white;border: 1px solid #E8E8E8">
			<div class="pictrue" style="height: 451px">
				<div class="box" style="width: 100%;height: 100%;margin: 0px">  
					<!-- 存放大图的容器-->
					<div class="all" style="margin: 0px">                                                                                     
						<div class="top-img">
						<div id='son' class="son" style="text-align: center;;z-index: 999;width:100%;height:100%;display:none"></div>
							<div class="activeimg" id="big" style="display: flex;flex-direction: row;">
							<c:forEach var="i" begin="0" end="5" items="${slide}">
								<div style="text-align: center;"><img src="${i}" onclick="openIMG('${i}')" style="height: 100%;width: auto;"  onerror="this.src='${ctxRes}/images/404-img.jpg'"></div>
							</c:forEach>      
							</div>
						</div>
						<!-- 存放缩略图的容器-->
						<div class="bot-img">
							<ul id="small">                                        
							<c:forEach var="i" begin="0" end="5" items="${slide}" varStatus="status">
								<li <c:if test="${status.index==0 }">class="active"</c:if> > <img  style="height: 70px" src="${i}"  onclick="openIMG('${i}')"  onerror="this.src='${ctxRes}/images/404-img.jpg'"> </li>
							</c:forEach>
								<!-- <li class="active"><img style="height: 70px" src=""> </li> -->
							</ul>
						</div>
					</div>
				</div>              
			</div>
			<div class="price" >                              
				<h1 style="height:30px;font-size: 22px;margin-top: 10px" id="name">${product.name }</h1>  
				<p style="color:#E64346;font-size: 16px;margin-top: 10px" id="description">${product.description }</p>
				<hr />
				<div style="padding: 10px 0px 10px 0px; height: 90px; background-color: #F5F5F5;">
					<div style="padding: 10px 4px 2px 10px;  float: left;width:100%">
						<span style="color: gray;">订购价&nbsp;：</span>
						<span style="font-size: 20px; color: #EE0000" id="price">￥${specifications[0].price }</span>
					</div>
					<div style="padding-left: 10px;color:gray" >              
						<span>重&nbsp;&nbsp;&nbsp;量 &nbsp;：&nbsp;&nbsp;&nbsp;</span><span id="weight" >${specifications[0].weight } KG</span>
					</div>  
					<div style="padding-left: 10px;color:gray" >                
						<span>地&nbsp;&nbsp;&nbsp;区 &nbsp;：&nbsp;&nbsp;&nbsp;</span><span>${product.province}-${product.city}-${product.area}</span>
					</div>
				</div>                        
				<div style="margin-top: 20px" id="specifications">                                                        
					<span style="color: gray;margin-left: 10px;">系列:</span> <br>
					<c:forEach var="i" begin="0" items="${specifications}" varStatus="status">         
						<button  onclick="btn('${i.image }',${i.id_ },'${i.name}',${i.stock},${i.price},${i.weight},this)"  class='layui-btn layui-btn-primary <c:if test="${i.stock<1 }">layui-btn-disabled</c:if>' style='background-color:#F5F5F5;' >         
							<img style='padding:2px 10px 6px 0px;width: 30px; height: 30px' src='${ctxUphoto}${i.image }'  onerror="this.src='${ctxRes}/images/404-img.jpg'">
		   					<span style='margin-top: 10px;padding-right:20px'>${i.name }</span>                         
						</button>
					</c:forEach>                               
				</div>   
				<div id="app2" style="margin-top: 20px">
				<span style="color: gray;">数量:</span>                       
					<template>  
	  					<el-input-number :precision="0" id="count" style="width: 130px;margin-right: 10px" v-model="num1" @change="handleChange" :min="0" :max="max" label="描述文字"></el-input-number>
					</template>     
				<span style="color: gray;">库存：</span><span id="stock">${specifications[0].stock }</span>
				<span style="margin-left:8px;" ><a style="color:gray" href="javascript:void(0);" onclick="collect()">收藏：<i id="star" class="layui-icon" style="cursor: pointer">&#xe658;</i></a></span>
				</div>
				<hr />
				<div style="margin-bottom: 20px;display: flex;width: 400px" > 
					<c:if test="${product.isUp==0}">                                   
						<button class="buy3" style="margin-right: 30px;">               
							<p style="cursor:pointer;color: white; font-size: 22px; padding: 10px 0px">已下架</p>
						</button>  
					</c:if>   
					<c:if test="${product.isUp==1}">                  
						<button class="buy2" style="margin-right: 30px;" id="add">
							<p style="cursor:pointer;color: white; font-size: 22px; padding: 10px 0px">加入购物车</p>
						</button>                   
					</c:if>                                         
					<c:if test="${product.isUp==1}">
						<button class="buy" type="button" >
							<p style="cursor:pointer;color: white; font-size: 22px; padding: 10px 0px" id="buy">立即购买</p>
						</button>    
					</c:if>                              
				</div>
			</div>
		</div>
		<div style=" display: flex;width: 100%;min-width: 1162px;height: auto; zoom:1;overflow:hidden;">
			<div class="left_list">
				<div style="background-color:white;height: 40px;  font-size: 20px;padding: 5px 5px 5px 10px;line-height: 40px;">
					<p style="color: #6b6b6b"> 热销商品</p>
				</div>
				<c:forEach var="i" begin="0" items="${recommend}" varStatus="status">
					<a href="${ctx}web/product/details/${i.id}.html" target="_blank"><div class="product2"><img onerror="this.src='${ctxRes}/images/404-img.jpg'" class="white2" src="${ctxUphoto}${i.image}"><div class="white1"><h6 style="line-height:36px;padding-left:5px;height:36px;width: 100%; word-wrap:break-word;word-break:break-all;overflow: hidden;">${i.name}</h6><div><span style="font-size: 18px; color: #f00;">￥${prList[status.index]}</span></div></div></div></a>
				</c:forEach>
			</div>
			<div class="details">
				<div style="height: 40px;  font-size: 20px;border-bottom:1px solid #E8E8E8;line-height: 40px;">
					<div id="p_detail" class="comment">商品详情</div><div id="p_comment">
						<span>累计评价</span>
						<span id="commentCount" style="color: #258dc4;font-size: 18px;">(0)</span>
					</div>
					<p style="color: #6b6b6b"></p>
				</div>

				<%-- 商品详情 --%>
				<div style="padding: 20px;font-size: 16px;" id="details">
				${product.content }
				</div>

				<%-- 累计评价 --%>
				<div style="padding: 20px;font-size: 16px;display: none;" id="comment_div">

					<div class="layui-form" style="margin-bottom: 15px;">
						<input type="radio" lay-filter="rank" name="rank" value="1" title="好评" checked >
						<%--<span id="good">(0)</span>--%>
						<input type="radio" lay-filter="rank" name="rank" value="2" title="中评" >
						<input type="radio" lay-filter="rank" name="rank" value="3" title="差评" >
					</div>

					<div id="commentList">
					</div>
					<div id="demo2"></div>
					<div style="border-bottom: 1px solid #CCCCCC;padding:28px 0px;display: none"  id="no_comment" >
						<span style="margin-left: 12%;color: #b1acac">暂无评价</span>
					</div>
				</div>
			</div>             
		</div>
	</div>
	<%@ include file="/web/include/footer.jsp"%>

	<script>
		$(function () {
            baiduLocation();
        })
        <%-- 商品搜索 start --%>
        //搜索框 -- 点击搜索按钮
        function productSearch() {
            var key = $("#keyWord").val().trim();
            if(key.length > 0){
                window.location.href="${ctx}/web/product/search.jsp?key="+key;
            }
        };
        //搜索框 -- 回车事件
        $("#keyWord").bind('keydown',function(event){
            if(event.keyCode == 13){
                var key = $("#keyWord").val().trim();
                if(key.length > 0){
                    window.location.href="${ctx}/web/product/search.jsp?key="+key;
                }
            }
        });
        $("#ff").bind('keydown',function(event){
            alert(1111)
            if(event.keyCode == 13){

                var key = $("#keyWord").val().trim();
                if(key.length > 0){
                    window.location.href="${ctx}/web/product/search.jsp?key="+key;
                }
            }
        });
        <%-- 商品搜索 end --%>

        <%-- 百度地图定位 start --%>
        // 百度地图API功能
		function baiduLocation() {
            var map = new BMap.Map("allmap");
            // var point = new BMap.Point(116.331398,39.897445);
            // map.centerAndZoom(point,12);
            var geolocation = new BMap.Geolocation();
            geolocation.getCurrentPosition(function(r){
                if(this.getStatus() == BMAP_STATUS_SUCCESS){
                    var mk = new BMap.Marker(r.point);
                    // map.addOverlay(mk);
                    // map.panTo(r.point);
                    // alert('您的位置：'+r.point.lng+','+r.point.lat);
                    //根据经纬度获取城市的名称
                    // 使用百度地图JS API
                    var point = new BMap.Point(r.point.lng,r.point.lat);
                    var geoc = new BMap.Geocoder();
                    geoc.getLocation(point, function(rs){
                        var addComp = rs.addressComponents;
                        // $("#allmap").html(addComp.city);
                        // alert('您所在城市：'+addComp.city);
                        $("#city").text(addComp.city);
                    });
                }
                else {
                    alert('failed'+this.getStatus());
                }
            },{enableHighAccuracy: true})
            //关于状态码
            //BMAP_STATUS_SUCCESS	检索成功。对应数值“0”。
            //BMAP_STATUS_CITY_LIST	城市列表。对应数值“1”。
            //BMAP_STATUS_UNKNOWN_LOCATION	位置结果未知。对应数值“2”。
            //BMAP_STATUS_UNKNOWN_ROUTE	导航结果未知。对应数值“3”。
            //BMAP_STATUS_INVALID_KEY	非法密钥。对应数值“4”。
            //BMAP_STATUS_INVALID_REQUEST	非法请求。对应数值“5”。
            //BMAP_STATUS_PERMISSION_DENIED	没有权限。对应数值“6”。(自 1.1 新增)
            //BMAP_STATUS_SERVICE_UNAVAILABLE	服务不可用。对应数值“7”。(自 1.1 新增)
            //BMAP_STATUS_TIMEOUT	超时。对应数值“8”。(自 1.1 新增)
        }

        <%-- 百度地图定位 end --%>

        var rank = 1;
        $(function () {
            selectAllcomment(1,rank);
            //初始化收藏样式
            if('${star}' == 1){
                $("#star").addClass("star")
            }
        });

        <%-- 商品收藏 start --%>
        function collect() {
            $.ajax({
                type:'post',
                url:'${ctx }/appsite/product/collect?pId=${product.id}',
                dataType:'json',
                success:function(data) {
                    layer.msg(data.msg);
                    if(data.status ==1){
                        //收藏成功
                        $("#star").addClass("star");
                    }else if(data.status ==2){
                        //取消收藏
                        $("#star").removeClass("star");
                    }
                },
                error: function (e) {
                    console.log(e);
                    layer.msg("系统异常");
                }
            });
        };
        <%-- 商品收藏 end --%>

        <%-- 商品评价 start --%>
        $("#p_detail").on("click",function () {
            $("#p_comment").removeClass("comment");
            $("#p_detail").addClass("comment");
            $("#details").css("display","");
            $("#comment_div").css("display","none");
        });
        $("#p_comment").on("click",function () {
            $("#p_detail").removeClass("comment");
            $("#p_comment").addClass("comment");
            $("#comment_div").css("display","");
            $("#details").css("display","none");
        });

        // 好评、中评、差评切换
        layui.use('form', function () {
            var form = layui.form;
            form.on('radio(rank)', function (data) {
                // alert(data.value);//判断单选框的选中值
                rank = data.value;
                selectAllcomment(1,rank);
            });
        });

        /*评论列表*/
        function selectAllcomment(pageNum,rank) {
            $.ajax({
                type:'post',
                url:'${ctx }/appsite/productComment/selectByPid?pId=${product.id}&pageNum='+pageNum+"&rank="+rank,
                dataType:'json',
                success:function(data){
                    var result = data.data;
                    console.log(result)
                    $("input[name=rank][value=1]").prop("title", "aaa");
                    if(result.count>0 ){
                        $("#no_comment").css("display","none");
                        $("#commentCount").text("(" + result.total + ")");


                        var str = "";
                        for(var i=0; i<result.data.length; i++){
                            var comm = result.data[i];
                            str += "<div style='height: 50px;'>\n" +
                                "<div style='display: inline;float: left;'>\n" +
                                "<img onerror='imgerrorfun();' style='margin-right:10px;height:40px;width:40px' src='${ctxUphoto}'"+comm.user.photo+">\n" +
                                "</div>\n" +
                                "<div style='display: inline;float: left;font-size: 12px;'>\n" +
                                "<p style='margin-bottom: 5px;'>"+comm.user.id+"</p>\n" +
                                "<p>"+formatDate_YMD_HMS(comm.createTime)+"</p>\n" +
                                "</div>\n" +
                                "</div>\n" +
                                "<div class='comment_context'>"+comm.comment+"</div>"
                        }
                        console.log(result)
                        $("#commentList").html(str)
                        //分页
                        initPage(result)
                    }else{
                        $("#commentList").html("")
                        $("#no_comment").css("display","block");
                    }
                },
                error:function (msg){
                    console.log(msg);
                }
            });

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
                            selectAllcomment(obj.curr,rank);
                            pageCurr = obj.curr;
                        }
                    }
                });
            });
        }

        function imgerrorfun(){
            var img=event.srcElement;
            img.src="${ctxRes}/images/default_user.jpg";
            img.onerror=null;
        }

        <%-- 商品评价 end --%>


        var pid = "";
        var weight=${specifications[0].weight};
        var id_=${specifications[0].id_};
        var price=${specifications[0].price};
        var name = "${specifications[0].name}";
        window.onload=function (){
            var text = $("#details").text();
            $("#details").html(text);
        }
        var array;
        var Main = {
            data() {
                return {
                    num1: 1,
                    max:${specifications[0].stock }
                };
            },
            methods: {
                handleChange(value) {
                    console.log(value);
                }
            }
        };
        var Ctor = Vue.extend(Main)
        var vm=new Ctor().$mount('#app2')
        new Vue().$mount('#app');
        function htmlspecialchars_decode(str) {
            str = str.replace(/&lt;/g, '<');
            str = str.replace(/&gt;/g, '>');
            str = str.replace(/&#40;/g, "(");
            str = str.replace(/&#41;/g, ")");
            str = str.replace(/&#39;/g, "\'");
            return str;
        }
        function btn(image_1,id_1,name1,stock1,price1,weight1,obj){
            $("#son").css("display","block");
            $("#son").html("<img src='${ctxUphoto}"+image_1+"' style='height: 100%;width: auto;'  onerror='this.src='${ctxRes}/images/404-img.jpg''>");
            $(".layui-btn").css("border","1px solid #E8E8E8");
            $(obj).css("border","1px solid #009688");
            var reg = /.*\..*/;
            $("#weight").text((reg.test(weight1)?weight1:(weight1+".0"))+"KG");
            $("#name").text(name1);
            $("#price").text("￥"+(reg.test(price1)?price1:(price1+".0")));
            $("#stock").text(stock1);
            console.log(id_1);
            vm.max=stock1;
            vm.num1=1;
            weight=weight1;
            price=price1;
            name=name1;
            id_=id_1;
        }
        $("#add").click(function(){
            insert();
        });
        $('.bot-img ul li').click(function(){
            $("#son").css("display","none");
        });
        /*
           *功能： 模拟form表单的提交
           *参数： URL 跳转地址 PARAMTERS 参数
           */
        function Post(URL, PARAMTERS) {
            //创建form表单
            var temp_form = document.createElement("form");
            temp_form.action = URL;
            //如需打开新窗口，form的target属性要设置为'_blank'
            temp_form.target = "_self";
            temp_form.method = "post";
            temp_form.style.display = "none";
            //添加参数
            for (var item in PARAMTERS) {
                var opt = document.createElement("textarea");
                opt.name = PARAMTERS[item].name;
                opt.value = PARAMTERS[item].value;
                temp_form.appendChild(opt);
            }
            document.body.appendChild(temp_form);
            //提交数据
            temp_form.submit();
        }

        $("#buy").click(function(){
            if($("#stock").text()=="0"){
                layer.msg("库存不足");
                return false;
            }
            if(vm.num1==0){
                layer.msg("请选择数量");
                return false;
            }
            $.ajax({
                type: 'get',
                url: '${ctx }appsite/checkLogin',
                dataType: 'json',
                async:false,
                success: function (result) {
                    if(result.status==0){
                        layer.msg(result.msg);
                    }else{
                        var parames = new Array();
                        parames.push({ name: "pId", value: '${product.id}'});
                        parames.push({ name: "type", value: 'buynow'});
                        parames.push({ name: "num", value: vm.num1});
                        parames.push({ name: "price", value: price});
                        Post("${ctx}web/shopcar/address.jsp", parames);
                    }
                },
                error: function (msg) {
                    layer.msg("系统异常");
                }
            });


        });
        function insert(){
            if($("#stock").text()=="0"){
                layer.msg("库存不足");
                return false;
            }
            if(vm.num1==0){
                layer.msg("请选择数量");
                return false;
            }
            var status;
            $.ajax({
                type: 'post',
                url: '${ctx }web/shopcar/insert',
                data:{
                    id_ : id_,
                    weight : weight,
                    name : name,
                    price : price,
                    number : vm.num1,
                    id : '${product.id}'
                },
                dataType: 'json',
                async:false,
                success: function (result) {

                    if(result.status==0){
                        layer.msg(result.msg);
                    }else{
                        pid = result.id;
                        layer.msg(result.msg);
                    }
                    status = result.status;
                    console.log("status 1 == " +status)
                },
                error: function (msg) {
                    layer.msg("系统异常");

                }
            });
            console.log("status 2 == " +status)
            return status;
        }


        function openIMG(src) {
            layer.open({
                type: 1,
                title: false,
                closeBtn: 0,
                area: ['auto'],
                skin: 'layui-layer-nobg', //没有背景色
                shadeClose: true,
                content: "<img src='"+src+" ' style='max-width: 100%;'/>"
            });
        }
	</script>
</body>

</html>
