<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>layout 后台大布局 - Layui</title>
 <%--<%@ include file="/commViews/head.jsp"%>--%>
  <link type="text/css" rel="stylesheet" href="${ctx }resource/css/demo.css">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/layui.css">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/modules/code.css">
  <link rel="stylesheet" href="${ctx }resource/plugins/layui2/css/modules/laydate/default/laydate.css">

  <script src="${ctx }resource/js/jquery-1.11.1.min.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx }resource/plugins/layui2/layui.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx }resource/plugins/layui2/lay/modules/layedit.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctxRes }js/cen.js" type="text/javascript" charset="utf-8"></script>
</head>
  
  <div class="" id="div1">
    <div style="padding: 10px;" id="main"> 
        <table id="table" style="border:0px;;width: 100%;">

        </table>
    </div>                            
    <div style="margin: 20px;font-size: 18px;">

    	<p style="margin: 5px 0px;"><span style="color: red;">微信支付订单号</span> : <span id="pay_num"></span></p>
    	<p style="margin: 5px 0px;"><span style="color: red;">商户订单号</span > : <span id="order_num"></span></p>
    	<c:if test="${param.password!=''}"><p><span style="color: red;">密码</span> : ${param.password }</p></c:if>
    	<p style="margin: 5px 0px;"><span style="color: red;">地址</span> : ${param.area} <c:if test="${param.school!='' && param.school!= 'undefined'}"> ${param.school}</c:if>
            <c:if test="${param.classes!='' && param.classes != 'undefined'}"> ${param.classes}</c:if>
    	<p style="margin: 5px 0px;"><span style="color: red;">姓名</span> : ${param.name }</p>
    	<p style="margin: 5px 0px;"><span style="color: red;">手机</span> : ${param.phone }</p>
        <c:if test="${param.remark!=''}">
    	<p style="margin: 5px 0px;"><span style="color: red;">备注</span> : ${param.remark }</p>
        </c:if>
    </div>
  </div>
<script type="text/javascript">
	var list = ${param.goods };
    var array = '${param.code}'.split(" ");
    var pay_num = '' ;
    var order_num = '';
    for(var i = 0;i< array.length;i++){
        if(i==array.length-4){
            console.log(array[i]);
            pay_num = array[i]
        }
        if(i==array.length-1 ){
            console.log(array[i]);
            order_num = array[i]
        }
    }
    $("#pay_num").text(pay_num);
    $("#order_num").text(order_num);
	for(var i = 0;i<list.length;i++){
		var html = `<tr style="background-color: #e8e8e8;height: 50px;line-height: 50px;width: 100%;display: flex">
                        <td width="55%"><span style="font-size:18px;margin: 20px;">
							\${list[i].name}
							</span></td>
                        <td width="15%"><span style="color: red;">￥\${list[i].item_price/100}</span> x \${list[i].num}</td>
                        <td width="30%"><span  style="color: red;">总价:￥\${list[i].price/100}</span></td>
					</tr> `;
		$("#table").append(html);
	}
</script>
</body>
</html>