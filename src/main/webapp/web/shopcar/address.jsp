<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>提交订单-广西科普传播中心</title>
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
	position: relative; //
此处不需要设置overflow: hidden, 因为after元素需要溢出显示
}

.ripple:focus {
	outline: none;
}

.ripple:after {
	content: "";
	display: block;
	position: absolute; //
扩大伪类元素4个方向各10px top: -10px;
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
.footer{

	height: auto;

	width: 100%;

	background-color: #ddd;

	position: fixed;

	bottom: 0;

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
				</i> 您当前的位置</el-breadcrumb-item> <el-breadcrumb-item> <a
						href="${ctx }/web/product/home">商城首页</a></el-breadcrumb-item> <el-breadcrumb-item>确认订单</el-breadcrumb-item>
				</el-breadcrumb>
			</div>
		</div>
                      
		<div>                               
				<div class="tabhead" style="margin-top: 30px">                          
					<div style="display: flex;height:100%;text-align: center;">           
						<div  style="height:100%;border-right: 1px solid #e8e8e8;flex:1">
							<p style="padding-top: 12px">商品信息</p>
						</div>
						<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 100px">
							<p style="padding-top: 12px">单价</p>
						</div>
						<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 100px">
							<p style="padding-top: 12px">数量</p>
						</div>
						<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 100px">                  
							<p style="padding-top: 12px">小计</p>   
						</div>          
					</div>                   
				</div>
		</div>                               
		<div id="main" style="">                                                  
   		</div>                      
   		<hr style="margin:20px 0px;width: 100%; margin-top: 15px; background-color: #e8e8e8; height: 1px; border: none" />
   		<div>       
	   		<div style="display: flex">
				<form class="layui-form layui-form-pane" id="main_form" style="margin-bottom: 20px;">             
					<label class="layui-form-label">地址选择</label>
						<div class="layui-input-inline" style="width: 700px">               
							<select name="address" id="address" lay-search="" lay-verify="required">
							</select>
						</div>                                          
				</form>                                                                         
				<a style="margin-left: 20px;" href="${ctx}web/user/delivery.jsp"><button style="background-color: #005caa" class="layui-btn">添加地址</button></a>
			</div>    
		</div>
	</div>
	<div class="footer">                                           
	<div style="width: 100%;height: 70px;border-top:1px solid #e8e8e8;background-color: white">
 		<div style="margin: 0px auto;width: 70%;height: auto;min-width: 1302px;display: flex;flex-direction: row;">
 		<div style="width:150px;margin: 25px 800px 25px 0px;">                                     
 		</div>           
 		<div style="width:150px;margin: 25px 0px">                                                      
 		</div>
 		<div style="width:150px;margin: 25px 0px">                           
 			总价:￥<span id="total" style="color:red">0</span>                          
 		</div>       
 		<div style="width:150px;height: 71px">                                                              
 			<button onclick="next()" style="width: 100%;height: 100%;border:1px solid #ff7c1b;background-color: #FF5722;font-size: 20px;color: white;">提交订单</button>
 		</div>            
 		</div>                              
 	</div>                             
	</div>            
</body>        
<script>                                 
	var form;
	var buyType;
	layui.use([ 'form' ], function() {      
		form = layui.form;
	});
	$(function () {
	    buyType = '${param.type}';
	    if(buyType == 'buynow'){
	        //立即购买
			buyNow();
        }else{
	        //购物车
            getShopCar();
        }

	});                  
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
	function getShopCar(){  
		var products2 = new Array();
		var products3 = new Map();
		var shopcars = new Array();
		var prd = "${param.name}";
		var products = prd.split(",");
		for(var i = 0;i<products.length;i++){
			$.ajax({                                              
	    		type: 'get',
	            url: '${ctx }web/shopcar/select?shopcarId='+products[i],
	            dataType: 'json',
	            async:false,               
	            success: function (result) {
	            	var shopcar = result.shopcar;
	            	var product = result.product;   
	            	shopcars.push(shopcar);                               
	            	products2.push(product.id);
	            	products3.set(product.id,product);    
	           },                                    
	            error: function (msg) {                                                        
	                console.log(msg);   
	                alert("系统异常");                  
	            }              
	    	}); 
		}                                            
		
		products2 = unique(products2);                             
		var map = new Map();                           
		for(var i = 0;i<products2.length;i++){ 
			var list = new Array();
			for(var j = 0;j<shopcars.length;j++){
				if(shopcars[j].productId==products2[i]){
					list.push(shopcars[j]);             
				}
			}                                  
			map.set(products2[i],list);                       
		}
		map.forEach(function (value, key, map) {
		    var list = value;               
		    for(var i = 0; i< list.length;i++){                                                 
		    	var shopcar = list[i];              
		    	var product = products3.get(key);                         
		    	var b = "margin-top:0px;";                                              
		    	var remark = "<div class='tabhead' style='background-color:white;margin-top: 10px;padding: 5px 0px 5px 0px;'><label style='margin-left: 5px;'>备注 : </label><input name='remarks' class='remark' style='border:1px solid #cecece;height:24px;width: 1230px;'></div>";
		    	var html= "<div name='t' id='"+i+"'><div name='s' shopcar='"+shopcar.id+"' class='tabhead' style='"+(i!=0?b:"")+"'><div style='padding: 12px'>"+                                                                     
            	"<div name='total' total='"+shopcar.number*shopcar.price+"' onclick='select(this)'>"+formatDate_YMD_HMS(shopcar.createtime)+"</div></div></div>"+
            	"<div style='height: 80px; width: 100%; border: 1px solid #e8e8e8; display: flex; border-top: 0px'>"+
            	"<div class='tabcontent' style='width:79%; padding-left: 20px'>"+
            	"<a target='_blank' href='${ctx}web/product/details/"+product.id+".html'><img onerror='onerrorIMG(this)' style='height: 80%;width: auto;padding-top:10px' src='${ctxUphoto}"+product.image+"'>"+
            	"<span>"+(product.isUp==0?"已下架,请删除该商品":product.name+"("+shopcar.name+")")+"</span></a></div><div class='tabcontent'  style='width: 100px; text-align: center; padding-top: 30px'>￥"+shopcar.price+"</div>"+
            	"<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 30px'>"+shopcar.number+"</div>"+                                                              
            	"<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 30px'>￥"+shopcar.number*shopcar.price+"</div>"+                                                                                                 
            	"</div>"+(i==(list.length-1)?remark:"")+"</div>";                
              	$("#main").append(html);                                 
		    }             
		});
		var total=0;                
		var a = $("#main").find("[name='total']");
  		for(var i=0;i<a.size();i++){                                               
 			total+=parseFloat($(a[i]).attr("total"));            
		}
  		$("#total").text(total);
	}

	//页面上点击立即购买
    function buyNow(){
        var pId = "${param.pId}";
		var product;
		$.ajax({
			type: 'get',
			url: '${ctx }/appsite/product/select?id='+pId,
			dataType: 'json',
			async:false,
			success: function (result) {
                product = result.product;
				console.log(result);
			},
			error: function (msg) {
				console.log(msg);
				alert("系统异常");
			}
		});

        var num = '${param.num}'.length>0 ? '${param.num}': 0;
        var price = '${param.price}'.length>0 ? '${param.price}': 0;
		var b = "margin-top:0px;";
		var remark = "<div class='tabhead' style='background-color:white;margin-top: 10px;padding: 5px 0px 5px 0px;'><label style='margin-left: 5px;'>备注 : </label><input name='remarks' class='remark' style='border:1px solid #cecece;height:24px;width: 1230px;'></div>";
		var html= "<div name='t'><div name='s' class='tabhead''><div style='padding: 12px'>"+
			"<div name='total' total='"+num * price+"' onclick='select(this)'>"+formatDate_YMD_HMS(new Date())+"</div></div></div>"+
			"<div style='height: 80px; width: 100%; border: 1px solid #e8e8e8; display: flex; border-top: 0px'>"+
			"<div class='tabcontent' style='width:79%; padding-left: 20px'>"+
			"<a target='_blank' href='${ctx}web/product/details/${param.pId}.html'><img onerror='onerrorIMG(this)' style='height: 80%;width: auto;padding-top:10px' src='${ctxUphoto}"+product.image+"'>"+
			"<span>"+(product.isUp==0?"已下架,请删除该商品":product.name+"("+product.name+")")+"</span></a></div><div class='tabcontent'  style='width: 100px; text-align: center; padding-top: 30px'>￥"+product.price+"</div>"+
			"<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 30px'>${param.num}</div>"+
			"<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 30px'>￥"+num * product.price+"</div>"+
			"</div>"+remark+"</div>";
		$("#main").append(html);

        var total= num * product.price;
        $("#total").text(total);
    }

    function JsonDataBuyNow(){
        var a = $("#main").find("[name='t']");
        var address = $("#address").val();
        if(address==null) {
            layer.msg("请选择收货地址");
            return;
		}

        $.ajax({
            type: 'post',
            url: '${ctx }web/order/buynow',
            dataType: 'json',
            async:false,
			data:{
                productId:"${param.pId}",
                remarks:$("#main").find("[name='remarks']").val(),
                addressId:address,
				number: "${param.num}"
			},
            success: function (result) {
                if(result.status==1){
                    // layer.msg(result.msg);
                    var parames = new Array();
                    parames.push({ name: "orderId", value: result.orderId });
                    parames.push({ name: "way", value: "buynow" });
					Post("${ctx}web/order/pay.jsp", parames);
                }else{
                    layer.msg(result.msg,{icon: 5});
                }
            },
            error: function (msg) {
                console.log(msg);
                alert("数据初始化异常");
            }
        });
    }
	
	function JsonData(){                                                                                                               
		var a = $("#main").find("[name='t']");               
		var address = $("#address").val();
		if(address==null) layer.msg("请选择收货地址");                      
		var params = new Array();
  		for(var i=0;i<a.size();i++){                               
 			var sc=$(a[i]).find("[name='s']").attr("shopcar");               
 			var remark=$(a[i]).find("[name='remarks']").val();
 			var status=((remark==null)?6:0);
 			var param = {shopcarId:sc,addressId:address,remarks:remark,status:status};
 			params.push(param);             
		}
  		$.ajax({       
	            type: 'post',
	            url: '${ctx }web/order/insert?content='+encodeURIComponent(JSON.stringify(params)),
	            dataType: 'json',            
	           	async:false,                     
	            success: function (result) {
	                console.log(result)
	                if(result.status==1){
                        var parames = new Array();
                        parames.push({ name: "orderIdList", value: result.orderIdList });
                        parames.push({ name: "way", value: "car" });
                        Post("${ctx}web/order/pay.jsp", parames);
	                }else{                 
	                	layer.msg(result.msg,{icon: 5});
	                }
	            },
	            error: function (msg) {
	                console.log(msg);
	                alert("数据初始化异常");
	            }
	     });           
	}
	new Vue().$mount('#app');
	//获取收货地址
	function getType() {               
		$.ajax({
			type : 'get',
			url : '${ctx }address/selectList?pageNum=' + 1 + '&userid=${sessionScope.USER_SESSION_NAME.id}',
			dataType : 'json',
			async : false,               
			success : function(result) {
				var data="";   
				var def = "";            
				if (result.count > 0) {              
					var list = result.list;                          
					data = "";        
					for (var i = 0; i < list.length; i++) {                          
						data += "<option "+"value="+list[i].id+">"                                 
								+ list[i].address +" "+list[i].detailaddress+ " | 收货人:"+list[i].name+" | 联系电话:"+list[i].phone+"</option>";            
						def = list[i].state==1?list[i].id:def;              
					}
    			}            
				$("#address").append(data);
				$("#address").val(def);                          
			},
			error : function(msg) {
				console.log(msg);
				alert("数据初始化异常");
			}
		});
	}

	//渲染表单
	function renderForm() {
		layui.use('form', function() {
			//form = layui.form;   
			//监听提交
			
			form.render();
		});
	}
	function onerrorIMG(obj) {
        obj.src='${ctxRes}/images/404-img.jpg';
    }
	function next(){
	    if(buyType == 'buynow'){
            JsonDataBuyNow();
		}else{
            JsonData();
        }
	}
	$(function() {// 初始化内容
		getType();
		renderForm();                          
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

</script>
</html>
