<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <title>云生源互联网金融平台-账户管理</title>
    
    [#include "/include/inc_css.ftl" /]
    <link href="/resources/morrisjs/morris.css" rel="stylesheet">
</head>
<body>
	<div id="wrapper">
	[#include "/include/inc_nav.ftl" /]
		<div id="page-wrapper">
			<!-- row -->
			<div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">账户管理</h1>
                </div>
            </div>
           	<!-- row end-->
           	
            <!-- row -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class=".container" style="margin-top:50px;width:250%;">
								<form  class="form-horizontal" role="form" action="updateAccount.jhtml"  method="get" id="ajaxForm">
								<div class="form-group">
                                    <label for="oldpass" class="col-sm-2 control-label">所属商家：</label>
                                    <div class="col-sm-10">
                                	  <input class="form-control" style="width:250px;" value="${account.fullName}" disabled>
                                	</div>
                               	</div>
                               	<div class="form-group">
                                    <label for="oldpass" class="col-sm-2 control-label">用户名：</label>
                                    <div class="col-sm-10">
                                    	<input class="form-control" style="width:250px;" value="${account.username}" disabled>
                                    </div>
                               	</div>
                               	<div class="form-group">
                                    <label for="oldpass" class="col-sm-2 control-label">昵称：</label>
                                    <div class="col-sm-10">
                                		<input class="form-control" style="width:250px;" name="storeName" value="${account.storeName}">
                                	</div>
                               	</div>
                               	<div class="form-group">
                               		<label class="col-sm-2 control-label"></label>
									<button type="submit" class="btn btn-primary"  data-toggle="modal" data-target="#myModal">保存</button>
									<button class="btn" onclick="javascript:history.go(-1);">返回</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!--row end-->
		</div>
	</div>
 	[#include "/include/inc_js.ftl" /]
    <script type="text/javascript" src="/resources/raphael/raphael.min.js"></script>
    <script type="text/javascript" src="/resources/morrisjs/morris.min.js"></script>
    <script type="text/javascript" src="/resources/morris-data.js"></script>
    <script type="text/javascript" src="/resources/dist/js/sb-admin-2.js"></script>
    <script type="text/javascript">
	    $(function(){
	    	$("#ajaxForm").submit(function(){
	    		if($(".modal-open").length > 0){
	    			return false;
	    		}
	    		$.ajax({
	    			url:$(this).attr('action'),
	    			data:$(this).serializeArray(),
	    			type:"get",
	    			success : function(data){
	    				if(data.type == 'success'){
	    					$.message({content:"修改成功!"});
	    				} else {
	    					$.message({content:"修改失败!"});
	    				}
	    			}
	    		});
	    		return false;
	    	});
	    });
	</script>
</body>
</html>