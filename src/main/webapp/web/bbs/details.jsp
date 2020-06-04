<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
<%@ include file="/commViews/head.jsp"%>
<link rel="stylesheet" href="${ctxRes}css/global.css">
<title>${topic.title}-广西科普传播中心</title>
<style>
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

.news_list {
	font-size: 16px;
	display: table-cell;
	vertical-align: middle;
	width: 100%;
}

.news_list_time {
	color: #ababab;
	float: right;
	margin-right: 15px;
}

#newslists>ul {
	width: 100%;
	padding-top: 10px;
	padding-bottom: 10px;
	color: #696969;
	display: table;
	width: 100%;
	height: 40px;
}
.img_icon{
    /*padding-bottom: 8px;*/
    margin-left: 8px;
}

#newslists>ul:nth-child(odd) {
	background-color: #f2f7fb;
}

#newslists>ul:nth-child(even) {
	background-color: #ffffff;
}

.fly-list-one dd span {
	float: right;
}
.layui-btn-normal {
	background-color: #1e9fff;
}

.fly-list-one dd a {
    max-width: 80%;
    margin-right: 5px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-size: 14px;
}

	#huitie li div p img{
		width: 200px;
	}
</style>

</head>
<body style="background-color: #f2f5f9">
	<div id="main" style="margin-top: 0px">
		<!-- 主体居中 -->
		<!-- 主体分三个部分 banner label 主页信息主题区域 -->
		<div
			style="width:100%;background-image: url('${ctxRes}images/news_top.png');min-width:1302px;">

			<div id="main_center"
				style="width: 70%; min-width: 1302px; margin: 0px auto; padding-top: 20px;">
				<%@ include file="/web/include/head.jsp"%>
			</div>
		</div>
		<div id="newslistdiv"
			style="width: 70%; min-width: 1302px; margin: 10px auto;">
			<div class="layui-row layui-col-space15">
				<div class="layui-col-md8 content detail">
					<div class="fly-panel detail-box">
						<h1>${topic.title}</h1>
						<div class="fly-detail-info">
							<!-- <span class="layui-badge">审核中</span> -->
							<%--<span class="layui-badge layui-bg-blue fly-detail-column">动态</span>--%>
							<%--<span class="layui-badge" style="background-color: #999;">未结</span>--%>
							<!-- <span class="layui-badge" style="background-color: #5FB878;">已结</span> -->
							<%--<span class="layui-badge layui-bg-black">置顶</span>--%>

							<div class="fly-admin-box" data-id="123">
								<%--<span class="layui-btn layui-btn-normal layui-btn-xs jie-admin" type="del">删除</span>--%>
								<%--<span class="layui-btn layui-btn-normal layui-btn-xs jie-admin" type="set" field="stick" rank="1">置顶</span>--%>
								<!-- <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="0" style="background-color:#ccc;">取消置顶</span> -->
								<%--<span class="layui-btn layui-btn-normal  layui-btn-xs jie-admin" type="set" field="status" rank="1">加精</span>--%>
								<!-- <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="0" style="background-color:#ccc;">取消加精</span> -->
							</div>
							<span class="fly-list-nums"> <i
								onclick="likeit(${topic.tid})" class="iconfont icon-zan" style="cursor: pointer;"></i> <em
								id="dd">${topic.likeNum}</em> <a href="#flyReply"><i
									class="iconfont" title="评论"></i> ${topic.comment}</a> <i
								class="iconfont" title="人气"></i> ${topic.clickNum} <i
								onclick="report('+${topic.tid}+',0)" class=""
								style="font-size: 16px;cursor:pointer;" style="cursor: pointer;"><img src="${ctxRes}images/jubao.png">举报</i>
							</span>
						</div>
						<div class="detail-about" style="margin-top: 30px">
							<a class="fly-avatar" href="#"> <img
								src="${ctxUphoto}${user.photo}" alt="${user.name}">
							</a>
							<div class="fly-detail-user">
								<a href="#" class="fly-link"> <cite>${user.name}</cite>
								</a> <span><fmt:formatDate value="${topic.createTime}" /></span>
								<div>
									<img src="${ctx}resource/images/${user.forumGradeIcon}">
									<c:if test="${user.isVip ==1}">
										<img src="${ctx}resource/images/${user.vipUserIcon}">
									</c:if>
								</div>
							</div>
							<div class="detail-hits" id="LAY_jieAdmin" data-id="123">
								<span style="padding-right: 10px; color: #FF7200"> </span>
								<%--<span class="layui-btn layui-btn-normal layui-btn-xs jie-admin" type="edit"><a
                                    href="add.html">编辑此贴</a></span>--%>
							</div>
						</div>
						<div class="detail-body photos">
							<p id="initContent">${topic.content}</p>

						</div>
					</div>
					<div class="fly-panel detail-box" id="flyReply">
						<fieldset class="layui-elem-field layui-field-title"
							style="text-align: center;">
							<legend>回帖</legend>
						</fieldset>

						<ul class="huitie" id="huitie">
						</ul>
						<div id="demo7"></div>


						<div class="layui-form layui-form-pane">
								<div>
									<input type="hidden" name="tid" value="${topic.tid}"> <input
										type="hidden" name="pid " value="${user.id}">
								</div>
								<div class="layui-form-item layui-form-text">
									<div class="layui-input-block">
										<textarea id="demo3" style="display:none;"></textarea>
									</div>
								</div>
								<div class="layui-form-item layui-form-text" style="display:none;">

									<div class="layui-input-block">
										<textarea id="L_content" name="content"  placeholder="请输入内容"
											class="layui-textarea fly-editor" ></textarea>
									</div>
								</div>
								<div class="layui-form-item" style="text-align: center">
									<input type="hidden" name="jid" value="123">
									<button id="insert" class="layui-btn layui-btn-normal" type="button" onclick="submitComment()">提交回复</button>
								</div>
						</div>
					</div>

				</div>
				<div class="layui-col-md4">
					<dl class="fly-panel fly-list-one">
						<dt class="fly-panel-title">本周热议</dt>
						<c:forEach items="${topicList}" var="topicList">
							<dd>
								<%--<a href="${ctx}topic/details?id=${topicList.tid}">${topicList.title}</a>--%>
                                <a href="javascript:void(0);" onclick="detail('${topicList.tid}','${topicList.type}')">${topicList.title}</a>
                                    <%--if (list[i].type == 1) {--%>
                                    <%--// vip版块--%>
                                    <%--img = vip_icon;--%>
                                    <%--}--%>
                                    <c:if test="${topicList.type == 1 }">
                                        <img src='${ctx}resource/images/topic-vip.png' style='margin-left: 5px;'>
                                    </c:if>
								<span><i class="iconfont icon-pinglun1"></i>
									${topicList.comment}</span>
							</dd>

						</c:forEach>
					</dl>

					<%--<div class="fly-panel">--%>
						<%--<div class="fly-panel-title">标题</div>--%>
						<%--<div class="fly-panel-main">--%>
							<%--<div class="layui-carousel" id="test1">--%>
								<%--<div carousel-item id="photo1"></div>--%>
							<%--</div>--%>
							<%--<div style="margin-top: 10px" class="layui-carousel" id="test2">--%>
								<%--<div carousel-item id="photo2"></div>--%>
							<%--</div>--%>
						<%--</div>--%>
					<%--</div>--%>

					<div class="fly-panel" style="padding: 20px 0; text-align: center;">
						<img
							src="${ctxRes}images/dzkp.jpg"
							style="max-width: 100%;" alt="layui">
						<p style="position: relative; color: #666; margin-top: 1em;">微信扫一扫，
							关注大众科普公众号</p>
					</div>

				</div>
			</div>


		</div>
		<div class="clearDiv"></div>
	</div>
	<%@ include file="/web/include/footer.jsp"%>
