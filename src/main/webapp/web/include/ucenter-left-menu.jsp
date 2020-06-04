<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div style="width:15%;margin-top:15px; height:600px;float: left;border: 1px solid #E8E8E8;font-size: 16px;color: #494949">
    <div style="margin-top:15px; width: 100%;margin-left: 25px;">
        <div style="float: left;">
            <img src="${ctxRes}images/gwc.png" width="18px" height="18px">
        </div>
        <div style="float: left;margin-left: 10px;font-size: 15px;">
            <a href="${ctx}web/shopcar/shopcar.jsp"><span style="color: #333333">我的购物车</span>(<span id="count" style="color: #E85958">0</span>)</a>
        </div>
        <div class="clearDiv"></div>
    </div>
    <div style="margin-top:25px;width: 100%;margin-left: 25px;">
        <div style="float: left;">
            <img src="${ctxRes}images/zhangh.png" width="18px" height="18px">
        </div>
        <div style="float: left;margin-left: 10px;">
            <span style="color: #333333;font-size: 15px;">个人资料</span>
            <span style="display: block;font-size: 14px;margin-top: 10px;color: #666666">
                        <a href="${ctx}web/user/user.jsp" style="color: #666666">个人信息</a>
                    </span>
            <%--  <span style="display: block;font-size: 14px;margin-top: 10px;color: #666666">
                          <a style="color: #666666">账户安全</a>
                      </span>--%>
        </div>
        <div class="clearDiv"></div>
    </div>
    <div style="margin-top:25px;width: 100%;margin-left: 25px;">        
        <div style="float: left;">
            <img src="${ctxRes}images/dingd.png" width="18px" height="18px">
        </div>
        <div style="float: left;margin-left: 10px;">          
            <span style="color: #333333;font-size: 15px;">商城</span>
            <a href="${ctx}web/user/order.jsp"><span style="display: block;font-size: 14px;margin-top: 10px;color: #666666">我的订单</span></a>
            <span style="display: block;font-size: 14px;margin-top: 10px;color: #666666">
             <a href="${ctx}web/user/myCollectionList.jsp" style="color: #666666">我的收藏</a>
            </span>
            <span style="display: block;font-size: 14px;margin-top: 10px;color: #666666">
             <a href="${ctx}web/user/myRemarkList.jsp" style="color: #666666">我的评论</a>
            </span>
            <span style="display: block;font-size: 14px;margin-top: 10px;color: #666666">
             <a href="${ctx}web/user/delivery.jsp" style="color: #666666">收货地址</a>
            </span>
        </div>
        <div class="clearDiv"></div>
    </div>
    <div style="margin-top:25px;width: 100%;margin-left: 25px;">
        <div style="float: left;">
            <img src="${ctxRes}images/zhangh.png" width="18px" height="18px">
        </div>
        <div style="float: left;margin-left: 10px;">
            <span style="color: #333333;font-size: 15px;">论坛</span>
            <span style="display: block;font-size: 14px;margin-top: 10px;color: #666666">
                 <a href="${ctx}web/user/bbs/insert.jsp" style="color: #666666">发布帖子</a>
            </span>
            <span style="display: block;font-size: 14px;margin-top: 10px;color: #666666">
                <a href="${ctx}web/user/bbs/list.jsp" style="color: #666666">我的帖子</a>
            </span>
            <span style="display: block;font-size: 14px;margin-top: 10px;color: #666666">
                <a href="${ctx}web/user/bbs/myCommentList.jsp" style="color: #666666">我的评论</a>
            </span>
        </div>
        <div class="clearDiv"></div>
    </div>
    <div style="margin-top:25px;width: 100%;margin-left: 25px;">
        <div style="float: left;">
            <img src="${ctxRes}images/zhangh.png" width="18px" height="18px">
        </div>
        <div style="float: left;margin-left: 10px;">
            <span style="color: #333333;font-size: 15px;">资讯</span>
            <span style="display: block;font-size: 14px;margin-top: 10px;color: #666666">
                <a href="${ctx}web/user/newsComment/list.jsp" style="color: #666666">我的评论</a>
            </span>
        </div>
        <div class="clearDiv"></div>
    </div>
</div>
<script>
	$(function() {// 初始化内容            
		$.ajax({
            type:'get',
            url:'${ctx}web/shopcar/shopcar',
            dataType:'json',
            success:function(data){
                $("#count").text(data.shopcars.length);
            },
            error:function (msg){
                console.log(msg);
            }
        });
	});
</script>