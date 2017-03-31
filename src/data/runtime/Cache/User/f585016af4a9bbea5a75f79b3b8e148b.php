<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>山西省医院挂号平台</title>
	<link rel="stylesheet" href="/hospital_end/src/public/css/index.css">
	<link rel="stylesheet" href="/hospital_end/src/public/css/jquery.bxslider.css">
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
				<div class="sbArea">
					<a href=""><div>疾病</div></a>
					<a href=""><div>医生</div></a>
					<!-- <a href=""><div>医院</div></a> -->
				</div>
			</form>
		</div>
	</div>
	<div class="index_nav_border">
		<div class="index_nav">
			<ul class="index_nav_ul">
				<li class="index_nav_lic">全部科室</li>
				<li><a href="<?php echo U('Xing/diseaseRegistered');?>">按疾病挂号</a></li>
				<li><a href="<?php echo U('Xing/doctorRegistered');?>">按医生挂号</a></li>
				<li class="nav_color"><a href="<?php echo U('Xing/visitTheTable');?>">医生出诊表</a></li>
				<li><a href="#">最新公告</a></li>
				<li class="personalCenter"><a href="<?php echo U('Xing/login');?>">个人中心</a></li>
			</ul>
		</div>
	</div>
	<!-- 广告导航部分 -->
	<div class="index_top_c">
		<!-- 广告左侧导航 -->
		<div class="index_top_left">
			<div class="index_top_navbar">
				<ul class="index_top_nav">
					<li><i class="i_t_s1"></i>
						<span><b>内科</b>
							<a href="#">冠心病</a>
							<a href="#">高血压</a>
						</span>
						<div class="index_top_showvalue" style="display:none">
							<div class="idnex_top_con_zwc">
								<div class="index_top_con_w">
									<p class="index_top_hdvalue_p">
										<span>口腔科</span>
									</p>
									<ul class="index_top_hdvalue_ul">
										<li><a href="#">口腔科</a><i></i></li>
										<li><a href="#">口腔科</a><i></i></li>
										<li><a href="#">口腔科</a><i></i></li>
										<li><a href="#">口腔科</a><i></i></li>
									</ul>
								</div>
							</div>
						</div>
					</li>
					<li><i class="i_t_s1"></i>
						<span><b>内科</b>
							<a href="#">冠心病</a>
							<a href="#">高血压</a>
						</span>
					</li>
					<li><i class="i_t_s1"></i>
						<span><b>内科</b>
							<a href="#">冠心病</a>
							<a href="#">高血压</a>
						</span>
					</li>
					<li><i class="i_t_s1"></i>
						<span><b>内科</b>
							<a href="#">冠心病</a>
							<a href="#">高血压</a>
						</span>
					</li>
					<li><i class="i_t_s1"></i>
						<span><b>内科</b>
							<a href="#">冠心病</a>
							<a href="#">高血压</a>
						</span>
					</li>
					<li><i class="i_t_s1"></i>
						<span><b>内科</b>
							<a href="#">冠心病</a>
							<a href="#">高血压</a>
						</span>
					</li>
					<li><i class="i_t_s1"></i>
						<span><b>内科</b>
							<a href="#">冠心病</a>
							<a href="#">高血压</a>
						</span>
					</li>
					<li><i class="i_t_s1"></i>
						<span><b>内科</b>
							<a href="#">冠心病</a>
							<a href="#">高血压</a>
						</span>
					</li>
					<li><i class="i_t_s1"></i>
						<span><b>内科</b>
							<a href="#">冠心病</a>
							<a href="#">高血压</a>
						</span>
					</li>
					<li><i class="i_t_s1"></i>
						<span><b>内科</b>
							<a href="#">冠心病</a>
							<a href="#">高血压</a>
						</span>
					</li>
				</ul>
				<p class="index_top_nav_p">
					<i class="i_t_qt"></i>
					<span class="i_t_s13"><a href="#" class="index_top_a_none">其他科室</a></span>
				</p>
			</div>
		<!-- 	<div class="index_top_hdvalue" style="position:absolute;left:0;display:none">
				<div class="index_top_con_st">
					<div class="index_top_con_zwc">
						<div class="index_top_con_w">
							<p class="index_top_hdvalue_p"><span>内科</span></p>
							<ul class="index_top_hdvalue_ul">
								<li><a href="#">心血管内科</a><i></i></li>
								<li><a href="#">心血管内科</a><i></i></li>
								<li><a href="#">心血管内科</a><i></i></li>
							</ul>
						</div>
						<div class="index_top_con_w">
							<p class="index_top_hdvalue_p"><span>内科常见疾病</span></p>
							<ul class="index_top_hdvalue_ul">
								<li><a href="#" class="index_top_hd_color">冠心病</a><i></i></li>
								<li><a href="#" class="index_top_hd_color">高血压</a><i></i></li>
								<li><a href="#">心律失常</a><i></i></li>
								<li><a href="#">心律失常</a><i></i></li>
								<li><a href="#">心律失常</a><i></i></li>
							</ul>
						</div>
					</div>
				</div>
			</div> -->
			<!-- 左导航详情 -->
		<!-- 	<div class="index_top_showvalue" style="display:none">
				<div class="idnex_top_con_zwc">
					<div class="index_top_con_w">
						<p class="index_top_hdvalue_p">
							<span>口腔科</span>
						</p>
						<ul class="index_top_hdvalue_ul">
							<li><a href="#">口腔科</a><i></i></li>
							<li><a href="#">口腔科</a><i></i></li>
							<li><a href="#">口腔科</a><i></i></li>
							<li><a href="#">口腔科</a><i></i></li>
						</ul>
					</div>
				</div>
			</div> -->
		</div>
		<!-- 轮播图 -->
		<div class="index_jdt">
			<div class="index-ad">
			    <div class="mads">
			        <ul class="bxslider">
			            <li><a href="#"><img src="/hospital_end/src/public/images/ad_1.jpg" alt=""></a></li>
			            <li><a href="#"><img src="/hospital_end/src/public/images/ad_2.jpg" alt=""></a></li>
			            <li><a href="#"><img src="/hospital_end/src/public/images/ad_3.jpg" alt=""></a></li>
			        </ul>
			    </div>
			</div>
		</div>
		<!-- 广告右侧搜索 -->
		<div class="ksbz">
			<div class="subscribe">
				<h2><span>快速预约</span></h2>
				<form name="searchForm">
					<p><select name="" id="" class="subscribe_p_select"><option value="">请选择科室</option></select></p>
					<p><select name="" id="" class="subscribe_p_select"><option value="">请选择疾病</option></select></p>
					<p><select name="" id="" class="subscribe_p_select"><option value="">请选择医生</option></select></p>
					<a href="#" class="ksbz_kscx">快速查询</a>
				</form>
			</div>
			<div class="ksbz_help">
				<h2><span>帮助中心</span></h2>
				<div class="ksbz_help_an">
					<a href="#" target="_blank" class="ksbz_h_a">账号指南</a>
					<a href="#" target="_blank" class="ksbz_h_a">预约指南</a>
					<a href="#" target="_blank" class="ksbz_h_a">账号找回</a>
					<a href="#" target="_blank" class="ksbz_h_a">常见问题</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 医生咨询 -->
	<div class="medicine_guide">
		<div class="medicine_guide_left">
			<div class="medicine_guide_header"><span class="current">医学指南</span></div>
				<!-- 医学指南 -->
				<div class="medicine_guide_content">
					<h2>山西省第十三届肾脏病学术年会</h2>
					<div class="post_meta">山西省医院 | 山西省太原市2016年10月21日</div>
					<div class="medicine_guide_content">
						<div class="imagebox"><img src="/hospital_end/src/public/images/medicine_guide.jpg" alt=""></div>
						<p><em> 欢迎我省各级医院肾脏病医护人员、血液净化、营养专业人员及研究生积极参与！</em></p>
						<p class="guide_text">
							<a href="#"> 山西省第十三届肾脏病学术年会</a>
							 暨第五届黄河论坛、第三届中原论坛会议定于2016年10月21日~23日在山西省人民医院（太原市双塔寺街29号）举行。届时将邀请国内外知名的肾脏病学家进行专题讲座。会议将围绕“急性肾损伤（
							 <a href="#"><strong>AKI</strong></a>
							  ）防治”这一主题，对临床常见肾脏病的诊断、治疗及预防进行学术交流，总结肾脏病学的临床和基础研究经验，旨在推动我省肾脏病学的交流和肾脏病工作的深入开展。
						</p>
					</div>		
				</div>
				<!-- 医学指南结束 -->
				<!-- 医学新闻 -->
				<div class="medicine_guide_header"><span class="current">医学新闻</span></div>
				<div class="medicine_news">
					<p><em>时刻关注医院新闻，了解医院最新动态</em></p> 
		            <ul class="templatemo_list">
		                <li class="flow"><a href="#">我院举办世界关节炎日暨骨质疏松日义诊活动</a></li>
		                <li class="flow"><a href="#">省委任命张晓清同志担任我院党委书记</a></li>
		                <li class="flow"><a href="#">我院关于招聘聘用制护士的通知</a></li>
		                <li class="flow"><a href="#">敬老月难忘前辈 送温暖传递真情</a></li>
		                <li class="flow"><a href="#">我院开展全国高血压日暨重阳节爱心义诊活动</a></li>
		                <li class="flow"><a href="#">二十五载春秋割舍不断日本客人对省医的情怀</a></li>
		                <li class="flow"><a href="#">李荣山院长率队到医务处指导调研</a></li>
		                <li class="flow"><a href="#">我院获省卫计委离退休人员健身舞比赛金奖</a></li>
		            </ul>
				</div>
				<!-- <div>
					<p>这里是医学新闻！</p>
				</div> -->
				<!-- 医学新闻结束 -->
		</div>
		<div class="medicine_guide_right">
			<div class="index_new_gg">
				<div class="index_new_gg_title">
					<h2>最新公告</h2>
					<a href="#">更多</a>
				</div>
				<ul class="index_new_gul">
					<li><a href="#">【重要】山西省医药分开综合改革...</a></li>
					<li><a href="#">北京大学人民医院调整放号周期的...</a></li>
					<li><a href="#">山西胸科医院暂停更新号源通知</a></li>
					<li><a href="#">系统检修暂停服务的公告</a></li>
					<li><a href="#">北京市大兴区红星医院变更通告</a></li>
					<li><a href="#">openssh版本升级通知</a></li>
				</ul>
			</div>
			<div class="index_tz_gg">
				<div class="index_tz_gg_title">
					<h2>停诊公告</h2>
					<a href="#">更多</a>
				</div>
				<ul class="index_tz_gul">
					<li><a href="#">解放军第302医院肝病内科酒药...</a></li>
					<li><a href="#">解放军第302医院肝病内科酒药...</a></li>
					<li><a href="#">山西儿科研究所附属儿童医院普通......</a></li>
					<li><a href="#">山西肿瘤医院疼痛与睡眠停诊公告...</a></li>
					<li><a href="#">山西肿瘤医院疼痛与睡眠停诊公告...</a></li>
					<li><a href="#">山西肿瘤医院疼痛与睡眠停诊公告...</a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- 底部 -->
	<div class="index_footer">
		<div class="templatemo_footer">Copyright © 2048 <a href="#">山西省医院</a> | Template from wuxin</div>
	</div>
</body>
<script src="/hospital_end/src/public/js/jquery-1.9.1.min.js"></script>
<script src="/hospital_end/src/public/js/jquery.bxslider.js"></script>
<script src="/hospital_end/src/public/js/index.js"></script>
<script>
	$(function(){ 
	 // $('.bxslider').bxSlider({ 
	 //  mode:'horizontal', //默认的是水平 
	 //  displaySlideQty:1,//显示li的个数 
	 //  moveSlideQty: 1,//移动li的个数  
	 //  captions: true,//自动控制 
	 //  auto: true, 
	 //  autoHover:true,
	 //  controls: true; //隐藏左右按钮 
	 // }); 
	 var s =$('.bxslider').bxSlider({ 
	  mode:'horizontal', //默认的是水平 
	  displaySlideQty:1,//显示li的个数 
	  moveSlideQty: 1,//移动li的个数  
	  captions: true,//自动控制 
	  auto: true, 
	  speed:200,
	  controls: true//隐藏左右按钮 
	  
	 }); 
	 // s.startAuto();
	});
</script>
</html>