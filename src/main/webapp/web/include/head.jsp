<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script src="http://pv.sohu.com/cityjson?ie=utf-8"></script>
<%@ include file="/commViews/head.jsp"%>
<div id="banner" style="width: 1302px;height: auto;display: block;">
    <div id="logoarea" style="float: left">
        <img src="${ctxRes}images/logo.png">
    </div>
    <%-- 天气部分 --%>
    <%--<div id="index_info" style="color: #FFFFFF;height:66px;float: left;margin-top:9px;margin-left: 40px;border-left:1px solid;padding-left:20px;border-left-color:#FFFFFF">
        <p style="">今天（<span id="clock"></span>）<span id="week"></span></p>
        <p style=""><span id="city"></span>当前<span id="wendu"></span> ℃ 今日最低<span id="low"></span>~ <span id="hight"></span></p>
        <p style=""><span id="tixing" >--</span></p>
    </div>--%>
    <div id="index_info" style="color: #FFFFFF;height:66px;float: left;margin-top:9px;margin-left: 40px;padding-left:20px;">
    </div>
    <div id="search" style="float: right;border: #66aede 5px solid;border-radius:25px;background-color: #FFFFFF;margin-top: 15px;">
        <div class="search_input_div" style="float: left;border: #FFFFFF 5px solid;border-radius:25px;">
            <select name="" style="height: 20px;border-width:0px;" lay-search="" id="select">
                <option value="news">新闻中心</option>
                <option value="news_axhd">党建工作</option>
                <option value="news_zzgk">政务公开</option>
            </select>
            <input onkeydown="titleSearch()" class="search_input" id="input" style="height: 20px;border-width:0px;" value="${param.title}" placeholder="请输入标题关键字" maxlength="15" type="text" autocomplete="off" autocorrect="off" role="combobox" spellcheck="false" title="搜索"aria-label="搜索">
        </div>
        <div class="search_button_div" style="float: left;background-color: #FFFFFF;border: #2377cd 5px solid;border-radius:25px;">

            <button class="search_button" type="button" style="height: 20px;border-width:0px;background-color: #2377cd;color: #FFFFFF;" aria-label="搜索" onclick="selectByObject()" >
                &nbsp;&nbsp;搜&nbsp;索&nbsp;&nbsp;
            </button>
        </div>
    </div>
    <div class="clearDiv"></div>
</div>
<div id="main_main" style="height: auto;display: block;margin-top: 0px;min-width: 1162px;">
    <div id="label" style="width: 100%;background-color: #085099;">
        <div id="label_div">
            <ul class="menu">
                <li><a href="${ctx}">网站首页</a></li>
                <li>
                    <a href="${ctx}web/news/toNewsList">新闻中心<i class="layui-icon" style="color:white">&#xe61a;</i></a>
                    <ul class="one" id="dictionary1">
                        <%--<li><a href="#">工作动态</a></li>
                        <li><a href="#">时政要闻</a></li>--%>
                    </ul>
                </li>
                <li>

                    <a href="${ctx}web/zxjjindex">中心简介<i class="layui-icon" style="color:white">&#xe61a;</i></a>
                    <ul class="one">
                        <li><a href="${ctx}web/jgznindex">机构职能</a></li>
                    </ul>
                </li>
                <li>
                    <a href="${ctx}web/news_axhd/selectList.html">党建工作<i class="layui-icon" style="color:white">&#xe61a;</i></a>
                    <ul class="one" id="dictionary2">
                        <%--<li><a href="#">党建生活</a></li>
                        <li><a href="#">党建工作</a></li>--%>
                    </ul>
                </li>
                <li>
                    <a href="${ctx}web/news_zzgk/selectList.html">政务公开<i class="layui-icon" style="color:white">&#xe61a;</i></a>
                    <ul class="one" id="dictionary3">
                        <%-- <li><a href="#">政策法规</a></li>
                         <li><a href="#">通知公告</a></li>
                         <li><a href="#">财政信息</a></li>
                         <li><a href="#">预算</a></li>
                         <li><a href="#">采购</a></li>--%>
                    </ul>
                </li>       
                <li><a href="${ctx}web/product/home?pageNum=1&pageSize=16">商城</a></li>
                <li><a href="${ctx}web/bbs/index">论坛</a></li>
            </ul>
        </div>                               
        <div id="login_info" class="white" style="float: right;margin-right:5px;">
            <shiro:guest>
                <p style="padding: 10px 25px;">请<a href="javascript:toLogin()" style="color: #FFFFFF">&nbsp;登录&nbsp;</a>或<a href="${ctx}web/register.jsp" target="_blank" style="color: #FFFFFF">&nbsp;注册&nbsp;</a></p>
            </shiro:guest>
            <shiro:user>
                <p style="padding: 10px 25px;">欢迎你 <a href="${ctx}web/user/user_index.jsp" target="_blank" style="color: orange">&nbsp;${sessionScope.USER_SESSION_NAME.name}&nbsp;</a>|<a href="#" onclick="logout()" style="color: #FFFFFF">&nbsp;登出&nbsp;</a></p>
            </shiro:user>
        </div>
        <div class="clearDiv"></div>
    </div>
