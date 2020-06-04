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
<form class="layui-form" action="">
  <div class="layui-form-item">
    <label class="layui-form-label">物流号</label>       
    <div class="layui-input-block">                    
      <input type="text" id="name" required  lay-verify="required" placeholder="物流号" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>           
    </div>
  </div>
</form>
 
<script>
//Demo
layui.use('form', function(){              
  var form = layui.form;
  
  //监听提交
  form.on('submit(formDemo)', function(data){          
	  $.ajax({
          type: 'post',           
          url: '${ctx }sys/order/logistics?id=${param.id}&logistics='+$("#name").val(),                  
          dataType: 'json',
          success: function (result) {
        	 closeWindow();            
        	 layer.msg(result.msg);
          },
          error: function (msg) {
              console.log(msg);
              alert("数据初始化异常");
          }
      });
    return false;
  });
});
//关闭当前弹出窗口
function closeWindow() {
    window.parent.frames["订单列表"].location.reload() ;// 刷新父窗口 
    setTimeout(function (){
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
        //layer.closeAll(); //疯狂模式，关闭所有层
    },1000)
}
</script>

</html>
       