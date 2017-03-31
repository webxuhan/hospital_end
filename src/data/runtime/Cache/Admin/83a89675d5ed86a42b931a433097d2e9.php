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
			<li class="active"><a href="<?php echo U('Registration/index');?>">挂号情况</a></li>
			<li><a href="<?php echo U('Registration/add');?>">添加</a></li>
		</ul>
		<form class="well form-search" method="post" action="<?php echo U('Registration/index');?>">
			<table>
				<tr>
					<td>挂号单号:</td>
					<td>
		            <input type="text" name="order_number" style="width: 100px;" value="<?php echo I('request.order_number/s','');?>" placeholder="请输入挂号单号"> 
		            </td>
		            
		            <td>病人名称:</td>
					<td>
		            <input type="text" name="patient_name" style="width: 100px;" value="<?php echo I('request.patient_name/s','');?>" placeholder="请输入病人名称"> 
		            </td>
		            <td>医生名称:</td>
					<td>
		            <input type="text" name="doctor_name" style="width: 100px;" value="<?php echo I('request.doctor_name/s','');?>" placeholder="请输入医生名称"> 
		            </td>
		            <td>疾病:</td>
					<td>
		            <input type="text" name="disease_name" style="width: 100px;" value="<?php echo I('request.disease_name/s','');?>" placeholder="请输入疾病名称"> 
		            </td>
		            </tr>
		            <tr>
		            
		            <td>科室:</td>
					<td>
		            <input type="text" name="bdept_name" style="width: 100px;" value="<?php echo I('request.bdept_name/s','');?>" placeholder="请输入科室名称"> 
		            </td>
		            <td>预约时间:</td>
					<td>
		            <input type="text" name="appoint_time" class="js-date" value="<?php echo I('request.appoint_time/s','');?>" style="width: 120px;" autocomplete="off" placeholder="请输入预约时间">
		            <td colspan="2">
		            <input type="submit" class="btn btn-primary" value="搜索" />
		            <a class="btn btn-danger" href="<?php echo U('Registration/index');?>">清空</a>
		            </td>       
	            </tr>
            </table>

        </form>
    
		<form class="js-ajax-form" action="<?php echo U('Registration/index');?>" method="post" id="form2">
			<input type="hidden" name="style" value="moment">
			<input type="hidden" name="newpass" id="newpass">
			<div class="table-actions">
				<button class="btn btn-danger btn-small js-ajax-submit" type="submit" data-action="<?php echo U('Registration/delete');?>" data-subcheck="true" data-msg="<?php echo L('DELETE_CONFIRM_MESSAGE');?>">取消预约</button>
			</div>
			<table class="table table-hover table-bordered table-list" style="width:120%;">

				<thead>
					<tr>
						<th width="20px"><label><input type="checkbox" class="js-check-all" data-direction="x" data-checklist="js-check-x"></label></th>
						<th>挂号单号</th>
						<th>病人名称</th>
						<th>科室</th>
						<th>医生名称</th>
						<th>疾病科</th>
						<th>预约时间</th>
						<th>状态</th>
						<th>预约金额</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<?php if(is_array($order)): foreach($order as $key=>$vo): ?><tr>
					<td>
						<label class="checkbox inline">
							<input type="checkbox" class="js-check" data-yid="js-check-y" data-xid="js-check-x" name="ids[]" value="<?php echo ($vo["order_id"]); ?>" title="ID:<?php echo ($vo["order_id"]); ?>">
						</label>
					</td>
					
					<?php $doctime_id = $vo['doctime'];$dtime = $doctime[$doctime_id] ?>
					<td><?php echo ($vo["order_number"]); ?></td>
					<td><?php echo ($vo["patient_name"]); ?></td>
					<td><?php echo ($vo["bdept_name"]); ?></td>
					<td><?php echo ($vo["doctor_name"]); ?></td>
					<td><?php echo ($vo["disease_name"]); ?></td>
					<td><?php echo (date("Y-m-d",$vo["appoint_time"])); echo ($dtime); ?></td>
					<?php $status = array('预约成功','支付完成','已就诊','预约取消'); $num = $vo['status']; $appoint_status = $status[$num]; ?>
					<td><?php echo ($appoint_status); ?></td>
					<td><?php echo ($vo["position_price"]); ?></td>
					<td>
						<a class="js-ajax-payfor" href='<?php echo U("Registration/payfor",array('order_id'=>$vo['order_id'],'doctor_id'=>$vo['doctor_id']));?>'>待支付</a> |
						<a class="js-ajax-cancel" href="<?php echo U('Registration/delete',array('order_id'=>$vo['order_id']));?>">取消预约</a>
					</td>
					</tr><?php endforeach; endif; ?>
				</tbody>
				<tfoot>
					<tr>
						<th ><label><input type="checkbox" class="js-check-all" data-direction="x" data-checklist="js-check-x"></label></th>
						<th>挂号单号</th>
						<th>病人名称</th>
						<th>联系电话</th>
						<th>医生名称</th>
						<th>疾病科</th>
						<th>预约时间</th>
						<th>状态</th>
						<th>预约金额</th>
						<th>操作</th>

					</tr>
				</tfoot>
			</table>
			<div class="pagination"><?php echo ($page); ?></div>
	
			<div class="table-actions">
				<button class="btn btn-danger btn-small js-ajax-submit" type="submit" data-action="<?php echo U('BigDept/delete');?>" data-subcheck="true" data-msg="<?php echo L('DELETE_CONFIRM_MESSAGE');?>">取消预约</button>
			</div>
		</form>
	</div>
	<script src="/appoint/src/public/js/common.js"></script>
	<!-- <script src="/appoint/src/public/js/importExport.js"></script> -->
	<script> 
	function send($this){
		var chk_value =[];  
		//get checkbox value  
		$('input[class="js-check"]:checked').each(function(){    
			chk_value.push($(this).val());    
		});    
		if(chk_value.length==0){
			art.dialog({
				id: 'warning',
				icon: 'warning',
				content: '请至少选择一个挂号者！',
				ok: function () {
					//reloadPage(window);
				}
			});   
		}else{	 	
			$("#form2").attr("action", $($this).attr("form_action"))[0].submit();			
		}    
	}
	
	</script>
</body>
</html>