<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<html>

<head>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <%@ include file="/commViews/head.jsp" %>
    <meta name="description" content="广西科普传播中心是广西科普地方组织，是由所属自治区级学会（协会、研究会）和市、县（市、区）科协组成的科技工作者的群众组织，是自治区党委领导下的人民团体，是提供科技类公共服务产品的社会组织，是广西创新体系的 重要组成部分。旨在开展学术交流、普及科学知识、密切联系科技工作者、举荐科学技术人才、建设广西的科技创新智库、加快科学技术成果转化应用、组织所属学会承接政府职能转移、开展民间国际科学技术交流、负责中学 生参加国内外奥林匹克竞赛活动的组织审核等工作、制定全区科协系统科普工作计划并组织实施、科普场所队伍建设等。 努力把广西科普传播中心聚集重点人群打造科普活动品牌，积极作为服务全民科学素质。">
    <title>广西科普传播中心</title>
</head>

<body>
<script>
    var index = -1;
</script>
<div id="main" style="width:100%;background-repeat:no-repeat;margin-top: 0px;">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <div id="main_center" style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 20px;">
        <%@ include file="/web/include/head.jsp" %>
        <div id="main_main2" style="width: 100%;height: auto;display: block;width: 1300px;display: flex;margin-top: 10px;flex-wrap:wrap">
            <div style="width: 100%;height: 750px;display: flex;margin: 0px 0px 10px 0px">
                <div style="height: 100%;display: flex;width: 436px;">
                    <div style="width: 100%;height: 100%;display: flex;flex-wrap:wrap">
                        <div style="width: 436px;height: 254px;background-color: #FAFAFA;display: flex;position:relative" >
                            <img src="${ctxUphoto}${list1[0].projectImg}" style="width: 100%;height: 90%" onclick="ad_href('${list1[0].htmlUrl}')" />
                            <div style="position:absolute;left:0px;top:90%;"><p style="font-size:16px;margin-top:5px">${list1[0].header}</p></div>
                        </div>
                        <div style="width: 210PX;height: 136PX;margin:10px 15.5px 15px 0px;display: flex;position:relative;">
                            <img style="width: 100%;height: 100%;" src="${ctxUphoto}${list1[1].projectImg}" onclick="ad_href('${list1[1].htmlUrl}')" />
                            <div style="position:absolute;left:0px;top:100%;"><p style="font-size:12px;color: #333333;background-color: #FAFAFA;margin-top:5px">${list1[1].header}</p></div>
                        </div>
                        <div style="width: 210px;height: 136PX;margin-top: 10px;display: flex;position:relative;">
                            <img style="width: 100%;height: 100%;" src="${ctxUphoto}${list1[2].projectImg}" onclick="ad_href('${list1[2].htmlUrl}')"  />
                            <div style="position:absolute;left:0px;top:100%;"><p style="font-size:12px;color: #333333;background-color: #FAFAFA;margin-top:5px">${list1[2].header}</p></div>
                        </div>
                        <div style="width: 100%;height: 45%;">
                            <div style="width: 436px;height: 325px;border: 1px solid #E8E8E8;margin:30px 0px 0px 0px">
                                <div style="width: 100%;height: auto;">
                                    <div style="float: left;width: 100%;padding-top: 5px;border-bottom: 1px solid #E8E8E8">
                                        <div>
                                            <div style="float: left;padding-bottom: 5px;border-bottom: 1px solid #1E9FFF;margin-left: 10px;">
                                                <img src="${ctxRes}images/rl.png">
                                                <span style="color: #3482d1;"><strong>&nbsp;新媒体矩阵&nbsp;</strong></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearDiv"></div>
                                </div>
                                <%--新媒体矩阵内容--%>
                                <div style="display: flex;height: 320px;margin:0px" class="layui-tab layui-tab-card">
                                    <ul class="layui-tab-title" style="flex: 1;height: 91.6%;flex-direction: column;display: flex;" id="xmtjz">
                                        <li class="layui-this" style="border-style: none;cursor:pointer;flex: 1;display: flex;border-bottom: 1px solid #E8E8E8; border-left: 1px solid #E8E8E8;padding: 0px;height:75px;width:75px">
                                            <img style="margin: auto;" src="resource/index_img/05.png">
                                        </li>
                                        <li style="border-style: none;cursor:pointer;flex: 1;display: flex;border-bottom: 1px solid #E8E8E8;padding: 0px;border-left: 1px solid #E8E8E8;height:75px;width:75px">
                                            <img style="margin: auto;" src="resource/index_img/06.png" width="65" height="65">
                                        </li>
                                        <li style="border-style: none;cursor:pointer;flex: 1;display: flex;border-bottom: 1px solid #E8E8E8;padding: 0px;border-left: 1px solid #E8E8E8;height:75px;width:75px">
                                            <img style="margin: auto;" src="resource/index_img/07.png">
                                        </li>
                                        <li style="border-style: none;cursor:pointer;flex: 1;display: flex;border-bottom: 1px solid #E8E8E8;padding: 0px;border-left: 1px solid #E8E8E8;height:75px;width:75px">
                                            <img style="margin: auto;height: 65px;width: 65px;" src="resource/index_img/08.png">
                                        </li>
                                    </ul>
                                    <div class="layui-tab-content" style="flex: 5;height: 100%;padding:0px 0px 0px 10px">
                                        <div class="layui-tab-item layui-show" style="height: 100%;">
                                            <c:forEach items="${dzkpJZ}" var="dzkpJZ" begin="0" end="4" varStatus="status">
                                                <div class="news_title_list jrtt hideul_nfkj showul_nfkj ">
                                                    <ul  style="border-bottom:1px solid #E8E8E8;padding:5px 0px;<c:if test='${status.index==0}'>padding:13px 0px;</c:if><c:if test='${status.index==4}'>border-bottom: 0px;</c:if>">
                                                        <div class="news_list">
                                                            <a target="_blank" href="${dzkpJZ.url}"
                                                               style="margin: 0px 0px 0px 10px;"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span>
                                                                <span style="color: #000000;font-size: 16px;width:323px;height:43px;float:right;text-overflow:ellipsis;overflow:hidden;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;height: 48px</c:if>">
                                                                        ${dzkpJZ.title}
                                                                </span>
                                                            </a>
                                                        </div>
                                                    </ul>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="layui-tab-item" style="height: 100%;">
                                            <c:forEach items="${nfnzJZ}" var="nfnzJZ" begin="0" end="4" varStatus="status">
                                                <div class="news_title_list jrtt hideul_nfkj showul_nfkj ">
                                                    <ul  style="border-bottom:1px solid #E8E8E8;padding:5px 0px;<c:if test='${status.index==0}'>padding:13px 0px;</c:if><c:if test='${status.index==4}'>border-bottom: 0px;</c:if>">
                                                        <div class="news_list" >
                                                            <a target="_blank" href="${nfnzJZ.url}" style="margin: 0px 0px 0px 10px;"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;width:323px;height:43px;float:right;text-overflow:ellipsis;overflow:hidden;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;height: 48px</c:if>">
                                                                    ${nfnzJZ.title}
                                                            </span></a>
                                                        </div>
                                                    </ul>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="layui-tab-item" style="height: 100%;">
                                            <c:forEach items="${xbsbJZ}" var="xbsbJZ" begin="0" end="4" varStatus="status">
                                                <div class="news_title_list jrtt hideul_nfkj showul_nfkj ">
                                                    <ul style="border-bottom:1px solid #E8E8E8;padding:5px 0px;<c:if test='${status.index==0}'>padding:13px 0px;</c:if><c:if test='${status.index==4}'>border-bottom: 0px;</c:if>">
                                                        <div class="news_list" >
                                                            <a target="_blank" href="${xbsbJZ.url}" style="margin: 0px 0px 0px 10px;"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;width:323px;height:43px;float:right;text-overflow:ellipsis;overflow:hidden;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;height: 48px</c:if>">
                                                                    ${xbsbJZ.title}
                                                            </span></a>
                                                        </div>
                                                    </ul>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="layui-tab-item" style="height: 100%;">
                                            <c:forEach items="${nfkjbJZ}" var="nfkjbJZ" begin="0" end="4" varStatus="status">
                                                <div class="news_title_list jrtt hideul_nfkj showul_nfkj " >
                                                    <ul style="border-bottom:1px solid #E8E8E8;padding:5px 0px;<c:if test='${status.index==0}'>padding:13px 0px;</c:if><c:if test='${status.index==4}'>border-bottom: 0px;</c:if>">
                                                        <div class="news_list" >
                                                            <a target="_blank" href="${nfkjbJZ.url}" style="margin: 0px 0px 0px 10px;"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;width:323px;height:43px;float:right;text-overflow:ellipsis;overflow:hidden;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;height: 48px</c:if>">
                                                                    ${nfkjbJZ.title}
                                                            </span></a>
                                                        </div>
                                                    </ul>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearDiv"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="height: 100%;display: flex;width: 516px;position: relative">

                    <div style="margin: auto;width: 100%;height: 100%;">
                        <div style="margin:0px 0px 45px 30px;" >
                            <%--<c:forEach items="${listAll}" var="news" begin="0" end="18" varStatus="status">--%>
                            <c:forEach items="${listAll}" var="news" begin="0" end="18" varStatus="status">
                                <script>
                                    index++;
                                </script>
                                <div class="news_title_list jrtt hideul_nfkj showul_nfkj " cid="${news.id}">
                                    <ul style="margin:10px 0px">
                                        <div class="news_list" cid="${news.id}">
                                            <input id="input_${status.index}" value="${news.newTypeId}" style="display: none;">
                                            <input id="newsId_${status.index}" value="${news.id}" style="display: none">
                                            <a id="aId_${status.index}" target="_blank" href=""><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;width: 96%;float: right;<c:if test='${status.index==0 || status.index==6 || status.index==12}'>font-size:18px;font-weight: bold;</c:if>">${news.title}</span></a>
                                        </div>
                                    </ul>
                                </div>
                            </c:forEach>
                        </div>
                        <%--<div style="margin:0px 0px 0px 30px">--%>
                            <%--<c:forEach items="${news_axhd}" var="news_axhd" begin="0" end="7" varStatus="status">--%>
                                <%--<div class="news_title_list jrtt hideul_nfkj showul_nfkj " cid="${news_axhd.id}">--%>
                                    <%--<ul style="margin:10px 0px">--%>
                                        <%--<div class="news_list" cid="${news_axhd.id}">--%>
                                            <%--<a target="_blank" href="${ctx}web/news_axhd/details/${news_axhd.id}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0 || status.index==4}'>font-size:18px;font-weight: bold;</c:if>">${news_axhd.title}</span></a>--%>
                                        <%--</div>--%>
                                    <%--</ul>--%>
                                <%--</div>--%>
                            <%--</c:forEach>--%>
                        <%--</div>--%>
                    </div>
                </div>
                <div style="height: 100%;width: 348px;display: flex;">
                    <div style="margin: auto 0px auto auto;width: 100%;height: 100%;flex-wrap:wrap">
                        <div style="width: 100%;height: 27%;">
                            <div style="width: 100%;height: 100%;border: 1px solid #E8E8E8">
                                <div style="width: 100%;height: auto;">
                                    <div style="float: left;width: 100%;padding-top: 5px;border-bottom: 1px solid #E8E8E8">
                                        <div>
                                            <div style="float: left;padding-bottom: 5px;border-bottom: 1px solid #1E9FFF;margin: 15px auto 0px 15px">
                                                <span style="color: #3482d1;font-size: 16px"><strong>&nbsp;热门推荐&nbsp;</strong></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearDiv"></div>
                                </div>
                                <div>
                                    <div style="display: flex;flex-direction: column;">
                                        <div style="height: 35%;width: 100%;border-bottom: 1px solid #E8E8E8;display: flex;">
                                            <div style="width:100%;background-color: #fbfbfb;flex-direction: column;">
                                                <div style="height: 25%;width: 100%;margin:15px 5px 0px 5px">
                                                    <a href="${list8[0].htmlUrl}" style="margin: 15px;font-size: 16px;font-weight: bold;"><span style="font-weight: bold;font-size: 18px;margin-right: 5px;color: #3482d1;">·</span>${list8[0].header}</a>
                                                </div>

                                            </div>

                                        </div>

                                    </div>
                                    <div style="">
                                        <div style="width: 108px;float: left;margin: 10px 0px 0px 30px"><img style="heigth:80px;width:108px" onclick="ad_href('${list8[0].htmlUrl}')" src="${ctxUphoto}${list8[0].projectImg}" /></div>
                                        <div style="float: left;">
                                            <p style="color: darkgray;margin: 6px 0px 6px 10px;font-size:16px;">适合中小学生阅读</p>
                                            <p style="color: darkgray;margin: 6px 0px 6px 10px;font-size:16px;">扣人心弦的科幻故事</p>
                                            <p style="color: darkgray;margin: 6px 0px 6px 10px;font-size:16px;">妙趣横生的科学小实验</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearDiv"></div>
                            </div>
                        </div>
                        <div style="width: 350px;height: 325px;background-color: white;margin:30px 0px 0px 0px">
                            <div style="height: 67%;width: 99.5%;border-bottom:0px;border: 1px solid #E8E8E8;border-bottom: 0px;">
                                <%--<p class="product" style="font-size:16px;margin-top:15px"><span style="margin: 20px 15px 20px 0px;font-size:16px">&gt;</span>百年童话绘本-典藏版</p>--%>
                                <%--<p class="product" style="font-size:16px"><span style="margin: 20px 15px 20px 0px;font-size:16px">&gt;</span>神奇校车图书版(全12册)</p>--%>
                                <%--<p class="product" style="font-size:16px"><span style="margin: 20px 15px 20px 0px;font-size:16px">&gt;</span>半小时漫画唐诗(漫画科普)</p>--%>
                                <%--<p class="product" style="font-size:16px"><span style="margin: 20px 15px 20px 0px;font-size:16px">&gt;</span>摆渡人3无境之爱(千万畅销图书)</p>--%>
                                <%--<p class="product" style="font-size:16px"><span style="margin: 20px 15px 20px 0px;font-size:16px">&gt;</span>半小时漫画唐诗(漫画科普)</p>--%>
                                <%--<p class="product" style="font-size:16px"><span style="margin: 20px 15px 20px 0px;font-size:16px">&gt;</span>摆渡人3无境之爱(千万畅销图书)</p>--%>
                                <%--<p class="product" style="font-size:16px"><span style="margin: 20px 15px 20px 0px;font-size:16px">&gt;</span>百年童话绘本-典藏版</p>--%>
                                    <%--<c:forEach items="${gqxx}" var="gqxx" begin="0" end="5" varStatus="status">--%>
                                        <%--<div class="news_title_list jrtt hideul_nfkj showul_nfkj " cid="${gqxx.id}">--%>
                                            <%--<ul  style="margin:5px 0px 5px 20px">--%>
                                                <%--<div class="news_list" cid="${gqxx.id}">--%>
                                                    <%--<a target="_blank" href="${ctx}web/news_nfkjw/details/${gqxx.id}.html"><span style="margin: 20px 15px 20px 0px;font-size:16px">&gt;</span><span style="color: #000000;font-size: 16px;">${fn:substring(gqxx.title,0,16)}</span></a>--%>
                                                <%--</div>--%>
                                            <%--</ul>--%>
                                        <%--</div>--%>
                                    <%--</c:forEach>--%>
                                    <div style="height: 208px;width: 338px;border-bottom:0px;">
                                        <%-- 往期专题 第一张大图 --%>
                                        <%--<img onclick="go('${list3[0].htmlUrl}')"  style="width: 100%;height: 100%;margin: 5px 0px 5px 5px;" src="${ctxUphoto}${list3[0].projectImg}">--%>
                                        <img onclick="go('http://www.gxkpcb.com/web/xxgzbd/index.html')"  style="width: 100%;height: 100%;margin: 5px 0px 5px 5px;" src="${ctx}web/xxgzbd/images/xxgzbd_zhuanti.jpg">
                                    </div>
                            </div>
                            <div style="width: 348px;height: 320px;border: 1px solid #E8E8E8">
                                <%--往期专题banner模块--%>
                                <div style="width: 100%;height: auto;">
                                    <div style="float: left;width: 100%;padding-top: 5px;border-bottom: 1px solid #E8E8E8;margin-top:5px">
                                        <div>
                                            <div style="float: left;padding-bottom: 5px;border-bottom: 1px solid #1E9FFF;margin-left: 10px;">
                                                <img src="${ctxRes}images/rl.png">
                                                <span style="color: #3482d1;"><strong>&nbsp;往期专题&nbsp;</strong></span>
                                            </div>
                                            <div style="float: right;">
                                                <div style="height:15px;float: left;margin-right: 10px;"></div>
                                                <div style="height:15px;float: right;margin-right: 10px;">
                                                    <img style="margin-top: 1px;transform: rotate(-180deg) translate(0px,0px) ;" src="${ctxRes}images/next.png">
                                                    <img style="margin-top: 1px;" src="${ctxRes}images/next.png">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearDiv"></div>
                                </div>
                                <%--往期专题图片模块--%>
                                <div>
                                    <div style="margin-top: 25px;">
                                        <%--第一行--%>
                                        <div>
                                            <div style="float: left;margin-left: 5px;width: 48%;height:110px;cursor:pointer">
                                                <%--<img src="${ctxRes}images/ba5.png" style="width: 100%;">--%>
                                                <div class="layui-carousel" id="test4">
                                                    <div carousel-item id="photo4">
                                                        <div onclick="ad_href('${list3[0].htmlUrl}')">
                                                            <img style="width: 159px; height:109px; " src="${ctxUphoto}${list3[0].projectImg}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div style="float: right;margin-right: 5px;width: 48%;height:110px;cursor:pointer">
                                                <div class="layui-carousel" id="test5">
                                                    <div carousel-item id="photo5">
                                                        <div onclick="ad_href('${list4[0].htmlUrl}')">
                                                            <img style="width: 159px; height:109px; " src="${ctxUphoto}${list4[0].projectImg}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearDiv"></div>
                                        </div>
                                        <%--第二行--%>
                                        <div style="margin-top: 10px;">
                                            <div style="float: left;margin-left: 5px;width: 48%;height:110px;cursor:pointer">
                                                <div class="layui-carousel" id="test6">
                                                    <div carousel-item id="photo6">
                                                        <div onclick="ad_href('${list5[0].htmlUrl}')">
                                                            <img  style="width: 159px; height:109px; " src="${ctxUphoto}${list5[0].projectImg}" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div style="float: right;margin-right: 5px;width: 48%;height:110px;cursor:pointer">
                                                <div class="layui-carousel" id="test7">
                                                    <div carousel-item id="photo7">
                                                        <div onclick="ad_href('${list6[0].htmlUrl}')">
                                                            <%--<img  style="width: 159px; height:109px; " src="${ctxUphoto}${list7[0].projectImg}" />--%>
                                                                <img  style="width: 159px; height:109px; " src="${ctxUphoto}${list6[0].projectImg}" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearDiv"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearDiv"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="width: 100%;height: 95px;margin:30px 0px 10px 0px;">
                <div class="layui-carousel" id="test10">
                    <div carousel-item="">
                        <c:forEach items="${list14}" var="list14" begin="0" end="5" varStatus="status">
                            <div><img  style="width: 100%; height: 100%; " src="${ctxUphoto}${list14.projectImg}" /></div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- 横幅-->

            <div style="width: 100%;height: 380px;margin:10px 0px;display: flex;min-width: 1382px;">
                <!-- 南方科技-->
                <div style="height: 100%;width:436px;">
                    <div style="width: 436px;position: relative;">
                        <img onclick="ad_href('http://www.nfkjw.com/')" src="${ctxRes}/index_img/30.png"  style="width: 50%;margin-bottom: 5px">
