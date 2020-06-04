<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <link rel="stylesheet" href="${ctxRes}css/global.css">
    <meta name="description" content="${news.description}">
    <meta name="keywords" content="HTML,CSS,XML,JavaScript">
    <title>网站声明-广西科普传播中心</title>

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
        .like{
           color:#1E9FFF; cursor:pointer;
            margin-left: 1em;
        }
        .comments {
            width: 98%; /*自动适应父布局宽度*/
            overflow: auto;
            word-break: break-all;
        }
        .commentsBtn{
            padding-right: 20px;
            color: #999;
            cursor: pointer;
        }

        #details img{
            max-width: 100%;
        }
        #details *{
            max-width: 100%;
            height: auto;
            width: auto;
        }


        .p {
            padding: 5px 50px;
            font-size: 18px;
            text-indent:2em;
            text-align: left;
            line-height: 35px;
        }
        .p2 {
            font-weight: 500;
        }
    </style>
</head>
<body style="background-color: #f2f5f9">
<div id="main" style="margin-top: 0px">
    <div style="width:100%;background-image: url('${ctxRes}images/news_top.png');min-width:1302px;">

        <div id="main_center" style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 20px;">
            <%@ include file="/web/include/head.jsp"%>
        </div>
    </div>

    <div style="width: 100%;text-align: center;">
        <div style="width:70%;min-width:1202px; background-color: white;margin:0 auto;padding-bottom: 50px">
            <h1 style="line-height: 100px;">隐私政策</h1>
            <p class="p">广西科普传播中心尊重并保护所有使用服务用户的个人隐私权。为了给您提供更准确、更有个性化的服务，
                广西科普传播中心会按照本隐私权政策的规定使用和披露您的个人信息。但广西科普传播中心将以高度的勤勉、
                审慎义务对待这些信息。除本隐私权政策另有规定外，在未征得您事先许可的情况下，广西科普传播中心不会将这些信息对外披露或向第三方提供。
                广西科普传播中心会不时更新本隐私权政策。您在同意广西科普传播中心服务使用协议之时，即视为您已经同意本隐私权政策全部内容。
                本隐私权政策属于广西科普传播中心服务使用协议不可分割的一部分。 </p>

            <p class="p p2" >1. 适用范围</p>
            <p class="p" >a) 在您注册广西科普传播中心门户网站帐号时，您根据广西科普传播中心门户网站要求提供的个人注册信息；</p>
            <p class="p" >b) 在您使用广西科普传播中心网络服务，或访问广西科普传播中心门户网站时，广西科普传播中心自动接收并记录的您的浏览历史等数据；</p>
            <p class="p" >您了解并同意，以下信息不适用本隐私权政策：</p>
            <p class="p" >a) 您在使用广西科普传播中心平台提供的搜索服务时输入的关键字信息； </p>
            <p class="p" >b) 广西科普传播中心收集到的您在广西科普传播中心门户网站评论的有关信息数据，包括但不限于参与活动、及答题等； </p>
            <p class="p" >c) 违反法律规定或违反广西科普传播中心规则行为及广西科普传播中心已对您采取的措施。 </p>

            <p class="p p2" >2. 信息使用</p>
            <p class="p" >a) 广西科普传播中心不会向任何无关第三方提供、出售、出租、分享或交易您的个人信息，除非事先得到您的许可，
                或该第三方和广西科普传播中心 （含广西科普传播中心关联公司）单独或共同为您提供服务，且在该服务结束后，
                其将被禁止访问包括其以前能够访问的所有这些资料。 </p>
            <p class="p" >b) 广西科普传播中心亦不允许任何第三方以任何手段收集、编辑、出售或者无偿传播您的个人信息。任何广西科普传播中心门户网站用户如从事上述活动，
                一经发现，广西科普传播中心有权立即终止与该用户的服务协议。</p>
            <p class="p" >c) 为服务用户的目的，广西科普传播中心可能通过使用您的个人信息，向您提供您感兴趣的信息，包括但不限于向您发出产品和服务信息，
                或者与广西科普传播中心合作伙伴共享信息以便他们向您发送有关其产品和服务的信息（后者需要您的事先同意）。 </p>

            <p class="p p2" >3. 信息披露</p>
            <p class="p" >在如下情况下，广西科普传播中心将依据您的个人意愿或法律的规定全部或部分的披露您的个人信息：</p>
            <p class="p" >a) 经您事先同意，向第三方披露；</p>
            <p class="p" >b) 为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；</p>
            <p class="p" >c) 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；</p>
            <p class="p" >d) 如您出现违反中国有关法律、法规或者广西科普传播中心服务协议或相关规则的情况，需要向第三方披露；</p>
            <p class="p" >e) 如您是适格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷；</p>
            <p class="p" >f) 其它广西科普传播中心根据法律、法规或者网站政策认为合适的披露。</p>

            <p class="p p2" >4. 信息存储和交换</p>
            <p class="p" >广西科普传播中心收集的有关您的信息和资料将保存在广西科普传播中心及（或）其关联公司的服务器上，
                这些信息和资料可能传送至您所在国家、地区或广西科普传播中心收集信息和资料所在地的境外并在境外被访问、存储和展示。</p>

            <p class="p p2" >5. 信息安全 </p>
            <p class="p" >a) 广西科普传播中心帐号均有安全保护功能，请妥善保管您的用户名及密码信息。广西科普传播中心将通过对用户密码进行加密等安全措施确保您的信息不丢失，
                不被滥用和变造。尽管有前述安全措施，但同时也请您注意在信息网络上不存在“完善的安全措施”。</p>
            <p class="p" >b) 在使用广西科普传播中心网络服务进行网上交易时，您不可避免的要向交易对方或潜在的交易对方披露自己的个人信息，
                如联络方式或者邮政地址。请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，
                尤其是广西科普传播中心门户网站用户名及密码发生泄露，请您立即联络广西科普传播中心客服，以便广西科普传播中心采取相应措施。</p>
        </div>
    </div>
    <div>
        <%@ include file="/web/include/footer.jsp"%>
    </div>
</div>


</body>
</html>
