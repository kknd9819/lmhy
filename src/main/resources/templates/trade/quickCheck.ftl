<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>云生源互联网金融平台-交易-快速查单</title> 
    [#include "/include/inc_css.ftl" /]
    <link href="/resources/datatables/css/dataTables.bootstrap.css" rel="stylesheet">
    <link href="/resources/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
    
    [#include "/include/inc_js.ftl" /]

	<script src="/resources/dist/js/list.js"></script>
	<script src="/resources/dist/js/common.js"></script>
	<script type="text/javascript" src="/resources/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript">
	$(function($) {
		$("#defaultForm").bootstrapValidator({
	        fields: {
	        	tradeNo: {
	                validators: {
	                    notEmpty: {
	                        message: '订单编号不能为空'
	                    }
	                }
	            }
	        } 
	    });
		$('#search_btn_a').on("click", function(){
			var tradeNo = $("#tradeNo").val();
			orderForPage(tradeNo);
        });
	});
		function orderForPage(tradeNo){
			$("#defaultForm").data("bootstrapValidator").validate();
			if(!$("#defaultForm").data('bootstrapValidator').isValid()) {  
       	 		return;
    		}
    		var getCouponForPage = "/trade/quickAjax.jhtml";
    		jQuery.getJSON(getCouponForPage, {tradeNo:tradeNo},function(data){
    			jQuery("#order_detail_div").empty();
    			var orderDetail = "";
    			if(data.data.length>0){
    				jQuery.each(data.data, function(i, data) {
    					orderDetail += "<div class='panel panel-default'>";
    					orderDetail += "<div class='panel-body'>";
    					orderDetail += "<h3 id='grid-column-ordering'>"+data.tradeStateStr+"</h3>";
    					orderDetail += "<p class='text-muted'>交易描述:"+data.tradeSubject+"</p>";
    					orderDetail += "<p>用户:"+data.nickName+"/"+data.mobile+"</p>";
    					orderDetail += "<p>订单号:"+data.tradeNo+"</p>";
    					if(data.tradeState == 0){
    						orderDetail += "<p>交易时间:"+data.createTime+"</p>";
    						 if(data.expireTime!= null && data.expireTime!=""){
    							 orderDetail += "<p>到期时间:"+data.expireTime+"</p>";
    						 }
    					}else{
    						orderDetail += "<p>交易时间:"+data.tradeTime+"</p>";
    					}
                         
					  
    					orderDetail += "<div class='row show-grid'>";
    					orderDetail += "<div class='col-md-4'>交易金额："+currency(data.tradeAmount,true,false)+"</div>";
    					orderDetail += "<div class='col-md-4'>退款金额："+currency(data.refundAmount,true,false)+"</div>";
    					orderDetail += "<div class='col-md-4'>实付金额：<span class='text-danger'>"+currency(data.tradeAmount-data.refundAmount,true,false)+"</span></div>";
    					orderDetail += "<div class='col-md-4'>交易途径："+data.tradeWayStr+"</div>";                      
    					orderDetail += "<div class='col-md-4'>资产类型："+data.assetTypeStr+"</div>";    
    					orderDetail += "<div class='col-md-4'>资产编号："+data.assetNo+"</div>";
    					if(data.settleApplyDate != ""){
    					    orderDetail += "<div class='col-md-4'>是否结算：是</div>";
    					    orderDetail += "<div class='col-md-4'>结算日期："+data.settleApplyDate+"</div>";  
    					}else{
    					    orderDetail += "<div class='col-md-4'>是否结算：否</div>";
    					}
    					orderDetail += "</div>";
    					orderDetail += "</div>";
    					orderDetail += "</div>";
    				});
    			}else{
    				var orderDetail = "";
    				orderDetail += "<div class='panel panel-default'>";
					orderDetail += "<div class='panel-body'>";
					orderDetail += "<p class='lead text-info'>暂无该订单信息</p>";
					orderDetail += "</div>";
					orderDetail += "</div>";
    			}
    			jQuery("#order_detail_div").append(orderDetail);
    		});
    	}

	</script>
</head>
<body>
	 <div id="wrapper">
        [#include "/include/inc_nav.ftl" /]
		<div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12"><h4 class="page-header">交易-快速查单</h4></div>
                </div>
				<div class="row">
                <div class="col-lg-12">
                	<div class="panel panel-default">
                	
                        <div class="panel-body">
                        <form id="defaultForm">
                        	<div class="row">
                    			<div class="form-group col-lg-1"><label class="lineheight34">订单编号</label></div>
                    			<div class="form-group col-lg-3"><input id="tradeNo" name="tradeNo" type="text" class="form-control" placeholder="订单编号"></div>
                        	</div>
                        	  </form>
                        	<div class="row">
                        		<div class="form-group col-lg-6 col-md-offset-1">
                        			<a id="search_btn_a" href="javascript:;" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;搜索</a>
                        		</div>
                        	</div>
                        </div>
                      
                    </div>	
			    </div>
			    <div class="col-lg-12" id="order_detail_div">
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