</div>
<%-- 导航菜单栏样式 --%>
<style type="text/css">
    #label_div ul{ list-style:none; margin:0; padding:0;}
    #label_div .menu { height:40px; line-height:40px;display: inline; }

    #label_div .menu li { float:left; position:relative;} /*这一级是导航*/
    #label_div .menu li a { font-size: 16px; display:block; height:40px; line-height:40px; padding:0 20px;color:#FFFFFF; font-weight: bold;}
    #label_div .menu li a:hover { color:#FFFFFF; background:#0099FF; cursor: pointer}
    #label_div .menu li a.more { color:orange; }

    #label_div .menu li ul {z-index: 10000; background-color:#085099;position:absolute; float:left; width:120px; display:none;} /*这是第二级菜单*/
    #label_div .menu li ul a { width:64px; }
    #label_div .menu li ul a:hover { background:#0099FF;}

    #label_div .menu li ul ul{ top:0;left:96px;} /*从第三级菜单开始,所有的子级菜单都相对偏移*/

    /* 设置全局属性**/
    /*  *{
         font-family: '宋体';
     } */

    /* 解决IE8、9下DIV不能居中
    body{width:100%;text-align:center;}
    */
</style>
<script type="text/javascript">

    $(function () {
        $("#select option[value='"+sessionStorage.getItem("selectNewsType")+"']").attr("selected","selected");

    })
    
    //搜索框回车事件
    function titleSearch(){
        var evt = window.event || e;
        if (evt.keyCode == 13) {
           selectByObject();
        }
    }

    function selectByObject() {
        //每次搜索都把搜索放到session中
        sessionStorage.setItem("selectNewsType",$("#select").val());

        var key = $.trim($("#input").val());
        if(key.length > 0){
            var value = sessionStorage.getItem("selectNewsType");
            if(value == "news"){
                window.open('${ctx}web/'+value+'/toNewsList?pageNum='+1+"&title="+key);
            }else{
                window.open('${ctx}web/'+value+'/selectList?pageNum='+1+"&title="+key);
            }
        }
    }

    //跳转到登录页
    function toLogin() {
        var url = window.location.href;
        //将当前url放到 sessionStorage, 用于用户登成功后再返回登录前所在页面
        sessionStorage.setItem("historyUrl",url);
        window.location.href = '${ctx}userlogin.jsp';
    }

