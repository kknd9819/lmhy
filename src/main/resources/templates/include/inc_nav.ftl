	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">切换导航</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/">云生源互联网金融-联盟商家平台</a>
		</div>
		<ul class="nav navbar-top-links navbar-right">
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:;">
					<i class="fa fa-envelope fa-fw"></i> <i class="fa fa-caret-down"></i>
				</a>
				<ul class="dropdown-menu dropdown-messages">
					[@message_list merchantId=session_merchant_id count=3]
					[#if msg_list?? && msg_list?size > 0]
					[#list msg_list as msg]
					<li>
						<a class="merchant_message_a" href="javascript:;" content="${msg.content}" title="${msg.title}">
						<div><strong>${abbreviate(msg.title, 20, "...")}</strong><span class="pull-right text-muted"><em>${interval(msg.sendDate)}</em></span></div>
						<div>${abbreviate(msg.content, 70, "...")}</div></a>
					</li>
					<li class="divider"></li>
					[/#list]
					[#else]
					<li>
						<a href="javascript:;"><div>未发现新的系统通知</div></a>
					</li>
					<li class="divider"></li>
					[/#if]
					[/@message_list]
					<li>
						<a class="text-center" href="/merchant/message/systemNotice.jhtml"><strong>查看所有通知</strong><i class="fa fa-angle-right"></i></a>
					</li>
				</ul>
			</li>
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:;">
					<i class="fa fa-tasks fa-fw"></i> <i class="fa fa-caret-down"></i>
				</a>
				<ul class="dropdown-menu dropdown-tasks">
					[@promotion_list merchantId=session_merchant_id]
					[#if prom_list?? && prom_list?size > 0]
					[#list prom_list as prom]
					<li>
						<a href="javascript:;">
							<div><p><strong>${prom.promotionName}</strong><span class="pull-right text-muted">${prom.endTime}</span></p></div>
						</a>
					</li>
					[#if prom_has_next]<li class="divider"></li>[/#if]
					[/#list]
					[#else]
					<li>
						<a href="javascript:;"><div>没有正在进行的优惠活动</div></a>
					</li>
					[/#if]
					[/@promotion_list]
				</ul>
			</li>
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:;">
					<i class="fa fa-bell fa-fw"></i> <i class="fa fa-caret-down"></i>
				</a>
				<ul class="dropdown-menu dropdown-alerts">
					[@alert_time merchantId=session_merchant_id]
					<li><a href="/merchant/message/userNotice.jhtml"><div><i class="fa fa-comment fa-fw"></i> 新用户评价<span class="pull-right text-muted small">[#if alert_times[0]??]${interval(alert_times[0])}[#else]无[/#if]</span></div></a></li>
					<li class="divider"></li>
					<li><a href="/trade/fuzzy.jhtml"><div><i class="fa fa-shopping-cart fa-fw"></i> 新交易订单<span class="pull-right text-muted small">[#if alert_times[1]??]${interval(alert_times[1])}[#else]无[/#if]</span></div></a></li>
					<li class="divider"></li>
					<li><a href="/settlement/settlement_page.jhtml"><div><i class="fa fa-envelope fa-fw"></i> 新结算提醒<span class="pull-right text-muted small">[#if alert_times[2]??]${interval(alert_times[2])}[#else]无[/#if]</span></div></a></li>
					<li class="divider"></li>
					<li><a href="#"><div><i class="fa fa-ticket fa-fw"></i> 新优惠券领取<span class="pull-right text-muted small">[#if alert_times[3]??]${interval(alert_times[3])}[#else]无[/#if]</span></div></a></li>
					[/@alert_time]
				</ul>
			</li>
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:;">
					<i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
				</a>
				<ul class="dropdown-menu dropdown-user">
					<li><a href="/merchant/jumpAccountManage.jhtml"><i class="fa fa-user fa-fw"></i> 账户管理</a></li>
					<li><a href="/merchant/editPwd.jhtml"><i class="fa fa-gear fa-fw"></i> 密码修改</a></li>
					<li class="divider"></li>
					<li><a href="javascript:;"><i class="fa fa-magic fa-fw"></i> 帮助中心</a></li>
					<li class="divider"></li>
					<li><a href="/login/logout.jhtml"><i class="fa fa-sign-out fa-fw"></i> 退出登录</a></li>
				</ul>
			</li>
		</ul>
		<div class="navbar-default sidebar" role="navigation">
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav" id="side-menu">
					<li class="sidebar-search">
						<div class="input-group custom-search-form">
							<input type="text" class="form-control" placeholder="Search...">
							<span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-search"></i></button></span>
						</div>
					</li>
					<li><a href="/merchant/index.jhtml"><i class="fa fa-dashboard fa-fw"></i> 首页</a></li>
					<li>
						<a href="javascript:;"><i class="fa fa-inbox fa-fw"></i> 发布<span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="/promotion/list.jhtml">优惠活动</a></li>
							<li><a href="/merchant/message/dynamic_page.jhtml">商家动态</a></li>
							<li><a href="javascript:;">电子优惠券</a></li>
						</ul>
					</li>
					<li>
						<a href="javascript:;"><i class="fa fa-shopping-cart fa-fw"></i> 交易<span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="/trade/quick.jhtml">快速查单</a></li>
							<li><a href="/trade/fuzzy.jhtml">交易订单</a></li>
							<li><a href="/trade/refund.jhtml">交易退款</a></li>
							<li><a href="javascript:;">交易分析</a></li>
						</ul>
					</li>
					<li>
						<a href="javascript:;"><i class="fa fa-support fa-fw"></i> 对账<span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="/settlement/settlement_page.jhtml">账务结算</a></li>
							<li><a href="/settlement_detail/detail_page.jhtml">账期汇总</a></li>
						</ul>
					</li>
					<li>
						<a href="javascript:;"><i class="fa fa-comments fa-fw"></i> 消息<span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="/merchant/message/userNotice.jhtml">用户评价</a></li>
							<li><a href="/merchant/message/systemNotice.jhtml">系统通知</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<script type="text/javascript">
	$(function($) {
		$(".merchant_message_a").click(function() {
			var _title = $(this).attr("title");
			var _content = $(this).attr("content");
			$.message({title:_title,content:_content});
		});
	});
	</script>