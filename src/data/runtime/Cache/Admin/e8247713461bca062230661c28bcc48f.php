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
<link rel="stylesheet" href="/appoint/src/public/css/combo.select/combo.select.css">
</head>

<body>
	<div class="wrap js-check-wrap">
		<form class="well form-search" method="post" action="<?php echo U('Registration/doctor');?>">
			<table>
				<tr>
					<td>医生编号:
		            <input type="text" name="doctor_number" style="width: 100px;" value="<?php echo I('request.zn_name/s','');?>" placeholder="请输入医生编号"></td>
		            <td>医生名称:
		            <input type="text" name="doctor_name" style="width: 100px;" value="<?php echo I('request.en_name/s','');?>" placeholder="请输入医生姓名"></td>
					<td>科室名称:
		            <input type="text" name="bdept_name" style="width: 100px;" value="<?php echo I('request.email/s','');?>" placeholder="请输入科室名称"></td>
		            <td>疾病科:
		            <input type="text" name="disease_name" style="width: 100px;" value="<?php echo I('request.email/s','');?>" placeholder="请输入疾病科名称"></td>
		            
	            </tr>
	            <tr>
	            	<td>邮箱:
		            <input type="text" name="doctor_email" style="width: 100px;" value="<?php echo I('request.email/s','');?>" placeholder="请输入邮箱"></td>
	            	<td>手机号码:
		            <input type="text" name="doctor_mobile" style="width: 100px;" value="<?php echo I('request.mobile/s','');?>" placeholder="请输入<?php echo L('MOBILE');?>"></td>
		            <td>任职状态:
		             <select style="width: 115px;margin-right:10px;" name="doctor_status">
		            	<option disabled selected>请选择</option>
		            	<option <?php if(I('request.manage') == 0): ?>selected<?php endif; ?> value="0">在职</option>
		            	<option value="1">离职</option>
		            </select>
		            </td>
		            <td>
		            <input type="submit" class="btn btn-primary" value="搜索" />
		            <a class="btn btn-danger" href="<?php echo U('Registration/doctor');?>">清空</a>
		            </td>       
	            </tr>
            </table>

        </form>
    
		<form class="js-ajax-form" action="<?php echo U('Registration/doctor');?>" method="post" id="form2">
			
			<table class="table table-hover table-bordered table-list" style="width:120%;">

				<thead>
					<tr>
						<th width="20px"></th>
						<th>医生编号</th>
						<th>医生名称</th>
						<th>职务</th>
						<th>疾病科</th>
						<th>科室</th>
						<th>手机号</th>
						<th>邮箱</th>
					</tr>
				</thead>
				<tbody>
					<?php if(is_array($doctor)): foreach($doctor as $k=>$vo): ?><tr>
					<td>
						<input type="hidden" id="json<?php echo ($k); ?>" value='<?php echo json_encode($vo);?>'>
						<input type="hidden" value="" name="doctor_json" id="doctor_json">
						<label class="checkbox inline">
							<input type="radio" class="js-check" data-yid="js-check-y" data-xid="js-check-x" name="doctor_id" id="doctor_id"
								onclick="if(this.checked==true){document.getElementById('doctor_id').value=this.value;
								document.getElementById('doctor_json').value=document.getElementById('json<?php echo ($k); ?>').value;};" value="<?php echo ($vo["doctor_id"]); ?>">
						</label>
					</td>
					<td><?php echo ($vo["doctor_number"]); ?></td>
					<td><?php echo ($vo["doctor_name"]); ?></td>
					<td><?php echo ($vo["position_name"]); ?></td>
					<td><?php echo ($vo["disease_name"]); ?></td>
					<td><?php echo ($vo["bdept_name"]); ?></td>
					<td><?php echo ($vo["doctor_mobile"]); ?></td>
					<td><?php echo ($vo["doctor_email"]); ?></td>
					
					</tr><?php endforeach; endif; ?>
				</tbody>
				<tfoot>
					<tr>
						<th></th>
						<th>医生编号</th>
						<th>医生名称</th>
						<th>职务</th>
						<th>疾病科</th>
						<th>科室</th>
						<th>手机号</th>
						<th>邮箱</th>

					</tr>
				</tfoot>
			</table>
			<div class="pagination"><?php echo ($page); ?></div>
		</form>
	</div>
	<script src="/appoint/src/public/js/common.js"></script>
</body>
</html>