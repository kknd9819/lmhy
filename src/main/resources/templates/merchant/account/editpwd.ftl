<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <title>云生源互联网金融平台-密码修改</title>
    
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
                    <h1 class="page-header">密码修改</h1>
                </div>
            </div>
           	<!-- row end-->
           	
            <!-- row -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class=".container" style="margin-top:50px;width:250%;">
								<form class="form-horizontal" role="form" id="ajaxForm" action="updatePassWord.jhtml" method="post">
								  	<div class="form-group">
									    <label for="oldpass" class="col-sm-2 control-label">旧密码</label>
									    <div class="col-sm-10">
									      <input type="password" class="form-control" style="width:250px;" name="oldpass" id="oldpass" placeholder="请输入旧密码">
									      	<span id="oldpassTip" style="display:none;color:red;"></span>
									    </div>
								  	</div>
								  	<div class="form-group">
									    <label for="newpass" class="col-sm-2 control-label">新密码</label>
									    <div class="col-sm-10">
									      <input type="password" class="form-control" style="width:250px;" name="newpass" id="newpass" placeholder="请输入新密码">
									      <span id="newpassTip" style="display:none;color:red;"></span>
									    </div>
								  	</div>
								  	<div class="form-group">
									    <label for="newpassAgain" class="col-sm-2 control-label">再次确认新密码</label>
									    <div class="col-sm-10">
									      <input type="password" class="form-control" style="width:250px;" name="newpassAgain" id="newpassAgain" placeholder="请再次输入新密码">
									      <span id="newpassAgainTip" style="display:none;color:red;"></span>
									    </div>
								  	</div>
								  <div class="form-group">
								    <label class="col-sm-2 control-label"></label>
								 	<button type="submit"  class="btn btn-primary" id="submit" style="text-align:center;">确认修改</button>
								 	<button type="button" class="btn btn-define" onclick="javascript:history.go(-1);" style="text-align:center;">返回</button>
								  </div>
								</form>
							</div>
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
    <script type="text/javascript">
    $(function(){
    	var oldpass = false;
    	var newpass = false;
    	var newpassAgain = false;
    		$("#oldpass").blur(function(){
    			var oldpass = $("#oldpass").val();
				if(oldpass =='') {
					showError('oldpass', '密码不能为空');
					return;
				}
				$.post("verifyPassWord.jhtml", {oldpass:oldpass}, function(data){
					if(data) {
						$("#oldpass").css({"border-color":"green"});
						$("#oldpassTip").css({"display":"none"});
						oldpass = true;
					} else {
						showError('oldpass', '旧密码错误');
						return;
					}
				});
			});
			$("#newpass").blur(function(){
				var newpass = $("#newpass").val();
				if(newpass.length < 4 || newpass.length > 20){
					showError('newpass', '密码长度必须为4-20位！');
					return;
				}
				if(newpass == '') {
					showError('newpass', '新密码不能为空');
					return;
				} else {
					if(newpass == $("#oldpass").val()){
						showError('newpass', '新密码不能与旧密码相同');
						return;
					}
					$("#newpass").css({"border-color":"green"});
					$("#newpassTip").css({"display":"none"});
					newpass = true;
				}
			});	
			
			$("#newpassAgain").blur(function(){
				var newpass = $("#newpass").val();
				if(newpass == '') {
					showError('newpass', '新密码不能为空');
					return;
				}
				if($(this).val() != newpass) {
					showError('newpassAgain', '与输入的新密码不一致');
					return;
				} else {
					if($(this).val().length < 4 || $(this).val().length > 20){
						showError('newpass', '密码长度必须为4-20位！');
						return;
					}
					$("#newpassAgain").css({"border-color":"green"});
					$("#newpassAgainTip").css({"display":"none"});
					$("#submit").attr("data-toggle","modal");
					$("#submit").attr("data-target","#myModal");
					newpassAgain = true;
				}
			});
			
			$("#ajaxForm").submit(function(){
				var $oldpass = $("#oldpass");
				var $newpass = $("#newpass");
				var $newpassAgain = $("#newpassAgain");
				$oldpass.blur();
				$newpass.blur();
				$newpassAgain.blur();
				if($(".modal-open").length > 0){
	    			return false;
	    		}
				if(!oldpass && !newpass && !newpassAgain){
					return false;
				}
				$.ajax({
	    			url:$(this).attr('action'),
	    			data:$(this).serializeArray(),
	    			type:"post",
	    			success : function(data){
	    				if(data.type == 'success'){
	    					$.message({content:"修改成功~"});
	    					$oldpass.val("");
	    					$newpass.val("");
	    					$newpassAgain.val("");
	    				} else {
	    					$.message({content:"好像修改失败了呢~"});
	    					$oldpass.val("");
	    					$newpass.val("");
	    					$newpassAgain.val("");
	    				}
	    			}
	    		});
				return false;
			});
			
			$("#modalButton").click(function(){
		    	if($("#submitState").val() == 'success'){
		    		location = "index.jhtml";
		    	}
	    	});
			
    	});
    	function showError(formSpan, errorText) {
			$("#" + formSpan).css({"border-color":"red"});
			$("#" + formSpan + "Tip").empty();
			$("#" + formSpan + "Tip").append(errorText);;
			$("#" + formSpan + "Tip").css({"display":"inline"});
		}
    </script>
</body>
</html>