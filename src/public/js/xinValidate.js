/*jquery注册验证*/
$(function(){
	//获取焦点后提示语隐藏
	console.log("验证加载成功")
	$("input").on("focus",function(){
		$(this).parent().parent().find(".errhint").css("display","none");
		$(this).parent().parent().find(".annotation").css("display","inline-block");
	});
	/*单框验证*/
	$("#usename").on("blur",function(){
		console.log("名称失去焦点");
		trimValue(this);
		console.log("失去焦点");
		if($(this).val() == ""){
			console.log(1)
			$(".usename .errhint").css("display","inline-block");
		}else{
			console.log(2)
			trueEffect(this);
		}
	});
	$(".editPopupDiv #usename").on("blur",function(){
		console.log("名称失去焦点");
		trimValue(this);
		console.log("失去焦点");
		if($(this).val() == ""){
			console.log(1)
			$(".usename .errhint").css("display","inline-block");
		}else{
			console.log(2)
			trueEffect(this);
		}
	});
	$("#userPassword").on("blur",function(){
		trueEffect(this);
	});
	$("#verifyPsd").on("blur",function(){
		trimValue(this);
		if($("#userPassword").val() != $(this).val()){
			$(".verifyPsd .errhint").css("display","inline-block");
		}else{
			if($(this).val() != ""){
				trueEffect(this);
			}
		}
	});
	$("#idNumber").on("blur",function(){
		console.log("1111");
		trimValue(this);
		idCard(this);
	});
	$(".editPopupDiv #idNumber").on("blur",function(){
		console.log("1111");
		trimValue(this);
		idCard(this);
	});
	$("#phoneNumber").on("blur",function(){
		trimValue(this);
		if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test($(this).val())) && ($(this).val() != "")){
			console.log(1)
			$(".phoneNumber .errhint").css("display","inline-block");
		}else{
			trueEffect(this);
		}
	});
	$(".editPopupDiv #phoneNumber").on("blur",function(){
		trimValue(this);
		if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test($(this).val())) && ($(this).val() != "")){
			console.log(1)
			$(".phoneNumber .errhint").css("display","inline-block");
		}else{
			trueEffect(this);
		}
	});
	$("#email").on("blur",function(){
		var value = $(this).val();
		if(!(/^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g.test(value)) && (value !="")){
			$(".email .errhint").css("display","inline-block");
		}else{
			trueEffect(this);
		}
	});
	$("#verifyCode").on("blur",function(){
		trimValue(this);
		if($(this).val() == ""){
			$(".verifyCode .errhint").css("display","inline-block");
		}else{
			trueEffect(this);
		}
	});
	//提交注册验证
	$(".btn input").on("click",function(){
		console.log("点击成功!");
		checkSubmit();
		var arr = [$("#usename"),$("#userPassword"),$("#verifyPsd"),$("#idNumber"),$("#phoneNumber")];
		for(var i = 0;i < arr.length;i++){
			if(checkInput(arr[i])){
				break;
			}
		}
		checkSubmit();
		console.log("提交成功！");
		// checkInput(usename);
		// checkInput(userPassword);
		// checkInput(verifyPsd);
		// checkInput(idNumber);
		// checkInput(phoneNumber);
		
		return false;
	});
	function trueEffect(data){ //验证成功效果
		var value = $(data).val();
		if(value !=""){
			$(data).parent().parent().find(".errhint").css("display","none");
			$(data).parent().parent().find(".annotation").css("display","none");
		}
	}
	function trimValue(data){ //清空输入框前后空格
		var value = $(data).val().trim();
		return $(data).val(value);
	}
	function idCard(num){  //身份证验证
		console.log(num);
		console.log(num.value);
		data = num.value.toUpperCase(); 
		console.log("data:",data);
		if(data == ""){
			console.log(1);
			return false;
		}else if(!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(data))){
			console.log(2)
			$(".idNumber .errhint").css("display","inline-block");
		}else{
			console.log(3)
			trueEffect(num);
		}
	}
	function checkInput(data){
		var value = data.val();
		console.log(data);
		console.log("输入框:",value);
		// if(mid == 1){ return}
		if(value ==""){
			data.parent().parent().find(".annotation").css("display","none");
			data.parent().parent().find(".errhint").css("display","inline-block");
			return true;
		}			
	}
	function checkSubmit(){
		//验证是否成功
        var verification = "";
        $(".errhint").each(function(){
            if($(this).css("display") == "inline-block" ){
                verification = 1;
                return false;
            }else{
                verification = 0;
            }
        });
        if(verification == 1){
        	return false;
        }
	}
});