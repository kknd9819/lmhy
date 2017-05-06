<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
<title>云生源互联网金融平台-交易-交易详情</title> 
   [#include "/include/inc_css.ftl" /]
    <link href="/resources/datatables/css/dataTables.bootstrap.css" rel="stylesheet">
    <link href="/resources/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
    
    [#include "/include/inc_js.ftl" /]

	<script src="/resources/dist/js/list.js"></script>
	<script src="/resources/dist/js/common.js"></script>
	<script type="text/javascript">
	$(function($) {
	});
	</script>
</head>
<body>
    <div class="modal-header">
	   <button type="button" class="close" data-dismiss="modal"aria-hidden="true">&times;</button>
	   <h4 class="modal-title" id="myModalLabel">交易-交易详情</h4>
	 </div>
	<div class="row">
             <div class="col-lg-12">
             	<div class="panel panel-default">
             	[#list orderDetail.content as data]
                     <div class="panel-body">
                         <h3 id="grid-column-ordering">${data.tradeStateStr}</h3>
                          <p class='text-muted'>交易描述:${data.tradeSubject}</p>
                          <p>用户:${data.nickName}/${data.mobile}</p>
                          <p>订单号:${data.tradeNo}</p>
 					     [#if data.tradeState == 0]
 						   <p>交易时间:${data.createTime?string("yyyy-MM-dd HH:mm:ss")}</p>
  						[#if data.expireTime!= null && data.expireTime!=""]
  							<p>到期时间:${data.expireTime?string("yyyy-MM-dd HH:mm:ss")}</p>
  						[/#if]
 					    [#else]
 						<p>交易时间:${data.tradeTime?string("yyyy-MM-dd HH:mm:ss")}</p>
 					    [/#if]
                         <div class="row show-grid">
                             <div class="col-md-4">交易金额：${currency(data.tradeAmount,true,false)}</div>
                             <div class="col-md-4">退款金额：
                             [#if data.refundAmount??]
                              ${currency(data.refundAmount,true,false)}
                             [#else]
                                                                                   ￥0.00
                             [/#if]
                             </div>
                             <div class="col-md-4">实付金额：<span class='text-danger'>
                             [#if data.refundAmount??]
                              ${currency(data.tradeAmount-data.refundAmount,true,false)}
                             [#else]
                              ${currency(data.tradeAmount,true,false)}
                             [/#if]
                            </span></div>
                             <div class="col-md-4 ">交易途径：${data.tradeWayStr}</div>                      
                             <div class="col-md-4 ">资产类型：${data.assetTypeStr}</div>    
                             <div class="col-md-4 ">资产编号：${data.assetNo}</div>
                             [#if data.settleApplyDate??]
                             <div class="col-md-4 ">是否结算：是</div>
                             <div class="col-md-8 ">结算日期：${data.settleApplyDate?string("yyyy-MM-dd HH:mm:ss")}</div>
                             [#else]
                              <div class="col-md-4 ">是否结算：否</div>
                             [/#if]
                         </div>
                     </div>
                  [/#list]
                 </div>
             </div>	
    </div> 
</div>
</body>
</html>
