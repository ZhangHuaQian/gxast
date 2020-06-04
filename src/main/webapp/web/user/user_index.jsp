<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>个人中心-广西科普传播中心</title>
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
            left: 300px;
            top: -10px;
        }
        .layui-progress-big, .layui-progress-big .layui-progress-bar {
            height: 13px;
            line-height: 13px;
        }
        .something-semantic {
            display: table;
            width: 100%;
        }
        .something-else-semantic {
            display: table-cell;
            text-align: center;
            vertical-align: middle;
        }

        .content-a-upload {
            margin-left: 15px;
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
        <div style="width:80%;height:auto;margin-top:15px;float: right;">               
            
            <div style="width: 100%;">                   
                <div id="photo">
                    <div style="float: left;height: auto;">
                    <img onerror="this.src='${ctxRes}/images/404-img.jpg'" onclick="window.location.href='${ctx}web/user/user.jsp'" style="cursor:pointer;height: 80px;width: auto;border-radius: 4px;" src="${ctxUphoto}${sessionScope.USER_SESSION_NAME.photo}" ><br>
                    <%--<a href="" class="content-a-upload" style="height: 22px;"><input type="file" id="projectImgBtn" style="height: 36px;width: 100px"/>更换头像</a>
                    <input type="hidden" name="photo"   >--%>
                    </div>

                <div style="float: left;margin-left:20px;color: #6A6A6A">
                    <div onclick="window.location.href='${ctx}web/user/user.jsp'" style="font-size: 16px"><span>用户名 ：</span><span>${sessionScope.USER_SESSION_NAME.name}</span></div>
                    <div style="font-size: 14px;margin-top: 10px;vertical-align:middle;">
                        <span style="float: left">账户安全 ： </span>
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
                    <div style="font-size: 14px;margin-top: 10px;">
                        <a href="${ctx}web/user/delivery.jsp" style="color: #6A6A6A">
                            <span>我的收货地址 ></span>
                        </a>
                    </div>
                </div>
                <div class="clearDiv"></div>
            </div>

            <div style="width: 100%;border: 1px solid #E8E8E8;margin-top: 30px;">
                <div style="width: 100%;background-color: #FAFAFA;">
                    <div style="color: #858585;margin-left: 15px;padding: 8px 0px;"><span><strong>我的订单</strong></span></div>
                </div>
                <div class="something-semantic" style="cursor:pointer ;width: 100%;height: 130px;border-bottom: 1px solid #E8E8E8;vertical-align: middle">
                    <div onclick="order(10)" class="something-else-semantic" style="width: 20%;float: left;text-align: center;margin-top: 30px;">
                        <img src="${ctxRes}images/userindex1.png">
                        <span style="display: block;margin-top: 5px;">全部订单<span id="order">(0)</span></span>
                    </div>
                    <div onclick="order(0)" class="something-else-semantic" style="cursor:pointer ;width: 20%;float: left;text-align: center;margin-top: 30px;">
                        <img src="${ctxRes}images/userindex2.png">
                        <span style="display: block;margin-top: 5px;">待付款<span id="order0">(0)</span></span>
                    </div>
                    <div onclick="order(1)" class="something-else-semantic" style="cursor:pointer ;width: 20%;float: left;text-align: center;margin-top: 30px;">
                        <img src="${ctxRes}images/userindex3.png">
                        <span style="display: block;margin-top: 5px;">待发货<span id="order1">(0)</span></span>
                    </div>
                    <div onclick="order(2)" class="something-else-semantic" style="cursor:pointer ;width: 20%;float: left;text-align: center;margin-top: 30px;">
                        <img src="${ctxRes}images/userindex4.png">
                        <span style="display: block;margin-top: 5px;">待收货<span id="order2">(0)</span></span>
                    </div>
                    <div onclick="order(3)" class="something-else-semantic" style="cursor:pointer ;width: 20%;float: left;text-align: center;margin-top: 30px;">
                        <img src="${ctxRes}images/userindex5.png">
                        <span style="display: block;margin-top: 5px;">已完成<span id="order3">(0)</span></span>
                    </div>
                    <div class="clearDiv"></div>
                </div>                           
                <div id="main2" style="height: auto">
                
                </div>
                <%-- <div style="width: 100%;height: 100px;border-bottom: 1px solid #E8E8E8;">
                    <div style="margin-top: 20px;">
                        <div style="float: left;margin-left: 20px">
                            <img src="${ctxRes}images/book.png" height="80px">
                        </div>
                        <div style="float: left;margin:25px 10px;width: 500px;vertical-align: middle">
                            <p style="vertical-align: middle">
                                侦探小组在行动 漫画升级版 淘气包马小跳 三四五年级课外书
                                6-12岁故事读物杨红樱校园系列儿童文学畅销品牌童书。
                            </p>
                        </div>
                        <div style="float: right;margin-right: 10px;margin-top: 25px;">
                            <a>查看详情></a>
                        </div>
                    </div>
                </div>
                <div style="width: 100%;height: 100px;border-bottom: 1px solid #E8E8E8;">
                    <div style="margin-top: 20px;">
                        <div style="float: left;margin-left: 20px">
                            <img src="${ctxRes}images/book.png" height="80px">
                        </div>
                        <div style="float: left;margin:25px 10px;width: 500px;vertical-align: middle">
                            <p style="vertical-align: middle">
                                侦探小组在行动 漫画升级版 淘气包马小跳 三四五年级课外书
                                6-12岁故事读物杨红樱校园系列儿童文学畅销品牌童书。
                            </p>
                        </div>
                        <div style="float: right;margin-right: 10px;margin-top: 25px;">
                            <a>查看详情></a>
                        </div>
                    </div>
                </div> --%>
            </div>

        </div>
        <div class="clearDiv"></div>
    </div>
    <div class="clearDiv"></div>   
</div>
<%@ include file="/web/include/footer.jsp"%>
</body>
<script>
	$(function () {         
		init();  
		order(10);                  
	});
	function init(){                               
		$.ajax({               
	           type: 'get',                                             
	           url: '${ctx }web/order/selectListCount',      
	           dataType: 'json',
	           async : false,                                   
	           success: function (result) {                       
	        	   var counts = result.count; 
	        	   $("#order").text("("+counts[0]+")");
	        	   for(var i = 0;i<counts.length;i++){
	        		   $("#order"+i).text("("+counts[i+1]+")");
	        	   }
	           },
	           error: function (msg) {
	               console.log(msg);
	           }
	       }); 
	}
	function onerrorIMG(obj) {
	    obj.src='${ctxRes}/images/404-img.jpg';
	}
	function order(status){                
		$.ajax({               
	            type: 'get',
	            url: '${ctx }web/order/selectList?status='+(status!=10?status:"")+"&pageNum=1&pageSize=3",      
	            dataType: 'json',
	           	async : false,              
	            success: function (result) {                                                     
	            	var orders = result.orders;
	            	console.log(orders);                
	            	$("#main2").html("");                    
	            	for(var i in orders){
	            		var order = orders[i][0];
	                	var html="<div style='width: 100%;height: 100px;border-bottom: 1px solid #E8E8E8;'><div style='margin-top: 20px;'>"+                                      
	                	"<div style='float: left;margin-left: 20px'><a target='_blank' href='${ctx}web/product/details/"+order.productId+".html'><img style='width:120px' onerror='onerrorIMG(this)' src='${ctxUphoto}"+order.image+"' height='80px'>"+
	                	"</div><div style='float: left;margin:25px 10px;width: 500px;vertical-align: middle'>"+
	                	"<p style='vertical-align: middle'>"+order.name+"</p></a>"+         
	                	"</div><div style='float: right;margin-right: 50px;margin-top: 25px;'><a href='${ctx }web/user/order_details.jsp?id="+order.orderId+"'>订单详情 ></a></div></div></div>";
	                	$("#main2").append(html);                   
	                }                                  
	                if(orders!=null&&getLength(orders)>=3){                                             
	                	var more = "<div style='text-align: center;'><a href='${ctx}web/user/order.jsp?status="+(status!=10?status:"")+"'>查看更多</a></div>";
		                $("#main2").append(more);                                      
	                }                                           
	            },                                            
	            error: function (msg) {
	                console.log(msg);                                   
	            }
	        }); 
	}
    //注意进度条依赖 element 模块，否则无法进行正常渲染和功能性操作
    layui.use('element', function(){
        var element = layui.element;
    });
    //获取map长度
    function getLength(obj){ 
    	　　var count = 0;                  
    	　　for(var i in obj){
    		count++;
    	　　}
    	　　return count;　　
    	}

</script>
</html>
