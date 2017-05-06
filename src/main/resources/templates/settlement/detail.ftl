<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>云生源互联网金融平台-对账-账期汇总</title>

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

        });
    </script>
    <style>
        .row{
            margin-bottom: 15px;
        }
    </style>
</head>

<body>
<div id="wrapper">
[#include "/include/inc_nav.ftl" /]
    <div id="page-wrapper">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12"><h4 class="page-header">对账--账期汇总</h4></div>
            </div>

            <h4 style="color: #b52b27">当前账期的数据情况实时统计</h4>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="row">
                                <label for="startDateYYYYMMDD" class="col-lg-1">开始日期:</label>
                                <div class="col-lg-2">
                                    ${monitor.startDateYYYYMMDD}
                                </div>
                                <label for="endDateYYYYMMDD" class="col-lg-1">结束日期:</label>
                                <div class="col-lg-2">
                                    ${monitor.endDateYYYYMMDD}
                                </div>
                                <label for="accumulationAmount" class="col-lg-1 control-label">额度累计:</label>
                                <div class="col-lg-2">
                                    ${monitor.accumulationAmount}
                                </div>
                            </div>
                            <div class="row">
                                <label for="appPay" class="col-lg-1 control-label">APP支付:</label>
                                <div class="col-lg-2">
                                   ${monitor.appPay}
                                </div>
                                <label for="scanPay" class="col-lg-1 control-label">扫码支付:</label>
                                <div class="col-lg-2">
                                    ${monitor.scanPay}
                                </div>
                                <label for="facePay" class="col-lg-1 control-label">买单支付:</label>
                                <div class="col-lg-2">
                                    ${monitor.facePay}
                                </div>
                            </div>
                            <div class="row">
                                <label for="balance" class="col-lg-1 control-label">余额:</label>
                                <div class="col-lg-2">
                                    ${monitor.balance}
                                </div>
                                <label for="money" class="col-lg-1 control-label">理财通:</label>
                                <div class="col-lg-2">
                                   ${monitor.money}
                                </div>
                                <label for="card" class="col-lg-1 control-label">一卡通:</label>
                                <div class="col-lg-2">
                                   ${monitor.card}
                                </div>
                            </div>
                            <div class="row">
                                <label for="orders" class="col-lg-1">订单数量:</label>
                                <div class="col-lg-2">
                                   ${monitor.orders}
                                </div>
                                <label for="successOrders" class="col-lg-1 control-label">成交订单:</label>
                                <div class="col-lg-2">
                                   ${monitor.successOrders}
                                </div>
                                <label for="refundOrders" class="col-lg-1 control-label">退款订单:</label>
                                <div class="col-lg-2">
                                   ${monitor.refundOrders}
                                </div>
                            </div>
                            <div class="row">
                                <label for="amount" class="col-lg-1 control-label">已收金额:</label>
                                <div class="col-lg-2">
                                    ${monitor.amount}
                                </div>
                                <label for="refundAmount" class="col-lg-1 control-label">退款金额:</label>
                                <div class="col-lg-2">
                                   ${monitor.refundAmount}
                                </div>
                                <label for="currentDays" class="col-lg-1">已过几天:</label>
                                <div class="col-lg-2">
                                   ${monitor.currentDays}
                                </div>
                            </div>
                            <div class="row">
                                <label for="onlyPaymentAmount" class="col-lg-1 control-label">支付净额:</label>
                                <div class="col-lg-2">
                                   ${monitor.onlyPaymentAmount}
                                </div>
                                <label for="feeAmount" class="col-lg-1 control-label">手续费:</label>
                                <div class="col-lg-2">
                                   ${monitor.feeAmount}
                                </div>
                                <label for="actualAmount" class="col-lg-1">划账金额:</label>
                                <div class="col-lg-2">
                                    ${monitor.actualAmount}
                                </div>
                            </div>




                            [#--<div class="row">--]
                                [#--<label for="startDateYYYYMMDD" class="col-lg-1">开始日期:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="startDateYYYYMMDD" readonly="readonly" value="${monitor.startDateYYYYMMDD}">--]
                                [#--</div>--]
                                [#--<label for="endDateYYYYMMDD" class="col-lg-1">结束日期:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="endDateYYYYMMDD" readonly="readonly" value="${monitor.endDateYYYYMMDD}">--]
                                [#--</div>--]
                                [#--<label for="accumulationAmount" class="col-lg-1 control-label">额度累计:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="accumulationAmount" readonly="readonly" value="${monitor.accumulationAmount}">--]
                                [#--</div>--]
                            [#--</div>--]
                            [#--<div class="row">--]
                                [#--<label for="appPay" class="col-lg-1 control-label">APP支付:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="appPay" readonly="readonly" value="${monitor.appPay}">--]
                                [#--</div>--]
                                [#--<label for="scanPay" class="col-lg-1 control-label">扫码支付:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="scanPay" readonly="readonly" value="${monitor.scanPay}">--]
                                [#--</div>--]
                                [#--<label for="facePay" class="col-lg-1 control-label">买单支付:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="facePay" readonly="readonly" value="${monitor.facePay}">--]
                                [#--</div>--]
                            [#--</div>--]
                            [#--<div class="row">--]
                                [#--<label for="balance" class="col-lg-1 control-label">余额:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="balance" readonly="readonly" value="${monitor.balance}">--]
                                [#--</div>--]
                                [#--<label for="money" class="col-lg-1 control-label">理财通:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="money" readonly="readonly" value="${monitor.money}">--]
                                [#--</div>--]
                                [#--<label for="card" class="col-lg-1 control-label">一卡通:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="card" readonly="readonly" value="${monitor.card}">--]
                                [#--</div>--]
                            [#--</div>--]
                            [#--<div class="row">--]
                                [#--<label for="orders" class="col-lg-1">订单数量:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="orders" readonly="readonly" value="${monitor.orders}">--]
                                [#--</div>--]
                                [#--<label for="successOrders" class="col-lg-1 control-label">成交订单:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="successOrders" readonly="readonly" value="${monitor.successOrders}">--]
                                [#--</div>--]
                                [#--<label for="refundOrders" class="col-lg-1 control-label">退款订单:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="refundOrders" readonly="readonly" value="${monitor.refundOrders}">--]
                                [#--</div>--]
                            [#--</div>--]
                            [#--<div class="row">--]
                                [#--<label for="amount" class="col-lg-1 control-label">已收金额:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="amount" readonly="readonly" value="${monitor.amount}">--]
                                [#--</div>--]
                                [#--<label for="refundAmount" class="col-lg-1 control-label">退款金额:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="refundAmount" readonly="readonly" value="${monitor.refundAmount}">--]
                                [#--</div>--]
                                [#--<label for="currentDays" class="col-lg-1">已过几天:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="currentDays" readonly="readonly" value="${monitor.currentDays}">--]
                                [#--</div>--]
                            [#--</div>--]
                            [#--<div class="row">--]
                                [#--<label for="onlyPaymentAmount" class="col-lg-1 control-label">支付净额:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="onlyPaymentAmount" readonly="readonly" value="${monitor.onlyPaymentAmount}">--]
                                [#--</div>--]
                                [#--<label for="feeAmount" class="col-lg-1 control-label">手续费:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="feeAmount" readonly="readonly" value="${monitor.feeAmount}">--]
                                [#--</div>--]
                                [#--<label for="actualAmount" class="col-lg-1">划账金额:</label>--]
                                [#--<div class="col-lg-2">--]
                                    [#--<input type="text" class="form-control"  name="actualAmount" readonly="readonly" value="${monitor.actualAmount}">--]
                                [#--</div>--]
                            [#--</div>--]

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
