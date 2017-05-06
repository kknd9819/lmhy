<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>云生源互联网金融平台-对账-财务结算</title>

[#include "/include/inc_css.ftl" /]
    <link href="/resources/datatables/css/dataTables.bootstrap.css" rel="stylesheet">
    <link href="/resources/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
    <link href="/resources/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
[#include "/include/inc_js.ftl" /]
    <script src="/resources/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/resources/datatables/js/dataTables.bootstrap.min.js"></script>
    <script src="/resources/datatables-responsive/dataTables.responsive.js"></script>
    <script src="/resources/dist/js/list.js"></script>
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
                $("#startTimeDiv").datetimepicker('setEndDate',endTime);
                $("#endTimeDiv").datetimepicker('setStartDate',startTime);
            });


            var columnDefs = [{
                targets: 10,
                render: function (data, type, row, meta) {
                    // 参考http://datatables.club/reference/option/columns.render.html
                    var content = '';
                    if(data.settlementStatus == 0 || data.settlementStatus == 3){
                        content = ' <a rid="'+row.id+'" class="table_edit_a" href="/settlement/apply.jhtml?settlementId='+data.id+'">申请结算</a> ';
                     //   content = " <a data-toggle='modal' data-target='#myModal' href='/settlement/apply.jhtml?settlementId="+data.id+"'>申请结算</a>";
                    } else {
                      //  content = '<a rid="'+row.id+'" class="table_delete_a" href="/settlement/apply.jhtml?settlementId='+data.id+'">等待复核</a> ';
                        content = '';
                    }
                    return content;
                }
            }];
            var dt = $.initTable("#dynamic_msg_table", "/settlement/settlement_list.jhtml", function (param){
                param.word = $('#titleWord').val();
                param.type = $('#typeSelect option:selected').val();
                param.begin = $('#beginTime').val();
                param.end = $('#endTime').val();
            }, columnDefs);

            dt.on("draw", function() {
//                $(".table_edit_a").click(function(){
//                    alert('准备编辑ID：'+$(this).attr("rid")+'的动态');
//                });

                $(".table_delete_a").click(function(){
                    alert('请等待财务审核放款,不要重复申请!');
                });
            });

            $("#search_btn_a").click(function(){
                dt.ajax.reload();
            });

            $("#export_btn_a").click(function(){
                var type = $('#typeSelect option:selected').val();
                var begin = $('#beginTime').val();
                var end = $('#endTime').val();
                window.location.href = "/settlement/export.jhtml?type="+type+"&begin="+begin+"&end="+end+"";
//                $.ajax({
//                    type:"GET",
//                    url:"/settlement/export.jhtml",
//                    data:{type:$('#typeSelect option:selected').val(),begin:$('#beginTime').val(),end:$('#endTime').val()},
//                    dataType: "json"
//                });
            });

            $("#settlement_btn_a").click(function(){

            });
        });
    </script>
</head>

<body>
<div id="wrapper">
[#include "/include/inc_nav.ftl" /]
    <div id="page-wrapper">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12"><h4 class="page-header">对账--账务结算</h4></div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="row">
                                <div class="form-group col-lg-1"><label class="lineheight34">组合检索</label></div>
                            [#--<div class="form-group col-lg-3"><input id="titleWord" type="text" class="form-control" placeholder="标题模糊检索"></div>--]
                                <div class="form-group col-lg-3">
                                    <select id="typeSelect" class="form-control">
                                        <option value="">按状态检索</option>
                                        <option value="0">未申请</option>
                                        <option value="1">待审核</option>
                                        <option value="2">通过审核,待打款</option>
                                        <option value="3">驳回</option>
                                        <option value="4">通过审核,已打款</option>
                                    </select>
                                </div>
                                [#--<div class="form-group col-lg-1">--]
                                    [#--<a data-toggle="collapse" href="#seniorSearch" class="btn btn-link">高级选项</a>--]
                            [#--</div>--]
                            </div>
                            <div id="seniorSearch" class="row">
                                <div class="form-group form-inline col-lg-6 col-md-offset-1">
                                    <div id="startTimeDiv" class="input-group date col-lg-5 form_datetime" data-date-format="yyyy-mm-dd hh:00:00">
                                        <input id="beginTime" name="beginTime" class="form-control" size="16" type="text" value="" placeholder="检索开始时间">
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
                                <div class="form-group col-lg-4 col-lg-offset-1">
                                    <a id="search_btn_a" href="javascript:;" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;搜索</a>
                                    <a id="export_btn_a" href="javascript:;" class="btn btn-primary"><em class="glyphicon glyphicon-export"></em>导出</a>
                                </div>
                            [#--[#if contract?exists && contract.hasNext()]--]
                            [#--<div class="col-lg-3">--]
                            [#--<a id="settlement_btn_a" href="javascript:;" class="btn btn-danger">生成结算单</a>--]
                            [#--</div>--]
                            [#--[/#if]--]
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dynamic_msg_table">
                                <thead>
                                <tr>
                                    <th data="createDateYYYYMMDD" orderable="s.create_date">划账日期</th>
                                    <th data="startDateYYYYMMDD" orderable="s.start_date">开始日期</th>
                                    <th data="endDateYYYYMMDD" orderable="s.end_date">结束日期</th>
                                    <th data="paymentAmount" orderable="s.payment_amount">支付金额</th>
                                    <th data="refundAmount" orderable="s.refund_amount">退款金额</th>
                                    <th data="onlyPaymentAmount" orderable="s.only_payment_amount">支付净额</th>
                                    <th data="feeAmount" orderable="s.fee_amount">手续费</th>
                                    <th data="amount" orderable="s.amount">划账金额</th>
                                    <th data="settlementStatusName" center="center">状态</th>
                                    <th data="haveMoneyDateYYYYMMDD" orderable="s.have_money_date">打款日期</th>
                                    <th center="center">操作</th>
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
