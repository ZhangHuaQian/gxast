<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commViews/taglib.jsp"%>
<html>
<head>
    <%@ include file="/commViews/head.jsp"%>
    <title>广西科普传播中心</title>
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
    </style>
</head>
<body style="background-color: #f2f5f9">
<div id="main" style="margin-top: 0px">
    <!-- 主体居中 -->
    <!-- 主体分三个部分 banner label 主页信息主题区域 -->
    <div style="width:100%;background-image: url('${ctxRes}images/news_top.png');min-width:1302px;">

        <div id="main_center" style="width:70%;min-width:1302px;margin: 0px auto;padding-top: 20px;">
            <%@ include file="/web/include/head.jsp"%>
        </div>
    </div>
    <div id="newslistdiv" style="width:70%;min-width:1302px;margin: 10px auto;">
        <div id="newslist_div" style="width:77%;float: left;background-color: #ffffff">
            <div id="newslist_area" style="margin-left: 10px;">
                <div id="newslist_header" style="color: #B8B8B8;">
                    <div style="padding-top: 8px;padding-bottom: 10px;border-bottom: 2px solid #B8B8B8;">
                        <img src=""><span>你当前位置 > 首页 > 新闻中心 > 工作动态</span>
                    </div>
                </div>
                <div id="newstitle" style="margin-top: 30px;text-align: center;">
                    <h1>2018年财政信息第8期</h1>
                    <h3 style="margin-top: 10px;color: #9c9c9c">2018年08月16日 09:00:00</h3>
                </div>
                <div id="newslist" style="margin-top: 30px;">
                    <div id="newslists" style="margin-right: 10px;color: #858585;font-size: 19px;line-height: 2">
                        <p>我市财政收入超序时平稳增长</p>
                        <p>5月止，全市财政总收入103.9亿元，完成预算的45.6%，超序时进度3.9个百分点，比上年同期增收7.4亿元，同比增长7.7%。
                            其中,地方级收入66.8亿元，完成预算的44.3%，超序时进度2.6个百分点，比上年同期增收3.1亿元，同比增长4.9%</p>

                        <p>我市强化业务培训学习夯实预算绩效管理基础</p>
                        <p>6月6日，市财政局分别举办两场预算绩效管理业务培训班，由李振华副局长主持、省财政厅绩效管理处王少强科长作专题讲座。各县（区、管委会
                        ）财政局，市医保局、医保中心，本局各相关业务科室、局属各单位；以及市直一级预算单位和二级副处级预算单位财务人员共约290人参加培训。
                        培训班围绕为什么做绩效、绩效要做什么、怎么做绩效及注意事项等四个问题，就预算绩效管理中的热点及难点问题进行了深入探讨，对省对市财
                        政资金绩效管理覆盖率考核指标、项目绩效目标实务、项目绩效监控评估实务、项目绩效自评实务与绩效重点评价实务等内容逐一进行了详细讲解，
                            对进一步强化我市的预算绩效管理意识、规范预算绩效管理业务流程、提高资金使用效益起到积极促进作用。</p>

                        <p>会上，李振华副局长强调：一要落实责任担当，坚决打好打赢翻身战。按照“谁主管，谁负责”的原则，进一步落实责任、强化担当。二要按照考评细则，一条一条认真抓落实。要对
                        照考评细则，认真研究、学懂吃透，争取做到覆盖率、质量达到双100%。三要严格时间节点，强化考核结果的运用。要严格要求各预算部门保质保
                            量按时完成预算绩效管理有关工作，加强对部门的业务指导和督促检查，确保本年度绩效管理工作争先进位。</p>

                        <p>（税政条法科）</p>

                        <p>市财政局召开深化国
                            库集中支付制度改革工作会议</p>

                        <p>近日，市财政局组织召开深化国库集中支付制度改革工作会议，刘强总会计师主持会议并作重要讲话。刘总会计师指
                        出：近年来，在各县区财政局的共同努力下，我市财政国库工作取得了新成效，国库集中支付制度改革扎实推进，各项运行机制不断完善，乡镇改
                        革全面启动，电子支付、动态监控体系陆续开始，但也存在着一些薄弱的地方。下一步，全市各级财政部门一要加强内控管理，确保财政资金安全；
                        二要强化库款管理，严防支付风险；三要深化集中支付改革，打通资金支付链条“末梢神经”；四要夯实基础，加强和改进决算编审及公开工作；
                            五要统筹协调，稳步推进政府财务报告制度改革。</p>

                    </div>
                    <div class="clearDiv"></div>
                </div>

                <div class="clearDiv"></div>
            </div>
            <div class="clearDiv"></div>

        </div>
        <div id="chippings" style="width:21%;float:right;">
            <div style="background-color: #FFFFFF;font-size: 15px">
                <ul>
                    <div style="background-color:#2377cd;color:#FFFFFF;border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">
                        <div style="margin-left: 10px;">
                            <div style="float: left">
                                <img src="${ctxRes}images/11.png" style="width:19px;height: 17px;margin-top: 2px;">
                            </div>
                            <span style="margin-left: 2px;">新闻中心</span>
                        </div>

                    </div>
                </ul>
                <ul>
                    <div style="border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">
                        <div style="margin-left: 10px;">
                            <div style="float: left;" ></div>
                            <span style="margin-left: 21px;">时政要闻</span>
                        </div>

                    </div>
                </ul>
                <ul>
                    <div style="color:#2377cd;border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">
                        <div style="margin-left: 10px;">
                            <div style="float: left"></div>
                            <span style="margin-left: 21px;">工作动态</span>
                        </div>
                    </div>
                </ul>
            </div>
            <div style="background-color: #FFFFFF;margin-top: 20px;font-size: 15px">
                <div style="border-bottom: 2px solid #f2f5f9;padding-top: 8px;padding-bottom: 8px;">
                    <span style="margin-left: 10px;">专题推荐</span>
                </div>
                <div>
                    <div style="margin: 10px 10px;padding-bottom: 10px;">
                        <img src="${ctxRes}images/zt00.png" style="width: 100%;">
                        <img src="${ctxRes}images/zt01.png" style="margin-top: 10px;width: 100%;">
                    </div>
                </div>
            </div>
        </div>
        <div class="clearDiv"></div>
    </div>
    <div class="clearDiv"></div>
</div>
<%@ include file="/web/include/footer.jsp"%>
</body>
</html>