</script>
<%-- 导航菜单栏脚本 --%>
<script type="text/javascript">
    $(document).ready(function(){
        $("#label_div .menu li").hover(function(){
            $(this).children("ul").show(); //mouseover
        },function(){
            $(this).children("ul").hide(); //mouseout
        });
        //getweather();
        //ss();
    });
    //setInterval("ss()",1000);//每秒钟获取一次系统时间
    function ss(){
        var clock=document.getElementById("clock");
        var dd=new Date();

        clock.innerHTML=dd.toLocaleString();
    }
    //var ipaddress = returnCitySN["cip"];
    var localcityName = returnCitySN["cname"];

    function getweather() {
        /*var reg = RegExp(/区/);
        var reg2 = RegExp(/省/);
        if(localcityName.match(reg)){
            localcityName = returnCitySN["cname"].split('区')[1].split('市')[0];
        }else if(localcityName.match(reg2)) {
            localcityName = returnCitySN["cname"].split('省')[1].split('市')[0];
        }*/
        $.ajax({
            type: 'post',
            url: '${ctx }weather/selectweather',
            success: function (result){
                console.log(result);
                console.log(result.data);
                if(result.data.code!=201){
                    var data=result.data;
                    $("#city").html(data.data.city);
                    var  toweek=data.data.forecast[0].date.split('日')[1];///1表示截取日之后的字符串
                    $("#week").html(toweek);
                    $("#hight").html(data.data.forecast[0].high.split('温')[1]);
                    $("#low").html(data.data.forecast[0].low.split('温')[1]);
                    $("#wendu").html(data.data.wendu);
                    $("#tixing").html(data.data.ganmao);
                }
            }
        })

    }


    // 登出
    function logout(){
        $.ajax({
            type:'post',
            url:'${ctx}logout',
            dataType:'json',
            success:function(data){
                if(data.status==1){
                    window.location.reload();
                }else{
                    layer.msg("失败");
                }
            },
            error:function (msg){
                console.log(msg);
                alert("异常");
            }
        });
    }

</script>
<script>
    // 新闻中心分类
    function dictionary1(){
        $.ajax({
            type: "get",
            url: "${ctx}appsite/selectList",
            data: {type: 'type_zx'},    //视情况将base64的前面字符串data:image/png;base64,删除
            dataType: "json",
            error: function(msg) {
                console.log(msg)
                alert("请检查网络后重试");
            },
            success: function(data) {
                //console.log(data)
                var str = "";

                for (var i=0;i<data.list.length;i++){
                        str += '<li><a class="commentsBtn1" comid1="'+data.list[i].value+'">'+data.list[i].name+'</a></li>' ;

                }
                $("#dictionary1").empty();
                $("#dictionary1").append(str);

                com_even_bind1();

            }
        });
    }

    function com_even_bind1(){
        $(".commentsBtn1").click(function () {
            //alert($(this).attr("comid"));
            window.location.href='${ctx}web/news/toNewsList?pageNum='+1+'&newTypeId='+$(this).attr("comid1");
        })
    }


    // 党建工作分类
    function dictionary2(){
        $.ajax({
            type: "get",
            url: "${ctx}appsite/selectList",
            data: {type: 'type_axhd'},    //视情况将base64的前面字符串data:image/png;base64,删除
            dataType: "json",
            error: function(msg) {
                console.log(msg)
                alert("请检查网络后重试");
            },
            success: function(data) {
                //console.log(data)
                var str = "";

                for (var i=0;i<data.list.length;i++){
                    str += '<li><a class="commentsBtn2" comid2="'+data.list[i].value+'">'+data.list[i].name+'</a></li>' ;

                }
                $("#dictionary2").empty();
                $("#dictionary2").append(str);

                com_even_bind2();

            }
        });
    }
    function com_even_bind2(){
        $(".commentsBtn2").click(function () {
            //alert($(this).attr("comid"));
            window.location.href='${ctx}web/news_axhd/selectList?pageNum='+1+'&newTypeId='+$(this).attr("comid2");
        })
    }
    // 政务公开分类
    function dictionary3(){
        $.ajax({
            type: "get",
            url: "${ctx}appsite/selectList",
            data: {type: 'type_zzgk'},    //视情况将base64的前面字符串data:image/png;base64,删除
            dataType: "json",
            error: function(msg) {
                console.log(msg)
                alert("请检查网络后重试");
            },
            success: function(data) {
                //console.log(data)
                var str = "";

                for (var i=0;i<data.list.length;i++){
                    str += '<li><a class="commentsBtn3" comid3="'+data.list[i].value+'">'+data.list[i].name+'</a></li>' ;

                }
                $("#dictionary3").empty();
                $("#dictionary3").append(str);

                com_even_bind3();

            }
        });
    }
    function com_even_bind3(){
        $(".commentsBtn3").click(function () {

            window.location.href='${ctx}web/news_zzgk/selectList?pageNum='+1+'&newTypeId='+$(this).attr("comid3");
        })
    }
    $(function() {
        dictionary1();
        dictionary2();
        dictionary3();
    });

</script>