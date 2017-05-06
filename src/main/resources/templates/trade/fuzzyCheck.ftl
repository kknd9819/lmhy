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
		$('.form_datetime').datetimepicker({
	        language:  "zh-CN",
	        todayBtn:  true,	//是否显示“今日”链接
			autoclose: true,
			minView: 1			//时间选择视图
   	 	}).on('changeDate',function(ev){
   	 		var startTime = $("#startTime").val();
   	 		var endTime = $("#endTime").val();
   	 		$("#beginTimeDiv").datetimepicker('setEndDate',endTime);
   	 		$("#endTimeDiv").datetimepicker('setStartDate',startTime);
   	 		//重新验证
   	 		$("#defaultForm").bootstrapValidator('revalidateField', 'beginTime'); 
   	 		$("#defaultForm").bootstrapValidator('revalidateField', 'endTime');   
   	 	});
		
		var columnDefs = [{
			targets: 1,
			render: function (data, type, row, meta) {
				var tradeTime = "";
				if(row.tradeState == 0){
					tradeTime = row.createTime;
				}else{
					tradeTime = row.tradeTime;
				}
				return tradeTime;
			}
		},{
			targets: 0,
			render: function (data, type, row, meta) {
				// 参考http://datatables.club/reference/option/columns.render.html
				//return content = "<a  target='_blank' href='/trade/view.jhtml?tradeNo="+row.tradeNo+"'>"+row.tradeNo+"</a>";
				return content = "<a data-toggle='modal' data-target='#orderDetail' href='../trade/view.jhtml?tradeNo="+row.tradeNo+"'>"+row.tradeNo+"</a>";
			}
        },{
        	targets: 3,
			render: function (data, type, row, meta) {
				return currency(row.tradeAmount);
			}
        	
        },{
        	targets: 6,
			render: function (data, type, row, meta) {
				return currency(row.refundAmount);
			}
        },
        {
        	targets: 8,
			render: function (data, type, row, meta) {
				var content = "";
				if(row.tradeState == 1 && row.tradeAmount > row.refundAmount && row.settleApplyDate == ""){
					content = "<a data-toggle='modal' data-target='#myModal' href='../trade/drawbackWeb.jhtml?tradeNo="+row.tradeNo+"'>退款</a>";
				}
				 return content;
			}
        }];
		var dt = $.initTable("#trade_orders_table", "/trade/fuzzyAjax.jhtml", function (param){
			param.content = $("#content").val();
			param.tradeState = $("#tradeState option:selected").val();
			param.tradeWay = $("#tradeWay option:selected").val();
			param.assetType = $("#assetType option:selected").val();
			param.beginTime = $("#beginTime").val();
			param.endTime = $("#endTime").val();
			param.beginAmount = $("#beginAmount").val();
			param.endAmount = $("#endAmount").val();
			param.hasRefund = $("#hasRefund option:selected").val();
    	}, columnDefs);
		
		//搜索
    	$("#search_btn_a").click(function(){
    		dt.ajax.reload();
    	});

    	//置空
    	$("#reset_btn_a").click(function(){
    		$("#content").val("");
    		$("#tradeState").val("");
    		$("#tradeWay").val("");
    		$("#assetType").val("");
    		$("#beginTime").val("");
    		$("#endTime").val("");
    		$("#beginAmount").val("");
    		$("#endAmount").val("");
    		$("#hasRefund").val("");
    	});
    	//导出
    	$("#export_btn_a").click(function(){
    		var content = $("#content").val();
    		var tradeState = $("#tradeState option:selected").val();
    		var tradeWay = $("#tradeWay option:selected").val();
    		var assetType = $("#assetType option:selected").val();
    		var beginTime = $("#beginTime").val();
    		var endTime = $("#endTime").val();
    		var beginAmount = $("#beginAmount").val();
    		var endAmount = $("#endAmount").val();
    		var hasRefund = $("#hasRefund option:selected").val();
			var param = "?content=" + content +"&tradeState=" + tradeState + "&tradeWay=" + tradeWay + "&assetType=" + assetType + "&beginTime=" + beginTime + "&endTime=" +endTime + "&beginAmount=" + beginAmount + "&endAmount=" + endAmount+ "&hasRefund=" + hasRefund;
    		window.location.href = "/trade/export.jhtml" + param;
    	});
    	//刷新
    	$("#table_refresh_a").click(function(){
    		dt.ajax.reload(null, false);
    	});
    	//modal 与   折叠不兼容
    	$("#choose").click(function(){
    		if($("#seniorSearch").attr("class") == 'row panel-collapse collapse'){
    			$("#seniorSearch").attr("class", "row panel-collapse collapse in");
    		}else{
    			$("#seniorSearch").attr("class", "row panel-collapse collapse");
    			
    		}
    		
    	});
	});
	</script>
