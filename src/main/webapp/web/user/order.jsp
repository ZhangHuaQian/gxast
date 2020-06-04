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
            left: 375px;
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

<script type="text/javascript" src="${ctx}resource/js/mycity.js"

		function openpage(){
		window.location = "/test.jsp";   ></script>

<body style="background-color: #ffffff">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <%@ include file="/web/include/ucenter-head.jsp"%>




    <div id="newslistdiv" class="triangle-tip-up" style="width:70%;min-width:1302px;margin: 0px auto;height:auto;min-height:700px;background-color: #FFFFFF">
        <%@ include file="/web/include/ucenter-left-menu.jsp"%>             
        <div style="width:80%;margin-top:15px;float: right;height:auto;border: 1px solid #e8e8e8">                
            <div style="width: 100%;background-color: #FAFAFA">
                <div style="color: #858585;margin-left: 15px;padding: 8px 0px;"><span><strong>订单管理</strong></span></div>
            </div>            
            <div style="width: 96%;padding:0px 0px;margin: 20px auto;color: #343434">
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
								<p style="padding-top: 12px">金额</p>
							</div>
							<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 100px">                  
								<p style="padding-top: 12px">状态</p>   
							</div>
							<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 100px">                          
								<p style="padding-top: 12px">操作</p>                           
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
<div id="demo7" style="width: 600px;margin-top: 10px;margin-right:200px;float:right;background-color: white;border-radius: 2px;"></div> 
<div class="clearDiv"></div> 
<%@ include file="/web/include/footer.jsp"%>
</body>
<script>

function unique(array){ // 数组去重
    var n = []; //一个新的临时数组
    //遍历当前数组
    for(var i = 0; i < array.length; i++){
        //如果当前数组的第i已经保存进了临时数组，那么跳过，
        //否则把当前项push到临时数组里面
        if (n.indexOf(array[i]) == -1) {
            n.push(array[i]);
        }
    }
    return n;
}
$(function () {        
	initPage(1);
	getShopCar(1,5);
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

//订单状态
function status(state,id){                     
	var text = "";
	if(state==0) text="<p style='color:red'>等待买家付款</p>";
	if(state==1) text="<p style='color:red'>买家已付款</p>";
	if(state==2) text="<p style='color:red'>等待买家收货</p>";                     
	if(state==3) text="<p style='color:gray'>已完成</p>";
	return text+"<a href='${ctx }web/user/order_details.jsp?id="+id+"'><span style='color:gray'>订单详情</span></a>";
}
//操作栏         
function operation(state,id){                                                                                          
	var text = "";
	// console.log(state+":"+id);
	if(state==0) text="<span  style='color:red;border:1px solid;border-radius:3px;cursor: pointer;' onclick=paynow('"+id+"')>&nbsp;立即付款&nbsp;</span><p style='color:gray;cursor:pointer' onclick=cancel('"+id+"')>取消订单</p>";
	if(state==1) text="";
	if(state==2) text="<span style='border:1px solid;border-radius:3px;color:#028ef7;cursor: pointer;' onclick=confirmOrder('"+id+"')>&nbsp;确认收货&nbsp;</span>";
	// if(state==3) text="<span style='border:1px solid;border-radius:3px;color:gray'>&nbsp;再次购买&nbsp;</span>";
	if(state==3) text="<span style='border:1px solid;border-radius:3px;color:gray;cursor: pointer;' onclick=proRemark('"+id+"')>&nbsp;商品评价&nbsp;</span>";
	if(state==4) text="<span style='border:1px solid;border-radius:3px;color:gray;cursor: pointer;' onclick=myRemark('"+id+"')>&nbsp;我的评价&nbsp;</span>";
	return text;
}

//商品评价
function proRemark(id) {
	window.location.href="${ctx}web/user/remark.jsp?id="+id;
}

//查看我的评价
function myRemark(id) {
    window.location.href="${ctx}web/user/myRemark.jsp?id="+id;
}

//确认订单
function confirmOrder(id){
    layer.confirm('请确保已经收到商品后再执行操作', {
        btn: ['确认','取消'] //按钮
    }, function(){
        $.ajax({
            type: 'post',
            url: '${ctx }web/order/confirm',
            dataType: 'json',
            data:{
                id:id
            },
            async:false,
            success: function (result) {
                layer.msg(result.msg)
                setTimeout( function(){
                    window.location.reload();
                }, 1500 );
            },
            error: function (msg) {
                layer.msg(msg)
            }
        });
    }, function(){
    });
}

function paynow(id){
    var parames = new Array();
    parames.push({ name: "orderId", value: id });
    Post("${ctx}web/order/pay.jsp", parames);
}

var count = 0;               
function getShopCar(pageNum,pageSize){                                          
	$.ajax({
		type: 'get',
        url: '${ctx }web/order/selectList?pageNum='+pageNum+'&pageSize='+pageSize+"&status=${param.status}",         
        dataType: 'json',
        async:false, 
        success: function (result) {                            
        	console.log(result);
        	$("#main1").html("");         
        	count = result.count;                          
        	var orders = result.orders;
        	for(var i in orders){
        		var shopcars = orders[i];
        		for(var j = 0;j<shopcars.length;j++){                                           
  	            	var shopcar = shopcars[j];                                                  
  	            	var a = "<div class='tabhead'><div style='padding: 12px'>"+                                                                  
  	            	"<div name='total'>"+formatDate_YMD_HMS(shopcar.orderTime)+"</div></div>";
  	            	var html= "<div id='"+i+"'>"+(j==0?a:"")+"</div>"+                   
  	            	"<div style='height: 80px; width: 100%; border: 1px solid #e8e8e8; display: flex; border-top: 0px'>"+
  	            	"<div class='tabcontent' style='flex: auto; padding-left: 20px'>"+                                                                                                 
  	            	"<a target='_blank' href='${ctx}web/product/details/"+shopcar.productId+".html'><img onerror='onerrorIMG()' style='height: 80%;width: 100px;padding-top:10px' src='${ctxUphoto}"+shopcar.image+"'>"+
  	            	"<span>&nbsp;"+shopcar.name+"</span></a></div><div class='tabcontent'  style='width: 100px; text-align: center; padding-top: 30px'>x"+shopcar.number+"</div>"+
  	            	"<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 30px'>￥"+shopcar.number*shopcar.price+"</div>"+
  	            	"<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 20px'>"+(j==0?status(shopcar.orderStatus,shopcar.orderId):"")+"</div>"+                                                    
  	            	"<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 20px'>"+(j==0?operation(shopcar.orderStatus,shopcar.orderId):"")+"</div>"+            
  	            	"</div></div>";                                                                                           
  	            	$("#main1").append(html);                                      
        		}
        	}
       },
        error: function (msg) {                                                                                  
            console.log(msg);   
        }              
	});                  
}
function onerrorIMG(){                                                        
    var img=event.srcElement; 
    img.src="${ctxRes}/images/404-img.jpg"; 
    img.onerror=null;
} 
var pageCurr = 1;
function initPage(pageData) {
    layui.use(['laypage', 'layer'], function () {
        var laypage = layui.laypage
            , layer = layui.layer;
        laypage.render({
            elem: 'demo7'
            ,limit:5
            , curr: pageCurr              
            , count: count
            , layout: ['count', 'prev', 'page', 'next', 'refresh', 'skip']    
            ,theme: '#1E9FFF'
            , jump: function (obj, first) {                                                   
                if (!first) {//首次不执行                  
                	getShopCar(obj.curr,5);
                    pageCurr = obj.curr;
                }                                                     
            }
        });                           
    });
}

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
</script>

</html>
