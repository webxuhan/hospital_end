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
			<li><a href="<?php echo U('Patient/index');?>">病人信息</a></li>
			<li class="active"><a href="<?php echo U('Patient/add');?>">添加</a></li>
		</ul>
		<form method="post" class="form-horizontal js-ajax-form" action="<?php echo U('Patient/add_post');?>">
			<fieldset>
				<div class="control-group">
					<label class="control-label">病人名称:</label>
					<div class="controls form-group">
						<input type="text" name="patient_name">
						<span class="form-required">*</span>
					</div>
				</div>
				<!-- <div class="control-group">
					<label class="control-label">头像:</label>
					<div class="controls form-group">
						<input type="text" name="doctor_avatar">
					</div>
				</div> -->
				<div class="control-group">
					<label class="control-label">性别:</label>
					<div class="controls form-group">
						<input type="radio" name="patient_sex" value="0" checked><span>男</span>
						<input type="radio" name="patient_sex" value="1"><span>女</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">身份证号:</label>
					<div class="controls form-group">
						<input type="text" name="patient_idcard">
						<span class="form-required">*</span>
					</div>
				</div>		
				<div class="control-group">
					<label class="control-label">邮箱:</label>
					<div class="controls form-group">
						<input type="text" name="patient_email">
					</div>
				</div>	
				<div class="control-group">
					<label class="control-label">手机号:</label>
					<div class="controls form-group">
						<input type="text" name="patient_mobile">
						<span class="form-required">*</span>
					</div>
				</div>	
				
			</fieldset>
			<div class="form-actions">
				<button type="submit" class="btn btn-primary js-ajax-submit">添加</button>
				<a class="btn" href="javascript:history.back(-1);">返回</a>
			</div>
		</form>
	</div>
	<script src="/appoint/src/public/js/common.js"></script>
</body>
</html>
<script type="text/javascript">
	$(document).ready(function(){
            $(".js-ajax-form").bootstrapValidator({
                message: '输入的值无效!',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                   patient_name: {
                        validators: {
                            notEmpty: {
                                message: '病人名称不可为空'
                            },
                            stringLength: {
								min: 1,
								max: 30,
								message: '填写名称太长'
							},
                            regexp: {
								regexp: /^[a-zA-Z0-9_\u4e00-\u9fa5\s]+$/,
								message: '请输入字母数字或下划线或汉字!'
							}
                        }
                    },
                    patient_email:{
                        validators: {
                        	notEmpty: {
                                message: '邮箱不可为空'
                            },
                            emailAddress: {
					            message: '邮箱格式错误'
					        },
                        }
                    },
                    patient_mobile:{
                        validators: {
                        	notEmpty: {
                                message: '手机号码不可为空'
                            },
                        	regexp: {
                                regexp: /^1(3|4|5|7|8)\d{9}$/,
                                message: '请填写正确的手机号码'
                            }
                        }
                    },
                    patient_idcard:{
                        validators: {
                        	notEmpty: {
                                message: '身份证号不可为空'
                            },
                        	regexp: {
                                regexp: /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/,
                                message: '请填写正确的身份证号'
                            }
                        }
                    }
					
                }
            });

            var form = $(".js-ajax-form");
            form.submit(function(ev){ev.preventDefault();});

            $('.js-ajax-submit').on("click", function(ev){
            	ev.preventDefault();
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