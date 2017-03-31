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
			<li><a href="<?php echo U('BigDept/index');?>">科室信息</a></li>
			<li><a href="<?php echo U('BigDept/add');?>">添加</a></li>
			<li class="active"><a href="javascript:;">编辑</a></li>
		</ul>
		<form method="post" class="form-horizontal js-ajax-form" action="<?php echo U('BigDept/edit_post');?>">
			<fieldset>
				<div class="control-group">
					<label class="control-label">科室名称:</label>
					<div class="controls form-group">
						<input type="text" name="bdept_name" value="<?php echo ($bdept["bdept_name"]); ?>">
						<span class="form-required">*</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">科室编号:</label>
					<div class="controls form-group">
						<input type="text" value="<?php echo ($bdept["bdept_number"]); ?>" disabled>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">联系人:</label>
					<div class="controls form-group">
						<input type="text" name="bdept_contactor" value="<?php echo ($bdept["bdept_contactor"]); ?>">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">手机话:</label>
					<div class="controls form-group">
						<input type="text" name="bdept_mobile" value="<?php echo ($bdept["bdept_mobile"]); ?>">
					</div>
				</div>	
			</fieldset>
			<div class="form-actions">
				<input type="hidden" name="bdept_id" value="<?php echo ($bdept["bdept_id"]); ?>" />
				<button type="submit" class="btn btn-primary js-ajax-submit">保存</button>
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
                    bdept_name: {
                        validators: {
                            notEmpty: {
                                message: '科室名称不可为空'
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
                    bdept_mobile:{
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
                    
                    bdept_contactor:{
						message: '输入的值无效!',
						validators: {
							notEmpty: {
                                message: '联系人不可为空'
                            },
							regexp: {
								regexp: /^[a-zA-Z0-9_\u4e00-\u9fa5\s]+$/,
								message: '请输入字母数字或下划线或汉字!'
							}
						}
					},
					
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