<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<html>

<head>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <%@ include file="/commViews/head.jsp" %>
    <meta name="description" content="广西科普传播中心是广西科协直属事业单位，由“两报一刊”（南方科技报社、小博士报社、家庭医药杂志社）整合而成立，主要承担全媒体科普资源的出版与传播、科技活动的策划与组织、科普信息化的建设与创新、科技产品的推广与开发、科技成果的展示与宣传等。">
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
                        <%-- zy_01[0] - zy_03[0] 数据从 com.cen.ucenter.controller.LoginController 中的方法获取  --%>
                        <div style="width: 436px;height: 254px;background-color: #FAFAFA;display: flex;position:relative" >
                            <img class="pointer" src="${ctxUphoto}${zy_01[0].projectImg}" style="width: 100%;height: 90%" onclick="ad_href('${zy_01[0].htmlUrl}')" />
                            <div style="position:absolute;left:0px;top:90%;"><p class="p_overflow" style="font-size:16px;margin-top:5px;width: 436px;" title="${zy_01[0].header}">${zy_01[0].header}</p></div>
                        </div>
                        <div style="width: 210PX;height: 136PX;margin:10px 15.5px 15px 0px;display: flex;position:relative;">
                            <img class="pointer" style="width: 100%;height: 100%;" src="${ctxUphoto}${zy_02[0].projectImg}" onclick="ad_href('${zy_02[0].htmlUrl}')" />
                            <div style="position:absolute;left:0px;top:100%;"><p class="p_overflow" style="width: 195px;font-size:12px;color: #333333;background-color: #FAFAFA;margin-top:5px;" title="${zy_02[0].header}">${zy_02[0].header}</p></div>
                        </div>
                        <div style="width: 210px;height: 136PX;margin-top: 10px;display: flex;position:relative;">
                            <img class="pointer" style="width: 100%;height: 100%;" src="${ctxUphoto}${zy_03[0].projectImg}" onclick="ad_href('${zy_03[0].htmlUrl}')"  />
                            <div style="position:absolute;left:0px;top:100%;"><p class="p_overflow" style="width: 195px;font-size:12px;color: #333333;background-color: #FAFAFA;margin-top:5px;" title="${zy_03[0].header}">${zy_03[0].header}</p></div>
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
                            <%-- 中间块新闻列表 --%>
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
                                        <div style="width: 100%;border-bottom: 1px solid #E8E8E8;display: flex;">
                                            <div style="width:100%;background-color: #fbfbfb;flex-direction: column;">
                                                <div style="width: 100%;margin:15px 5px 0px 5px">
                                                    <a href="${zy_04[0].htmlUrl}" style="margin: 15px;font-size: 16px;font-weight: bold;">
                                                        <p class="p_overflow" style="width: 330px" ><span  style="font-weight: bold;font-size: 18px;margin-right: 5px;color: #3482d1;">·</span>${zy_04[0].header}</p>
                                                    </a>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                    <div style="">
                                        <div style="width: 108px;float: left;margin: 10px 0px 0px 30px"><img class="pointer" style="height:100px;width:108px" onclick="ad_href('${zy_04[0].htmlUrl}')" src="${ctxUphoto}${zy_04[0].projectImg}" /></div>
                                        <div style="float: left;width: 180px;height:105px;color: darkgray;margin: 6px 0px 6px 10px;font-size:16px;overflow: hidden">
                                            ${zy_04[0].photoDescribe}
                                            <%--<p style="color: darkgray;margin: 6px 0px 6px 10px;font-size:16px;">适合中小学生阅读</p>--%>
                                            <%--<p style="color: darkgray;margin: 6px 0px 6px 10px;font-size:16px;">扣人心弦的科幻故事</p>--%>
                                            <%--<p style="color: darkgray;margin: 6px 0px 6px 10px;font-size:16px;">妙趣横生的科学小实验</p>--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearDiv"></div>
                            </div>
                        </div>
                        <div style="width: 350px;height: 325px;background-color: white;margin:30px 0px 0px 0px">
                            <!-- 往期专题顶部大图模块 -->
                            <div style="height: 67%;width: 99.5%;border-bottom:0px;border: 1px solid #E8E8E8;border-bottom: 0px;">
                                    <div style="height: 208px;width: 338px;border-bottom:0px;">
                                        <img class="pointer" id="subject_top" style="width: 100%;height: 100%;margin: 5px 0px 5px 5px;" >
                                    </div>
                            </div>
                            <!--往期专题底部滑动模块 start-->
                            <div style="width: 348px;height: 320px;border: 1px solid #E8E8E8">
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
                                                    <i class="layui-icon" id="subject_left" onclick="subject_left()" style="font-size: 22px;">&#xe603;</i>
                                                    <i class="layui-icon" id="subject_right" onclick="subject_right()" style="font-size: 22px;">&#xe602;</i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearDiv"></div>
                                </div>
                                <div>
                                    <div id="subject_module" style="margin-top: 25px;">
                                    </div>
                                </div>
                                <div class="clearDiv"></div>
                            </div>
                            <!--往期专题底部滑动模块 end-->
                        </div>
                    </div>
                </div>
            </div>

            <!-- 横幅-->
            <div style="width: 100%;height: 95px;margin:30px 0px 10px 0px;">
                <div class="layui-carousel" id="test10">
                    <div carousel-item="">
                        <div>
                            <img class="pointer" onclick="ad_href('${zy_05[0].htmlUrl}')" style="width: 100%; height: 100%; " src="${ctxUphoto}${zy_05[0].projectImg}" style="height: 100%;width: 100%;margin: auto;" />
                        </div>
                    </div>
                </div>
            </div>
            <!-- 横幅-->

            <div style="width: 100%;height: 380px;margin:10px 0px;display: flex;min-width: 1382px;">
                <!-- 南方科技-->
                <div style="height: 100%;width:436px;">
                    <div style="width: 436px;position: relative;">
                        <img class="pointer" onclick="ad_href('http://www.nfkjw.com/')" src="${ctxRes}/index_img/30.png"  style="width: 50%;margin-bottom: 5px">
