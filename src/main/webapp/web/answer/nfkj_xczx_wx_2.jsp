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
    console.log("code:" + code);
    $(function () {
        if (code != null) {

            $.ajax({
                url: "${ctx}appsite/nfkj/xczx/wx/getAccess_token",
                type: "get",
                dataType: 'text',
                data: {code: code},
                success: function (openid) {
                    // alert(result)
                    // console.log(result)web/answer/index_stxc.jsp
                    window.location.href = '${ctx}web/answer/nfkj_xczx_index.jsp?openid='+openid;
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
