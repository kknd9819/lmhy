<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>云生源互联网金融平台-交易-交易退款</title>
    [#include "/include/inc_css.ftl" /]
     <link href="/resources/datatables/css/dataTables.bootstrap.css" rel="stylesheet">
    <link href="/resources/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
	[#include "/include/inc_js.ftl" /]
</head>
[#include "/include/inc_nav.ftl" /]
<body>
    <div class="wrapper">
        <div id="page-wrapper">
        	<div class="container-fluid">
            	<div class="row">
            		<div class="col-lg-12"><h4 class="page-header">消息--交易退款</h4></div>
            	</div>
            	
	            	<div class="row">
	            		<div class="col-lg-12">
	            			<form id="queryForm" method="post">
		            			<div class="panel panel-default">
		            				<div class="panel-body">
		            					<div class="row">
		            						<div class="form-group col-lg-4">
		            							<label>订单号:</label>
		            							<input id="tradeNo" name="tradeNo" type="text" class="form-control" placeholder="请输入订单号"/>
		            						</div>
		            						<div class="form-group col-lg-4">
		            							<label>退款单号:</label>
		            							<input id="refundNo" name="refundNo" type="text" class="form-control" placeholder="请输入退款单号"/>
		            						</div>
		            						<div class="form-group col-lg-4">
			                                	<a data-toggle="collapse" href="#seniorSearch" class="btn btn-link">高级选项</a>
			                                </div>
		            					</div> <!-- row end -->
		            					<div id="seniorSearch" class="row panel-collapse collapse">
		            						<div class="form-group col-lg-4">
		            							<label for="ds_host">退款资产单号:</label>
		            							<input id="assetNo" name="assetNo" type="text" class="form-control" placeholder="请输入退款资产单号">
		            						</div>
		            						<div class="form-group col-lg-4">
		            							<label for="ds_host">退款方式:</label>
		            							<select class="form-control" id="assetType" name="assetType">
									        		<option value="" selected="true">请选择...</option>
		                                    		<option value="0">余额</option>
		                                    		<option value="1">理财通</option>
		                                    		<option value="2">一卡通</option>
	                                    		</select>
		            						</div>
		            					</div> <!-- seniorSearch end -->
		            				</div>
		            			</div>
	            			</form>
	            			<div class="panel panel-default">
	            				<div class="panel-body">
	            					<div class="row-fluid">
	            						<div class="pull-right">
									        <div class="btn-group">
									            <button type="button" class="btn btn-primary btn-sm" id="btn-re">
									                <i class="fa fa-refresh"></i>&nbsp;刷新
									            </button>
									        </div>
									    </div>
	            					</div> <!-- row-fluid end -->
	            					<table width="100%" class="table table-striped table-bordered table-hover nowrap" id="refundTable">
		                                <thead>
			                                <tr>
			                                	<!--<th data="id"><input type="checkbox" id="checkAll" /></th>-->
			                                    <th data="">订单号/退款单号</th>
			                                    <th data="">退款资产单号/退款资金方式</th>
			                                    <th data="merchantName">商家</th>
			                                    <th data="refundAmount" orderable="refund_amount">退款金额</th>
			                                    <th data="refundTime" orderable="refund_time">退款时间</th>
			                                    <th data="refundSubject">退款描述</th>
			                                    <th data="refundState" orderable="refund_state">退款状态</th>
			                                    <!--<th data-priority="2">操作</th>-->
			                                </tr>
		                                </thead>
		                            </table>
	            				</div>
	            			</div>
	            		</div>
	            	</div>
            	</div>
            </div><!-- container-fluid end -->
        </div>
     </div><!-- wrapper end -->
</body>

<!-- DataTables JavaScript -->
<script src="/resources/datatables/js/jquery.dataTables.min.js"></script>
<script src="/resources/datatables/js/dataTables.bootstrap.min.js"></script>
<script src="/resources/datatables-responsive/dataTables.responsive.js"></script>
<script src="/resources/dist/js/list.js"></script>
<!-- Page-Level Demo Scripts - Tables - Use for reference -->
<script>
	var tables;
	$(function(){
		//{targets : 0,render : function (data) {return '<input type="checkbox" name="ids" id="ids" value="'+data.id+'"/>';}},
		var columns = [{
			targets : 0,
	        render : function (data) {
	        	return data.tradeNo+'<br/>'+data.refundNo;
	        }
		},{
			targets : 1,
	        render : function (data) {
	        	var html = data.assetNo+'<br/>';
	        	switch(data.assetType){
	        		case 0:
	        			html += '余额';
	        		break;
	        		case 1:
	        			html += '理财通';
	        		break;
	        		case 2:
	        			html += '一卡通';
	        		break;
	        	}
	        	return html;
	        }
		},{
			targets : 3,
			render : function(data){
				return data+'元';
			}
		},{
			targets : 6,
			render : function(data){
				if(data == 0){
					return '待退款';
				} else {
					return '退款完成';
				}
			}
		}];
		tables = $.initTable("#refundTable","refundList.jhtml",function(param){
				var formData = $("#queryForm").serializeArray();
				formData.forEach(function(e){
					param[e.name] = e.value;
				});
    		},columns);
    	
    	//刷新
	    $("#btn-re").on("click", function () {
	    	tables.draw(false);//刷新保持分页状态
	    });
    	
    	//订单号查询
    	$("#tradeNo").keyup(function(){
	    	tables.ajax.reload();
	    	tables.draw(false);
	    });
	    //退款单号查询
    	$("#refundNo").keyup(function(){
	    	tables.ajax.reload();
	    	tables.draw(false);
	    });
	     //退款单号查询
    	$("#assetNo").keyup(function(){
	    	tables.ajax.reload();
	    	tables.draw(false);
	    });
	    
	    //下拉框选中
	    $("#assetType").change(function(){
	    	tables.ajax.reload();
	    	tables.draw(false);
	    });
	});
</script>
</html>