<%--                        <img onclick="ad_href('${list13[0].htmlUrl}')" src="${ctxUphoto}${list13[0].projectImg}" style="height: 100%;width: 436px;">--%>
<%--                        <div style="position:absolute;left:0px;top:100%;"><p style="font-size: 18px;color: black;background-color: #FAFAFA;margin:60px 0px">${list13[0].header}</p></div>--%>
                    </div>
                    <div style="width: 436px;height: 278px;display: flex;position:relative;border:1px solid rgba(18,0,0,0.17);">
                        <img class="pointer" onclick="ad_href('${zy_06[0].htmlUrl}')" style="width: 436px;height: 231px;" src="${ctxUphoto}${zy_06[0].projectImg}" style="height: 100%;width: 100%;margin: auto;" />
                        <div style="position:absolute;left:10px;top: 87%;"><p class="p_overflow" style="width: 430px;font-size:16px;color: #333333" title="${zy_06[0].header}">${zy_06[0].header}</p>
                        </div>
                    </div>
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
                            <%-- 今日要闻 --%>
                            <div id="jryw_div" class="layui-tab-item layui-show" style="height: 100%;">
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
                            <%--行情快报--%>
                            <div id="hxkb_div" class="layui-tab-item" style="height: 100%;">
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
                            <%--创富商机--%>
                            <div id="cfsj_div" class="layui-tab-item" style="height: 100%;">
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
                            <%--种植养殖--%>
                            <div id="zzyz_div" class="layui-tab-item" style="height: 100%;">
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
                            <%--市场信息--%>
                            <div id="scxy_div" class="layui-tab-item" style="height: 100%;">
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
                                        <img class="pointer" onclick="ad_href('${yxkxList[0].url}')" src="${yxkxList[0].thumb}"  style="height: 100%;width: 100%;margin: auto;">
                                        <div style="position: absolute;top: 100%"><p style="font-size:8px;color:black;background-color: whitesmoke;margin-top: 5px">${yxkxList[0].title}</p></div>
                                    </div>
                                    <div style="position:relative;width: 100%;margin:0px 5px">
                                        <img class="pointer" onclick="ad_href('${yxkxList[1].url}')" src="${yxkxList[1].thumb}"  style="height: 100%;width: 100%;margin: auto;">
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
                                        <img class="pointer" onclick="ad_href('${zjmdmList[0].url}')" src="${zjmdmList[0].thumb}"  style="height: 100%;width: 100%;margin: auto;">
                                        <div style="position: absolute;top: 100%"><p style="font-size:8px;color:black;background-color: whitesmoke;margin-top: 5px">${zjmdmList[0].title}</p></div>
                                    </div>
                                    <div style="position:relative;width: 100%;margin:0px 5px">
                                        <img class="pointer" onclick="ad_href('${zjmdmList[1].url}')" src="${zjmdmList[1].thumb}"  style="height: 100%;width: 100%;margin: auto;">
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
                            <img class="pointer" onclick="go('http://www.xbskp.com/math.html')"  style="width: 100%;height: 100%;" src="./resource/index_img/20.png" />
                        </div>
                        <%--								<div class="layui-carousel" id="test16" style="float: left;margin-left: 5px;">--%>
                        <%--                                    <img onerror="this.src='${ctxRes}/images/404-img.jpg'" style="width: 100%;height: 100%;margin-right: 5px;" src="./resource/index_img/20.png" />--%>
                        <%--								</div>--%>
                    </div>

                    <div style="width: 436px;height: 260px;display: flex;position:relative;border:1px solid rgba(18,0,0,0.17);;margin-top:18px">
                        <img class="pointer" onclick="ad_href('${zy_07[0].htmlUrl}')" style="width: 436px;height: 213px;" src="${ctxUphoto}${zy_07[0].projectImg}" style="height: 100%;width: 100%;margin: auto;" />
                        <div style="position:absolute;left:10px;top: 87%;"><p class="p_overflow" style="width: 430px;font-size:14px;color: #333333" title="${zy_07[0].header}">${zy_07[0].header}</p></div>
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
                            <div class="layui-row">
                                <div class="layui-col-md6">
                                     <c:forEach items="${ywdgy}" var="ywdgy" begin="0" end="7" varStatus="status">
                                          <div class="news_title_list jrtt hideul_nfkj showul_nfkj" cid="${ywdgy.id}">
                                              <div class="layui-row kptd_list_item">
                                                  <div class="news_list" cid="${ywdgy.id}">
                                                      <a target="_blank" href="${ctx}web/news_xbsb/details/${ywdgy.id}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(ywdgy.title,0,10)}<c:if test="${fn:length(ywdgy.title)>'10'}">...</c:if></span></a>
                                                  </div>
                                              </div>
                                          </div>
                                     </c:forEach>
                                </div>
                                <div class="layui-col-md6">
                                    <c:forEach items="${ywdgy}" var="ywdgy" begin="8" end="15" varStatus="status">
                                        <div class="news_title_list jrtt hideul_nfkj showul_nfkj " cid="${ywdgy.id}">
                                            <div class="layui-row kptd_list_item">
                                                <div class="news_list" cid="${ywdgy.id}">
                                                    <a target="_blank" href="${ctx}web/news_xbsb/details/${ywdgy.id}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(ywdgy.title,0,10)}<c:if test="${fn:length(ywdgy.title)>'10'}">...</c:if></span></a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="layui-tab-item " style="height: 100%;width: 100%;">
                            <div class="layui-row">
                                <div class="layui-col-md6">
                                    <c:forEach items="${zwlmd}" var="zwlmd" begin="0" end="7" varStatus="status">
                                        <div class="news_title_list jrtt hideul_nfkj showul_nfkj" cid="${zwlmd.id}">
                                            <div class="layui-row kptd_list_item">
                                                <div class="news_list" cid="${zwlmd.id}">
                                                    <a target="_blank" href="${ctx}web/news_xbsb/details/${zwlmd.id}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(zwlmd.title,0,10)}<c:if test="${fn:length(zwlmd.title)>'10'}">...</c:if></span></a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="layui-col-md6">
                                    <c:forEach items="${zwlmd}" var="zwlmd" begin="8" end="15" varStatus="status">
                                        <div class="news_title_list jrtt hideul_nfkj showul_nfkj " cid="${zwlmd.id}">
                                            <div class="layui-row kptd_list_item">
                                                <div class="news_list" cid="${zwlmd.id}">
                                                    <a target="_blank" href="${ctx}web/news_xbsb/details/${zwlmd.id}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(zwlmd.title,0,10)}<c:if test="${fn:length(zwlmd.title)>'10'}">...</c:if></span></a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="layui-tab-item " style="height: 100%;width: 100%;">
                            <div class="layui-row">
                                <div class="layui-col-md6">
                                    <c:forEach items="${sxxqns}" var="sxxqns" begin="0" end="7" varStatus="status">
                                        <div class="news_title_list jrtt hideul_nfkj showul_nfkj" cid="${sxxqns.id}">
                                            <div class="layui-row kptd_list_item">
                                                <div class="news_list" cid="${sxxqns.id}">
                                                    <a target="_blank" href="${ctx}web/news_xbsb/details/${sxxqns.id}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(sxxqns.title,0,10)}<c:if test="${fn:length(sxxqns.title)>'10'}">...</c:if></span></a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="layui-col-md6">
                                    <c:forEach items="${sxxqns}" var="sxxqns" begin="8" end="15" varStatus="status">
                                        <div class="news_title_list jrtt hideul_nfkj showul_nfkj " cid="${sxxqns.id}">
                                            <div class="layui-row kptd_list_item">
                                                <div class="news_list" cid="${sxxqns.id}">
                                                    <a target="_blank" href="${ctx}web/news_xbsb/details/${sxxqns.id}.html"><span style="font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;">·</span><span style="color: #000000;font-size: 16px;<c:if test='${status.index==0}'>font-size:18px;font-weight: bold;</c:if>">${fn:substring(sxxqns.title,0,10)}<c:if test="${fn:length(sxxqns.title)>'10'}">...</c:if></span></a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
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
                            <img class="pointer" onclick="ad_href('http://www.xbskp.com/science_show-1337.html')" src="http://www.xbskp.com/upload/201903/12/201903121526571477.jpg"  style="width: 100%;height: 105px;" />
                            <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">拜植物为师</p></div>
                        </div>
                        <div style="margin: 10px 0px 10px 20px;display: flex;position: relative;width: 40%;">
                            <img class="pointer" onclick="ad_href('http://www.xbskp.com/science_show-1333.html')" src="http://www.xbskp.com/upload/201902/14/201902141632169630.png"  style="width: 100%;height: 105px" />
                            <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">花的“媒人”</p></div>
                        </div>
                        <div style="margin: 30px 18px 10px 20px;display: flex;position: relative;width: 40%;float:left;">
                            <img class="pointer" onclick="ad_href('http://www.xbskp.com/science_show-1309.html')" src="http://www.xbskp.com/upload/201807/31/201807311530057008.jpg"  style="width: 100%;height: 105px" />
                            <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">青藏高原上的花</p></div>
                        </div>
                        <div style="margin: 40px 0px 10px 20px;display: flex;position: relative;width: 40%;">
                            <img class="pointer" onclick="ad_href('http://www.xbskp.com/science_show-1315.html')" src="http://www.xbskp.com/upload/201808/06/201808061136242327.jpg"  style="width: 100%;height: 105px" />
                            <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">珍贵的绢蝶——阿波罗绢蝶</p></div>
                        </div>
                      </div>
                        <div class="layui-tab-item">
                            <div style="margin: 10px 18px 10px 20px;display: flex;position: relative;width: 40%;float:left;">
                                <img class="pointer" onclick="ad_href('http://www.xbskp.com/space_show-1206.html')" src="http://www.xbskp.com/upload/201605/11/201605111659476287.png"  style="width: 100%;height: 105px;" />
                                <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">月球上怎么会有火山口</p></div>
                            </div>
                            <div style="margin: 10px 0px 10px 20px;display: flex;position: relative;width: 40%;">
                                <img class="pointer" onclick="ad_href('http://www.xbskp.com/space_show-1202.html')" src="http://www.xbskp.com/upload/201605/11/201605111158369032.png"  style="width: 100%;height: 105px" />
                                <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">拯救酸化土地</p></div>
                            </div>
                            <div style="margin: 30px 18px 10px 20px;display: flex;position: relative;width: 40%;float:left;">
                                <img class="pointer" onclick="ad_href('http://www.xbskp.com/space_show-1207.html')" src="http://www.xbskp.com/upload/201605/11/201605111741532741.png"  style="width: 100%;height: 105px" />
                                <div style="position:absolute;left:0px;top:105px"><p style="font-size:12px;margin-top: 3px">模拟生物圈</p></div>
                            </div>
                            <div style="margin: 40px 0px 10px 20px;display: flex;position: relative;width: 40%;">
                                <img class="pointer" onclick="ad_href('http://www.xbskp.com/space_show-1201.html')" src="http://www.xbskp.com/upload/201605/11/201605111141146711.png"  style="width: 100%;height: 105px" />
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
                <%-- 家庭医药 左--%>
                <div style="height: 100%;width: 436px;margin: 0px 30px 0px 0px">
                    <%-- 家庭医药 左上--%>
                    <div style="width: 436px;height: 68px;display: flex;flex-direction: row;">
                        <div class="layui-carousel" id="test19" style="float: left;">
                            <img class="pointer" onclick="ad_href('http://www.jtyy.com/')"  style="width: 100%;height: 100%;" src="./resource/index_img/26.png" />
                        </div>
                    </div>
                    <%-- 家庭医药 左中--%>
                    <div style="width: 100%;height: 90px;display: flex;margin-top: 20px">
                        <div style="height:100px;width: 210px;margin:0px 15px 20px 0px;position:relative;">
                            <img id="jtyy_left_center_img_1" class="pointer" src=""  style="height: 85%;width: 100%">
                            <div style="position:absolute;left:0px;top:85%"><p id="jtyy_left_center_title_1" style="font-size:14px;margin-top: 5px"></p></div>
                        </div>
                        <div style="height:100px;width: 210px;margin:0px 0px 20px 0px;position:relative;">
                            <img  id="jtyy_left_center_img_2" class="pointer"  src=""  style="height: 85%;width: 100%">
                            <div style="position:absolute;left:0px;top:85%"><p id="jtyy_left_center_title_2" style="font-size:14px;margin-top:5px">${new_jtyyList1[1].title}</p></div>
                        </div>
                    </div>
                    <%-- 家庭医药 左下--%>
                    <div id="jtyy_left_lower" style="width: 100%;height: 40%;margin: 50px 10px 0px 0px;">
                    </div>
                </div>
                <%-- 家庭医药 中--%>
                <div style="height: 100%;width: 454px;margin: 0px 30px 0px 0px" class="layui-tab layui-tab-card" id="jtyy_label">
                    <ul class="layui-tab-title" style="width: 100%;margin: 0px 30px 13px 0px;">
                        <li class="layui-this" style="padding: 0px 10px;">名医在线</li>
                        <li style="padding: 0px 10px;" >健康医药</li>
                        <li style="padding: 0px 10px;" class="">快乐养生</li>
                        <li style="padding: 0px 10px;" class="">特别策划</li>
                    </ul>
                    <div class="layui-tab-content" style="padding: 0px;">
                        <%--名医在线--%>
                        <div id="myzx_div" style="width: 100%;height: 40%;margin: 0px 10px 0px 0px;" class="layui-tab-item layui-show">
                        </div>
                         <%--健康医药--%>
                        <div id="jkyy_div" style="width: 100%;height: 40%;margin: 0px 10px 0px 0px;" class="layui-tab-item">
                        </div>
                        <%--快乐养生--%>
                        <div id="klys_div" style="width: 100%;height: 40%;margin: 0px 10px 0px 0px;" class="layui-tab-item">
                        </div>
                        <%--特别策划--%>
                        <div id="tbch_div" style="width: 100%;height: 40%;margin: 0px 10px 0px 0px;" class="layui-tab-item">
                        </div>
                    </div>
                </div>
                <%-- 家庭医药 右--%>
                <div style="height: 331px;width: 350px;">
                    <div style="height: 350px;width: 350px;margin: auto;background-color: #E8E8E8;display: flex;">
                        <div id="ranking_div" style="height: 90%;width: 90%;margin: auto;">
                            <p style="color: #2377CD;border-left: 3px solid cornflowerblue;font-size: 16px;margin:0px 0px 10px 0px">&nbsp;一周新闻排行榜</p>
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
        initJtyy();
    })
    //专题模块起始分页
    var subjectTypePageNum = 1;
    //专题模块总分页数
    var subjectTypeCount;

    //专题模块 向左按钮
    function subject_left(){
        if(subjectTypePageNum>1){
            subjectTypePageNum--;
            drawingSubject(subjectTypePageNum);
        }
    }


