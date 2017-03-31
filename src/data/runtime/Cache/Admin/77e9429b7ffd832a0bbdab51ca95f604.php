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
		<ul class="nav nav-tabs">
			<li class="active"><a href="<?php echo U('Appoint/index');?>">挂号信息</a></li>
		</ul>
		<form class="well form-search" method="post" action="<?php echo U('Appoint/index');?>">
			<table>
				<tr>
					<td>医生编号:</td>
					<td>
		            <input type="text" name="doctor_number" style="width: 100px;" value="<?php echo I('request.doctor_number/s','');?>" placeholder="请输入医生编号"> 
		            </td>
		            <td>医生名称:</td>
					<td>
		            <input type="text" name="doctor_name" style="width: 100px;" value="<?php echo I('request.doctor_name/s','');?>" placeholder="请输入医生名称"> 
		            </td>
		            <td>
		            <input type="submit" class="btn btn-primary" value="搜索" />
		            <a class="btn btn-danger" href="<?php echo U('Appoint/index');?>">清空</a>
		            </td>       
	            </tr>
            </table>

        </form>
    
			<table class="table table-hover table-bordered table-list" style="width:120%;">

				<thead>
					<tr>
						<th width="80px">医生编号</th>
						<th>医生名称</th>
						<th>挂号总量</th>
						<th>就诊总量</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<?php if(is_array($doctor)): foreach($doctor as $key=>$vo): ?><tr>
						<td><?php echo ($vo["doctor_number"]); ?></td>
						<td><?php echo ($vo["doctor_name"]); ?></td>
						<td><?php echo ($vo["appoint_totalnum"]); ?></td>
						<td><?php echo ($vo["expire_totalnum"]); ?></td>
						<td>
						<a href="<?php echo U('Appoint/detail',array('doctor_id'=>$vo['doctor_id']));?>">查看详情</a>
						</td>
					</tr><?php endforeach; endif; ?>
				</tbody>
				<tfoot>
					<tr>
						<th width="80px">医生编号</th>
						<th>医生名称</th>
						<th>挂号总量</th>
						<th>就诊总量</th>
						<th>操作</th>
					</tr>
				</tfoot>
			</table>
			<div class="pagination"><?php echo ($page); ?></div>
	</div>
	<script src="/appoint/src/public/js/common.js"></script>
	<!-- <script src="/appoint/src/public/js/importExport.js"></script> -->
</body>
</html>