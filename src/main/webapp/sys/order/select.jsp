<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/12/28
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>我的订单-广西科普传播中心</title>        
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
            left: 380px;
            top: -10px;
        }
        .layui-progress-big, .layui-progress-big .layui-progress-bar {
            height: 13px;
            line-height: 13px;
        }
        .address_table>tbody>tr>td{
            border: 1px solid #e6e6e6;
            text-align: center;
            vertical-align: middle;
        }
        .address_table>tbody>tr:nth-child(odd){
            border: 1px solid #e6e6e6;
            text-align: center;
            vertical-align: middle;
        }
        .address_table>tbody>tr:nth-child(even){
            border: 1px solid #e6e6e6;
            text-align: center;
            vertical-align: middle;
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
    </style>
</head>

<script type="text/javascript" src="${ctx}resource/js/mycity.js"></script>

<body style="background-color: #ffffff">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->       
                           
    <div id="newslistdiv" class="triangle-tip-up" style="float:right;width:70%;min-width:982px;margin: 0px auto;height:auto;min-height:700px;background-color: #FFFFFF">
        <div style="width:80%;margin-top:15px;height:auto;border: 1px solid #e8e8e8">                
            <div style="width: 100%;background-color: #FAFAFA">
                <div style="color: #858585;margin-left: 15px;padding: 8px 0px;"><span><strong>订单管理</strong></span></div>
            </div>                    
            <div style="width: 96%;padding:0px 0px;margin: 20px auto;color: #343434">
            <div style="display: flex;width: 100%;height:200px;border: 1px solid #e8e8e8">
            		<div style="flex:1;border-right: 1px solid #e8e8e8">                                 
            			<div style="width: 220px;min-height: 150px;height:auto;margin: auto;margin-top:20px;">
            				<p style="margin: 13px 0px">订单信息</p>       
            				<p style="margin: 13px 0px">收货人:<span id="name"></span></p>          
            				<p style="margin: 13px 0px">地址:<span id="address"></span></p>
            				<p>手机号码:<span id="phone"></span></p>            
            			</div>           
            		</div>
            		<div style="flex:1;border-right: 1px solid #e8e8e8">
            			<div style="width: 220px;min-height: 150px;height:auto;margin: auto;margin-top:20px;">
            				<p style="margin: 13px 0px">配送信息</p>       
            				<p style="margin: 13px 0px">配送方式:快递</p>          
            				<p style="margin: 13px 0px">运费:￥0.00</p>
            				<p style="margin: 13px 0px">备注:<span id="remark"></span></p>
            				<p>物流号:<span id="lid"></span></p>                                                  
            			</div>                                            
            		</div>                           
            		<div style="flex:1">
            			<div style="width: 220px;min-height: 150px;height:auto;margin: auto;margin-top:20px;">
            				<p style="margin: 13px 0px">付款信息</p>       
            				<p style="margin: 13px 0px">付款方式:在线支付</p>          
            				<p style="margin: 13px 0px">付款时间:<span id="time"></span></p>
            				<p style="margin: 13px 0px">商品总额:<span id="total2"></span></p>
            				<p>应支付金额:<span id="total3"></span></p>
            			</div>
            		</div>
            	</div>
		         <div>                                            
					<div class="tabhead">                          
						<div style="display: flex;height:100%;text-align: center;">           
							<div  style="height:100%;border-right: 1px solid #e8e8e8;flex:1">
								<p style="padding-top: 12px">订单信息</p>              
							</div>
							<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 100px">
								<p style="padding-top: 12px">数量</p>
							</div>
							<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 100px">
								<p style="padding-top: 12px">单价</p>
							</div>
							<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 100px">                          
								<p style="padding-top: 12px">总价</p>                           
							</div>                      
						</div>                              
					</div>
				</div>
            	<div id="main1"></div>                               
            </div>
        </div>                   
    </div>                               
</div>         
<div class="clearDiv"></div>                                   
<div id="demo7" style="width: 500px;margin-top: 10px;margin-right:200px;float:right;background-color: white;border-radius: 2px;"></div> 
<div class="clearDiv"></div> 
</body>
<script>   
$(function () {                  
	getShopCar();
});
//取消订单
function cancel(id){
	layer.confirm('是否删除该订单', {                    
	  btn: ['确认','取消'] //按钮            
	}, function(){
		$.ajax({
			type: 'post',
	        url: '${ctx }web/order/delete?id='+id,
	        dataType: 'json',
	        async:false, 
	        success: function (result) {                             
	        	  layer.msg(result.msg);
	        	  setTimeout( function(){
	        		  window.location.reload();
	        		}, 1500 );
	       	},
	        error: function (msg) {                                                        
	            console.log(msg);   
	            alert("系统异常");            
	        }              
		});
	}, function(){                
	});
}

function getShopCar(){       
	$.ajax({
		type: 'get',
        url: '${ctx }sys/order/select?id=${param.id}',         
        dataType: 'json',
        async:false, 
        success: function (result) {                                  
        	var order = result.order;        
        	$("#oid").text(order.id);                
        	$("#time").text(formatDate_YMD_HMS(order.createtime));          
        	$("#lid").text(order.logistics);
        	$("#remark").text(order.remarks);           
        	$("#address").text(order.address);        
        	$("#phone").text(order.phone);
        	$("#name").text(order.name);
        	var shopcars = result.shopcars;
        	var products = result.products;
        	for(var i= 0;i<shopcars.length;i++){      
        		var a = "<div class='tabhead'><div style='padding: 12px'>"+                                                                  
               	"<div name='total' total='"+shopcars[i].number*shopcars[i].price+"'>"+formatDate_YMD_HMS(order.createtime)+"</div></div>";            
               	var html= "<div id='"+i+"'>"+(i==0?a:"")+"</div>"+                   
               	"<div style='height: 80px; width: 100%; border: 1px solid #e8e8e8; display: flex; border-top: 0px'>"+
               	"<div class='tabcontent' style='flex: auto; padding-left: 20px'>"+                                                                                                 
               	"<a href='${ctx}web/product/details/"+products[i].id+".html'><img onerror='onerrorIMG(this)' style='height: 80%;width: 100px;padding-top:10px' src='${ctxUphoto}"+products[i].image+"'>"+
               	"<span>"+products[i].name+"("+shopcars[i].name+")"+"</span></a></div><div class='tabcontent'  style='width: 100px; text-align: center; padding-top: 30px'>x"+shopcars[i].number+"</div>"+
               	"<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 30px'>￥"+shopcars[i].price+"</div>"+
               	"<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 30px'>￥"+shopcars[i].number*shopcars[i].price+"</div>"+               
               	"</div></div>";                                                                                                                                                                                              
               	$("#main1").append(html);                                           	
        	}            
        	var total=0;                
    		var a = $("#main").find("[name='total']");
      		for(var i=0;i<a.size();i++){                                               
     			total+=parseFloat($(a[i]).attr("total"));            
    		}                      
      		$("#total").text("￥"+total);
      		$("#total2").text("￥"+total);
      		$("#total3").text("￥"+total);
       	},
        error: function (msg) {                                                        
            console.log(msg);   
            alert("系统异常");            
        }              
	});                  
}

</script>

</html>
       