/** 南方科技报 ****************************************************/



/** 家庭医药 ****************************************************/
function initJtyy() {
    jtyyLeftCenter();
    jtyyLeftLower();

    myzxFunc();
    jkyyFunc();
    klysFunc();
    tbchFunc();
    rankingData();
}

//获取数据
function jtyyGetData(cIds, num) {
    var list ="";
    $.ajax({
        type : 'post',
        url : '${ctx }web/jtyy/selectByCid',
        dataType : 'json',
        async:false,
        data:{
            cIds:cIds,
            num:num
        },
        success : function(data) {
            list = data.data;
        },
        error : function(msg) {
            console.log(msg);
        }
    });
    return list;
}

//左中
function jtyyLeftCenter() {

    var list = jtyyGetData("8", 2);
    $("#jtyy_left_center_img_1").attr("src", "${ctxUphoto}"+list[0].photo)
    $("#jtyy_left_center_img_2").attr("src", "${ctxUphoto}"+list[1].photo)

    $("#jtyy_left_center_title_1").text(list[0].title)
    $("#jtyy_left_center_title_2").text(list[1].title)
}
//左下
function jtyyLeftLower() {
    var list = jtyyGetData("9", 4);
    var html = "";
    if(list.length > 0){
        for(var i=0; i< list.length; i++){
            var c = "";
            if (i == 0){
                c = "jtyy_title";
            }
            html  += "<p style='line-height: 30px' class='pointer p_overflow "+ c +"' title='"+ list[i].title +"'>" +
                "<span style='font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;'>·</span>" +
                "<a >" + list[i].title + "</a></p>"
        }
    }
    $("#jtyy_left_lower").append(html);
}

