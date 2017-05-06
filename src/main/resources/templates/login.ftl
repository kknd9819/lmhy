<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>云生源互联网金融平台-商家登录</title>

    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/metisMenu/metisMenu.min.css" rel="stylesheet">
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="/resources/maxcdn/html5shiv.js"></script>
    <script src="/resources/maxcdn/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="login-panel panel panel-default">
                <div class="panel-heading"><h3 class="panel-title">联盟商家登录</h3></div>
                <div class="panel-body">
                    <form role="form" action="login.jsp">
                        <fieldset>
                            <div class="form-group">
                                <input id="username" class="form-control" placeholder="请输入用户名" type="mobile" autofocus>
                            </div>
                            <div class="form-group">
                                <input id="password" class="form-control" placeholder="请输入密码" type="password" value="">
                            </div>
                            <div class="form-inline">
                                <input id="captcha" class="form-control" placeholder="验证码" type="text" value="">
                                <img id="captchaImage" src="/common/captchaImage.jhtml" title="点击刷新" />
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input id="isRememberUsername" type="checkbox" value="Remember Me">记住用户名
                                </label>
                            </div>
                            <a id="loginBtn" href="javascript:;" class="btn btn-lg btn-success btn-block">登录</a>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/resources/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/resources/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="/resources/rsa/jsbn.js"></script>
<script type="text/javascript" src="/resources/rsa/prng4.js"></script>
<script type="text/javascript" src="/resources/rsa/rng.js"></script>
<script type="text/javascript" src="/resources/rsa/rsa.js"></script>
<script type="text/javascript" src="/resources/rsa/base64.js"></script>
<script type="text/javascript" src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/metisMenu/metisMenu.min.js"></script>
<script type="text/javascript" src="/resources/dist/js/sb-admin-2.js"></script>
<script type="text/javascript" src="/resources/dist/js/login.js"></script>

</body>

</html>