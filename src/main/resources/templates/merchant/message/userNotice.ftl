<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>云生源互联网金融平台-用户评价</title>
    [#include "/include/inc_css.ftl" /]
    <link href="/resources/datatables/css/dataTables.bootstrap.css" rel="stylesheet">
    <link href="/resources/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
    <link href="/resources/lightbox/css/lightbox.css" rel="stylesheet">
	[#include "/include/inc_js.ftl" /]
</head>
[#include "/include/inc_nav.ftl" /]
<body>
    <div class="wrapper">
        <div id="page-wrapper">
        	<div class="container-fluid">
        		<div class="row">
            		<div class="col-lg-12"><h4 class="page-header">消息--用户评价</h4></div>
            	</div>
            	<div class="row">
                <div class="col-lg-12">
                	<!-- 搜索条件 -->
                	<div class="panel panel-default">
                		<div class="panel-body">
                			<form id="queryForm" method="post">
	                			<div class="row">
								    <div class="form-group col-lg-4">
		            					<label>用户昵称:</label>
		            					<input type="text"  id="nickName" name="nickName" class="form-control" placeholder="请输入用户昵称">
		            				</div>
								    
	                			</div>
                			</form>
                		</div>
                	</div>
                	<!-- 搜索条件end -->
                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="row-fluid">
                        		<div class="pull-right">
							        <div class="btn-group">
							        	<button type="button" class="btn btn-primary btn-sm" id="btn-delAll">
							                <i class="fa fa-remove"></i>&nbsp;删除
							            </button>
							            <button type="button" class="btn btn-primary btn-sm" id="btn-re">
							                <i class="fa fa-refresh"></i>&nbsp;刷新
							            </button>
							        </div>
							    </div>
                            <table width="100%" class="table table-striped table-bordered table-hover" id="noticeTable">
                                <thead>
	                                <tr>
	                                	<th data="id"><input type="checkbox" class="checkall" id="checkAll" /></th>
	                                	<th data="nickName" >会员昵称</th>
	                                	<th data="content">评论内容</th>
	                                	<th data="reviewImages">评论图片</th>
	                                	<th data="createDate" orderable="create_date">评论时间</th>
	                                	<th data="score" orderable="score">评分</th>
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
</body>
<!-- DataTables JavaScript -->
<script src="/resources/datatables/js/jquery.dataTables.min.js"></script>
<script src="/resources/datatables/js/dataTables.bootstrap.min.js"></script>
<script src="/resources/datatables-responsive/dataTables.responsive.js"></script>
<script src="/resources/dist/js/list.js"></script>
<script src="/resources/lightbox/js/lightbox.js"></script>
<!-- Page-Level Demo Scripts - Tables - Use for reference -->
<script type="text/javascript">
	var tables;
	$(function(){
		var columns = [{
			targets:0,
			"render":function(data){
				return '<input type="checkbox" name="ids" class="checkchild"  value="' + data + '" />';
			}
		},{
			targets:3,
			"render":function(data){
				var imgHtml = "";
				if(data != ""){
					for(var i in data){
						if(i == 0){
							imgHtml = '<a href="'+data[i].source+'" class="lightbox-link" data-lightbox="'+data[i].reviewId+'">查看</a>';
						} else if(i > 0){
							imgHtml += '<a href="'+data[i].source+'" style="background-color:hidden;" class="lightbox-link" data-lightbox="'+data[i].reviewId+'"></a>';
						}
					}
				} else {
					imgHtml = "-";
				}
				return imgHtml;
    		}
		},{
			targets:5,
			"render":function(data){
				var scoreHtml = "";
				for(var i = 1; i <= data; i++ ){
					scoreHtml += "<i class='glyphicon glyphicon-heart'></i>";
				}
				for(var i = 1; i <= 5-data; i++ ){
					scoreHtml += "<i class='glyphicon glyphicon-heart-empty'></i>";
				}
				return scoreHtml;
			}
		}];
		tables = $.initTable("#noticeTable","userList.jhtml",function(param){
				var formData = $("#queryForm").serializeArray();
				formData.forEach(function(e){
					param[e.name] = e.value;
				});
    		},columns);
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
	     //刷新
	     $("#btn-re").on("click", function () {
	     	tables.draw(false);//刷新保持分页状态
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
	        
	        //查询
	        $("#nickName").keyup(function(){
	        	tables.ajax.reload();
	            tables.draw();//查询后不需要保持分页状态，回首页
	        });
	});
	
	function notice(content){
		$.message({content:content});
	}
	
	function remove(ids){
		$.message({content:"确定要删除选中的通知?",otherButtons:["确定"]});
	    $("#confirm").click(function(){
			$.ajax({
		 		url :"removeNotice.jhtml",
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
</script>
</html>