<body>
   <div id="wrapper">
        [#include "/include/inc_nav.ftl" /]
		<div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12"><h4 class="page-header">交易-交易订单</h4></div>
                </div>
				<div class="row">
                <div class="col-lg-12">
                	<div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="row">
                    			<div class="form-group col-lg-1"><label class="lineheight34">组合检索</label></div>
                    			<div class="form-group col-lg-4"><input id="content" type="text" class="form-control" placeholder="订单编号/交易信息/对方信息模糊检索"></div>
                    			<div class="form-group col-lg-2">
                    				<select id="tradeState" class="form-control">
                        				<option value="">交易状态</option>
                                        <option value="0">待支付</option>
                                        <option value="1">交易完成</option>
                                    </select>
                                </div>
                                <div class="form-group col-lg-1">
                                	<a data-toggle="collapse"  class="btn btn-link" id="choose">高级选项</a>
                                </div>
                        	</div>
                        	
								<div id="seniorSearch" class="row panel-collapse collapse">
									<div class="form-group col-lg-2  col-md-offset-1">
										<select id="tradeWay" class="form-control">
											<option value="">交易途径</option>
											<option value="0">APP支付</option>
											<option value="1">扫码支付</option>
											<option value="2">买单支付</option>
										</select>
								   </div>

									<div class="form-group form-inline col-lg-7">
									      <div id="beginTimeDiv" class="input-group date form_datetime" data-date-format="yyyy-mm-dd hh:00:00">
		                        			<input id="beginTime" type="text" class="form-control" placeholder="交易开始时间" size="16" type="text" value="" >
		                        			<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
										    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
										  </div>
	                        			～
		                        		 <div id="endTimeDiv" class="input-group date form_datetime" data-date-format="yyyy-mm-dd hh:59:59">
		                        			<input id="endTime" type="text" class="form-control" placeholder="交易结束时间" size="16" type="text" value="" >
		                        			<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                        			<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
		                        		 </div>
		                        	</div>

                        		<div class="form-group col-lg-2 col-md-offset-1">
									<select id="assetType" class="form-control">
										<option value="">资产类型</option>
										<option value="0">余额</option>
										<option value="1">理财通</option>
										<option value="2">一卡通</option>
									</select>
								</div>
								<div class="form-group form-inline col-lg-4">
                        			<input id="beginAmount" type="text" class="form-control" placeholder="资金范围">
                        			-
                        			<input id="endAmount" type="text" class="form-control" placeholder="资金范围">
                        		</div>
								<div class="form-group col-lg-2">
									<select id="hasRefund" class="form-control">
										<option value="">是否退款</option>
										<option value="0">否</option>
										<option value="1">是</option>
									</select>
								</div>
                        	  </div>
                        	<div class="row">
                        		<div class="form-group col-lg-6 col-md-offset-1">
                        		    <a id="reset_btn_a" href="javascript:;" class="btn btn-primary"><i class="fa fa-gear fa-fw"></i>重置</a>
                        		    <a id="export_btn_a" href="javascript:;" class="btn btn-primary"><em class="glyphicon glyphicon-export"></em>导出</a>
                        			<a id="search_btn_a" href="javascript:;" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;搜索</a>
                        		</div>
                        	</div>
                        </div>
                    </div>
                    
                    <div class="panel panel-default">
                        <div class="panel-body">
                          <div class="row-fluid">
							    <div class="pull-right">
							        <div class="btn-group">
							        	<a id="table_refresh_a" href="javascript:;" class="btn btn-primary"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
							        </div>
							    </div>
							</div>
                            <table width="100%" class="table table-striped table-bordered table-hover" id="trade_orders_table">
                                <thead>
                                    <tr>
                                        <th data="tradeNo" orderable="trade_no" data-priority="1">交易订单号</th>
                                        <th data="tradeTime" orderable="trade_time" data-priority="3">交易时间</th>
                                        <th data="tradeWayStr" center="center" orderable="trade_way">交易途径</th>
                                        <th data="tradeAmount" center="center" orderable="trade_amount">交易金额</th>
                                        <th data="tradeStateStr" center="center" orderable="trade_state">交易状态</th>
                                        <th data="isHasRefundStr" center="center" orderable="has_refund">是否退款</th>
                                        <th data="refundAmount" center="center" orderable="refund_amount">退款金额</th>
                                        <th data="isSettleApplyStr" center="center" orderable="settle_apply_date">是否结算</th>
                                        <th center="center" data-priority="2">操作</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                 </div>
               </div>

                 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                     <div class="modal-dialog">
                         <div class="modal-content">      
                             <div class="modal-body"></div>
                         </div>
                    </div>
                </div>
                 <div class="modal fade" id="orderDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                     <div class="modal-dialog">
                         <div class="modal-content">      
                             <div class="modal-body"></div>
                         </div>
                    </div>
                </div>
       </div> 
   </div> 
 </div>
</body>
</html>