//名医在线
function myzxFunc() {
    var list = jtyyGetData("13,19,20,21",7);
    var html = "<a target='_blank' href='#' >"+
        "<span style='font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;'>·</span>" +
        "<span style='color: #000000;font-size: 16px;font-size:18px;font-weight: bold;'>"+ list[0].title +"</span></a>";
    
    var html2 = "<div style='width: 100%;height: 100px;display: flex;margin-top: 10px;'>\n" +
        " <div style='height:100px;width: 210px;margin:0px 11px 15px 0;position:relative;'>\n" +
        " <img class='pointer' onclick='' src='${ctxUphoto}"+ list[1].photo +"'  style='height: 85%;width: 100%'>\n" +
        " <div style='position:absolute;left:0px;top:85%'><p style='font-size:14px;margin-top:5px'>"+ list[1].title + "</p></div>\n" +
        "</div>\n" +
        " <div style='height:100px;width: 210px;margin:0px 11px 0px 0;position:relative;'>\n" +
        " <img class='pointer' onclick='' src='${ctxUphoto}"+ list[2].photo +"'  style='height: 85%;width: 100%'>\n" +
        " <div style='position:absolute;left:0px;top:85%'><p style='font-size:14px;margin-top:5px'>"+ list[2].title + "</p></div>\n" +
        " </div>\n" +
        " </div>";
    var html3 ="<div style='margin-top: 40px;'>"
    for(var i=3; i< list.length; i++){
        html3  += "<p style='line-height: 30px' class='pointer p_overflow ' title='"+ list[i].title +"'>" +
            "<span style='font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;'>·</span>" +
            "<a >" + list[i].title + "</a></p>"
    }
    html3 += "</div>";

    $("#myzx_div").append(html);
    $("#myzx_div").append(html2);
    $("#myzx_div").append(html3);
}

