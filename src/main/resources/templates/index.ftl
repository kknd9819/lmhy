<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <title>云生源互联网金融平台-商家首页</title>
    
    <#include "/include/inc_css.ftl" />
    <link href="/resources/morrisjs/morris.css" rel="stylesheet">
    
    <#include "/include/inc_js.ftl" />
    <script type="text/javascript" src="/resources/raphael/raphael.min.js"></script>
    <script type="text/javascript" src="/resources/morrisjs/morris.min.js"></script>
    <script type="text/javascript" src="/resources/dist/js/index.js"></script>
</head>

<body>
    <div id="wrapper">
        <#include "/include/inc_nav.ftl" />
		<div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12"><h4 class="page-header">${session_merchant_name}商家首页</h4></div>
                </div>
                <div class="row">
	                <div class="col-lg-3 col-md-6">
	                    <div class="panel panel-primary">
	                        <div class="panel-heading">
	                            <div class="row">
	                                <div class="col-xs-3"><i class="fa fa-comments fa-5x"></i></div>
	                                <div class="col-xs-9 text-right"><div class="huge">${reviewNum}</div><div>条今日新评价</div></div>
	                            </div>
	                        </div>
	                        <a href="/merchant/message/userNotice.jhtml">
	                            <div class="panel-footer">
	                                <span class="pull-left">点击查看</span>
	                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
	                                <div class="clearfix"></div>
	                            </div>
	                        </a>
	                    </div>
	                </div>
	                <div class="col-lg-3 col-md-6">
	                    <div class="panel panel-green">
	                        <div class="panel-heading">
	                            <div class="row">
	                                <div class="col-xs-3"><i class="fa fa-tasks fa-5x"></i></div>
	                                <div class="col-xs-9 text-right"><div class="huge">${promotionNum}</div><div>个正在进行的活动</div></div>
	                            </div>
	                        </div>
	                        <a href="/promotion/list.jhtml">
	                            <div class="panel-footer">
	                                <span class="pull-left">点击查看</span>
	                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
	                                <div class="clearfix"></div>
	                            </div>
	                        </a>
	                    </div>
	                </div>
	                <div class="col-lg-3 col-md-6">
	                    <div class="panel panel-yellow">
	                        <div class="panel-heading">
	                            <div class="row">
	                                <div class="col-xs-3"><i class="fa fa-shopping-cart fa-5x"></i></div>
	                                <div class="col-xs-9 text-right"><div class="huge">${orderNum}</div><div>笔新交易订单</div></div>
	                            </div>
	                        </div>
	                        <a href="/trade/fuzzy.jhtml">
	                            <div class="panel-footer">
	                                <span class="pull-left">点击查看</span>
	                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
	                                <div class="clearfix"></div>
	                            </div>
	                        </a>
	                    </div>
	                </div>
	                <div class="col-lg-3 col-md-6">
	                    <div class="panel panel-red">
	                        <div class="panel-heading">
	                            <div class="row">
	                                <div class="col-xs-3"><i class="fa fa-support fa-5x"></i></div>
	                                <div class="col-xs-9 text-right"><div class="huge">${settlementNum}</div><div>张结算单等待确认</div></div>
	                            </div>
	                        </div>
	                        <a href="/settlement/settlement_page.jhtml">
	                            <div class="panel-footer">
	                                <span class="pull-left">点击查看</span>
	                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
	                                <div class="clearfix"></div>
	                            </div>
	                        </a>
	                    </div>
	                </div>
	            </div>
            </div>
            <div class="row">
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> 交易走势图
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" id="analyze_type_button">周时段交易走势 <span class="caret"></span></button>
                                    <ul class="dropdown-menu pull-right" role="menu">
                                    	<li><a href="javascript:;" id="dayTradeOrder">周时段交易走势</a></li>
                                        <li><a href="javascript:;" id="weekTradeOrder">日交易总额走势</a></li>
                                        <li><a href="javascript:;" id="monthTradeOrder">月交易总额走势</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body"><div id="morris-area-chart"><p class="text-center">报表数据分析中...</p></div></div>
                    </div>
                </div>
                <div class="col-lg-4">
                	<div class="chat-panel panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-comments fa-fw"></i> 用户评价
                            <div class="btn-group pull-right">
                                <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-chevron-down"></i>
                                </button>
                                <ul class="dropdown-menu slidedown">
                                    <li><a href="javascript:;" id="review_refresh_a"><i class="fa fa-refresh fa-fw"></i> 刷新</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="panel-body" id="review_panel_div">
                            <p class="text-center">正在加载数据...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
