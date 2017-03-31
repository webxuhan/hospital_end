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
			<li><a href="<?php echo U('Registration/index');?>">挂号情况</a></li>
			<li class="active"><a href="<?php echo U('Registration/add');?>">添加</a></li>
		</ul>
		<form method="post" class="form-horizontal js-ajax-form" action="<?php echo U('Registration/add_post');?>">
			<table class="form-group">
				<tr>
					<input type="hidden" name="patient_id" value="">
					<td>病人名称:</td>
					<td>
		            <input type="text" name="patient_name" style="width: 200px;" value="<?php echo I('request.patient_name/s','');?>" readonly> 
		            </td>
		            <td>身份证号:</td>
					<td>
		            <input type="text" name="patient_idcard" style="width: 200px;" value="<?php echo I('request.patient_idcard/s','');?>" disabled> 
		            </td>
		            <td>联系电话:</td>
					<td>
		            <input type="text" name="patient_mobile" style="width: 150px;" value="<?php echo I('request.patient_mobile/s','');?>" disabled> 
		            </td>    
	            </tr>
	            <tr>
					<td colspan="2">
		           	 	<span class="btn btn-primary findpatient">选择病人</span>
		            </td>   
	            </tr>
	            <tr>
					<input type="hidden" name="doctor_id" value="">
					<td>医生名称:</td>
					<td>
		            <input type="text" name="doctor_name" style="width: 200px;" value="<?php echo I('request.doctor_name/s','');?>" readonly> 
		            </td>
		            <td>医生编号:</td>
					<td>
		            <input type="text" name="doctor_number" style="width: 200px;" value="<?php echo I('request.doctor_number/s','');?>" readonly> 
		            </td>
		            <td>联系电话:</td>
					<td>
		            <input type="text" name="doctor_mobile" style="width: 150px;" value="<?php echo I('request.doctor_mobile/s','');?>" disabled> 
		            </td> 
		            <td>
		            </td>      
	            </tr>
	            <tr>
	            	<td>科室:</td>
					<td>
		            <input type="text" name="bdept_name" style="width: 200px;" value="<?php echo I('request.bdept_name/s','');?>" readonly> 
		            </td> 
		            <td>疾病科:</td>
					<td>
		            <input type="text" name="disease_name" style="width: 200px;" value="<?php echo I('request.disease_name/s','');?>" readonly> 
		            </td> 
		           
	            </tr>
	            <tr>
					 <td colspan="2">
		            <span class="btn btn-primary finddoctor">选择医生</span>
		            </td>       
	            </tr>
	            
            </table>
            <table border="1" style="margin-top:20px;display:none;" class="doctortime">
            	<tr align='center'>
            		<td style="width:100px;">时间</td>
            		<?php $arr = array('1' => '周一','2' => '周二','3' => '周三','4' => '周四','5' => '周五','6' => '周六','7' => '周日'); ?>
	            	<?php if(is_array($cal)): foreach($cal as $k=>$c): ?><td style="width:100px;">
						<?php echo ($k); ?><br><?php echo ($arr[$c]); ?>
		            </td><?php endforeach; endif; ?>
	            </tr>
	            <?php $week = date("w")+1; $start = 2*$week - 1; $end = 2*$week; ?>
	            <tr align='center'>
            		<td style="width:100px;">上午</td>
            		<?php $__FOR_START_26201__=$start;$__FOR_END_26201__=$start+13;for($i=$__FOR_START_26201__;$i < $__FOR_END_26201__;$i+=2){ ?><td>
            			<input type="radio" name="doctime" <?php if($i > 14): ?>value="<?php echo ($i-14); ?>" <?php else: ?> value="<?php echo ($i); ?>"<?php endif; ?>>	
            		</td><?php } ?>	
	            </tr>
	            <tr align='center'>
            		<td style="width:100px;">下午</td>
            		<?php $__FOR_START_15130__=$end;$__FOR_END_15130__=$end+13;for($i=$__FOR_START_15130__;$i < $__FOR_END_15130__;$i+=2){ ?><td>
            			<input type="radio" name="doctime" <?php if($i > 14): ?>value="<?php echo ($i-14); ?>" <?php else: ?> value="<?php echo ($i); ?>"<?php endif; ?>>	
            		</td><?php } ?>	
	            </tr>
            </table>
			<div class="form-actions">
				<button type="submit" class="btn btn-primary js-ajax-submit">预约</button>
				<a class="btn" href="javascript:history.back(-1);">返回</a>
			</div>
		</form>
	</div>
	<script src="/appoint/src/public/js/common.js"></script>