//健康医药
function jkyyFunc() {
    var list = jtyyGetData("25,26,27,29,30",7);
    var html = "<a target='_blank' href='#' >"+
        "<span style='font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;'>·</span>" +
        "<span style='color: #000000;font-size: 16px;font-size:18px;font-weight: bold;'>"+ list[0].title +"</span></a>";

    var html2 = "<div style='width: 100%;height: 100px;display: flex;margin-top: 10px;'>\n" +
        " <div style='height:100px;width: 210px;margin:0px 11px 15px 0;position:relative;'>\n" +
        " <img class='pointer' onclick='' src='${ctxUphoto}"+ list[1].photo +"'  style='height: 85%;width: 100%'>\n" +
        " <div style='position:absolute;left:0px;top:85%'><p style='font-size:14px;margin-top:5px'>"+ list[1].title + "</p></div>\n" +
        "</div>\n" +
        " <div style='height:100px;width: 210px;margin:0px 11px 0px 0;position:relative;'>\n" +
        " <img class='pointer' onclick='' src='${ctxUphoto}"+ list[2].photo +"'  style='height: 85%;width: 100%'>\n" +
        " <div style='position:absolute;left:0px;top:85%'><p style='font-size:14px;margin-top:5px'>"+ list[2].title + "</p></div>\n" +
        " </div>\n" +
        " </div>";
    var html3 ="<div style='margin-top: 40px;'>"
    for(var i=3; i< list.length; i++){
        html3  += "<p style='line-height: 30px' class='pointer p_overflow ' title='"+ list[i].title +"'>" +
            "<span style='font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;'>·</span>" +
            "<a >" + list[i].title + "</a></p>"
    }
    html3 += "</div>";

    $("#jkyy_div").append(html);
    $("#jkyy_div").append(html2);
    $("#jkyy_div").append(html3);
}

