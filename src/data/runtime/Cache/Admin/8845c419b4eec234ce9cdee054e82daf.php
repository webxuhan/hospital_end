<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<!-- Set render engine for 360 browser -->
	<meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- HTML5 shim for IE8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <![endif]-->

	<link href="/appoint/src/public/simpleboot/themes/<?php echo C('SP_ADMIN_STYLE');?>/theme.min.css" rel="stylesheet">
    <link href="/appoint/src/public/simpleboot/css/simplebootadmin.css" rel="stylesheet">
    <link href="/appoint/src/public/js/artDialog/skins/default.css" rel="stylesheet" />
    <link href="/appoint/src/public/simpleboot/font-awesome/4.4.0/css/font-awesome.min.css"  rel="stylesheet" type="text/css">
	<script src="/appoint/src/public/simpleboot/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"></script>
	<script src="/appoint/src/public/simpleboot/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"></script>
	<script src="/appoint/src/public/simpleboot/bootstrap/css/bootstrapValidator.css" rel="stylesheet" type="text/css"></script>
    <style>
		form .input-order{margin-bottom: 0px;padding:3px;width:40px;}
		.table-actions{margin-top: 5px; margin-bottom: 5px;padding:0px;}
		.table-list{margin-bottom: 0px;}
	</style>
	<!--[if IE 7]>
	<link rel="stylesheet" href="/appoint/src/public/simpleboot/font-awesome/4.4.0/css/font-awesome-ie7.min.css">
	<![endif]-->
	<script type="text/javascript">
	//全局变量
	var GV = {
	    ROOT: "/appoint/src/",
	    WEB_ROOT: "/appoint/src/",
	    JS_ROOT: "public/js/",
	    APP:'<?php echo (MODULE_NAME); ?>'/*当前应用名*/
	};
	</script>
    <script src="/appoint/src/public/js/jquery.js"></script>
    <script src="/appoint/src/public/js/wind.js"></script>
    <script src="/appoint/src/public/simpleboot/bootstrap/js/bootstrap.min.js"></script>
	
	<script src="/appoint/src/public/simpleboot/bootstrap/js/bootstrapValidator.js"></script>
	<script src="/appoint/src/public/simpleboot/bootstrap/js/language/zh_CN.js"></script>
	
    <script>
    	$(function(){
    		$("[data-toggle='tooltip']").tooltip();
    	});
    </script>
<?php if(APP_DEBUG): ?><style>
		#think_page_trace_open{
			z-index:9999;
		}
	</style><?php endif; ?>
</head>
<body>
	<div class="wrap">
		<ul class="nav nav-tabs">
			<li><a href="<?php echo U('user/index');?>"><?php echo L('ADMIN_USER_INDEX');?></a></li>
			<li class="active"><a href="<?php echo U('user/add');?>"><?php echo L('ADMIN_USER_ADD');?></a></li>
		</ul>
		<form method="post" class="form-horizontal js-ajax-form" action="<?php echo U('User/add_post');?>">
			<fieldset>
				<div class="control-group">
					<label class="control-label"><?php echo L('USERNAME');?></label>
					<div class="controls form-group">
						<input type="text" name="user_login">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><?php echo L('PASSWORD');?></label>
					<div class="controls form-group">
						<input type="password" name="user_pass">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><?php echo L('EMAIL');?></label>
					<div class="controls form-group">
						<input type="text" name="user_email">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><?php echo L('ROLE');?></label>
					<div class="controls">
						<?php if(is_array($roles)): foreach($roles as $key=>$vo): ?><label class="checkbox inline"><input value="<?php echo ($vo["id"]); ?>" style="position:relative;bottom:3px;" type="radio" name="role_id[]" <?php if(sp_get_current_admin_id() != 1 && $vo['id'] == 1): ?>disabled="true"<?php endif; ?>><?php echo ($vo["name"]); ?></label><?php endforeach; endif; ?>
					</div>
				</div>
			</fieldset>
			<div class="form-actions">
				<button type="submit" class="btn btn-primary js-ajax-submit"><?php echo L('ADD');?></button>
				<a class="btn" href="javascript:history.back(-1);"><?php echo L('BACK');?></a>
			</div>
		</form>
	</div>
	<script src="/appoint/src/public/js/common.js"></script>
</body>
</html>
<script>
		$(document).ready(function(){
			$(".js-ajax-form").bootstrapValidator({
				message: '<?php echo L("IS_NOT_VALID");?>',
				feedbackIcons: {
					valid: 'glyphicon glyphicon-ok',
					invalid: 'glyphicon glyphicon-remove',
					validating: 'glyphicon glyphicon-refresh'
				},
				fields: {
					user_login: {
						message: '<?php echo L("IS_NOT_VALID");?>',
						validators: {
							notEmpty: {
								message: '<?php echo L("NAME_MUST");?>'
							},
							regexp: {
								regexp: /^[a-zA-Z0-9_\u4e00-\u9fa5\-\(\)\（\）]+$/,
								message: '<?php echo L("IS_VALID");?>'
							}
						}
					},
					user_pass: {
						message: '<?php echo L("IS_NOT_VALID");?>',
						validators: {
							notEmpty: {
								message: '<?php echo L("PASSWORD_MUST");?>'
							},
							stringLength: {
								min: 6,
								max: 20,
								message: '<?php echo L("NAME_LENGTH");?>'
							},
							regexp: {
								regexp: /^[a-zA-Z0-9_\u4e00-\u9fa5\-\(\)\（\）]+$/,
								message: '<?php echo L("IS_VALID");?>'
							}
						}
					},
					user_email:{
                        validators: {
                            emailAddress: {
					            message: '<?php echo L("EMAIL_ERROR");?>'
					        },
                        }
                    }
				}
			});

			var form = $(".js-ajax-form");
			form.submit(function(ev){ev.preventDefault();});

			$('.js-ajax-submit').on("click", function(e){e.preventDefault();
				var bootstrapValidator = form.data('bootstrapValidator');

				if (bootstrapValidator) {
					// 修复记忆的组件不验证
					bootstrapValidator.validate();

					if (!bootstrapValidator.isValid()) {

						return false;
					}else{
						//$('.js-ajax-submit').removeAttr('disabled');
						form.submit();
					}

				}

			});
		});
	</script>