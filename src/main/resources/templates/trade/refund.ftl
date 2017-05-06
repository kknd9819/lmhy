<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

   <title>云生源互联网金融平台-交易-交易订单</title> 
   
    [#include "/include/inc_css.ftl" /]
    <link href="/resources/datatables/css/dataTables.bootstrap.css" rel="stylesheet">
    <link href="/resources/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
    <link href="/resources/bootstrapvalidator/css/bootstrapValidator.min.css" rel="stylesheet"/>
    <link href="/resources/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    
    [#include "/include/inc_js.ftl" /]
    <script src="/resources/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/resources/datatables/js/dataTables.bootstrap.min.js"></script>
    <script src="/resources/datatables-responsive/dataTables.responsive.js"></script>
	<script src="/resources/dist/js/list.js"></script>
	<script src="/resources/dist/js/common.js"></script>
	<script type="text/javascript" src="/resources/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="/resources/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="/resources/bootstrap-datetimepicker/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript">
	$(function($) {
	    //表单验证
		$("#defaultForm").bootstrapValidator({
	        fields: {
	        	hasRefundAmount: {
	                validators: {
	                    notEmpty: {
	                        message: '退款金额不能为空'
	                    },
	                    regexp: {  
                            regexp: /^(?!0+(?:\.0+)?$)(?:[1-9]\d*|0)(?:\.\d{1,2})?$/,  
                            message: '退款金额填写错误'  
                        },
                        callback: {
        	            	message: '退款金额不能大于订单交易余额',
        	            	callback: function(value, validator) {
        	            	   sum = $("#tradeAmount").val()- $("#refundAmount").val();
        	            	   return value <= sum;
        	             }
	                  }
	                }
	            },
	            refundSubject: {
	                validators: {
	                    notEmpty: {
	                        message: '退款说明不能为空'
	                    }
	                }
	            }
	        } 
	    });

		//保存
		var isCommitted = false;//是否已经提交标识，默认为false
		$("#submitBtn").on("click", function(){
			$("#defaultForm").data("bootstrapValidator").validate();
			if(!$("#defaultForm").data('bootstrapValidator').isValid()) {  
       	 		return;
    		}  
			var hasRefundAmount = $("#hasRefundAmount").val();
			var refundSubject = $("#refundSubject").val();
			var tradeNo = $("#tradeNo").val();
			
			$("#submitBtn").attr("data-dismiss",'modal');
			   if(isCommitted == false){
				  isCommitted = true;//提交后，将是否已经提交标识设置为true
				    $.ajax({
						url: "/trade/drawback.jhtml",
						type: "POST",
						data: {tradeNo:tradeNo,hasRefundAmount:hasRefundAmount,refundSubject:refundSubject},
						dataType: "json",
						cache: false,
						success: function(message) {
							$.message(message);
							if (message.type == "success") {
								setTimeout(function() {
									window.location.href="fuzzy.jhtml";
								}, 3000);
							}
							
						}
					}); 
				 }
		});
	});
	</script>
<body>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h4 class="modal-title" id="myModalLabel">退款</h4>
</div>
<div class="panel-body">
	<form id="defaultForm" class="form-horizontal">
	<input type="hidden" id="tradeNo" name="tradeNo" value="${orderDetail.tradeNo}" />
	                     <div class="form-group">
                            <label class="col-lg-2 control-label">用户:</label>
                            <div class="col-lg-5">
                                <input type="text" class="form-control" name="nickName" value="${orderDetail.nickName}/${orderDetail.mobile}" readOnly="true"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">交易金额:</label>
                            <div class="col-lg-5">
                                <input type="text" class="form-control" name="tradeAmount" id="tradeAmount" value="${currency(orderDetail.tradeAmount)}" readOnly="true"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">已退金额:</label>
                            <div class="col-lg-5">
                                <input type="text" class="form-control" name="refundAmount" id="refundAmount" readOnly="true"
                                 value="[#if orderDetail.refundAmount!=''] ${currency(orderDetail.refundAmount)}[#else] 0.00 [/#if]" />
                            </div>
                        </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">交易途径:</label>
                            <div class="col-lg-5">
                                <input type="text" class="form-control" name="tradeWayStr" value="${orderDetail.tradeWayStr}" readOnly="true"/>
                            </div>
                        </div>
                         <div class="form-group">
                            <label class="col-lg-2 control-label">资产类型:</label>
                            <div class="col-lg-5">
                                <input type="text" class="form-control" name="assetTypeStr" value="${orderDetail.assetTypeStr}" readOnly="true"/>
                            </div>
                        </div>
                         <div class="form-group">
                            <label class="col-lg-2 control-label">资产编号:</label>
                            <div class="col-lg-5">
                                <input type="text" class="form-control" name="assetNo" value="${orderDetail.assetNo}" readOnly="true"/>
                            </div>
                        </div>
						<div class="form-group">
                            <label class="col-lg-2 control-label">退款金额:</label>
                            <div class="col-lg-5">
                                <input type="text" class="form-control" name="hasRefundAmount" id="hasRefundAmount" maxlength="100" 
                                placeholder="可退款金额[#if orderDetail.refundAmount != ''] ${currency(orderDetail.tradeAmount-orderDetail.refundAmount)}[#else] ${currency(orderDetail.tradeAmount)} [/#if]"/>
                            </div>
                        </div>
	                <div class="form-group">
                            <label class="col-lg-2 control-label">退款说明:</label>
                            <div class="col-lg-7">
                                <textarea class="form-control" name="refundSubject" maxlength="100" id="refundSubject" rows="3"></textarea>
                            </div>
                        </div>
					</form>
</div>
  <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
    <button id ="submitBtn" type="button" class="btn btn-primary">确定</button>
</div>
</body>
</html>
