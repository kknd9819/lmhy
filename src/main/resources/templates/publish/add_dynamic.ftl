<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>云生源互联网金融平台-发布商家动态</title>
    [#include "/include/inc_css.ftl" /]
    <link href="/resources/bootstrapvalidator/css/bootstrapValidator.min.css" rel="stylesheet"/>
    <link href="/resources/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
	[#include "/include/inc_js.ftl" /]
	<script type="text/javascript" src="/resources/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="/resources/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="/resources/bootstrap-datetimepicker/js/bootstrap-datetimepicker.zh-CN.js"></script>

</head>
<body>
	<div id="wrapper">
	[#include "/include/inc_nav.ftl" /]
	<div id="page-wrapper">
    <div class="row">
	    <div class="col-lg-12">
	        <div class="panel panel-default">
	            <div class="panel-heading">
	                <h3>发布商家动态</h3>
	            </div>
	            <div class="panel-body">
					<form id="defaultForm" class="form-horizontal" action="save.jhtml" method="post">
						<div class="form-group">
                            <label class="col-lg-3 control-label">动态名称</label>
                            <div class="col-lg-3">
                                <input type="text" class="form-control" name="dynamicMsgName" maxlength="20" />
                            </div>
                        </div>
						
						<div class="form-group">
                            <label class="col-lg-3 control-label">动态类型</label>
                            <div class="col-lg-3">
                                <select name="dynamicMsgType" id="dynamicMsgType" class="col-lg-5">
									[#list dynamicMsgTypes as pt]
										[#if pt_index == 0]
											<option value="${pt.code}" selected>${pt.typeName}</option>
										[#else]
											<option value="${pt.code}" >${pt.typeName}</option>
										[/#if]
									[/#list]
								</select>
                            </div>
                        </div>
                        
						<div class="form-group">
                            <label class="col-lg-3 control-label">开始时间</label>
                            <div class="col-lg-3">
                        		<div id="startTimeDiv" class="input-group date form_datetime" data-date-format="yyyy-mm-dd hh:00:00">
		                    		<input id="startTime" name="startTime" class="form-control" size="16" type="text" value="" >
		                    		<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
		                		</div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-lg-3 control-label">结束时间</label>
                            <div class="col-lg-3">
                        		<div id="endTimeDiv" class="input-group date form_datetime" data-date-format="yyyy-mm-dd hh:59:59">
		                    		<input id="endTime" name="endTime" class="form-control" size="16" type="text" value="">
		                    		<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
		                		</div>
                            </div>
                        </div>
						
						<div class="form-group">
                            <label class="col-lg-3 control-label">动态内容</label>
                            <div class="col-lg-3">
                                <textarea class="form-control" name="msg" maxlength="100" rows="3"></textarea>
                            </div>
                        </div>
						
						<div class="form-group">
                            <div class="col-lg-9 col-lg-offset-3">
                                <button type="submit" class="btn btn-primary">保存</button>
                                <button type="button" class="btn btn-info" id="backBtn">返回</button>
                            </div>
                        </div>
					</form>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
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
   	 		//重新验证
   	 		$("#defaultForm").bootstrapValidator('revalidateField', 'startTime'); 
   	 		$("#defaultForm").bootstrapValidator('revalidateField', 'endTime');   
   	 	});
		
		$("#defaultForm").bootstrapValidator({
	        fields: {
	            dynamicMsgName: {
	                validators: {
	                    notEmpty: {
	                        message: '动态名称不能为空'
	                    }
	                }
	            },
	            startTime: {
	                validators: {
	                    notEmpty: {
	                        message: '开始时间不能为空'
	                    }
	                }
	            },
	            endTime: {
	                validators: {
	                    notEmpty: {
	                        message: '结束时间不能为空'
	                    }
	                }
	            },
	            msg: {
	                validators: {
	                    notEmpty: {
	                        message: '动态内容不能为空'
	                    }
	                }
	            }
	        }
	    });
		
		
		$("#backBtn").on("click", function(){window.location.href="dynamic_page.jhtml";});
	});


</script>
</html>