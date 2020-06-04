<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>2019全国科技工作日</title>
    <style>
        .clearDiv {
            clear: both;
        }
    </style>
</head>
<body style="background-color: #F6F6F6">
<div id="main" style="width: 100%;margin-top: 0px;">
    <div id="mian_center" style="width: 100%;height:auto;display:block;min-width: 1162px;margin: 0 auto">
        <div style="" >
            <img src="${ctx}resource/images/head.png"style="width: 100%;height:auto" >
        </div>
    </div>
    <div id="zt-center" style="background-color: #FFFFFF;width: 70%;height:auto;max-width:940px;display: block;margin: 0 auto;border: 1px solid #e6e6e6;position: relative;top: -200px;">

        <%-- 活动速递 --%>
        <div style="margin:0px auto;margin-top:10px;width: 98%;height:auto;">
            <table style="width: 100%;height:auto;">
                <tr>
                    <td style="padding-right: 5px;width: 50%;"><a href="${ctx}web/details/${list1[0].id}.html" target="_blank"><img src="${ctxUphoto}${list1[0].img}"style="width: 100%;height:250px" ></a></td>
                        <td style="width: 50%;" valign="top">
                            <div style="width: 98%;height:40px;background:#1e9fff82;line-height: 40px;font-weight: bold;padding-left: 5px;font-size: 18px;color: #F6F6F6">${list1[0].zname}</div>
                            <div style="width: 100%;height:auto;margin-top: 10px;">
                                <c:forEach items="${list1}" var="list1" >
                                <a href="${ctx}web/details/${list1.id}.html" target="_blank"><div style="font-weight: bold;font-size: 14px;margin-top: 10px;">${list1.title}</div></a>
                                </c:forEach>
                            </div>
                     </td>
                </tr>
            </table>
        </div>
        <%-- 最美科技人 --%>
        <div style="margin:0px auto;margin-top:10px;width: 98%;height:auto;">
            <div style="width: 99%;height:40px;background: #1e9fff82;line-height: 40px;font-weight: bold;padding-left: 5px;font-size: 18px;color: #F6F6F6">${list2[0].zname}</div>
            <div style="width: 100%;height:auto;margin-top: 10px;">

                <table style="width: 100%;height:auto;">
                    <c:forEach items="${list2}" var="l2" varStatus="s">
                        <c:if test="${s.index%2==0}"><tr></c:if>
                        <td style="padding-right: 5px;">
                            <a href="${ctx}web/details/${l2.id}.html" target="_blank"><img src="${ctxUphoto}${l2.img}"style="width: 100%;height:250px" ></a>
                            <div style="padding-top: 5px;padding-bottom: 10px;">${l2.title}</div>
                        </td>
                        <c:if test="${s.index%2!=0}"></tr></c:if>
                    </c:forEach>
                </table>

            </div>
        </div>
        <div style="margin:0px auto;margin-top:10px;width: 98%;height:auto;">
            <div style="width: 99%;height:40px;background: #1e9fff82;line-height: 40px;font-weight: bold;padding-left: 5px;font-size: 18px;color: #F6F6F6">${list3[0].zname}</div>
            <div style="width: 100%;height:auto;margin-top: 10px;">
                <table style="width: 100%;height:auto;">
                    <c:forEach items="${list3}" var="l3" varStatus="s">
                        <c:if test="${s.index%2==0}"><tr></c:if>
                        <td style="padding-right: 5px;">
                            <a href="${ctx}web/details/${l3.id}.html" target="_blank"><img src="${ctxUphoto}${l3.img}"style="width: 100%;height:250px" ></a>
                            <div style="padding-top: 5px;padding-bottom: 10px;">${l3.title}</div>
                        </td>
                        <c:if test="${s.index%2!=0}"></tr></c:if>
                    </c:forEach>
                </table>
            </div>

        </div>
    </div>
    <div class="clearDiv"></div>
</div>
<%@ include file="/web/include/footer.jsp" %>
</body>
<script >

</script>
</html>