</body>
<script>

</script>
<script>
    //
    var userid = '${sessionScope.USER_SESSION_NAME.id}';
    var username = '${sessionScope.USER_SESSION_NAME.name}';
    var tid = '${topic.tid}';
    var louzhuid='';
    var userID;
    var uName='';
    var map = {};//分页

	$(function () {
        //查询用户是否已经点赞过
        selectUserLikeIt();
    });

    /***查看帖子详情  -- 本周热议**/
    var vip_icon = "<img src='${ctx}resource/images/topic-vip.png' style='margin-left: 5px;'>";
    var vip_user_icon = "<img class='img_icon' src='${ctx}resource/images/default_vip_icon.png' style='margin-left: 5px;'>";
    function detail(id, type) {
        if (type == 1) {
            $.ajax({
                type: 'get',
                url: '${ctx}topic/checkVip',
                data: {
                    id: id
                },
                dataType: 'json',
                success: function (result) {
                    console.log(result);
                    if (result.status == 0) {
                        layer.msg(result.msg, {
                            offset: ['400px,400px'],
                            anim: 6
                        });
                    } else {
                        window.location.href="${ctx}topic/details?id="+id;
                    }
                },
                error: function (msg) {
                    console.log(msg);
                    layer.msg('数据初始化异常', {
                        offset: ['200px,400px'],
                        anim: 6
                    });
                }
            });
        }else{
            window.location.href="${ctx}topic/details?id="+id;
        }
    }

    /*举报*/
    function report(tid,cid) {
        parent.layer.open({
            type: 2,
            area: ['750px', '485px'],
            offset:['250px','450px'],
            title:'举报',
            fixed: false, //不固定
            maxmin: false,
            content:'${ctx}web/bbs/report.jsp?id='+tid+'&cid='+cid,
            success: function (layero, index) {

            },
        });

    };

    //点赞
    function dianzan(tid,cid){
		$.ajax({
            type:'get',
            url:'${ctx}comment/likeitTwo?userid='+userid+'&tid='+tid+'&cid='+cid,
			dataType:'json',
            success:function (data) {
                $.ajax({
                    type : "get",
                    url : '${ctx}comment/select?userid='+userid+'&tid='+tid+'&cid='+cid,
                    error : function(data) {
                    },
                    success : function(data) {
                        $("#dt"+cid).html(data.comments.likeNum);
					}
                });
                if(data==2){
                    layer.msg('请先登录哦，亲！', {
                        offset:['200px,200px'] ,
                        anim: 6
                    });
                }else{
					$("#dt"+cid).html(data.likeNum);

                }

            },
            error : function(msg) {
                console.log(msg);
                alert("系统异常");
            }
        });
	}

    layui.use('element', function(){
        var element = layui.element;
    });
    var layedit;
    //富文本
    var layeditIndex;
    //富文本上传图片，视频
    layui.use('layedit', function(){
        layedit = layui.layedit;
        layeditIndex = layedit.build('demo3', {
            height: 250,
            tool: [
                'strong' //加粗
                ,'italic' //斜体
                ,'underline' //下划线
                ,'del' //删除线

                ,'|' //分割线

                ,'left' //左对齐
                ,'center' //居中对齐
                ,'right' //右对齐
                ,'link' //超链接
                ,'unlink' //清除链接
                ,'face' //表情
                ,'image' //插入图片
            ],
            uploadImage: {
                url: '${ctx}base/uploadfile'
                ,type: 'post' //默认post
            },
        });
    });
    window.onload=function () {
        var text=$("#initContent").text();
        $("#initContent").html(htmlspecialchars_decode(text));

	}


    function htmlspecialchars_decode(str) {
        str = str.replace(/&lt;/g, '<');
        str = str.replace(/&gt;/g, '>');
        str = str.replace(/&#40;/g, "(");
        str = str.replace(/&#41;/g, ")");
        str = str.replace(/&#39;/g, "\'");
        return str;
    }

    function refresh() {
        window.location.reload();
    }
    /*提交回复*/
    function answer(){
       var toid= louzhuid.split('v')[1];
       console.log(userID)
       var content= $("#content"+toid+"").val();
       var tousername= $("#tousername"+toid+"").val();
        var url = '${ctx }comment/answer?'+'toid='+userID+'&tid='+tid+'&content='+content;
        if(toid != 'undefined'){
            url = url + '&pid='+toid;
        }
        $.ajax({
            type:'post',
            url: url ,
            /*data:fromDate,*/
            dataType:'json',
            success:function(data){
                if(data.status==1){
                    //window.location.href = "${ctx}web/user/user_index.jsp";
                    layer.msg(data.msg, {icon: 5});
                    window.location.reload(true);
                }else{
                    layer.msg(data.msg, {icon: 5});
                }
            },
            error:function (msg){
                console.log(msg);
                //alert("发布失败");
            }
        });
    }

    /*提交评论*/
    function submitComment(){
			$("#insert").addClass("layui-btn-disabled");
            $.ajax({
                type:'post',
                url:'${ctx }comment/insert?userid='+userid,
                data:{
                    content:layedit.getContent(layeditIndex),
					tid:'${topic.tid}',
				},
                dataType:'json',
                success:function(data){
                    $("#insert").attr('disabled','disabled');
                    if(data.status=="1"){
                        layer.msg(data.msg, {
                            offset:['200px,200px'] ,
                            anim: 6
                        });
                        setTimeout('refresh()',2000);
                    }else if(data.status=="2"){
                        $("#insert").attr('disabled','disabled');
                        layer.msg("您需要登录之后才能评论", {
                            offset:['200px,200px'] ,
                            anim: 6
                        });

                    }else if(data.status=="5"){
                        $("#insert").attr('disabled','disabled');
                        layer.msg("评论不可为空哦，亲", {
                            offset:['200px,200px'] ,
                            anim: 6
                        });
                    }
                },
                error:function (msg){
                    $("#insert").attr('disabled','disabled');
                    console.log(msg);
                }
            });
        }

    $(function () {
        selectAllcomment(1);
        initadv();

    });
    /*评论列表*/
    var lccomment;
    function selectAllcomment(pageNum) {
        $.ajax({
            type:'post',
            url:'${ctx }comment/selectAllcomment?tid='+tid+'&pageNum='+pageNum,
            /*data:fromDate,*/
            dataType:'json',
            success:function(data){
                var str="";

                // console.log(data.list);
                if(data.list.length>0){
                    for (var i = 0; i < data.list.length; i++) {
                        var user =data.list[i].user;
						var comment= data.list[i].comment;
						var lccomment=data.list[i].toconmmentList;
						var vip_user = "";
						if (user.isVip == 1){
						    //vip用户
							vip_user = vip_user_icon;
                        }

                        comment.createTime =new Date(comment.createTime).format("yyyy-MM-dd hh:mm:ss");
                        comment.content=htmlspecialchars_decode(comment.content);
                        //var unixTimestamp = new Date(comment.create_time) ;
                        //commonTime = unixTimestamp.toLocaleString();
                        str += '<li  style="margin-top: 10px;border-top: 1px dashed #E8E8E8;padding-top: 5px;" data-id="111"><a name="item-1111111111"></a><div class="detail-about detail-about-reply">'+
                         '<a class="fly-avatar" href="javascript:void(0)"><img onerror="imgerrorfun();" src="${ctxUphoto}'+user.photo+'" alt=" ">'+
                         '</a><div class="fly-detail-user"><a href="javascript:void(0)" class="fly-link"><cite id=1111>'+user.name+'<img class="img_icon" src="${ctx}resource/images/'+user.forumGradeIcon+'">'+vip_user+'</cite>'+
                        '</a></div><div class="detail-hits"><span>'+comment.createTime+'</span></div></div><div class="detail-body jieda-body photos">'+
                        '<p id="initTwo">'+comment.content+'</p></div><div class="jieda-reply">'+
                       '<span class="jieda-zan" type="zan"><i id="iconf" comid='+comment.id+' class="iconfont icon-zan" style="cursor: pointer;" onclick="dianzan(${topic.tid},'+comment.id+')"></i><em id="dt'+comment.id+'">'+comment.likeNum+'</em>'+
                        '</span><span class="sbtn" uid="'+user.id+'" uName="'+user.name+'" sid="v'+comment.id+'" type="reply"><i class="iconfont icon-svgmoban53"></i>回复</span>'+
                        '<span style="float:right"><i onclick="report(${topic.tid},'+comment.id+')" style="cursor: pointer;"><img src="${ctxRes}images/jubao.png">举报</i></span>'+
                        '<div id="b'+comment.id+'" style="margin-left:50px;background-color:#f2f5f9">';
                        for (var k = 0; k < lccomment.length; k++) {
                            var vip_user2 = "";
                            if(lccomment[k].userType == 1){
                                vip_user2 = vip_user_icon;
                            }
                            str+='<div style="padding:10px;padding-bottom:0px;height:auto;display:flex"><img onerror="imgerrorfun();" style="margin-right:10px;height:40px;width:40px" src="${ctxUphoto}'
                            +lccomment[k].userPhoto+'" alt=" "><div><div style="text-align:center"><a href="#" class="fly-link"><cite>'+lccomment[k].username+'</cite></a></div><div>'+vip_user2+'</div>'
                           	+'</div><div style="flex:auto;margin-top:5px;"><p style="word-wrap: break-word;word-break: break-all;">'+' 回复 <a href="javascript:void(0)" style="color:#01aaed">@'+lccomment[k].tousername+'</a> :'+lccomment[k].content+'</p></div>'+'<hr style="margin:3px"></div><div style="height:20px"><span style="float:right" class="sbtn" uid='
                            +lccomment[k].userId+' uName="'+lccomment[k].username+'" sid="v'+comment.id+'" type="reply"><i style="position: inherit;" class="iconfont icon-svgmoban53"></i>回复</span><span style="float:right;">'+new Date(lccomment[k].createDate).format("yyyy-MM-dd hh:mm:ss")+'</span></div>'
                        }
                        map[comment.id] = 1;//分页初始化
                        if(lccomment.length>0&&lccomment.length==10){
                        	str += '<div><span onclick="prev('+comment.id+','+map[comment.id]+')">上一页</span>  <span onclick="next('+comment.id+','+map[comment.id]+')">下一页</span></div>';
                        }
                        str += '</div>';
                        str += '<div id="v'+comment.id+'" class="v'+comment.id+'" style="display: none;padding: 5px;margin-left:50px">' ;
                        str += '<input type="hidden" id="tousername'+comment.id+'" name="tousername'+comment.id+'" value="'+user.name+'">' ;
                        str +=  '<textarea id="content'+comment.id+'"    name="content"   placeholder="'+uName+'" content="" maxlength="500"style="height:65px;width:300px;padding: 2px;border: 1px solid #E8E8E8" ></textarea>';
                        str += '<button style="display: block;margin-top: 5px;" class="layui-btn layui-btn-xs layui-btn-normal" onclick="answer()"  id="answer" lay-filter="answer" lay-submit="submit" >提交评论</button></div>';
                        str += '</div></li><br>';
                    }

                    $("#huitie").empty();
                    $("#huitie").html(str);
                   /* var text=$("#initTwo").text();
                    $("#initTwo").html(htmlspecialchars_decode(text));*/

                    initPage(data.count);

                    $(".sbtn").click(function () {

                        $("."+$(this).attr("sid")).show()
                        louzhuid=$(this).attr("sid");
                        console.log("louzhuid = "+louzhuid)
                        userID = $(this).attr("uid");
                        uName =$(this).attr("uName");
                        $("#content"+louzhuid.split("v")[1]).attr('placeholder','回复：'+uName);
                        location.href="#content"+louzhuid.split("v")[1];
                    });

                }else{
                    str +=' <li class="fly-none">消灭零回复</li>';
                    $("#huitie").html(str);
                    var text=$("#initTwo").text();
                    $("#initTwo").html(text);
                }
            },
            error:function (msg){
                console.log(msg);
                //alert("发布失败");
            }
        });

    }
    function prev(cid,pageNum){
    	if(pageNum==1) return false;
    	pageNum--;
    	map[cid] = pageNum;
    	$.ajax({
            type:'get',
            url:'${ctx }comment/selecToComment?cid='+cid+'&tid=${topic.tid}'+'&pageNum='+pageNum,
            dataType:'json',
            success:function(data) {
            	var str="";
            	var lccomment = data.list;
            	for (var k = 0; k < data.list.length; k++) {
                    // str += '<br/>'+lccomment[k].username+'回复'+lccomment[k].tousername+' :'+lccomment[k].content;
            		 str+='<div style="padding:10px;padding-bottom:0px;height:auto;display:flex"><img onerror="imgerrorfun();" style="margin-right:10px;height:40px;width:40px" src="${ctxUphoto}'
                         +lccomment[k].userPhoto+'" alt=" "><div><div style="margin: 6px 0px;"><a href="#" class="fly-link"><cite>'+lccomment[k].username+'</cite></a>:</div>'
                        	+'</div><div style="flex:auto;margin-top:5px;"><p style="word-wrap: break-word;word-break: break-all;">'+' 回复 <a href="#" style="color:#01aaed">@'+lccomment[k].tousername+'</a> :'+lccomment[k].content+'</p></div>'+'<hr style="margin:3px"></div><div style="height:20px"><span style="float:right" class="sbtn" uid='
                         +lccomment[k].userId+' uName="'+lccomment[k].username+'" sid="v'+cid+'" type="reply"><i style="position: inherit;" class="iconfont icon-svgmoban53"></i>回复</span><span style="float:right;">'+new Date(lccomment[k].createDate).format("yyyy-MM-dd hh:mm:ss")+'</span></div>'
                 }
                if(data.next==0){
           		 str += '<div ><span onclick="prev('+cid+','+map[cid]+')">上一页</span></div>';
           	 	}else{
           	 	str += '<div><span onclick="prev('+cid+','+map[cid]+')">上一页</span>  <span onclick="next('+cid+','+map[cid]+')">下一页</span></div>';
           	 	}
            	 $("#b"+cid).html("");
            	 $("#b"+cid).html(str);
            	 $(".sbtn").click(function () {

                     $("."+$(this).attr("sid")).show()
                     louzhuid=$(this).attr("sid");
                     userID = $(this).attr("uid");
                     uName =$(this).attr("uName");
                     $("#content"+louzhuid.split("v")[1]).attr('placeholder','回复：'+uName);
                     location.href="#content"+louzhuid.split("v")[1];
                 });

            },
            error:function (msg){

            }
        });
    }
    function next(cid,pageNum){
    	pageNum++;
    	map[cid] = pageNum;
    	$.ajax({
            type:'get',
            url:'${ctx }comment/selecToComment?cid='+cid+'&tid=${topic.tid}'+'&pageNum='+pageNum,
            dataType:'json',
            success:function(data) {
            	var str="";
            	var lccomment = data.list;
            	for (var k = 0; k < data.list.length; k++) {
                    // str += '<br/>'+lccomment[k].username+'回复'+lccomment[k].tousername+' :'+lccomment[k].content;
            		 str+='<div style="padding:10px;padding-bottom:0px;height:auto;display:flex"><img onerror="imgerrorfun();" style="margin-right:10px;height:40px;width:40px" src="${ctxUphoto}'
                         +lccomment[k].userPhoto+'" alt=" "><div><div style="margin: 6px 0px;"><a href="#" class="fly-link"><cite>'+lccomment[k].username+'</cite></a>:</div>'
                        	+'</div><div style="flex:auto;margin-top:5px;"><p style="word-wrap: break-word;word-break: break-all;">'+' 回复 <a href="#" style="color:#01aaed">@'+lccomment[k].tousername+'</a> :'+lccomment[k].content+'</p></div>'+'<hr style="margin:3px"></div><div style="height:20px"><span style="float:right" class="sbtn" uid='
                         +lccomment[k].userId+' uName="'+lccomment[k].username+'" sid="v'+cid+'" type="reply"><i style="position: inherit;" class="iconfont icon-svgmoban53"></i>回复</span><span style="float:right;">'+new Date(lccomment[k].createDate).format("yyyy-MM-dd hh:mm:ss")+'</span></div>'
                 }
                if(data.next==0){
           		 str += '<div ><span onclick="prev('+cid+','+map[cid]+')">上一页</span></div>';
           	 	}else{
           	 	str += '<div><span onclick="prev('+cid+','+map[cid]+')">上一页</span>  <span onclick="next('+cid+','+map[cid]+')">下一页</span></div>';
           	 	}
            	 $("#b"+cid).html("");
            	 $("#b"+cid).html(str);
            	 $(".sbtn").click(function () {

                     $("."+$(this).attr("sid")).show()
                     louzhuid=$(this).attr("sid");
                     userID = $(this).attr("uid");
                     uName =$(this).attr("uName");
                     $("#content"+louzhuid.split("v")[1]).attr('placeholder','回复：'+uName);
                     location.href="#content"+louzhuid.split("v")[1];
                 });
            },
            error:function (msg){
            	
            }
        });
    }
    function imgerrorfun(){                                    
        var img=event.srcElement; 
        img.src="${ctxRes}/images/404-img.jpg"; 
        img.onerror=null;
    }           
            
    //初始化分页栏
    var pageCurr=1;
    function initPage(pageData) {
        // console.log(pageData);
        layui.use([ 'laypage', 'layer' ], function() {
            var laypage = layui.laypage, layer = layui.layer;
            laypage.render({
                elem : 'demo7',
                curr :pageCurr,
                count :pageData,
                theme: '#1E9FFF',
                layout : [ 'count', 'prev', 'page', 'next', 'refresh',
                    'skip' ],
                jump : function(obj, first) {
                    if (!first) {//首次不执行
                        /*getUserData(obj.curr);*/
                        $("#huitie").empty();
                        selectAllcomment(obj.curr);
                        pageCurr = obj.curr;
                        console.log( obj.curr);

                    }
                }
            });
        });
    }
    //点赞、取消点赞
    function likeit() {
        $.ajax({
            type:'Get',
            url:'${ctx }comment/likeit?userid='+userid+'&tid='+${topic.tid},
            dataType:'json',
            success:function(data) {
                console.log(data.stust);
                if(data==2){
                    layer.msg('请先登录哦，亲！', {
                        offset:['200px,200px'] ,
                        anim: 6
                    });
                }else{
                    $("#dd").empty();
                    $("#dd").append(data.likeNum);
                    // location.reload();
                }

                if(data.stust == 2){ //1-取消点赞，2-点赞
                    $(".fly-list-nums .icon-zan").css("color","#FF5722")
                }else{
                    $(".fly-list-nums .icon-zan").css("color","")
                }

            },
            error:function (msg){
            }
        });
    }

    //查询用户是否已经点赞过
    function selectUserLikeIt() {
        $.ajax({
            type:'get',
            url:'${ctx }comment/selectUserLikeIt?userid='+userid+'&tid='+${topic.tid},
            dataType:'json',
            success:function(data) {
                if(data.status == 1){ //用户已点赞过
					$(".fly-list-nums .icon-zan").css("color","#FF5722")
                }
            },
            error:function (msg){
            }
        });
    }


    function loop() {
        layui.use('carousel', function(){
            var carousel = layui.carousel;
            //建造实例
            carousel.render({
                elem: '#test1'
                ,width: '100%' //设置容器宽度
                ,height:'70px'
                ,arrow: 'always' //始终显示箭头
                //,anim: 'updown' //切换动画方式
            });
            carousel.render({
                elem: '#test2'
                ,width: '100%' //设置容器宽度
                ,height:'70px'
                ,arrow: 'always' //始终显示箭头
                //,anim: 'updown' //切换动画方式
            });
        });
    }

    var photozise=3;//图片数量
    var photonum=2;//广告位数
    var phototype="lt";
    function initadv() {
        $.ajax({
            type: 'POST',
            url: '${ctx }topic/selectadvphoto?phototype='+phototype+'&photozise='+photozise+'&photonum='+photonum,
            dataType: 'json',
            success: function (result) {
                // console.log(result);
                var str = "";
                if(result.list1.length>0){
                    for (var i = 0; i < result.list1.length; i++) {
                        str += '<a href="'+result.list1[i].htmlUrl +'"><img style="width:100%;height:70px;" src="${ctxUphoto}'+result.list1[i].projectImg+'"/></a>';
                        str+='';
                    }
                    $("#photo1").append(str);
                }else {
                    $("#photo1").html("");
                };
                var str2 = "";
                if(result.list2.length>0){
                    for (var i = 0; i < result.list1.length; i++) {

                        str2 += '<a href="'+result.list2[i].htmlUrl +'" ><img style="width:100%;height:70px;" src="${ctxUphoto}'+result.list2[i].projectImg+'"/></a>';
                        str2+='';
                    }
                    $("#photo2").append(str2);
                }else {
                    $("#photo2").html("");
                }
                loop();
            },
            error: function (msg) {
                console.log(msg);
                //alert("系统异常");
            }
        });

    }
    // 新建窗口
    function cen_showWin(param) {
        parent.layer.open({
            type : param.type,
            area : [ param.width, param.height ],
            title : param.title,
            closeBtn : 1,
            //shade: [0.1, '#FFFFFF'],
            shadeClose : true,
            skin : 'yourclass',
            resize : true,
            success : function(layero, index) {
                //console.log(layero, index);
            },
            content : param.url
        });
    }


</script>
</html>