//快乐养生
function klysFunc() {
    var list = jtyyGetData("42,43,44,45,46,47,49",7);
    var html = "<a target='_blank' href='#' >"+
        "<span style='font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;'>·</span>" +
        "<span style='color: #000000;font-size: 16px;font-size:18px;font-weight: bold;'>"+ list[0].title +"</span></a>";

    var html2 = "<div style='width: 100%;height: 100px;display: flex;margin-top: 10px;'>\n" +
        " <div style='height:100px;width: 210px;margin:0px 11px 15px 0;position:relative;'>\n" +
        " <img class='pointer' onclick='' src='${ctxUphoto}"+ list[1].photo +"'  style='height: 85%;width: 100%'>\n" +
        " <div style='position:absolute;left:0px;top:85%'><p style='font-size:14px;margin-top:5px'>"+ list[1].title + "</p></div>\n" +
        "</div>\n" +
        " <div style='height:100px;width: 210px;margin:0px 11px 0px 0;position:relative;'>\n" +
        " <img class='pointer' onclick='' src='${ctxUphoto}"+ list[2].photo +"'  style='height: 85%;width: 100%'>\n" +
        " <div style='position:absolute;left:0px;top:85%'><p style='font-size:14px;margin-top:5px'>"+ list[2].title + "</p></div>\n" +
        " </div>\n" +
        " </div>";
    var html3 ="<div style='margin-top: 40px;'>"
    for(var i=3; i< list.length; i++){
        html3  += "<p style='line-height: 30px' class='pointer p_overflow ' title='"+ list[i].title +"'>" +
            "<span style='font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;'>·</span>" +
            "<a >" + list[i].title + "</a></p>"
    }
    html3 += "</div>";

    $("#klys_div").append(html);
    $("#klys_div").append(html2);
    $("#klys_div").append(html3);
}