<%--                        <img onclick="ad_href('${list13[0].htmlUrl}')" src="${ctxUphoto}${list13[0].projectImg}" style="height: 100%;width: 436px;">--%>
<%--                        <div style="position:absolute;left:0px;top:100%;"><p style="font-size: 18px;color: black;background-color: #FAFAFA;margin:60px 0px">${list13[0].header}</p></div>--%>
                    </div>
                    <div style="width: 436px;height: 278px;display: flex;position:relative;border:1px solid rgba(18,0,0,0.17);">
                        <img onclick="ad_href('${list13[0].htmlUrl}')" style="width: 436px;height: 231px;" src="${ctxUphoto}${list13[0].projectImg}" style="height: 100%;width: 100%;margin: auto;" />
                        <div style="position:absolute;left:10px;top: 87%;"><p style="font-size:16px;color: #333333">${list13[0].header}</p></div>
                    </div>
<%--                    <div style="width: 436px;height: 130px;display: flex;position:relative;margin-top: 100px;border: 1px solid #E8E8E8;">--%>
<%--                        <div style="width: 90px;height: 100%;display: flex;position:relative;color: #a0a0a0">--%>
<%--                            <p style="font-weight: bold;font-size:16px;position:absolute;left:15px;top:10px">南方头条</p>--%>
<%--                            <p style="font-weight: bold;font-size:16px;position:absolute;left:15px;top:55px">南方头条</p>--%>
<%--                            <p style="font-weight: bold;font-size:16px;position:absolute;left:15px;top:100px">南方头条</p>--%>
<%--                        </div>--%>
<%--                        <div style="width: 336px;height: 100%;">--%>
<%--                                <c:forEach items="${nftt}" var="nftt" begin="0" end="2" varStatus="status">--%>
<%--                                    <div class="news_title_list jrtt hideul_nfkj showul_nfkj " >--%>
<%--                                        <ul  style="margin:5px 0px 15px 0px">--%>
<%--                                            <div class="news_list" >--%>
<%--                                                <a target="_blank" href="${nftt.url}"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">|</span>${fn:substring(nftt.title,0,19)}<c:if test="${fn:length(nftt.title)>'19'}">...</c:if></a>--%>
<%--                                            </div>--%>
<%--                                        </ul>--%>
<%--                                    </div>--%>
<%--                                </c:forEach>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                </div>
                <div style="fheight: 100%;display: flex;width:454px"  id="nfkj">
                    <div class="layui-tab layui-tab-card" style="display:flex;margin:auto;flex-direction: column;height: 100%;width: 100%;">
                        <ul class="layui-tab-title" style="width: 100%;margin:0px 30px 15px 30px">
                            <li class="layui-this" style="padding: 0px 13.8px;">今日要闻</li>
                            <li style="padding: 0px 13.8px;">行情快报</li>
                            <li style="padding: 0px 13.8px;">创富商机</li>
                            <li style="padding: 0px 13.8px;">种植养殖</li>
                            <li style="padding: 0px 13.8px;">市场信息</li>
                        </ul>
                        <div class="layui-tab-content" style="flex:auto;background-color: white;padding: 0px;margin:0px 30px 0px 30px">
                            <div class="layui-tab-item layui-show" style="height: 100%;">
                                <c:forEach items="${jrtt}" var="jrtt" begin="0" end="9" varStatus="status">
                                    <div class="news_title_list jrtt hideul_nfkj showul_nfkj ">
                                        <ul  style="<c:if test='${status.index>0}'>margin:10px 0px</c:if>">
                                            <div class="news_list" >
                                                <a target="_blank" href="${jrtt.url}"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(jrtt.title,0,16)}</span></a>
                                            </div>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="layui-tab-item" style="height: 100%;">
                                <c:forEach items="${hqkb}" var="hqkb" begin="0" end="9" varStatus="status">
                                    <div class="news_title_list jrtt hideul_nfkj showul_nfkj " >
                                        <ul  style="<c:if test='${status.index>0}'>margin:10px 0px</c:if>">
                                            <div class="news_list" >
                                                <a target="_blank" href="${hqkb.url}"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(hqkb.title,0,16)}</span></a>
                                            </div>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="layui-tab-item" style="height: 100%;">
                                <c:forEach items="${cfsj}" var="cfsj" begin="0" end="9" varStatus="status">
                                    <div class="news_title_list jrtt hideul_nfkj showul_nfkj ">
                                        <ul  style="<c:if test='${status.index>0}'>margin:10px 0px</c:if>">
                                            <div class="news_list" >
                                                <a target="_blank" href="${cfsj.url}"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(cfsj.title,0,16)}</span></a>
                                            </div>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="layui-tab-item" style="height: 100%;">
                                <c:forEach items="${zzyz}" var="zzyz" begin="0" end="9" varStatus="status">
                                    <div class="news_title_list jrtt hideul_nfkj showul_nfkj " >
                                        <ul  style="<c:if test='${status.index>0}'>margin:10px 0px</c:if>">
                                            <div class="news_list" >
                                                <a target="_blank" href="${zzyz.url}"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(zzyz.title,0,16)}</span></a>
                                            </div>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="layui-tab-item" style="height: 100%;">
                                <c:forEach items="${gqxx}" var="gqxx" begin="0" end="9" varStatus="status">
                                    <div class="news_title_list jrtt hideul_nfkj showul_nfkj ">
                                        <ul  style="<c:if test='${status.index>0}'>margin:10px 0px</c:if>">
                                            <div class="news_list" >
                                                <a target="_blank" href="${gqxx.url}"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(gqxx.title,0,16)}</span></a>
                                            </div>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="height: 100%;width: 348px;display: flex;margin:0px 0px 0px 60px" id="nfkj1">
                    <div class="layui-tab layui-tab-card" style="display:flex;margin:auto;flex-direction: column;height: 100%;width: 100%;">
                        <ul class="layui-tab-title" style="margin:0px 0px 15px 0px">
                            <li class="layui-this">一线快讯</li>
                            <li>专家面对面</li>
                        </ul>

                        <div class="layui-tab-content" style="flex:auto;background-color: white;padding: 0px">
                            <div class="layui-tab-item layui-show" style="height: 100%;">
                                <div style="height: 120px;width: 100%;display: flex;margin:0px  0px 40px 0px">
                                    <div style="position:relative;width: 100%;margin:0px 5px">
                                        <img onclick="ad_href('${yxkxList[0].url}')" src="${yxkxList[0].thumb}"  style="height: 100%;width: 100%;margin: auto;">
                                        <div style="position: absolute;top: 100%"><p style="font-size:8px;color:black;background-color: whitesmoke;margin-top: 5px">${yxkxList[0].title}</p></div>
                                    </div>
                                    <div style="position:relative;width: 100%;margin:0px 5px">
                                        <img onclick="ad_href('${yxkxList[1].url}')" src="${yxkxList[1].thumb}"  style="height: 100%;width: 100%;margin: auto;">
                                        <div style="position: absolute;top: 100%"><p style="font-size:8px;color:black;background-color: whitesmoke;margin-top: 5px">${yxkxList[1].title}</p></div>
                                    </div>
                                </div>
                                <c:forEach items="${yxkx}" var="yxkx" begin="0" end="4">
                                    <div class="news_title_list jrtt hideul_nfkj showul_nfkj ">
                                        <ul>
                                            <div class="news_list" >
                                                <a target="_blank" href="${yxkx.url}"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 14px;">${yxkx.title}</span></a>
                                            </div>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="layui-tab-item" style="height: 100%;">
                                <div style="height: 120px;width: 100%;display: flex;margin:0px  0px 40px 0px">
                                    <div style="position:relative;width: 100%;margin:0px 5px">
                                        <img onclick="ad_href('${zjmdmList[0].url}')" src="${zjmdmList[0].thumb}"  style="height: 100%;width: 100%;margin: auto;">
                                        <div style="position: absolute;top: 100%"><p style="font-size:8px;color:black;background-color: whitesmoke;margin-top: 5px">${zjmdmList[0].title}</p></div>
                                    </div>
                                    <div style="position:relative;width: 100%;margin:0px 5px">
                                        <img onclick="ad_href('${zjmdmList[1].url}')" src="${zjmdmList[1].thumb}"  style="height: 100%;width: 100%;margin: auto;">
                                        <div style="position: absolute;top: 100%"><p style="font-size:8px;color:black;background-color: whitesmoke;margin-top: 5px">${zjmdmList[1].title}</p></div>
                                    </div>
                                </div>
                                <c:forEach items="${zjmdm}" var="zjmdm" begin="0" end="4">
                                    <div class="news_title_list jrtt hideul_nfkj showul_nfkj " >
                                        <ul>
                                            <div class="news_list" >
                                                <a target="_blank" href="${zjmdm.url}"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 14px;">${zjmdm.title}</span></a>
                                            </div>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="return">
                    <img src="${ctxRes}/images/return.png" style="height: 100%;width: 100%" onclick="go('http://www.nfkjw.com/index.php')">
                </div>
            </div>
            <div style="height: 5px;width: 100%;background-color: #9ecbe8;margin: 10px 0px 15px 0px;"></div>
            <!--分割线-->
            <div style="width: 100%;height: 350px;margin:5px 0px;display: flex;flex-wrap:wrap;min-width: 1382px;" id="xbsb">
                <!-- 小博士报-->
                <div style="height: 100%;width: 436px;margin: 0px 30px 0px 0px">
                    <div style="width: 436px;height: 62px;display: flex;flex-direction: row;border:1px solid rgba(18,0,0,0.17);">
                        <div class="layui-carousel" id="test15">
                            <img onclick="go('http://www.xbskp.com/math.html')"  style="width: 100%;height: 100%;" src="./resource/index_img/20.png" />
                        </div>
                        <%--								<div class="layui-carousel" id="test16" style="float: left;margin-left: 5px;">--%>
                        <%--                                    <img onerror="this.src='${ctxRes}/images/404-img.jpg'" style="width: 100%;height: 100%;margin-right: 5px;" src="./resource/index_img/20.png" />--%>
                        <%--								</div>--%>
                    </div>
                    <div style="width: 436px;height: 260px;display: flex;position:relative;border:1px solid rgba(18,0,0,0.17);;margin-top:18px">
                        <img onclick="ad_href('http://www.xbskp.com/news_show-1338.html')" style="width: 436px;height: 213px;" src="${ctxUphoto}${list17[0].projectImg}" style="height: 100%;width: 100%;margin: auto;" />
                        <div style="position:absolute;left:10px;top: 87%;"><p style="font-size:14px;color: #333333">广西科普传播中心联合学会开展校园气象科技活动</p></div>
                    </div>
                </div>
                <div id="kptd1_label" class="layui-tab layui-tab-card" style="height: 100%;width: 454px;display: flex;flex-direction: column;margin: 0px 30px 0px 0px;">
                    <ul class="layui-tab-title" style="width: 100%;margin:0px 30px 15px 0px">
                        <li class="layui-this" style="padding: 0px 10px;">语文大观园</li>
                        <li style="padding: 0px 10px;">作文乐满地</li>
                        <li style="padding: 0px 10px;">数学小巧手</li>
                    </ul>
                    <div class="layui-tab-content" style="width: 100%;height: 100%;margin:0px 0px 0px 0px;padding:0px">
                        <div class="layui-tab-item layui-show" style="height: 100%;width: 100%;">
                          <c:forEach items="${ywdgy}" var="ywdgy" begin="0" end="16" varStatus="status">
                            <div class="news_title_list jrtt hideul_nfkj showul_nfkj " cid="${ywdgy.id}">
                                <ul style="margin: 7px 0px 7px 0px">
                                    <div class="news_list" cid="${ywdgy.id}">
                                        <a target="_blank" href="${ctx}web/news_xbsb/details/${ywdgy.id}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(ywdgy.title,0,10)}<c:if test="${fn:length(ywdgy.title)>'10'}">...</c:if></span></a>
                                    </div>
                                </ul>
                            </div>
                          </c:forEach>
                        </div>
                        <div class="layui-tab-item" style="height: 100%;width: 100%;">
                            <c:forEach items="${zwlmd}" var="zwlmd" begin="0" end="16" varStatus="status">
                                <div class="news_title_list jrtt hideul_nfkj showul_nfkj " cid="${zwlmd.id}">
                                    <ul style="margin: 7px 0px 7px 0px">
                                        <div class="news_list" cid="${zwlmd.id}">
                                            <a target="_blank" href="${ctx}web/news_xbsb/details/${zwlmd.id}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(zwlmd.title,0,10)}<c:if test="${fn:length(zwlmd.title)>'10'}">...</c:if></span></a>
                                        </div>
                                    </ul>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="layui-tab-item" style="height: 100%;width: 100%;">
                            <c:forEach items="${sxxqns}" var="sxxqns" begin="0" end="16" varStatus="status">
                                <div class="news_title_list jrtt hideul_nfkj showul_nfkj " cid="${sxxqns.id}">
                                    <ul style="margin: 7px 0px 7px 0px">
                                        <div class="news_list" cid="${sxxqns.id}">
                                            <a target="_blank" href="${ctx}web/news_xbsb/details/${sxxqns.id}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(sxxqns.title,0,10)}<c:if test="${fn:length(sxxqns.title)>'10'}">...</c:if></span></a>
                                        </div>
                                    </ul>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div id="kptd_label" class="layui-tab layui-tab-card" style="height: 100%;width: 348px;height: 100%;width: 348px;position: relative;margin:0px">
                    <ul class="layui-tab-title" style="background-color: #f2f2f2;">
                        <li class="layui-this">科普天地</li>
                        <li>科普漫画</li>
                    </ul>
                    <div class="layui-tab-content" style="height: 300px;width: 348px;margin: auto;display: flex;flex-wrap:wrap;padding: 0px;border-bottom: 1px solid #E8E8E8;border-right: 1px solid #E8E8E8; border-left: 1px solid #E8E8E8;">
                      <div class="layui-tab-item layui-show">
                        <div style="margin: 10px 18px 10px 20px;display: flex;position: relative;width: 40%;float:left;">
                            <img onclick="ad_href('http://www.xbskp.com/science_show-1337.html')" src="http://www.xbskp.com/upload/201903/12/201903121526571477.jpg"  style="width: 100%;height: 105px;" />
                            <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">拜植物为师</p></div>
                        </div>
                        <div style="margin: 10px 0px 10px 20px;display: flex;position: relative;width: 40%;">
                            <img onclick="ad_href('http://www.xbskp.com/science_show-1333.html')" src="http://www.xbskp.com/upload/201902/14/201902141632169630.png"  style="width: 100%;height: 105px" />
                            <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">花的“媒人”</p></div>
                        </div>
                        <div style="margin: 30px 18px 10px 20px;display: flex;position: relative;width: 40%;float:left;">
                            <img onclick="ad_href('http://www.xbskp.com/science_show-1309.html')" src="http://www.xbskp.com/upload/201807/31/201807311530057008.jpg"  style="width: 100%;height: 105px" />
                            <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">青藏高原上的花</p></div>
                        </div>
                        <div style="margin: 40px 0px 10px 20px;display: flex;position: relative;width: 40%;">
                            <img onclick="ad_href('http://www.xbskp.com/science_show-1315.html')" src="http://www.xbskp.com/upload/201808/06/201808061136242327.jpg"  style="width: 100%;height: 105px" />
                            <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">珍贵的绢蝶——阿波罗绢蝶</p></div>
                        </div>
                      </div>
                        <div class="layui-tab-item">
                            <div style="margin: 10px 18px 10px 20px;display: flex;position: relative;width: 40%;float:left;">
                                <img onclick="ad_href('http://www.xbskp.com/space_show-1206.html')" src="http://www.xbskp.com/upload/201605/11/201605111659476287.png"  style="width: 100%;height: 105px;" />
                                <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">月球上怎么会有火山口</p></div>
                            </div>
                            <div style="margin: 10px 0px 10px 20px;display: flex;position: relative;width: 40%;">
                                <img onclick="ad_href('http://www.xbskp.com/space_show-1202.html')" src="http://www.xbskp.com/upload/201605/11/201605111158369032.png"  style="width: 100%;height: 105px" />
                                <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">拯救酸化土地</p></div>
                            </div>
                            <div style="margin: 30px 18px 10px 20px;display: flex;position: relative;width: 40%;float:left;">
                                <img onclick="ad_href('http://www.xbskp.com/space_show-1207.html')" src="http://www.xbskp.com/upload/201605/11/201605111741532741.png"  style="width: 100%;height: 105px" />
                                <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">模拟生物圈</p></div>
                            </div>
                            <div style="margin: 40px 0px 10px 20px;display: flex;position: relative;width: 40%;">
                                <img onclick="ad_href('http://www.xbskp.com/space_show-1201.html')" src="http://www.xbskp.com/upload/201605/11/201605111141146711.png"  style="width: 100%;height: 105px" />
                                <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">谁是海洋清洁工</p></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="return">
                    <img src="${ctxRes}/images/return.png" style="height: 100%;width: 100%" onclick="go('http://www.xbskp.com/index.html')">
                </div>
            </div>
            <div style="height: 5px;width: 100%;background-color: #9ecbe8;margin: 10px 0px 10px 0px"></div>
            <!--分割线-->
            <div style="width: 100%;height: 350px;margin:10px 0px;display: flex;min-width: 1382px;" id="jtyy">
                <!-- 家庭医药-->
                <div style="height: 100%;width: 436px;margin: 0px 30px 0px 0px">
                    <div style="width: 436px;height: 68px;display: flex;flex-direction: row;">
                        <div class="layui-carousel" id="test19" style="float: left;">
                            <img onclick="ad_href('http://www.jtyy.com/')"  style="width: 100%;height: 100%;" src="./resource/index_img/26.png" />
                        </div>
                        <%--								<div class="layui-carousel" id="test20" style="width:195px;float: left;margin-left: 10px;">--%>
                        <%--                                    <img onerror="this.src='${ctxRes}/images/404-img.jpg'" style="width: 100%;height: 100%;" src="./resource/index_img/26.png"  />--%>
                        <%--								</div>--%>
                    </div>
                    <div style="width: 100%;height: 90px;display: flex;margin-top: 20px">
                        <div style="height:100px;width: 210px;margin:0px 15px 20px 0px;position:relative;">
                            <img onclick="ad_href('http://www.jtyy.com/shiwenxinzhi/${new_jtyyList1[0].cid}.html')" src="http://www.jtyy.com/${new_jtyyList1[0].thumb}"  style="height: 85%;width: 100%">
                            <div style="position:absolute;left:0px;top:85%"><p style="font-size:14px;margin-top: 5px">${new_jtyyList1[0].title}</p></div>
                        </div>
                        <div style="height:100px;width: 210px;margin:0px 0px 20px 0px;position:relative;">
                            <img onclick="ad_href('http://www.jtyy.com/shiwenxinzhi/${new_jtyyList1[1].cid}.html')" src="http://www.jtyy.com/${new_jtyyList1[1].thumb}"  style="height: 85%;width: 100%">
                            <div style="position:absolute;left:0px;top:85%"><p style="font-size:14px;margin-top:5px">${new_jtyyList1[1].title}</p></div>
                        </div>
                    </div>
                    <div style="width: 100%;height: 40%;margin: 50px 10px 0px 0px;">
                      <%--  <c:forEach items="${jkys}" var="cfsj" begin="0" end="3" varStatus="status">
                            <div class="news_title_list jrtt hideul_nfkj showul_nfkj " cid="${cfsj.id}">
                                <ul>
                                    <div class="news_list" cid="${cfsj.id}">
                                        <a target="_blank" href="${ctx}web/news_jtyy/details/${cfsj.id}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(cfsj.title,0,16)}</span></a>
                                    </div>
                                </ul>
                            </div>
                        </c:forEach>--%>
                          <c:forEach items="${jttt}" var="jttt" begin="0" end="3" varStatus="status">
                              <div class="news_title_list jrtt hideul_nfkj showul_nfkj " >
                                  <ul>
                                      <div class="news_list" >
                                          <a target="_blank" href="http://www.jtyy.com/shiwenxinzhi/${jttt.cid}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(jttt.title,0,16)}</span></a>
                                      </div>
                                  </ul>
                              </div>
                          </c:forEach>
                    </div>
                </div>
                <div style="height: 100%;width: 454px;margin: 0px 30px 0px 0px" class="layui-tab layui-tab-card" id="jtyy_label">
                    <ul class="layui-tab-title" style="width: 100%;margin: 0px 30px 13px 0px;">
                        <li class="" style="padding: 0px 10px;">名医在线</li>
                        <li style="padding: 0px 10px;" class="layui-this">健康医药</li>
                        <li style="padding: 0px 10px;" class="">快乐养生</li>
                        <li style="padding: 0px 10px;" class="">特别策划</li>
                    </ul>
                    <div class="layui-tab-content" style="padding: 0px;">
                        <div style="width: 100%;height: 40%;margin: 0px 10px 0px 0px;" class="layui-tab-item layui-show">
                            <a target="_blank" href="http://www.jtyy.com/shiwenxinzhi/${myzx[0].cid}.html" style="/* position: absolute; *//* top:40px; */"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;font-size:18px;font-weight: bold;">${myzx[0].title}</span></a>
                            <div style="width: 100%;height: 100px;display: flex;margin-top: 10px;">
                                <div style="height:100px;width: 210px;margin:0px 11px 15px 0;position:relative;">
                                    <img onclick="ad_href('http://www.jtyy.com/shiwenxinzhi/${new_jtyyList2[0].cid}.html')" src="http://www.jtyy.com/${new_jtyyList2[0].thumb}"  style="height: 85%;width: 100%">
                                    <div style="position:absolute;left:0px;top:85%"><p style="font-size:14px;margin-top:5px">${new_jtyyList2[0].title}</p></div>
                                </div>
                                <div style="height:100px;width: 210px;margin:0px 11px 0px 0;position:relative;">
                                    <img onclick="ad_href('http://www.jtyy.com/shiwenxinzhi/${new_jtyyList2[1].cid}.html')" src="http://www.jtyy.com/${new_jtyyList2[1].thumb}"  style="height: 85%;width: 100%">
                                    <div style="position:absolute;left:0px;top:85%"><p style="font-size:14px;margin-top:5px">${new_jtyyList2[1].title}</p></div>
                                </div>
                            </div>
                            <div style="margin-top: 40px;">
                                <c:forEach items="${myzx}" var="myzx" begin="1" end="4" varStatus="status">
                                    <div class="news_title_list jrtt hideul_nfkj showul_nfkj " >
                                        <ul>
                                            <div class="news_list">
                                                <a target="_blank" href="http://www.jtyy.com/shiwenxinzhi/${myzx.cid}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;">${myzx.title}</span></a>
                                            </div>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div style="width: 100%;height: 40%;margin: 0px 10px 0px 0px;" class="layui-tab-item">
                            <a target="_blank" href="http://www.jtyy.com/shiwenxinzhi/${yyzd[0].cid}.html" style="/* position: absolute; *//* top:40px; */"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;font-size:18px;font-weight: bold;">${yyzd[0].title}</span></a>
                            <div style="width: 100%;height: 100px;display: flex;margin-top: 10px;">
                                <div style="height:100px;width: 210px;margin:0px 11px 15px 0;position:relative;">
                                    <img onclick="ad_href('http://www.jtyy.com/shiwenxinzhi/${new_jtyyList3[0].cid}.html')" src="http://www.jtyy.com/${new_jtyyList3[0].thumb}"  style="height: 85%;width: 100%">
                                    <div style="position:absolute;left:0px;top:85%"><p style="font-size:14px;margin-top:5px">${new_jtyyList3[0].title}</p></div>
                                </div>
                                <div style="height:100px;width: 210px;margin:0px 11px 0px 0;position:relative;">
                                    <img onclick="ad_href('http://www.jtyy.com/shiwenxinzhi/${new_jtyyList3[1].cid}.html')" src="http://www.jtyy.com/${new_jtyyList3[1].thumb}"  style="height: 85%;width: 100%">
                                    <div style="position:absolute;left:0px;top:85%"><p style="font-size:14px;margin-top:5px">${new_jtyyList3[1].title}</p></div>
                                </div>
                            </div>
                            <div style="margin-top: 40px;">
                            <c:forEach items="${yyzd}" var="yyzd" begin="1" end="4" varStatus="status">
                                <div class="news_title_list jrtt hideul_nfkj showul_nfkj ">
                                    <ul>
                                        <div class="news_list" >
                                            <a target="_blank" href="http://www.jtyy.com/shiwenxinzhi/${yyzd.cid}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;">${yyzd.title}</span></a>
                                        </div>
                                    </ul>
                                </div>
                            </c:forEach>
                            </div>
                        </div>
                        <div style="width: 100%;height: 40%;margin: 0px 10px 0px 0px;" class="layui-tab-item">
                            <a target="_blank" href="http://www.jtyy.com/shiwenxinzhi/${klys[0].cid}.html" style="/* position: absolute; *//* top:40px; */"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;font-size:18px;font-weight: bold;">${klys[0].title}</span></a>
                            <div style="width: 100%;height: 100px;display: flex;margin-top: 10px;">
                                <div style="height:100px;width: 210px;margin:0px 11px 15px 0;position:relative;">
                                    <img onclick="ad_href('http://www.jtyy.com/shiwenxinzhi/${new_jtyyList4[0].cid}.html')" src="http://www.jtyy.com/${new_jtyyList4[0].thumb}"  style="height: 85%;width: 100%">
                                    <div style="position:absolute;left:0px;top:85%"><p style="font-size:14px;margin-top:5px">${new_jtyyList4[0].title}</p></div>
                                </div>
                                <div style="height:100px;width: 210px;margin:0px 11px 0px 0;position:relative;">
                                    <img onclick="ad_href('http://www.jtyy.com/shiwenxinzhi/${new_jtyyList4[1].cid}.html')" src="http://www.jtyy.com/${new_jtyyList4[1].thumb}"  style="height: 85%;width: 100%">
                                    <div style="position:absolute;left:0px;top:85%"><p style="font-size:14px;margin-top:5px">${new_jtyyList4[1].title}</p></div>
                                </div>

                            </div>
                            <div style="margin-top: 40px;">
                            <c:forEach items="${klys}" var="klys" begin="1" end="4" varStatus="status">
                                <div class="news_title_list jrtt hideul_nfkj showul_nfkj ">
                                    <ul>
                                        <div class="news_list" >
                                            <a target="_blank" href="http://www.jtyy.com/shiwenxinzhi/${klys.cid}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;">${klys.title}</span></a>
                                        </div>
                                    </ul>
                                </div>
                            </c:forEach>
                            </div>
                        </div>
                        <div style="width: 100%;height: 40%;margin: 0px 10px 0px 0px;" class="layui-tab-item">
                            <a target="_blank" href="http://www.jtyy.com/shiwenxinzhi/${tbch[0].cid}.html" style="/* position: absolute; *//* top:40px; */"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;font-size:18px;font-weight: bold;">${tbch[0].title}</span></a>
                            <div style="width: 100%;height: 100px;display: flex;margin-top: 10px;">
                                <div style="height:100px;width: 210px;margin:0px 11px 15px 0;position:relative;">
                                    <img onclick="ad_href('http://www.jtyy.com/shiwenxinzhi/${new_jtyyList5[0].cid}.html')" src="http://www.jtyy.com/${new_jtyyList5[0].thumb}"  style="height: 85%;width: 100%">
                                    <div style="position:absolute;left:0px;top:85%"><p style="font-size:14px;margin-top:5px">${new_jtyyList5[0].title}</p></div>
                                </div>
                                <div style="height:100px;width: 210px;margin:0px 11px 0px 0;position:relative;">
                                    <img onclick="ad_href('http://www.jtyy.com/shiwenxinzhi/${new_jtyyList5[1].cid}.html')" src="http://www.jtyy.com/${new_jtyyList5[1].thumb}"  style="height: 85%;width: 100%">
                                    <div style="position:absolute;left:0px;top:85%"><p style="font-size:14px;margin-top:5px">${new_jtyyList5[1].title}</p></div>
                                </div>
                            </div>
                            <div style="margin-top: 40px;">
                            <c:forEach items="${tbch}" var="tbch" begin="1" end="4" varStatus="status">
                                <div class="news_title_list jrtt hideul_nfkj showul_nfkj ">
                                    <ul>
                                        <div class="news_list">
                                            <a target="_blank" href="http://www.jtyy.com/shiwenxinzhi/${tbch.cid}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;">${tbch.title}</span></a>
                                        </div>
                                    </ul>
                                </div>
                            </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="height: 331px;width: 350px;">
                    <div style="height: 350px;width: 350px;margin: auto;background-color: #E8E8E8;display: flex;">
                        <div style="height: 90%;width: 90%;margin: auto;">
                            <p style="color: #2377CD;border-left: 3px solid cornflowerblue;font-size: 16px;margin:0px 0px 10px 0px">&nbsp;一周新闻排行榜</p>
                            <c:forEach items="${yzphb}" var="yzphb" begin="0" end="7" varStatus="status">
                                <div class="news_title_list jrtt hideul_nfkj showul_nfkj "  style="margin-left: 10px">
                                    <ul style="margin:3px 0px">
                                        <div class="news_list" >
                                            <a target="_blank" href="http://www.jtyy.com/shiwenxinzhi/${yzphb.cid}.html"><span style="background-color: lightgray;margin-right: 10px;<c:if test='${status.index==0}'>background-color: cornflowerblue;color: white;</c:if>">&nbsp;${status.index+1}&nbsp;</span><span style="color: #000000;font-size: 14px;">${fn:substring(yzphb.title,0,16)}</span></a>
                                        </div>
                                    </ul>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="return">
                    <img src="${ctxRes}/images/return.png" style="height: 100%;width: 100%" onclick="go('http://www.jtyy.com')">
                </div>
            </div>

        </div>
    </div>
