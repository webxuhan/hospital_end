// 医院挂号系统主要js
$(function(){
	$(".index_top_nav li").on("mouseover",function(){
		// console.log(1);
		$(this).addClass("navCurrent");
		$(this).find(".index_top_showvalue").css("display","inline-block")
	});
	$(".index_top_nav li").on("mouseout",function(){
		// console.log(2);
		$(this).removeClass("navCurrent");
		$(this).find(".index_top_showvalue").css("display","none");
	});
});