</body>
</html>
<script type="text/javascript">
	$(document).ready(function(){
            /*选择病人*/
            $(".findpatient").on("click",function(){
            	 Wind.use('artDialog', 'iframeTools', function () {
	                var seatUrl = "<?php echo U('Registration/patient');?>";
	                art.dialog.open(seatUrl, {
	                    title: '选择病人',
	                    lock: true,
	                    height: 400,
	                    width: "80%",
	                    // 在open()方法中，init会等待iframe加载完毕后执行
	                    init: function () {
	                        var iframe = this.iframe.contentWindow;
	                        var top = art.dialog.top;// 引用顶层页面window对象
	
	                    },
	                    ok: function () {

	                        var iframe = this.iframe.contentWindow;
	                        if (!iframe.document.body) {
	                            alert('iframe还没加载完毕呢')
	                            return false;
	                        }

	                       // 获取iframe嵌套内容
	                       var patient_id = iframe.document.getElementById('patient_id').value;

	                       $("input[name='patient_id']").val(patient_id);

	                        //获取iframe内嵌信息的json
	                        var patient_jsons = iframe.document.getElementById('patient_json').value;
							var obj = eval('(' + patient_jsons + ')');
							$("input[name='patient_name']").val(obj.patient_name);
							$("input[name='patient_idcard']").val(obj.patient_idcard);
							$("input[name='patient_mobile']").val(obj.patient_mobile);
	                        return true;
	                        
	                        
	                    },
	                    cancel: true
	                });
	            });

            });//end findpatient
			/*选择医生*/
            $(".finddoctor").on("click",function(){
            	 Wind.use('artDialog', 'iframeTools', function () {
	                var seatUrl = "<?php echo U('Registration/doctor');?>";
	                art.dialog.open(seatUrl, {
	                    title: '选择医生',
	                    lock: true,
	                    height: 400,
	                    width: "80%",
	                    // 在open()方法中，init会等待iframe加载完毕后执行
	                    init: function () {
	                        var iframe = this.iframe.contentWindow;
	                        var top = art.dialog.top;// 引用顶层页面window对象
	
	                    },
	                    ok: function () {

	                        var iframe = this.iframe.contentWindow;
	                        if (!iframe.document.body) {
	                            alert('iframe还没加载完毕呢')
	                            return false;
	                        }

	                       // 获取iframe嵌套内容
	                       var doctor_id = iframe.document.getElementById('doctor_id').value;
	                       $("input[name='doctor_id']").val(doctor_id);

	                        //获取iframe内嵌信息的json
	                        var doctor_jsons = iframe.document.getElementById('doctor_json').value;
							var obj = eval('(' + doctor_jsons + ')');
							$("input[name='doctor_name']").val(obj.doctor_name);
							$("input[name='doctor_number']").val(obj.doctor_number);
							$("input[name='doctor_mobile']").val(obj.doctor_mobile);
							$("input[name='bdept_name']").val(obj.bdept_name);
							$("input[name='disease_name']").val(obj.disease_name);
							$.ajax({
								url:"<?php echo U('Registration/doctorcal');?>",
								method:"post",
								data:{doctor_id:doctor_id},
								success:function(data){
									var b = data.split(",");
									$(".doctortime").css("display","inline-block");
									var week = $("input[name='doctime']");
									$("input[name='doctime']").css("display","none");
									week.each(function(){
										var w = this;
										// console.log("w:",w);
										b.forEach(function(item,index){
											// console.log("item:",item);
											// console.log("w:",w.value);
											if(w.value == item){
												// console.log("w:",w);

												$(w).css("display","inline-block");
											}
										})
									});	
								}
							});
	                        return true;
	                        
	                        
	                    },
	                    cancel: true
	                });
	            });

            });//end finddoctor
        });
</script>