</div>
</div>
<%@ include file="/web/include/footer.jsp" %>
</body>
<script type="text/javascript">

    $(function () {
        for(var i=0;i<=index;i++){
            var newsType = $("#input_"+i).val();
            if(newsType>=20 && newsType<30){
                $("#aId_"+i).attr("href","${ctx}web/news/details/"+$("#newsId_"+i).val()+".html");
            }
            if(newsType>=80 && newsType<90){
                $("#aId_"+i).attr("href","${ctx}web/news_axhd/details/"+$("#newsId_"+i).val()+".html");
            }
            if(newsType>=90 && newsType<100){
                $("#aId_"+i).attr("href","${ctx}web/news_zzgk/details/"+$("#newsId_"+i).val()+".html");
            }
        }
    });

    $("#xmtjz div").click(function() {
        /*console.log($("#xmtjz div"))
        console.log($(this));*/
        $("#xmtjz div").each(function() {
            $(this).removeClass("select");
        });
        $(this).addClass("select");
    });

    function htmlspecialchars_decode(str) {
        str = str.replace(/&lt;/g, '<');
        str = str.replace(/&gt;/g, '>');
        str = str.replace(/&#40;/g, "(");
        str = str.replace(/&#41;/g, ")");
        str = str.replace(/&#39;/g, "\'");
        return str;
    }

    function selectNewsNum(tid) {
        $.ajax({
            type: 'POST',
            url: '${ctx }web/news/selectNewsNum?newTypeId=' + tid + "&pageNum=" + 1 + "&pageSize=10",
            dataType: 'json',
            success: function(result) {
                console.log(result);
                var list = result.list;
                var str = "";
                var str1 = "";
                if(result.list.length > 0) {
                    for(var i = 0; i < result.list.length; i++) {
                        var str2 = result.list[0].description;
                        var str3 = str2.substring(0, 110) + "...";

                        str1 = '<div id="news_title" style="margin-top: 10px;"><a target="_blank" href="${ctx}web/news/details/' + result.list[0].id + '.html"><p style="color: #3482d1;font-size: 28px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' + result.list[0].title + '</p></a></div>' +
                            '<div id="news_title_content" style="margin-top: 10px;">' +
                            '<p class="test" style="color: #6f6f6f;font-size: 16px;overflow:hidden; letter-spacing:1px;">' + htmlspecialchars_decode(str3) + '</p></div>';
                    }
                    for(var i = 1; i < result.list.length; i++) {
                        list[i].createTime = new Date(list[i].createTime).format("yyyy-MM-dd");
                        str += '<ul><a target="_blank" href="${ctx}web/news/details/' + result.list[i].id + '.html" target="_blank"><div class="news_list"><div style="display:flex;height:21px;width:500px"><div style="color: #000000;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;width:410px" >' + result.list[i].title + '</div><span class="news_list_time" style="margin-top:3px">' + result.list[i].createTime + '</span></div></a></div></ul>';
                    }
                    $("#newslist").html(str);
                    $("#newslist1").html(str1);
                } else {
                    $("#newslist").html("");
                    $("#newslist1").html("");
                }
            },
            error: function(msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
    }
    layui.use('element', function() {
        var element = layui.element;
        $(".layui-tab-title li").hover(function(){
            $(this).click()
        });
    });
    <%-- 广告点击跳转 --%>

    function ad_href(url) {
        console.log(url)
        if(url != '' && url != '#') {
            window.open(url);
        } else if(url == '') {

        }
    }

    function go(url) {
        window.open(url);
    }
    layui.use('carousel', function() {
        var carousel = layui.carousel;
        carousel.render({
            elem: '#test4',
            width: '100%', //设置容器宽度
            height: '100%',
            arrow: 'hover', //始终显示箭头
            indicator: 'none',
            interval: 5000
        });
        carousel.render({
            elem: '#test5',
            width: '100%', //设置容器宽度
            height: '100%',
            arrow: 'hover', //始终显示箭头
            indicator: 'none',
            interval: 5000
        });
        carousel.render({
            elem: '#test6',
            width: '100%', //设置容器宽度
            height: '100%',
            arrow: 'hover', //始终显示箭头
            indicator: 'none',
            //,anim: 'updown' //切换动画方式
            interval: 5000
        });
        carousel.render({
            elem: '#test7',
            width: '100%', //设置容器宽度
            height: '100%',
            arrow: 'hover', //始终显示箭头
            interval: 5000
        });
        carousel.render({
            elem: '#test10',
            width: '100%', //设置容器宽度
            height: '100%',
            autoplay: true,
            arrow: 'none', //始终显示箭头
            indicator: 'none',
            interval: 3000
        });
        carousel.render({
            elem: '#test11',
            width: '100%', //设置容器宽度
            height: '100%',
            arrow: 'hover', //始终显示箭头
            indicator: 'none',
            interval: 5000
        });
        carousel.render({
            elem: '#test12',
            width: '41%', //设置容器宽度
            height: '100%',
            arrow: 'hover', //始终显示箭头
            indicator: 'none',
            interval: 5000
        });
        carousel.render({
            elem: '#test15',
            width: '100%', //设置容器宽度
            height: '100%',
            arrow: 'hover', //始终显示箭头
            indicator: 'none',
            interval: 5000
        });
        carousel.render({
            elem: '#test16',
            width: '41%', //设置容器宽度
            height: '100%',
            arrow: 'hover', //始终显示箭头
            indicator: 'none',
            interval: 5000
        });
        carousel.render({
            elem: '#test19',
            width: '100%', //设置容器宽度
            height: '100%',
            arrow: 'hover', //始终显示箭头
            indicator: 'none',
            interval: 5000
        });
        carousel.render({
            elem: '#test20',
            width: '41%', //设置容器宽度
            height: '100%',
            arrow: 'hover', //始终显示箭头
            indicator: 'none',
            interval: 5000
        });
    });
</script>

<style>
    .return {
        margin-top: 15px;
        margin-left: 8px;
        height: 100px;
        width: 30px;
        cursor: pointer
    }

    #nfkj .layui-this {
        border-top: 3px solid #085099;
    }

    #nfkj1 .layui-this {
        border-top: 3px solid #085099;
    }

    #kptd_label.layui-tab.layui-tab-card .layui-this{
        background-color: #9ecbe8;
        color: white;
    }
    #kptd1_label.layui-tab.layui-tab-card .layui-this{
        background-color: #9ecbe8;
        color: white;
    }
    #jtyy_label.layui-tab.layui-tab-card .layui-this{
        background-color: #ff9696;
        color: white;
    }

    .popular_recommendations {
        /*热门推荐*/
        display: flex;
        min-height: 40px;
        height: auto;
        border-bottom: 1px solid #f2f2f2;
    }

    .popular_recommendations_img {
        display: none;
        margin: 5px 0px;
        height: auto;
        width: 80px
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
        font-size: 18px;
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

    .news_title_list>ul {
        display: table;
        width: 100%;
        height: 30px;
    }

    .news_list {
        font-size: 16px;
        display: table-cell;
        vertical-align: middle;
    }

    .news_list_time {
        color: #ababab;
        float: right;
        margin-right: 5px;
    }

    .test {
        word-break: break-all;
        text-overflow: ellipsis;
        display: -webkit-box;
        /** 对象作为伸缩盒子模型显示 **/
        -webkit-box-orient: vertical;
        /** 设置或检索伸缩盒对象的子元素的排列方式 **/
        -webkit-line-clamp: 6;
        /** 显示的行数 **/
        overflow: hidden;
        /** 隐藏超出的内容 **/
    }

    .hideul_nfkj {
        display: none;
    }

    .showul_nfkj {
        display: inline;
    }

    .hideul_xbsb {
        display: none;
    }

    .showul_xbsb {
        display: inline;
    }

    .hideul_jtyy {
        display: none;
    }

    .showul_jtyy {
        display: inline;
    }

    .layui-tab-card {
        border-width: 0px;
        box-shadow: none;
    }

    .select {
        background-color: white !important;
    }

    .product {
        color: #847e7e;
        margin: 6px;
        margin-left: 20px;
    }

    .layui-tab-title .layui-this:after {
        border-style: none;
    }

    #kptd1_label .layui-tab-item ul {
        display: table-cell;
        width: 225px;
        padding: 7px 0px;
    }

</style>

</html>