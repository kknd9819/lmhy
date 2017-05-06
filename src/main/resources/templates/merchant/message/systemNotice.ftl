<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>云生源互联网金融平台-系统通知</title>
    [#include "/include/inc_css.ftl" /]
     <link href="/resources/datatables/css/dataTables.bootstrap.css" rel="stylesheet">
    <link href="/resources/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
	[#include "/include/inc_js.ftl" /]
</head>
[#include "/include/inc_nav.ftl" /]
<body>
    <div class="wrapper">
    	<div id="page-wrapper">
    		<div class="row">
            	<div class="col-lg-12"><h4 class="page-header">消息--系统通知</h4></div>
            </div>
            
            <div class="row">
            	<div class="col-lg-12">
            		<form id="queryForm" method="post">
            			<div class="panel panel-default">
		            		<div class="panel-body">
		            			<div class="row">
		            				<div class="form-group col-lg-4">
		            					<label>标题名:</label>
		            					<input type="text" id="searchKey" name="searchKey" class="form-control" placeholder="请输入标题名">
		            				</div>
		            				<div class="form-group col-lg-4">
		            					<label>消息状态:</label>
		            					<select class="form-control" id="isRead" name="isRead">
                                    		<option value="true">已读</option>
                                    		<option value="false" selected="true">未读</option>
                                    	</select>
		            				</div>
		            			</div>
		            		</div>
		            	</div>
            		</form>
            		<div class="panel panel-default">
            			<div class="panel-body">
            				<div class="row-fluid">
            					<div class="pull-right">
							        <div class="btn-group">
							            <button type="button" class="btn btn-primary btn-sm" id="btn-delAll">
							                <i class="fa fa-remove"></i>&nbsp;批量删除
							            </button>
							            <button type="button" class="btn btn-primary btn-sm" id="btn-re">
							                <i class="fa fa-refresh"></i>&nbsp;刷新
							            </button>
							        </div>
							    </div>
            				</div>
            				<table width="100%" class="table table-striped table-bordered table-hover nowrap" id="noticeTable">
                                <thead>
	                                <tr>
	                                	<th data="id"><input type="checkbox" class="checkall" id="checkAll" /></th>
	                                    <th data="title" data-priority="1">标题</th>
	                                    <th data="content">内容</th>
	                                    <th data="sendDate" orderable="send_date">时间</th>
	                                    <th data-priority="2">操作</th>
	                                </tr>
                                </thead>
                            </table>
            			</div>
            		</div>
            	</div>
            </div>
            
    	</div><!-- page-wrapper end-->
    </div><!-- wrapper end-->
</body>

<!-- DataTables JavaScript -->
<script src="/resources/datatables/js/jquery.dataTables.min.js"></script>
<script src="/resources/datatables/js/dataTables.bootstrap.min.js"></script>
<script src="/resources/datatables-responsive/dataTables.responsive.js"></script>
<script src="/resources/dist/js/list.js"></script>
<!-- Page-Level Demo Scripts - Tables - Use for reference -->

<script type="text/javascript">
		var tables;
    	$(function(){
    		$("#btn-delAll").hide();
    		var columns = [{
    			targets:0,
	            "render": function (data) {
	            	return '<input type="checkbox" name="ids" class="checkchild"  value="' + data + '" />';
	            }
    		},{
    			targets:2,
    			width:"250px",
	            "render": function (data) {
	            	if(data.length > 20){
	            		return data.substring(0,20)+"...";
	            	}
	            	return data;
	            }
    		},{
    			targets:4,
    			"render":function(data){
    				var buttonHtml = '';
    				if(data.receiverRead == ''){
    					buttonHtml = '<a href="javascript:showMessageContent('+data.id+')" style="text-align:center;">查看</a>';
		            } else {
		            	buttonHtml = '<a href="javascript:showMessageContent('+data.id+')" style="text-align:center;">查看</a>&nbsp;&nbsp;';
		            	buttonHtml+= '<a href="javascript:remove('+data.id+')" style="text-align:center;">删除</a>';
		            }
		            return buttonHtml;
    			}
    		}];
    		tables = $.initTable("#noticeTable","/merchant/message/list.jhtml",function(param){
				var formData = $("#queryForm").serializeArray();
				formData.forEach(function(e){
					param[e.name] = e.value;
				});
    		},columns);
			
			//刷新
	        $("#btn-re").on("click", function () {
	            tables.draw(false);//刷新保持分页状态
	        });
	        
	        //checkbox全选
		     $("#checkAll").on("click", function () {
		     	if ($(this).prop("checked") === true) {
		        	$("input[name='ids']").prop("checked", $(this).prop("checked"));
		            $(this).hasClass('selected')
		        } else {
		            $("input[name='checkList']").prop("checked", false);
		            $("input[name='ids']").prop("checked", false);
		        }
		     });
	        
	        //下拉框选中
	        $("#isRead").change(function(){
	        	if($(this).val() == 'true'){
	        		$("#btn-delAll").show();
	        	}else{
	        		$("#btn-delAll").hide();
	        	}
	        	tables.ajax.reload();
	            tables.draw();//查询后不需要保持分页状态，回首页
	        });
	        
	        //关键字查询
	        $("#searchKey").keyup(function(){
	        	tables.ajax.reload();
	            tables.draw();//查询后不需要保持分页状态，回首页
	        });
	        
	        //批量删除
	        $("#btn-delAll").on("click", function () {
	 			var checkbox = $("input[name='ids']");
	 			var checkboxValue = "";
	 			checkbox.each(function(e){
	 				if(checkbox[e].checked){
	 					checkboxValue += checkbox[e].value+",";
	 				}
	 			});
	 			if(checkboxValue == ""){
	 				$.message({content:"请至少选择一行!"});
	 				return;
	 			}
	 			remove(checkboxValue);
	        });
		});
		
		function remove(ids){
			$.message({content:"确定要删除选中的通知?",otherButtons:["确定"]});
	        $("#confirm").click(function(){
				$.ajax({
		 			url :"removeMsg.jhtml",
		 			type:"post",
		 			data:{ids:ids},
		 			success : function(data){
		 				if(data.type == 'success'){
		 					$.message({content:"已删除!"});
		 				} else {
		 					$.message({content:"删除未成功!"});
		 				}
		 				tables.draw(false);//刷新保持分页状态
		 			}
		 		});
	 		});
		}
		
		function showMessageContent(id){
			$.ajax({
				url : "showMessage.jhtml",
				type : "post",
				data : {id:id,isRead:$("#isRead").val()},
				success : function(data){
					$.message({content:data.content});
					tables.draw(false);//刷新保持分页状态
				}
			});
		}
		
    	function formatDate(now) { 
			var year=now.getFullYear(); 
			var month=now.getMonth()+1; 
			var date=now.getDate(); 
			//var hour=now.getHours(); 
			//var minute=now.getMinutes(); 
			//var second=now.getSeconds();
			return year+"-"+month+"-"+date; 
		} 
    </script>
</html>


