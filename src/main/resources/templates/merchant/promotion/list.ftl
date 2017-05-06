<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>云生源互联网金融平台-优惠活动</title>
    [#include "/include/inc_css.ftl" /]
    <link href="/resources/datatables/css/dataTables.bootstrap.css" rel="stylesheet">
    <link href="/resources/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
    <link href="/resources/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
	[#include "/include/inc_js.ftl" /]
	<script type="text/javascript" src="/resources/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="/resources/bootstrap-datetimepicker/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script src="/resources/datatables/js/jquery.dataTables.min.js"></script>
	<script src="/resources/datatables/js/dataTables.bootstrap.min.js"></script>
	<script src="/resources/datatables-responsive/dataTables.responsive.js"></script>
	<script src="/resources/dist/js/list.js"></script>
</head>
<body>
    <div id="wrapper">
    [#include "/include/inc_nav.ftl" /]
        <div id="page-wrapper">
        	<div class="container-fluid">
        		<div class="page-header" style="padding-bottom:0px;">
					<div class="form-inline">
						<div class="form-group"><h4>发布--优惠活动</h4></div>
						<div class="form-group navbar-right"><a href="add.jhtml" class="btn btn-primary"><i class="fa fa-plus"></i>&nbsp;发布活动</a> <!-- <a href="javascript:;" class="btn btn-primary">扩展按钮</a> ---> &nbsp;&nbsp;&nbsp;&nbsp;</div>
					</div>
				</div>
	            <div class="row">
	                <div class="col-lg-12">
		                <div class="panel panel-default">
	                        <div class="panel-body">
	                        	<div class="row">
	                    			<div class="form-group col-lg-1"><label class="lineheight34">组合检索</label></div>
	                    			<div class="form-group col-lg-3"><input id="titleWord" type="text" class="form-control" placeholder="活动名称模糊检索"></div>
	                    			<div class="form-group col-lg-3">
	                    				<select id="typeSelect" class="form-control">
	                        				<option value="">按类型检索</option>
											[#list promotionTypes as pt]
											<option value="${pt.code}" >${pt.typeName}</option>
											[/#list]
	                                    </select>
	                                </div>
	                                <div class="form-group col-lg-1">
	                                	<a data-toggle="collapse" href="#seniorSearch" class="btn btn-link">高级选项</a>
	                                </div>
	                        	</div>
	                        	<div id="seniorSearch" class="row panel-collapse collapse">
	                        		<div class="form-group form-inline col-lg-7 col-md-offset-1">
	                        			<div id="startTimeDiv" class="input-group date col-lg-5 form_datetime" data-date-format="yyyy-mm-dd hh:00:00">
				                    		<input id="startTime" name="startTime" class="form-control" size="16" type="text" value="" placeholder="检索开始时间">
				                    		<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
		                				</div>
	                        			～
	                        			<div id="endTimeDiv" class="input-group date col-lg-5 form_datetime" data-date-format="yyyy-mm-dd hh:59:59">
				                    		<input id="endTime" name="endTime" class="form-control" size="16" type="text" value="" placeholder="检索结束时间">
				                    		<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
				                		</div>
	                        		</div>
	                        	</div>
	                        	<div class="row">
	                        		<div class="form-group col-lg-6 col-md-offset-1">
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
								            <button id="btn_del" type="button" class="btn btn-primary btn-sm">
								                <i class="fa fa-remove"></i>&nbsp;批量删除
								            </button>
								        </div>
								    </div>
								</div>
	                            <table id="promotion_table" width="100%" class="table table-striped table-bordered table-hover nowrap">
	                                <thead>
		                                <tr>
		                                	<th center="center"><input type="checkbox" class="checkall" /></th>
		                                    <th data="promotionName">活动名称</th>
	                                        <th data="promotionTypeName" center="center">类型</th>
	                                        <th data="promotionStatusName" center="center">活动状态</th>
	                                        <th data="startTime" orderable="start_time">开始时间</th>
	                                        <th data="endTime" orderable="end_time">结束时间</th>
	                                        <th center="center" data-priority="1">操作</th>
		                                </tr>
	                                </thead>
	                                <tbody>
	                                </tbody>
	                            </table>
	                        </div>
	                    </div>
	                </div>
	            </div>    
            </div>
        </div>
    </div>
</body>

<script type="text/javascript">
	var table;
    $(function($) {
	    $('.form_datetime').datetimepicker({
	        language:  "zh-CN",
	        todayBtn:  true,	//是否显示“今日”链接
			autoclose: true,
			minView: 1			//时间选择视图
   	 	}).on('changeDate',function(ev){
   	 		var startTime = $("#startTime").val();
   	 		var endTime = $("#endTime").val();
   	 		$("#startTimeDiv").datetimepicker('setEndDate',endTime);
   	 		$("#endTimeDiv").datetimepicker('setStartDate',startTime);
   	 	});
    
		var columnDefs = [
			{
				targets: 0,
				render: function (data, type, row, meta) {
					return '<input type="checkbox" name="ids" class="checkchild"  value="' + row.id + '" />';
				}
            },
			{
				targets: 6,
				render: function (data, type, row, meta) {
					var content = '<a rid="'+row.id+'" class="table_edit_a" href="javascript:;">编辑</a>';
					content += '&nbsp;&nbsp;<a class="table_view_a" href="javascript:;">查看条件</a>';
					return content;
				}
        	}
        ];
		table = $.initTable("#promotion_table", "/promotion/listAjax.jhtml", function (param){
        	param.promotionName = $('#titleWord').val();
        	param.promotionType = $('#typeSelect option:selected').val();
        	param.startTime = $('#startTime').val();
        	param.endTime = $('#endTime').val();
    	}, columnDefs);
    	
    	table.on("draw", function() {
    		$(".table_edit_a").click(function(){
    			var promotionId = $(this).attr("rid");
    			window.location.href="edit.jhtml?promotionId="+promotionId;
	    	});
	    	
	    	$(".table_view_a").click(function(){
		        var tr = $(this).closest('tr');
		        var row = table.row( tr );
		        if ( row.child.isShown() ) {
		            row.child.hide();
		        }
		        else {
		            row.child(conditionFormat(row.data())).show();
		        }
	    	});
		});
    	
    	// 全选
		$(".checkall").click( function() {
			var $this = $(this);
			var $enabledIds = $("#promotion_table input[name='ids']:enabled");
			if ($this.prop("checked")) {
				$enabledIds.prop("checked", true);
			} else {
				$enabledIds.prop("checked", false);
			}
		});
    	
    	$("#search_btn_a").click(function(){
    		table.ajax.reload();
    	});
    	
    	$("#btn_del").on("click", deletePromotion);        
    });
  
    //条件表格
    function conditionFormat(data) {
    	var conditions = data.conditions;
    	var content = '<table style="padding-left:50px;width:50%">';
		content += '<tr>';
		content += '<th style="width:20%">条件名称</th>';
		content += '<th style="width:20%">条件金额</th>';
		content += '<th style="width:20%">满减金额(满折折扣)</th>';
		if(data.promotionType==1){
			content += '<th style="width:20%">封顶金额</th>';
		}
		content +=  '</tr>';
		for(var i=0;i<conditions.length;i++){
			content += '<tr>';
			content +=	 '<td>'+conditions[i].conditionName+'</td>';
			content +=	 '<td>'+conditions[i].conditionAmount+'</td>';
			content +=	 '<td>'+conditions[i].subAmount+'</td>';
			if(data.promotionType==1){
				content +=	'<td>'+conditions[i].capAmount+'</td>';
			}
			content += '</tr>';
		}
		content += '</table>'; 
				    
	    return content;
	}
    
	//删除
	function deletePromotion() {
		var $checkedIds = $("#promotion_table input[name='ids']:enabled:checked");
		var $selectAll = $(".checkall");
		if($checkedIds.serialize() != ''){
			$.message({
				content: "确定要删除选中的活动?",
				otherButtons: ['确定'],
				otherButtonStyles: ['btn-primary'],
				clickButton: function(sender,modal,index) {
					$.ajax({
						url: "/promotion/delete.jhtml",
						type: "POST",
						data: $checkedIds.serialize(),
						dataType: "json",
						cache: false,
						success: function(message) {
							$.message({content:message.content,timeOut: 2000});
							if (message.type == "success") {
								table.ajax.reload();
							}
							$selectAll.prop("checked", false);
							$checkedIds.prop("checked", false);
						}
					});
				}
			});
		} else {
			$.message({content:"请选择要删除的活动",timeOut: 2000});
		}
	}
 
</script>


</html>
