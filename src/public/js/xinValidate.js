/*jquery注册验证*/
$(function(){
	//获取焦点后提示语隐藏
	$("input").on("focus",function(){
		$(this).parent().parent().find(".errhint").css("display","none");
		$(this).parent().parent().find(".annotation").css("display","inline-block");
	});
	/*单框验证*/
	$("#usename").on("blur",function(){
		trimValue(usename);
		if($(this).val() == ""){
			$(".usename .errhint").css("display","inline-block");
		}else{
			trueEffect(usename);
		}
	});
	$("#userPassword").on("blur",function(){
		trueEffect(userPassword);
	});
	$("#verifyPsd").on("blur",function(){
		trimValue(verifyPsd);
		if($("#userPassword").val() != $(this).val()){
			$(".verifyPsd .errhint").css("display","inline-block");
		}else{
			if($(this).val() != ""){
				trueEffect(verifyPsd);
			}
		}
	});
	$("#idNumber").on("blur",function(){
		trimValue(idNumber);
		idCard(idNumber);
	});
	$("#phoneNumber").on("blur",function(){
		trimValue(phoneNumber);
		if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test($(this).val())) && ($(this).val() != "")){
			$(".phoneNumber .errhint").css("display","inline-block");
		}else{
			trueEffect(phoneNumber);
		}
	});
	$("#email").on("blur",function(){
		var value = $(this).val();
		if(!(/^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g.test(value)) && (value !="")){
			$(".email .errhint").css("display","inline-block");
		}else{
			trueEffect(email);
		}
	});
	$("#verifyCode").on("blur",function(){
		trimValue(verifyCode);
		if($(this).val() == ""){
			$(".verifyCode .errhint").css("display","inline-block");
		}else{
			trueEffect(verifyCode);
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
			}else{
				checkSubmit();
				console.log("提交成功！");
			}
		}
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
		data = num.value.toUpperCase(); 
		if(data == ""){
			return false;
		}else if(!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(data))){
			$(".idNumber .errhint").css("display","inline-block");
		}else{
			trueEffect(num);
		}
	}
	function checkInput(data){
		var value = data.val();
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