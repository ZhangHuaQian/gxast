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
    <title>我的评论列表-广西科普传播中心</title>
    <style>
        /*为添加的空div设置的样式*/
        .clearDiv {
            clear: both;
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
        <div style="width:80%;margin-top:15px;float: right;padding-top: 50px;">
			<div style="padding-top: 20px;">
				<span>我的评论列表</span>
				<hr>
			</div>
			<div id="remarkList">
			</div>
			<div style="border-bottom: 1px solid #CCCCCC;padding:28px 0px;text-align: center;"  id="no_product" >
				<span style="color: #b1acac">暂无评论</span>
			</div>
			<div id="demo2"></div>
        </div>                   
    </div>                               
</div>         

<div id="demo7" style="width: 600px;margin-top: 10px;margin-right:200px;float:right;background-color: white;border-radius: 2px;"></div> 
<div class="clearDiv"></div> 
<%@ include file="/web/include/footer.jsp"%>
<script>

	$(function () {
        initData(1);
    });

    //初始化页面数据
    function initData(pageNum) {
		$.ajax({
			type:'get',
			url:'${ctx }/appsite/productComment/selectUid?pageNum='+pageNum,
			dataType:'json',
			success:function(data) {
			    console.log(data);
				var result = data.data;

				var str = "";
				for(var i=0; i<result.data.length; i++){
					var product = result.pList[i];
					var remark = result.data[i];
					// web/user/myRemark.jsp
					str += "<a href='${ctx}web/user/myRemark.jsp?id="+ remark.orderId +"' target='_blank'><div style='height: 100px;'>\n" +
						"<div style='display: inline;float: left;'>\n" +
						"<img onerror='imgerrorfun();' style='margin-right:10px;height:80px;width:80px' src='${ctxUphoto}"+product.image+" '>\n" +
						"</div>\n" +
						"<div style='display: inline;float: left;font-size: 12px;width:60%;'>\n" +
						"<h3 style='margin-bottom: 5px;font-weight: 600;'>"+product.name+"</h3>\n" +
						"<p>"+product.description+"</p>\n" +
						"</div>\n" +
						"</div></a><hr>"
				}
				$("#remarkList").html(str);

				//分页
				initPage(result);
			},
			error: function (e) {
				console.log(e);
				layer.msg("系统异常");
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
                        initData(obj.curr);
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
</body>

</html>
