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
			<li class="active"><a href="<?php echo U('Doctime/index');?>">工作时间</a></li>
			<li><a href="<?php echo U('Doctime/add');?>">添加</a></li>
		</ul>
		<form class="well form-search" method="post" action="<?php echo U('Doctime/index');?>">
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
		            <td>工作时间:</td>
					<td>
		            <select style="width: 115px;margin-right:10px;"name="time_id">
		            	<option disabled selected>请选择</option>
		            	<?php if(is_array($doctime)): foreach($doctime as $key=>$dt): ?><option value="<?php echo ($dt["time_id"]); ?>"><?php echo ($dt["time_name"]); ?></option><?php endforeach; endif; ?>
		            </select>
		            </td>
		            <td>
		            <input type="submit" class="btn btn-primary" value="搜索" />
		            <a class="btn btn-danger" href="<?php echo U('Doctime/index');?>">清空</a>
		            </td>       
	            </tr>
            </table>

        </form>
    
		<form class="js-ajax-form" action="<?php echo U('Doctime/index');?>" method="post" id="form2">
			<input type="hidden" name="style" value="moment">
			<input type="hidden" name="newpass" id="newpass">
			<div class="table-actions">
				<button class="btn btn-danger btn-small js-ajax-submit" type="submit" data-action="<?php echo U('Doctime/delete');?>" data-subcheck="true" data-msg="<?php echo L('DELETE_CONFIRM_MESSAGE');?>">删除</button>
			</div>
			<table class="table table-hover table-bordered table-list" style="width:120%;">

				<thead>
					<tr>
						<th width="20px"><label><input type="checkbox" class="js-check-all" data-direction="x" data-checklist="js-check-x"></label></th>
						<th width="120px">医生编号</th>
						<th width="120px">医生名称</th>
						<th>工作时间</th>
						<th width="150px">操作</th>
					</tr>
				</thead>
				<tbody>
					<?php if(is_array($worktime)): foreach($worktime as $key=>$vo): ?><tr>
					<td>
						<label class="checkbox inline">
							<input type="checkbox" class="js-check" data-yid="js-check-y" data-xid="js-check-x" name="ids[]" value="<?php echo ($vo["work_id"]); ?>" title="ID:<?php echo ($vo["work_id"]); ?>">
						</label>
					</td>
					

					<td><?php echo ($vo["doctor_number"]); ?></td>
					<td><?php echo ($vo["doctor_name"]); ?></td>
					<td><?php echo ($vo["time_id"]); ?></td>
					<td>
						<a href='<?php echo U("Doctime/edit",array("work_id"=>$vo["work_id"]));?>'>编辑</a> |
						<a class="js-ajax-delete" href="<?php echo U('Doctime/delete',array('work_id'=>$vo['work_id']));?>">删除</a>
					</td>
					</tr><?php endforeach; endif; ?>
				</tbody>
				<tfoot>
					<tr>
						<th ><label><input type="checkbox" class="js-check-all" data-direction="x" data-checklist="js-check-x"></label></th>
						<th>医生编号</th>
						<th>医生名称</th>
						<th>工作时间</th>
						<th>操作</th>

					</tr>
				</tfoot>
			</table>
			<div class="pagination"><?php echo ($page); ?></div>
	
			<div class="table-actions">
				<button class="btn btn-danger btn-small js-ajax-submit" type="submit" data-action="<?php echo U('Doctime/delete');?>" data-subcheck="true" data-msg="<?php echo L('DELETE_CONFIRM_MESSAGE');?>">删除</button>
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
				content: '请至少选择一个疾病！',
				ok: function () {
					//reloadPage(window);
				}
			});   
		}else{	 	
			$("#form2").attr("action", $($this).attr("form_action"))[0].submit();			
		}    
	}
	function _import(){
	    Wind.use('artDialog', 'iframeTools', function () {
	        var ImportUrl = "<?php echo U('import_index');?>";
	        art.dialog.open(ImportUrl, {
	            title: '<?php echo L("DATA_IMPORT");?>',
	            lock: true,
	            height: 150,
	            width: "40%",
	            // 在open()方法中，init会等待iframe加载完毕后执行
	            init: function () {
	                var iframe = this.iframe.contentWindow;
	                var top = art.dialog.top;// 引用顶层页面window对象

	            },
	            ok: function () {				
	                return true;                
	            },
	            cancel: true
	        });
	    });
	}
	</script>
</body>
</html>