[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>订单查看 -  云生源（shengyuan.cn）你的消费很值钱！</title>
<meta name="author" content="云生源后台管理系统" />
<meta name="copyright" content="云生源后台管理系统" />
<link type="text/css" href="/resources/css/common.css" rel="stylesheet"/>
<script type="text/javascript" src="/resources/common/jquery/jquery.js"></script>
<script type="text/javascript" src="/resources/common/jquery/jquery.tools.js"></script>
<script type="text/javascript" src="/resources/js/input.js"></script>
<script type="text/javascript" src="/resources/js/phone.js"></script>
</head>
<body>
	<div class="path">
		<a href="/admin/common/index.jhtml">首页</a> &raquo; 查看订单详情
	</div>
	<ul id="tab" class="tab">
		<li><input type="button" value="订单信息" /></li>
		<!--<li><input type="button" value="商品信息" /></li>-->
		<!--<li><input type="button" value="收款信息" /></li>-->
		<!--<li><input type="button" value="发货信息" /></li>-->
		<!--<li><input type="button" value="退款信息" /></li>-->
		<!--<li><input type="button" value="退货信息" /></li>-->
		<!--<li><input type="button" value="缺货信息" /></li>-->
		<li><input type="button" value="交易日志" /></li>
	</ul>
	<table class="input tabContent">
		<tr>
			<th>订单编号:</th>
			<td width="360">${tradeorder.tradeNo}</td>
			<th>所属商家:</th>
			<td>${tradeorder.merchantName}</td>
		</tr>
		<tr>
			<th>用户ID:</th>
			<td>${tradeorder.memberId}</td>
			<th>创建日期:</th>
			<td>${tradeorder.createTime}</td>
		</tr>
		<tr>
			<th>交易资产编号:</th>
			<td>${tradeorder.assetNo}</td>
			<th>交易方式:</th>
			<td>
				[#if tradeorder.assetType = 0]
					消费余额
				[#elseif tradeorder.assetType = 1]
					理财通
				[#elseif tradeorder.assetType = 2]
					一卡通
				[/#if]
			</td>
		</tr>
		<tr>
			<th>交易状态:</th>
			<td>
				[#if tradeorder.tradeState == 0]
					待交易
					[#if tradeorder.expireTime != null]
						<span title="到期时间: ${tradeorder.expireTime?string("yyyy-MM-dd HH:mm:ss")}">
							[#if tradeorder.expireTime gte currentTime]
								(到期时间: ${tradeorder.expireTime})
							[#else]
								(已到期)
							[/#if]
						</span>
					[/#if]
				[/#if]
				[#if tradeorder.tradeState == 1]
					交易完成
					[#if tradeorder.tradeTime != null]
					<span title="交易时间: ${tradeorder.tradeTime?string("yyyy-MM-dd HH:mm:ss")}">
						(交易时间: ${tradeorder.tradeTime})
					</span>
					[/#if]
				[/#if]
			</td>
			<th>交易金额:</th>
			<td>${tradeorder.tradeAmount}元</td>
		</tr>
		<tr>
			<th>交易发起方:</th>
			<td>
				[#if tradeorder.initiator == 0]
					商家
				[#elseif tradeorder.initiator == 1]
					用户
				[/#if]
			</td>
			<th>交易描述:</th>
			<td>${tradeorder.tradeSubject}</td>
		</tr>
		<tr>
			<th>是否退款:</th>
			<td>
				[#if !tradeorder.hasRefund]
					否
				[#elseif tradeorder.hasRefund]
					是
				[/#if]
			</td>
		</tr>
	</table>
	<table class="input tabContent">
		<tr class="title">
			<th>请求时间</th>
			<th>请求IP</th>
			<th>请求设备串号</th>
			<th>请求提示</th>
		</tr>
			[#list paymentLog as tradePaymentLog]
				<tr>
					<td>
						<span title="${tradePaymentLog.requestTime?string("yyyy-MM-dd HH:mm:ss")}">
							${tradePaymentLog.requestTime?string("yyyy-MM-dd HH:mm:ss")}
						</span>
					</td>
					<td>
						${tradePaymentLog.requestIp}
					</td>
					<td>
						${tradePaymentLog.requestMobile}
					</td>
					<td>
						${tradePaymentLog.errorMsg}
					</td>
				</tr>
			[/#list]
	</table>
	<table class="input">
		<tr>
			<th>
				&nbsp;
			</th>
			<td>
				<input type="button" onclick="javascript:history.go(-1);" class="button" value="返回" id="btnBack" />
			</td>
		</tr>
	</table>
</body>