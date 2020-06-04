<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commViews/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes"/>
    <%@ include file="/commViews/head.jsp"%>
</head>
<script type="text/javascript">
    var is_weixin = (function () {
        return navigator.userAgent.toLowerCase().indexOf('micromessenger') !== -1
    })();
    var code = getUrlParam("code");
    code = '021MsZS22PX0vU0gQYU22teIS22MsZSQ'
    console.log("code:" + code);
    $(function () {
        if (code != null) {
            $.ajax({
                url: "${ctx}appsite/wx/getAccess_token",
                type: "get",
                data: {code: code},
                success: function (openid) {
                    <%--window.location.href = '${ctx}web/answer/app/xczx_contest.jsp?openid='+openid;--%>
                },
                error: function (msg) {
                    console.log(msg);
                }
            });

        }

    });
</script>
<body>

</body>
</html>
