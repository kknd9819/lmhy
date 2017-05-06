<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>云生源互联网金融平台-编辑优惠活动</title>
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
	                <h3>编辑优惠活动</h3>
	            </div>
	            <div class="panel-body">
					<form id="defaultForm" class="form-horizontal">
						<input type="hidden" id="id" name="id" value="${merchantPromotion.id}" />
						<div class="form-group">
                            <label class="col-lg-2 control-label">活动类型</label>
                            <div class="col-lg-3">
                                <select name="promotionType" id="promotionType" class="col-lg-5">
									[#list promotionTypes as pt]
										[#if pt.code == merchantPromotion.promotionType]
											<option value="${pt.code}" selected>${pt.typeName}</option>
										[#else]
											<option value="${pt.code}" >${pt.typeName}</option>
										[/#if]
									[/#list]
								</select>
                            </div>
                        </div>
                        
						<div class="form-group">
                            <label class="col-lg-2 control-label">活动名称</label>
                            <div class="col-lg-3">
                                <input type="text" class="form-control" name="promotionName" value="${merchantPromotion.promotionName}" maxlength="100" />
                            </div>
                        </div>
						
						<div class="form-group">
                            <label class="col-lg-2 control-label">活动开始时间</label>
                            <div class="col-lg-3">
                        		<div id="startTimeDiv" class="input-group date form_datetime" data-date-format="yyyy-mm-dd hh:00:00">
		                    		<input id="startTime" name="startTime" class="form-control" size="16" type="text" value="[#if merchantPromotion.startTime == null][#else]${merchantPromotion.startTime?string("yyyy-MM-dd HH:mm:ss")}[/#if]" >
		                    		<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
		                		</div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-lg-2 control-label">活动结束时间</label>
                            <div class="col-lg-3">
                        		<div id="endTimeDiv" class="input-group date form_datetime" data-date-format="yyyy-mm-dd hh:59:59">
		                    		<input id="endTime" name="endTime" class="form-control" size="16" type="text" value="[#if merchantPromotion.endTime == null][#else]${merchantPromotion.endTime?string("yyyy-MM-dd HH:mm:ss")}[/#if]">
		                    		<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
		                		</div>
                            </div>
                        </div>
						
						<div class="form-group">
                            <label class="col-lg-2 control-label">活动状态</label>
                            <div class="col-lg-5">
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="promotionStatus" value="1" [#if merchantPromotion.promotionStatus==1]checked="true"[/#if]/>启用
                                    </label>
                                    &nbsp;
                                    <label>
                                        <input type="radio" name="promotionStatus" value="0" [#if merchantPromotion.promotionStatus==0]checked="true"[/#if]/> 禁用
                                    </label>
                                </div>
                            </div>
                        </div>
                        
						<div class="form-group">
							<div class="col-lg-8">
								<input type="button" class="btn" id="deleteLastCondition" value="删除最后活动条件" />
								<input type="button" class="btn" id="addCondition" value="添加活动条件" />
								(注意：活动条件必须添加,切换“活动类型”会清空活动条件)
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-lg-8">
								<table class="table table-striped table-bordered table-hover" id="subTable" style="display:none;">
									<tr>
										<th>条件名称</th>
										<th>条件金额</th>
										<th>满减金额</th>
									</tr>
									[#if merchantPromotion.promotionType == 0]
									<input type="hidden" id="subIndex" value="${merchantPromotion.conditions?size}" />
									<tbody id="subTbody">
								 		[#list merchantPromotion.conditions as opc]
								 			<tr>
												<td><input type="text"  name="conditions[${opc_index}].conditionName" value="${opc.conditionName}" class="form-control" maxlength="50" /></td>
												<td><input type="text"  name="conditions[${opc_index}].conditionAmount" value="${opc.conditionAmount}" class="form-control moneyInput" maxlength="8" /></td>
												<td><input type="text"  name="conditions[${opc_index}].subAmount" value="${opc.subAmount}" class="form-control moneyInput" maxlength="8" /></td>
											</tr>
								 		[/#list]
									</tbody>
									[#else]
									<input type="hidden" id="subIndex" value="0" />
									<tbody id="subTbody">
								 
									</tbody>
									[/#if]
								</table>
							</div> 
						</div>
						
						<div class="form-group">
							<div class="col-lg-10">
								<table class="table table-striped table-bordered table-hover" id="discountTable" style="display:none;">
									<tr>
										<th>条件名称</th>
										<th>条件金额</th>
										<th>满折折扣(注：折扣率不能大于1，例如8折填写成0.8)</th>
										<th>封顶金额</th>
									</tr>
									[#if merchantPromotion.promotionType == 1]
									<input type="hidden" id="discountIndex" value="${merchantPromotion.conditions?size}" />
									<tbody id="discountTbody">
								 		[#list merchantPromotion.conditions as opc]
								 			<tr>
												<td><input type="text"  name="conditions[${opc_index}].conditionName" value="${opc.conditionName}" class="form-control" maxlength="50" /></td>
												<td><input type="text"  name="conditions[${opc_index}].conditionAmount" value="${opc.conditionAmount}" class="form-control moneyInput" maxlength="8" /></td>
												<td><input type="text"  name="conditions[${opc_index}].subAmount" value="${opc.subAmount}" class="form-control moneyInput" maxlength="8" /></td>
												<td><input type="text"  name="conditions[${opc_index}].capAmount" value="${opc.capAmount}" class="form-control moneyInput" maxlength="8" /></td>
											</tr>
								 		[/#list]
									</tbody>
									[#else]
									<input type="hidden" id="discountIndex" value="0" />
									<tbody id="discountTbody">
									</tbody>
									[/#if]
								 </table>
							</div>
						</div>
						
						<div class="form-group">
                            <div class="col-lg-8 col-lg-offset-2">
                                <button id="submitBtn" type="button" class="btn btn-primary">保存</button>
                                <button id="backBtn" type="button" class="btn btn-info" >返回</button>
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
	            promotionName: {
	                validators: {
	                    notEmpty: {message: '活动名称不能为空'}
	                }
	            },
	            startTime: {
	                validators: {
	                    notEmpty: {message: '活动开始时间不能为空'}
	                }
	            },
	            endTime: {
	                validators: {
	                    notEmpty: {message: '活动结束时间不能为空'}
	                }
	            }
	        } 
	    });
		
		var promotionTypeVal = $('select[name="promotionType"]').val();
		showTable(promotionTypeVal);
		function showTable(opType){
			if(opType == "0"){
				subTableShow();		 	
				discountTableHide();
			} else if(opType == "1"){
				subTableHide();			 
				discountTableShow();
			}
		}
		
		function discountTableHide(){
	    	$('#discountTable').hide();
	    	$('#discountTbody').empty();
	    	$('#discountIndex').val(0);
	    }
		
		function discountTableShow(){
	    	$('#discountTable').show();
	    }
		 
		function subTableHide(){
	    	$('#subTable').hide();
	    	$('#subTbody').empty();
	    	$('#subIndex').val(0);
	    }
	    function subTableShow(){
	    	$('#subTable').show();
	    } 
    
    	$("select[name='promotionType']").bind("click",function(){
	 		var $val = $(this).val();
	 		showTable($val);
 		}); 
 		
		$('#addCondition').bind('click',function(){
			var $promotionType = $('select[name="promotionType"]').val();
			if($promotionType == "0"){
				var subIndex = parseInt($('#subIndex').val());
				var htmlStr = '<tr>';
				htmlStr += '<td><input type="text"  name="conditions['+subIndex+'].conditionName" class="form-control" maxlength="50" /></td>';
				htmlStr += '<td><input type="text"  name="conditions['+subIndex+'].conditionAmount" class="form-control moneyInput" maxlength="8" /></td>';
				htmlStr += '<td><input type="text"  name="conditions['+subIndex+'].subAmount" class="form-control moneyInput" maxlength="8" /></td>';
				htmlStr += '</tr>';
				$('#subIndex').val(subIndex+1);
				$('#subTbody').append(htmlStr);
			} else if($promotionType == "1"){
				var discountIndex = parseInt($('#discountIndex').val());
				var htmlStr = '<tr>';
				htmlStr += '<td><input type="text"   name="conditions['+discountIndex+'].conditionName" class="form-control" maxlength="50" /></td>';
				htmlStr += '<td><input type="text"   name="conditions['+discountIndex+'].conditionAmount" class="form-control moneyInput" maxlength="8" /></td>';
				htmlStr += '<td><input type="text"   name="conditions['+discountIndex+'].subAmount" class="form-control moneyInput" maxlength="8" /></td>';
				htmlStr += '<td><input type="text"   name="conditions['+discountIndex+'].capAmount" class="form-control moneyInput" maxlength="8" /></td>';
				htmlStr += '</tr>';
				$('#discountIndex').val(discountIndex+1);
				$('#discountTbody').append(htmlStr);
			}
			$(".moneyInput").keyup(function () {
	            var reg = $(this).val().match(/\d+\.?\d{0,2}/);
	            var txt = '';
	            if (reg != null) {
	                txt = reg[0];
	            }
	            $(this).val(txt);
	        }).change(function () {
	            $(this).keypress();
	            var v = $(this).val();
	            if (/\.$/.test(v)){
	            	$(this).val(v.substr(0, v.length - 1));
	            }
	        });
		});
	
		$('#deleteLastCondition').bind('click',function(){
			var $promotionType = $('select[name="promotionType"]').val();
			if($promotionType == "0"){
				var subIndex = parseInt($('#subIndex').val());
				if(subIndex > 0){
					$('#subIndex').val(subIndex-1);
				}
				$('#subTbody').find("tr").last().remove();
			} else if($promotionType == "1"){
				var discountIndex = parseInt($('#discountIndex').val());
				if(discountIndex > 0){
					$('#discountIndex').val(discountIndex-1);
				}
				$('#discountTbody').find("tr").last().remove();
			}
		});
		
		
		$("#backBtn").on("click", function(){window.location.href="list.jhtml";});
		
		$("#submitBtn").on("click", function(){
			$("#defaultForm").data("bootstrapValidator").validate();
			if(!$("#defaultForm").data('bootstrapValidator').isValid()) {  
       	 		return;
    		}  
			var sDate = new Date($("#startTime").val().replace(/\-/g, "\/"));
    		var eDate = new Date($("#endTime").val().replace(/\-/g, "\/"));
		    if(sDate > eDate){
		    	$.message({content:"结束日期不能小于开始日期!"});
		    	return;
		    }
		    
		    $.ajax({
				url: "/promotion/update.jhtml",
				type: "POST",
				data: $("#defaultForm").serialize(),
				dataType: "json",
				cache: false,
				success: function(message) {
					$.message(message);
					if (message.type == "success") {
						setTimeout(function() {
							window.location.href="list.jhtml";
						}, 2000);
					}
				}
			});  
		});
		
		$(".moneyInput").keyup(function () {
            var reg = $(this).val().match(/\d+\.?\d{0,2}/);
            var txt = '';
            if (reg != null) {
                txt = reg[0];
            }
            $(this).val(txt);
        }).change(function () {
            $(this).keypress();
            var v = $(this).val();
            if (/\.$/.test(v)){
            	$(this).val(v.substr(0, v.length - 1));
            }
        });
	});


</script>
</html>