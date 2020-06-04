<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/2/14
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>支付中心</title>
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
    </style>
</head>

<script type="text/javascript" src="${ctx}resource/js/mycity.js"></script>

<body style="background-color: #ffffff">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <%@ include file="/web/include/ucenter-head.jsp"%>




    <script type="text/javascript" src="http://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://static.runoob.com/assets/qrcode/qrcode.min.js"></script>

    <input id="text" type="hidden" style="width:80%" value="${param.id}"/><br />
    <div class="two-dimensionCode-state text-center">
        <div  style="text-align: center;margin-top: 15px;margin-bottom: 65px;font-size: 22px;" class="form-group">
            请使用手机扫描二维码进行支付
        </div>
    </div>
    <div id="qrcode" style="width:350px; height:550px; color:#959e8d;margin-top:10px;margin: 0 auto"></div>
    <script type="text/javascript">
    	var websocket = null;
    	var username = "${sessionScope.USER_SESSION_NAME.id}"; // 获得当前登录人员的userName  
    	//判断当前浏览器是否支持WebSocket  
    	if ('WebSocket' in window) {                                 
    		//console.log('ws://'+window.location.host+'/gxast/webSocket/'+username);               
    	    websocket = new WebSocket('ws://139.159.138.151:8086/webSocket/'+username);  
    	} else {                                                                            
    	    //alert('当前浏览器 Not support websocket')  
    	} 
    	//连接发生错误的回调方法  
    	websocket.onerror = function() {  
    	　　alert("连接发生错误")
    	};   
    	//连接成功建立的回调方法  
    	websocket.onopen = function() {
    	}  
    	//接收到消息的回调方法          
    	websocket.onmessage = function(event) {
    		//alert("这是后台推送的消息："+event.data); 
    		if(event.data=="success"){
    			alert("支付成功");                     
    			window.location.href="${ctx}/web/user/order.jsp"
    		}
    	　　　 websocket.close();        
    	}
    	//连接关闭的回调方法  
    	websocket.onclose = function() {  
    		
    	}  
    	
    	//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。  
    	window.onbeforeunload = function() {  
    	    closeWebSocket();  
    	}  
    	
    	//关闭WebSocket连接  
    	function closeWebSocket() {  
    	    websocket.close();  
    	} 
    	
        var qrcode = new QRCode(document.getElementById("qrcode"), {
            width : 350,
            height : 350

        });

        function makeCode () {
            var elText = document.getElementById("text");

            if (!elText.value) {
                alert("Input a text");
                elText.focus();
                return;
            }           
            qrcode.makeCode(window.location.protocol+"//"+window.location.host+"/web/order/buy?id="+elText.value);
        }                           

        makeCode();

        $("#text").
        on("blur", function () {
            makeCode();
        }).
        on("keydown", function (e) {
            if (e.keyCode == 13) {
                makeCode();
            }
        });
    </script>


    <div class="clearDiv"></div>



</div>
<%@ include file="/web/include/footer.jsp"%>
</body>

</html>
