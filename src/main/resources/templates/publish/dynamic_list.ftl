<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <title>云生源互联网金融平台-发布-动态</title>
    
    [#include "/include/inc_css.ftl" /]
    <link href="/resources/datatables/css/dataTables.bootstrap.css" rel="stylesheet">
    <link href="/resources/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
    
    [#include "/include/inc_js.ftl" /]
	<script src="/resources/datatables/js/jquery.dataTables.min.js"></script>
	<script src="/resources/datatables/js/dataTables.bootstrap.min.js"></script>
	<script src="/resources/datatables-responsive/dataTables.responsive.js"></script>
	<script src="/resources/dist/js/list.js"></script>
	<script type="text/javascript">
	$(function($) {
		var columnDefs = [{
			targets: 4,
			render: function (data, type, row, meta) {
				// 参考http://datatables.club/reference/option/columns.render.html
				var content = '<a rid="'+row.id+'" class="table_edit_a" href="javascript:;">编辑</a> <a rid="'+row.id+'" class="table_delete_a" href="javascript:;">删除</a>';
				return content;
			}
        }];
		var dt = $.initTable("#dynamic_msg_table", "/merchant/message/dynamic_list.jhtml", function (param){
        	param.word = $('#titleWord').val();
        	param.type = $('#typeSelect option:selected').val();
        	param.begin = $('#beginTime').val();
        	param.end = $('#endTime').val();
    	}, columnDefs);
    	
    	dt.on("draw", function() {
    		$(".table_edit_a").click(function(){
    			alert('准备编辑ID：'+$(this).attr("rid")+'的动态');
	    	});
	    	
	    	$(".table_delete_a").click(function(){
	    		alert('准备删除ID：'+$(this).attr("rid")+'的动态');
	    	});
		});
    	
    	$("#search_btn_a").click(function(){
    		dt.ajax.reload();
    	});
    	
    	$("#table_refresh_a").click(function(){
    		dt.ajax.reload(null, false);
    	});
	});
	</script>
</head>

<body>
    <div id="wrapper">
        [#include "/include/inc_nav.ftl" /]
		<div id="page-wrapper">
            <div class="container-fluid">
				<div class="page-header" style="padding-bottom:0px;">
					<div class="form-inline">
						<div class="form-group"><h4>发布--商家动态</h4></div>
						<div class="form-group navbar-right"><a href="add_dynamic_page.jhtml" class="btn btn-primary"><i class="fa fa-plus"></i>&nbsp;发布动态</a> <!-- <a href="javascript:;" class="btn btn-primary">扩展按钮</a> ---> &nbsp;&nbsp;&nbsp;&nbsp;</div>
					</div>
				</div>
				<div class="row">
                <div class="col-lg-12">
                	<div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="row">
                    			<div class="form-group col-lg-1"><label class="lineheight34">组合检索</label></div>
                    			<div class="form-group col-lg-3"><input id="titleWord" type="text" class="form-control" placeholder="标题模糊检索"></div>
                    			<div class="form-group col-lg-3">
                    				<select id="typeSelect" class="form-control">
                        				<option value="">按类型检索</option>
                                        <option value="0">返现</option>
                                        <option value="1">优惠</option>
                                    </select>
                                </div>
                                <div class="form-group col-lg-1">
                                	<a data-toggle="collapse" href="#seniorSearch" class="btn btn-link">高级选项</a>
                                </div>
                        	</div>
                        	<div id="seniorSearch" class="row panel-collapse collapse">
                        		<div class="form-group form-inline col-lg-6 col-md-offset-1">
                        			<input id="beginTime" type="text" class="form-control" placeholder="检索开始时间">～<input id="endTime" type="text" class="form-control" placeholder="检索结束时间">
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
							        	<a id="table_refresh_a" href="javascript:;" class="btn btn-primary"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
							        </div>
							    </div>
							</div>
                            <table width="100%" class="table table-striped table-bordered table-hover nowrap" id="dynamic_msg_table">
                                <thead>
                                    <tr>
                                        <th data="dynamicMsgName" data-priority="1">标题</th>
                                        <th data="dynamicMsgTypeName" center="center" data-priority="3">类型</th>
                                        <th data="startTime" orderable="start_time">开始时间</th>
                                        <th data="endTime" orderable="end_time">结束时间</th>
                                        <th center="center" data-priority="2">操作</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>