//特别策划
function tbchFunc() {
    var list = jtyyGetData("12",7);
    var html = "<a target='_blank' href='#' >"+
        "<span style='font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;'>·</span>" +
        "<span style='color: #000000;font-size: 16px;font-size:18px;font-weight: bold;'>"+ list[0].title +"</span></a>";

    var html2 = "<div style='width: 100%;height: 100px;display: flex;margin-top: 10px;'>\n" +
        " <div style='height:100px;width: 210px;margin:0px 11px 15px 0;position:relative;'>\n" +
        " <img class='pointer' onclick='' src='${ctxUphoto}"+ list[1].photo +"'  style='height: 85%;width: 100%'>\n" +
        " <div style='position:absolute;left:0px;top:85%'><p style='font-size:14px;margin-top:5px'>"+ list[1].title + "</p></div>\n" +
        "</div>\n" +
        " <div style='height:100px;width: 210px;margin:0px 11px 0px 0;position:relative;'>\n" +
        " <img class='pointer' onclick='' src='${ctxUphoto}"+ list[2].photo +"'  style='height: 85%;width: 100%'>\n" +
        " <div style='position:absolute;left:0px;top:85%'><p style='font-size:14px;margin-top:5px'>"+ list[2].title + "</p></div>\n" +
        " </div>\n" +
        " </div>";
    var html3 ="<div style='margin-top: 40px;'>"
    for(var i=3; i< list.length; i++){
        html3  += "<p style='line-height: 30px' class='pointer p_overflow ' title='"+ list[i].title +"'>" +
            "<span style='font-weight: bold;font-size: 18px;margin-right: 10px;color: darkgray;'>·</span>" +
            "<a >" + list[i].title + "</a></p>"
    }
    html3 += "</div>";

    $("#tbch_div").append(html);
    $("#tbch_div").append(html2);
    $("#tbch_div").append(html3);
}


