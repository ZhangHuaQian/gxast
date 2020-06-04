<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>购物车-广西科普传播中心</title>
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
input[type="checkbox"]{margin-right:10px;width:16px;height:16px;display: inline-block;text-align: center;vertical-align: middle; line-height: 18px;position: relative;}
input[type="checkbox"]::before{content: "";position: absolute;top: 0;left: 0;background: #fff;width: 100%;height: 100%;border: 1px solid #d9d9d9}                
input[type="checkbox"]:checked::before{content: "\2713";background-color: #fff;position: absolute;top: 0;left: 0;width:100%;border: 1px solid black;color:black;font-size: 20px;font-weight: bold;}
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
</style>
<style>
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
	<div class="bg" style="margin-top: 10px">
		<div                            
			style="background-color: white; margin: 15px 0px; width: 1340px; height: 40px; border: 1px solid #e8e8e8">
			<div id="app" style="margin: 13px;">                                     
				<el-breadcrumb separator-class="el-icon-arrow-right">
				<el-breadcrumb-item> <i class="layui-icon">&#xe68e;
				</i> 您当前的位置</el-breadcrumb-item> <el-breadcrumb-item> <a
					href="${ctx }/web/product/home">商城首页</a></el-breadcrumb-item> <el-breadcrumb-item>购物车</el-breadcrumb-item>
				</el-breadcrumb>                          
			</div>
		</div>

		<div>
			<p style="font-size: 16px;padding-left: 10px;" id="count"></p>
		</div>
		<hr
			style="width: 100%; margin-top: 15px; background-color: #e8e8e8; height: 1px; border: none" />
		<div>                     
				<div class="tabhead">                          
					<div style="display: flex;height:100%;text-align: center;">           
						<div  style="height:100%;border-right: 1px solid #e8e8e8;flex:1">
							<p style="padding-top: 12px">商品信息</p>
						</div>
						<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 100px">
							<p style="padding-top: 12px">单价</p>
						</div>
						<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 160px">
							<p style="padding-top: 12px">数量</p>
						</div>
						<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 100px">                  
							<p style="padding-top: 12px">小计</p>   
						</div>
						<div  style="height:100%;border-right: 1px solid #e8e8e8;width: 100px">                          
							<p style="padding-top: 12px">操作</p>                           
						</div>                      
					</div>                   
				</div>
		</div>                               
		<div id="main" style="margin-bottom: 100px">                             
   		</div>
	</div>
	<div class="footer">                                           
	<div style="width: 100%;height: 70px;border-top:1px solid #e8e8e8;background-color: white">
 		<div style="margin: 0px auto;width: 70%;height: auto;min-width: 1302px;display: flex;flex-direction: row;">
 		<div style="width:150px;margin: 25px 0px">                                                     
 			<input style="vertical-align:middle;" type='checkbox' id="all"><span style="vertical-align:middle;">全选</span>
 		</div>
 		<div style="width:200px;margin: 25px 550px 25px 0px;">
 			<button id="delChecked" title="点击清空所有物品" class='layui-btn layui-btn-danger layui-btn-sm layui-btn-disabled' disabled>删除选中</button>
 			<button id="clear" title="点击清空所有物品" class='layui-btn layui-btn-danger layui-btn-sm'>清空购物车</button>
 		</div>
 		<div style="width:150px;margin: 25px 0px">                                                      
 			已选择 <span id="sel" style="color:red">0</span> 件商品
 		</div>
 		<div style="width:150px;margin: 25px 0px">                           
 			总价:￥ <span id="total" style="color:red;font-weight: bold;">0</span>
 		</div>       
 		<div style="width:150px;height: 71px">                                                      
 			<button onclick="next()" title="点击结算" style="cursor:pointer;width: 100%;height: 100%;border:1px solid #ff7c1b;background-color: #FF5722;font-size: 20px;color: white;">去结算</button>
 		</div>            
 		</div>                              
 	</div>
	</div>            
</body>        
<script>
	var layer;
	$(function () {
        layui.use('layer', function() { //独立版的layer无需执行这一句
            var $ = layui.jquery;
            layer = layui.layer; //独立版的layer无需执行这一句
        });
    });

	//清空购物车
	var length = 0;//购物车数量
	$("#clear").click(function(){
        layer.open({
            type: 1
            ,title: false //不显示标题栏
            ,closeBtn: false
            ,area: '[200px;200px]'
            ,shade: 0.3
            ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
            ,btn: ['确定', '取消']
            ,btnAlign: 'c'
            ,moveType: 1 //拖拽模式，0或者1
            ,content: '<div style="padding: 50px; line-height: 22px; font-weight: 700;">确定要清空购物车吗</div>'
            ,yes: function(index,layero){
                clear();
            }
        });
	  });
	function clear(){                                          
		$.ajax({
			type : 'post',
			url : '${ctx }web/shopcar/deleteAll',
			dataType : 'json',
			async : false,
			success : function(result) {
				layer.msg("清空成功");
            	setTimeout( function(){
            		window.location.reload();
            	}, 2 * 1000 );
			},
			error : function(msg) {
				console.log(msg);
				alert("数据初始化异常");
			}
		});
	}

    //删除选中商品
    $("#delChecked").click(function(){
        layer.open({
            type: 1
            ,title: false //不显示标题栏
            ,closeBtn: false
            ,area: '[200px;200px]'
            ,shade: 0.3
            ,id: 'LAY_layuipro2' //设定一个id，防止重复弹出
            ,btn: ['确定', '取消']
            ,btnAlign: 'c'
            ,moveType: 1 //拖拽模式，0或者1
            ,content: '<div style="padding: 50px; line-height: 22px; font-weight: 700;">确定要删除选中商品吗</div>'
            ,yes: function(index,layero){
                deleteCheckedProduct();
            }
        });
    });
    function deleteCheckedProduct(){

        var carIdArray = new Array();
        var index = 0;
        var a = $("#main").find("[name='total']");
        for(var i=0;i<a.size();i++){
            if($(a[i]).find("[type='checkbox']").prop("checked")==true){
                var carId = $(a[i]).find("[type='checkbox']").attr("shopcar");
                carIdArray[index] = carId;
                index ++;
            }
        }
        $.ajax({
            type : 'post',
            url : '${ctx }web/shopcar/deleteCheckedProduct',
            dataType : 'json',
            async : false,
            data: {
                carIdArray:carIdArray.toString()
			},
            success : function(result) {
                layer.msg("删除成功",{time:2000},function () {
                    window.location.reload();
                });
            },
            error : function(msg) {
                console.log(msg);
                alert("数据初始化异常");
            }
        });
    }

	//全选 和 全不选   
	var flag=true;                                                 
	$("#all").click(function(){                                                     
		var total=0;                                              
		if(flag){ 
 			if($("[type='checkbox']").prop("disabled")==false){
				$("[type='checkbox']").prop("checked",'true');//全选  
				$("#sel").text($("input:checkbox:checked").length-1);
			}
			//删除选中按钮设置为可用
            $("#delChecked").removeAttr("disabled");
			$("#delChecked").removeClass("layui-btn-disabled");

		}else{                                                                                               
	  		            
			$("[type='checkbox']").prop("checked",null);//全不选 
			$("#sel").text($("input:checkbox:checked").length);

			//删除选中按钮设置为不可用
			$("#delChecked").attr("disabled",true);
			$("#delChecked").addClass("layui-btn-disabled");

		}                                                         
		var a = $("#main").find("[name='total']");
  		for(var i=0;i<a.size();i++){                               
	 		if($(a[i]).find("[type='checkbox']").prop("checked")==true){
	 			total+=parseFloat($(a[i]).attr("total"));            
	 		}                     
		}
  		$("#total").text(total);
		flag=!flag;                                 
	  });      
	$(function () {         
		getShopCar();
	});
	function getShopCar(){
		$.ajax({
    		type: 'get',
            url: '${ctx }web/shopcar/shopcar',
            dataType: 'json',
            async:false, 
            success: function (result) {
            	var shopcars = result.shopcars;                
            	$("#count").text( "全部商品 ("+shopcars.length+")");
            	if(shopcars!=null){
            		length = shopcars.length;
            	}
            	length = shopcars.length;
            	var products = result.products;         
            	for(var i=0;i<shopcars.length;i++){         
            		var shopcar = shopcars[i].price;
            		var list = JSON.parse(products[i].specifications);
            		var price ;
            		for(var j=0;j<list.length;j++){                               
            			if(list[j].id_==shopcars[i].pid){
            				price=list[j].price;                                          
            				break;
            			}                 
            		}
            		var color = "";
            		var color2 = "";                          
            		if(shopcar<price){//如果价格上涨 
            			color="(<span style='color:red'>"+price+"↑</span>)";
            			color2="(<span style='color:red'>"+price*shopcars[i].number+"↑</span>)";  
            		}else if(shopcar>price){//如果价格下降   
            			color="(<span style='color:#14e014'>"+price+"↓</span>)";                          
            			color2="(<span style='color:#14e014'>"+price*shopcars[i].number+"↓</span>)";                                                  
            		}
            		var html= "<div id='"+i+"'><div class='tabhead'><div style='padding: 12px'>"+                                                             
                	"<div name='total' total='"+shopcars[i].number*shopcars[i].price+"' onclick='select(this)'><input style='vertical-align:middle;' shopcar='"+shopcars[i].id+"'  type='checkbox'"+(products[i].isUp==0?"disabled":"")+"><span style='vertical-align:middle;'>"+formatDate_YMD_HMS(shopcars[i].createtime)+"</span></div></div></div>"+
                	"<div style='height: 80px; width: 100%; border: 1px solid #e8e8e8; display: flex; border-top: 0px'>"+
                	"<div class='tabcontent' style='flex: auto; padding-left: 20px'>"+                                                                                                               
                	"<a target='_blank' href='${ctx}web/product/details/"+products[i].id+".html'><img onerror='onerrorIMG(this)' style='height: 80%;width: 100px;padding-top:10px' src='${ctxUphoto}"+products[i].image+"'>"+
                	"<span style='margin-left:20px;'>"+(products[i].isUp==0?"已下架,请删除该商品":products[i].name+"("+shopcars[i].name+")")+"</span></a></div><div class='tabcontent'  style='width: 100px; text-align: center; padding-top: 30px'>￥"+shopcars[i].price+color+"</div>"+
                	"<div class='tabcontent' style='width: 160px; text-align: center; padding-top: 30px'><span id='n"+i+"'>"+
                   		"<div class=\"layui-btn-group\">\n" +
                        "  <button type=\"button\" class=\"layui-btn layui-btn-primary layui-btn-sm\" onclick='updateCount(0,\""+shopcars[i].id+ "\",\""+ products[i].id + "\",\"" +shopcars[i].price+"\")'>\n" +
                        "    <i class=\"layui-icon\">-</i>\n" +
                        "  </button>\n" +
                        "  <button style='width:50px;padding:0px' type=\"button\" class=\"layui-btn layui-btn-primary layui-btn-sm\">\n" +
                        "    <input id='"+shopcars[i].id+"' readonly class=\"layui-icon\" value='"+ shopcars[i].number +"' style='width: 45px;border: 0px;float: left;text-align: center;' />"+
                        "  </button>\n" +
                        "  <button type=\"button\" class=\"layui-btn layui-btn-primary layui-btn-sm\" onclick='updateCount(1,\""+shopcars[i].id+ "\",\""+ products[i].id + "\",\"" +shopcars[i].price+"\")'>\n" +
                        "    <i class=\"layui-icon \">+</i>\n" +
                        "  </button>\n" +
                        "</div>"+
					"</span></div>"+
                	"<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 30px'>￥<span id='sub-total-"+shopcars[i].id+"'>"+shopcars[i].number*shopcars[i].price+color2+"</span></div>"+
                	"<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 30px'><button class='layui-btn layui-btn-danger layui-btn-xs' idd='"+i+"' shopcar='"+shopcars[i].id+"'  onclick='del(this)'>删除</button></div>"+
                	"</div></div>";                                                                                                                                               
                	$("#main").append(html);                                                                                                            
            	}      
           },
            error: function (msg) {                                                                                     
                console.log(msg);   
                alert("系统异常");            
            }              
    	});                  
	}                                                      
	function add_num(i){
		$("#n"+i).text(parseInt($("#n"+i).text())+1);
	}                      
	function add_reduce(i){
		if(parseInt($("#n"+i).text())>0){
			$("#n"+i).text(parseInt($("#n"+i).text())-1);
		}
	}

	//删除商品
	function del(obj){
		var shopcar = $(obj).attr("shopcar");
		console.log(shopcar)
        $.ajax({
            type: 'post',
            url: '${ctx }web/shopcar/delete?id1='+shopcar,
            dataType: 'json',
            success: function (result) {
                if(result.status==1){
                	layer.msg(result.msg);
                	$("#"+$(obj).attr("idd")).remove();
                	length--;
                	$("#count").text( "全部商品 ("+length+")");
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

    //商品数量修改
    function updateCount(value,carId,prodId,price){
	    // value值：0减，1加

		var num = $("#"+carId).val();
		if(value == 1 ){
            num ++;
		}else{
            num --;
		}

		//数量大于0
        if( num > 0){
            $.ajax({
				type: 'post',
				url: '${ctx }web/shopcar/update',
				dataType: 'json',
				data:{
                    carId:carId,
                    prodId:prodId,
                    num:num,
				},
				success: function (result) {
                    layer.msg(result.msg);
					if(result.status==1){
					    //数量
                        $("#"+carId).val(num);
                        //小计
                        $("#sub-total-"+carId).text(num*price);
						//勾选商品时总价统计调用的属性
                        $("#main").find("[shopcar='"+carId+"']").parent().attr("total",num*price);

                        //如果选中，刷新总价统计
                        var checked = $("#main").find("[shopcar='"+carId+"']").prop("checked");
                        if(checked){
                            select();
                        }
					}
				},
				error: function (msg) {
				console.log(msg);
				alert("数据初始化异常");
				}
            });
		}
    }

    //勾选商品
    function select(obj){
        var checkAll = true; // 全部选中
		var delChecked = false; //删除选中按钮
            var total=0;
		if($("#all").prop("checked")==true){                 
			$("#sel").text($("input:checkbox:checked").length-1);  
		}else{
			$("#sel").text($("input:checkbox:checked").length);  
		}
		var a = $("#main").find("[name='total']");
  		for(var i=0;i<a.size();i++){                               
	 		if($(a[i]).find("[type='checkbox']").prop("checked")==true){
	 			total+=parseFloat($(a[i]).attr("total"));
	 			delChecked = true;
	 		}else{
                checkAll = false; // 非全部选中
			}
		}
  		$("#total").text(total);
  		if(checkAll){
            $("#all").prop("checked",true);
		}else{
            $("#all").prop("checked",false);
        }

        if(delChecked){
            //删除选中按钮设置为可用
            $("#delChecked").removeAttr("disabled");
            $("#delChecked").removeClass("layui-btn-disabled");
		}else{
            //删除选中按钮设置为不可用
            $("#delChecked").attr("disabled",true);
            $("#delChecked").addClass("layui-btn-disabled");
		}
	}
	new Vue().$mount('#app');


	function onerrorIMG(obj) {
        obj.src='${ctxRes}/images/404-img.jpg';
    }
	function next(){
		JsonData();
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
	function JsonData(){                  
		var a = $("#main").find("[name='total']"); 
		var parames = new Array();
		var b = "";
  		for(var i=0;i<a.size();i++){                               
	 		if($(a[i]).find("[type='checkbox']").prop("checked")==true){         
	 			var sc=$(a[i]).find("[type='checkbox']").attr("shopcar");
	 			if(b=="") b+=sc;
	 			else b+=","+sc;
	 			/* $.ajax({
	 	            type: 'post',
	 	            url: '${ctx }/web/order/insert?shopcarId='+sc,
	 	            dataType: 'json',
	 	           async : false,
	 	            success: function (result) {                                          
	 	                if(result.status==1){
	 	                	layer.msg(result.msg);
	 	                	setTimeout( function(){    
	 	                		window.location.href="${ctx}web/shopcar/address.jsp"; 
	 	               		}, 2 * 1000 );
	 	                }else{                 
	 	                	layer.msg(result.msg,{icon: 5});
	 	                }
	 	            },
	 	            error: function (msg) {
	 	                console.log(msg);
	 	                alert("数据初始化异常");
	 	            }
	 	        }); */  
	 		}                                        
		}
  		if(b==""){
  			layer.msg("请选择商品");
  			return false;                          
  		}
  		parames.push({ name: "name", value: b});
  		Post("${ctx}web/shopcar/address.jsp", parames);
	}
</script>
</html>
