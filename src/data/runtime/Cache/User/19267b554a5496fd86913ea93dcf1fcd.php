<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html style="height:100%">
<head>
<title><?php echo ($site_name); ?></title>
<meta name="keywords" content="<?php echo ($site_seo_keywords); ?>" />
<meta name="description" content="<?php echo ($site_seo_description); ?>">
<meta name="author" content="ThinkCMF">
<link rel="stylesheet" href="/hospital_end/src/public/css/index.css">
</head>
<body style="height:100%">
	<div class="login-index clearfix">
		<div class="container tc-main">
			<div class="index-logobox">
				<img src="/hospital_end/src/public/images/Login-logo.png" alt="">111
			</div>
			<div class="row">
					<p class="text-center"><?php echo L("STAFF_LOGIN");?></p>
					<form class="form-horizontal js-ajax-form" action="<?php echo U('user/login/dologin');?>" method="post">
						<div class="control-group firstDiv">
							<input type="text" id="input_username" name="username" placeholder="<?php echo L('MOBILE_MAIL');?>" class="span4" onkeyup="this.value=this.value.replace(/[^\x00-\xff]/g, '')">
						</div>

						<div class="control-group">
							<input type="password" id="input_password" name="password" placeholder="<?php echo L('PASSWORD');?>" class="span4" onkeyup="this.value=this.value.replace(/[^\x00-\xff]/g, '')">
						</div>

						<div class="control-group">
							<div class="span4 verifyBox">
								<input type="text" id="input_verify" name="verify"  placeholder="<?php echo L('VERIFY_CODE');?>" style="width:40%;" required maxlength="4" onkeyup="this.value=this.value.replace(/[^\x00-\xff]/g, '')">
								<?php echo sp_verifycode_img('length=4&font_size=14&width=100&height=34&charset=2345678&use_noise=1&use_curve=0');?>
							</div>
							
						</div>

						<div class="control-group loginBtn">
							<button class="btn btn-primary js-ajax-submit span4" type="submit"><?php echo L("LOGIN");?></button>
						</div>

						<div class="control-group" style="text-align: center;">
							<ul class="inline">
								<!-- <li><a href="<?php echo leuu('user/register/index');?>">现在注册</a></li> -->
								<!-- <li><a href="<?php echo U('user/login/forgot_password');?>">忘记密码</a></li> -->
							</ul>
						</div>
					</form>
				</div>
		</div>
	</div>
	
	<!-- /container -->

	<script type="text/javascript">
//全局变量
var GV = {
    ROOT: "/hospital_end/src/",
    WEB_ROOT: "/hospital_end/src/",
    JS_ROOT: "public/js/"
};
</script>
   <!-- Placed at the end of the document so the pages load faster -->
   <script src="/hospital_end/src/public/js/jquery.js"></script>
   <script src="/hospital_end/src/public/js/wind.js"></script>
   <script src="/hospital_end/src/public/js/noty/noty.js"></script>
   <script src="/hospital_end/src/themes/simplebootx/Public/assets/simpleboot/bootstrap/js/bootstrap.min.js"></script>
   <script src="/hospital_end/src/public/js/frontend.js"></script>
<script>
$(function(){
	$('body').on('touchstart.dropdown', '.dropdown-menu', function (e) { e.stopPropagation(); });
	
	$("#main-menu li.dropdown").hover(function(){
		$(this).addClass("open");
	},function(){
		$(this).removeClass("open");
	});
	
	$.post("<?php echo U('user/index/is_login');?>",{},function(data){
		if(data.status==1){
			if(data.user.avatar){
				$("#main-menu-user .headicon").attr("src",data.user.avatar.indexOf("http")==0?data.user.avatar:"<?php echo sp_get_image_url('[AVATAR]','!avatar');?>".replace('[AVATAR]',data.user.avatar));
			}
			
			$("#main-menu-user .user-nicename").text(data.user.user_nicename!=""?data.user.user_nicename:data.user.user_login);
			$("#main-menu-user li.login").show();
			
		}
		if(data.status==0){
			$("#main-menu-user li.offline").show();
		}
		
		/* $.post("<?php echo U('user/notification/getLastNotifications');?>",{},function(data){
			$(".nav .notifactions .count").text(data.list.length);
		}); */
		
	});	
	;(function($){
		$.fn.totop=function(opt){
			var scrolling=false;
			return this.each(function(){
				var $this=$(this);
				$(window).scroll(function(){
					if(!scrolling){
						var sd=$(window).scrollTop();
						if(sd>100){
							$this.fadeIn();
						}else{
							$this.fadeOut();
						}
					}
				});
				
				$this.click(function(){
					scrolling=true;
					$('html, body').animate({
						scrollTop : 0
					}, 500,function(){
						scrolling=false;
						$this.fadeOut();
					});
				});
			});
		};
	})(jQuery); 
	
	$("#backtotop").totop();
	
	
});
</script>


</body>
<script>
$(function(){
	$("input[name='verify']").on("blur",function(){
		var verify = $("input[name='verify']").val();
		if(verify !=""){$("input[name='verify']").removeClass("errorInput");}
	});
	$(".btn").on("click",function(){
		var verify = $("input[name='verify']").val();
		if(verify == ""){
			noty({
				text: "<?php echo L('VERIFY_CODE_NULL');?>",
	            type:"error",
	            layout:"center"
			});
			$("input[name='verify']").addClass("errorInput");
		}
		
	});
});
</script>
</html>