//一周新闻排行榜
function rankingData() {
    $.ajax({
        type : 'post',
        url : '${ctx }web/jtyy/ranking',
        dataType : 'json',
        async:false,
        success : function(data) {
            var list = data.data;
            var html="";
            var ranking = "background-color: cornflowerblue;color: white;";
            var index = 1;
            for(var i=0; i<list.length; i++){
                if(i > 0){
                    ranking = "";
                }
                html  += "<p style='line-height: 28px' class='pointer p_overflow' title='"+ list[i].title +"'>" +
                    "<span class='ranking' style='background-color: lightgray;margin-right: 10px; "+ ranking + "'>&nbsp;"+ index + "&nbsp;</span>" +
                    "<a >" + list[i].title + "</a></p>"

                index ++;
            }
            $("#ranking_div").append(html);
        },
        error : function(msg) {
            console.log(msg);
        }
    });
}

/** ****************************************************/
/** ****************************************************/
/** ****************************************************/
/** ****************************************************/
/** ****************************************************/
/** ****************************************************/
/** ****************************************************/
/** ****************************************************/
/** ****************************************************/
/** ****************************************************/
/** ****************************************************/
    //专题模块 向右按钮
    function subject_right(){
        if(subjectTypePageNum<subjectTypeCount){
            subjectTypePageNum++;
            drawingSubject(subjectTypePageNum);
        }
    }

    var subArray = new Array();
    //初始专题模块
    function initSubject(pageNum){
        var pageSize = 100;
        $.ajax({
            type : 'get',
            url : '${ctx }appsite/subjectType/selectList?pageSize='+ pageSize +'&pageNum='+pageNum,
            dataType : 'json',
            success : function(data) {
                var result = data.data.data;
                if(result.length > 0) {
                    //将第一条放到专题顶部大图
                    $("#subject_top").attr("onclick","go('"+result[0].url+"')");
                    $("#subject_top").attr("src",'${ctxUphoto}'+ result[0].image);
                }
                for(var x = 1; x < result.length; x++){
                    subArray.push(result[x]);
                }
                //计算分页
                subjectTypeCount = Math.ceil(subArray.length/4);
                //渲染专题栏
                drawingSubject(1);
            },
            error : function(msg) {
                console.log(msg);
            }
        });
    }

    //渲染专题模块
    function drawingSubject(start){

        if(subjectTypePageNum ==1){
            $("#subject_left").css("color","#ccc")
        }else{
            $("#subject_left").css("color","#3482d1")
        }

        if(subjectTypePageNum == subjectTypeCount){
            $("#subject_right").css("color","#ccc")
        }else{
            $("#subject_right").css("color","#3482d1")
        }
        $("#subject_module").empty();

        var index = (start-1)*4;
        //专题底部翻页图,每次循环执行4次即停
        for(var i= index,times = 1; times<=4; i++,times ++){
            if (i == subArray.length)
                break;
            var html = '<div style="float: left;margin-left: 3px;width: 48%;height:110px;cursor:pointer;margin-top:5px;border: 1px solid #ccc">\n' +
                '          <div class="layui-carousel" id="test4">\n' +
                '             <div class="carousel-item" id="photo4">\n' +
                '                <div onclick="ad_href(\''+ subArray[i].url +'\')">\n' +
                '                   <img style="width: 100%; height:109px; " src="${ctxUphoto}'+ subArray[i].image +'"/>\n' +
                '                 </div>\n' +
                '              </div>\n' +
                '           </div>\n' +
                '        </div>';

            $("#subject_module").append(html);
        }
    }


    $(function () {
        //初始专题模块
        initSubject(1);

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
    layui.use(['carousel','element','form'], function() {
        var element = layui.element;
        $(".layui-tab-title li").hover(function(){
            $(this).click()
        });
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
    .jtyy_title{
        font-size:18px;
        font-weight: bold;
    }

     /* 单行文本溢出显示省略号
     谷歌浏览器的扩展css，故只能在webkit内核的浏览器下使用，兼容性不好。
     */
     .p_overflow {
         overflow: hidden;
         text-overflow:ellipsis;
         white-space: nowrap;
     }
    .pointer{
        cursor: pointer;
    }

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

    .kptd_list_item{
        margin: 15px 0px;
    }
    .kptd_list_item:first-child{
        margin-top: 0px;
    }

</style>

</html>