<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>山西省医院挂号平台</title>
	<link rel="stylesheet" href="/hospital_end/src/public/css/index.css">
	<link rel="shortcut icon" href="/hospital_end/src/public/images/favicon.ico" >
</head>
<body>
	<!-- 头部 -->
	<div class="dbnav">
		<div class="dbnav_context">
			<p class="dbnav_context_left">
				<img src="/hospital_end/src/public/images/dbnav.png" alt=""><span>15111511431电话预约</span>
			</p>
			<p class="dbnav_context_right" id="isLogin">欢迎来到山西省预约挂号平台 请
				<a href="<?php echo U('Login/index');?>" class="db_login">登录</a>
				<a href="<?php echo U('Register/index');?>" class="db_register">注册</a>
			</p>
		</div>
	</div>
	<div class="top">
		<div class="top_left"><a href=""><img src="/hospital_end/src/public/images/logo.png" alt=""></a></div>
		<div class="top_search">
			<form action="" method="get" name="search">
				<div class="option"><span>疾病</span></div>
				<div class="sbox"><input type="text" placeholder="请输入搜索内容" autocomplete="off"></div>
				<div class="sbtn">
					<input type="submit" value="">
				</div>
			</form>
		</div>
	</div>
	<div class="nav">
		<div class="nav_box">
			<ul class="nav_ul">
				<li><a href="<?php echo U('Xing/index');?>">首页</a></li>
				<li><a href="<?php echo U('Xing/diseaseRegistered');?>">按疾病挂号</a></li>
				<li><a href="<?php echo U('Xing/doctorRegistered');?>">按医生挂号</a></li>
				<li><a href="<?php echo U('Xing/visitTheTable');?>">医生出诊表</a></li>
				<li><a href="#">最新公告</a></li>
				<li class="personalCenter nav_color"><a href="<?php echo U('Xing/personalCenter');?>">个人中心</a></li>
			</ul>
		</div>
	</div>
	<!-- 头部结束 -->
	<!-- 主内容区 -->
	<div class="loginBox">
		<div class="leftLogin">
			<form action="">
				<div class="formgroup">
					<label for="loginName">登录名:</label>
					<div class="formInputBox"><input type="text" placeholder="请输入手机号码或者身份证" id="loginName"></div>
				</div>
				<div class="formgroup">
					<label for="userPsd">密码:</label>
					<div class="formInputBox"><input type="password" placeholder="请输入6-16位字符密码" id="userPsd"></div>
				</div>
				<div class="formgroup">
					<label for="verificationCode">验证码:</label>
					<div class="formInputBox"><input type="password" placeholder="请输入验证码" id="verificationCode"></div>
					<img src="" alt="">
				</div>
				<div class="formgroup"><a href="" class="psdBack">找回密码</a></div>
				<div class="loginBtn"><a href="">登录</a></div>
			</form>
		</div>
		<div class="rightLogin">
			<p><span>还没有注册？</span><a href="<?php echo U('Register/index');?>" class="no_register">注册</a></p>
			<div class="loginImgBox"><img src="/hospital_end/src/public/images/reg_ad.jpg" alt=""></div>
		</div>
	</div>
	<!-- 底部 -->
	<div class="index_footer">
		<div class="templatemo_footer">Copyright © 2048 <a href="#">山西省医院</a> | Template from wuxin</div>
	</div>
</body>
<script src="/hospital_end/src/public/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/hospital_end/src/public/js/jquery.page.js"></script>
<script>
	$(function(){
		$(".agreementHead").on("click",function(){
			var result = $(".agreementContent").css("display");
			if(result == "none"){
				 $(".agreementContent").css("display","block");
			}else{
				 $(".agreementContent").css("display","none");
			}
		})
	})
</script>
</html>