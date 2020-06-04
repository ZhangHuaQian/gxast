<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/12/28
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<html>
<head>
    <%@ include file="/commViews/head.jsp" %>
    <title>我的订单-广西科普传播中心</title>
    <style>
        /*为添加的空div设置的样式*/
        .clearDiv {
            clear: both;
        }

        .triangle-tip-up {
            width: 200px;
            background: #ffffff;
            border-radius: 4px;
            position: relative;
        }

        .triangle-tip-up:before {
            content: '';
            width: 0;
            height: 0;
            border-width: 0 10px 10px;
            border-style: solid;
            border-color: transparent transparent #ffffff;
            position: absolute;
            left: 375px;
            top: -10px;
        }

        .tabhead {
            margin-top: 20px;
            background-color: #f2f2f2;
            width: 100%;
            height: 40px;
            border: 1px solid #e8e8e8;
            background-color: #f2f2f2;
        }

        .bottomMargin {
            margin-bottom: 10px;
        }

    </style>
</head>

<script type="text/javascript" src="${ctx}resource/js/mycity.js"

        function openpage(){
        window.location="/test.jsp" ;></script>

<body style="background-color: #ffffff">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <%@ include file="/web/include/ucenter-head.jsp"%>
    <form class="layui-form" id="main_form" accept-charset="utf-8">
    <div id="newslistdiv" class="triangle-tip-up"
         style="width:70%;min-width:1302px;margin: 0px auto;height:auto;min-height:700px;background-color: #FFFFFF">
        <%@ include file="/web/include/ucenter-left-menu.jsp" %>
        <div style="width:80%;margin-top:15px;float: right;height:auto;border: 1px solid #e8e8e8">
            <div style="width: 96%;padding:0px 0px;margin: 20px auto;color: #343434">
            </div>
            <div id="main1">
            </div>
            <input type="hidden" name="orderId" value="${param.id}">
        </div>
        <div style="float: right;width: 78%;margin-top: 90px;border: 1px solid #e8e8e8;padding: 12px;">

            <div>
                <input type="radio" name="rank" value="1" title="好评" >
                <input type="radio" name="rank" value="2" title="中评" >
                <input type="radio" name="rank" value="3" title="差评" >
            </div>

            <span>宝贝与描述相符</span>
            <div id="test1">
            </div>
            <input type="hidden" id="productDescription" name="productDescription">

            <p class="bottomMargin">
                <textarea style="width: 100%;height: 100px;padding: 5px;" id="comment" name="comment" readonly></textarea>
            </p>

            <div>
                <ul>
                    <li>
                        <label>卖家的服务态度</label>
                        <div id="test2">
                        </div>
                        <input type="hidden" id="serviceAttitude" name="serviceAttitude">
                    </li>
                    <li>
                        <label>卖家发货的速度</label>
                        <div id="test3">
                        </div>
                        <input type="hidden" id="deliverySpeed" name="deliverySpeed">
                    </li>
                </ul>
            </div>
        </div>
    </div>
</form>
<%@ include file="/web/include/footer.jsp" %>

<script>
    var form;

    //好评、中评、差评的 radio有时候渲染不出来，需要用定时器定时重新渲染一次
    setTimeout(function () {
        form.render();
    },100);

    function initData(){
        $.ajax({
            type: 'get',
            url: '${ctx }/sys/productComment/selectByOrderIdAndUid?orderId=${param.id}',
            dataType: 'json',
            async: false,
            success: function (result) {
                // console.log(result);
                result = result.data;
                $("#comment").text(result.comment)
                $("#commentTime").text("评价时间："+formatDate_YMD_HMS(result.createTime));
                $(":radio[name='rank'][value='" + result.rank + "']").prop("checked", "checked");
                layui.use(['layer','rate','form'], function(){
                    layer = layui.layer;
                    form = layui.form;
                    var rate = layui.rate;
                    //宝贝与描述相符
                    var test1 = rate.render({
                        elem: '#test1'
                        ,value: result.productDescription //初始值
                        ,text: true //开启文本
                        ,readonly: true
                        ,setText: function(value){ //自定义文本的回调
                        }
                    });
                    //卖家的服务态度
                    rate.render({
                        elem: '#test2'
                        ,value: result.serviceAttitude
                        ,text: true
                        ,readonly: true
                        ,setText: function(value){ //自定义文本的回调
                            var arrs = {
                                '1': '极差'
                                ,'2': '差'
                                ,'3': '中等'
                                ,'4': '好'
                                ,'5': '极好'
                            };
                            this.span.text(arrs[value] || ( value + "星"));
                        }
                    })
                    //卖家发货的速度
                    rate.render({
                        elem: '#test3'
                        ,value: result.deliverySpeed
                        ,text: true
                        ,readonly: true
                        ,setText: function(value){ //自定义文本的回调
                            var arrs = {
                                '1': '极慢'
                                ,'2': '慢'
                                ,'3': '中等'
                                ,'4': '快'
                                ,'5': '极快'
                            };
                            this.span.text(arrs[value] || ( value + "星"));
                        }
                    })
                });
            },
            error: function (msg) {
                console.log(msg);
            }
        });
    }

    $(function () {
        getShopCar(1, 5);
        initData();
    });

    var count = 0;
    function getShopCar(pageNum, pageSize) {
        $.ajax({
            type: 'get',
            url: '${ctx }web/order/select?id=${param.id}',
            dataType: 'json',
            async: false,
            success: function (result) {

                $("#main1").html("");
                var shopcar = result.shopcars[0];
                var order = result.order;

                var a = "<div class='tabhead'><div style='padding: 12px'>" +
                    "<div name='total'>下单时间：" + formatDate_YMD_HMS(order.createtime) + "<span style='margin-left: 20px;' id='commentTime'>评论时间</span></div></div>";
                var html = a +
                    "<div style='height: 80px; width: 100%; border: 1px solid #e8e8e8; display: flex; border-top: 0px'>" +
                    "<div class='tabcontent' style='flex: auto; padding-left: 20px'>" +
                    "<a target='_blank' href='${ctx}web/product/details/" + shopcar.productId + ".html'><img onerror='onerrorIMG()' style='height: 80%;width: 100px;padding-top:10px' src='${ctxUphoto}" + shopcar.image + "'>" +
                    "<span>&nbsp;" + shopcar.name + "</span></a></div><div class='tabcontent'  style='width: 100px; text-align: center; padding-top: 30px'>x" + shopcar.number + "</div>" +
                    "<div class='tabcontent' style='width: 100px; text-align: center; padding-top: 30px'>￥" + shopcar.number * shopcar.price + "</div>" +
                    "</div></div>";
                $("#main1").append(html);
            },
            error: function (msg) {
                console.log(msg);
            }
        });
    }
    function onerrorIMG() {
        var img = event.srcElement;
        img.src = "${ctxRes}/images/404-img.jpg";
        img.onerror = null;
    }
</script>
</body>

</html>
