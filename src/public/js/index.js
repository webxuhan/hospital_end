// 医院挂号系统主要js
$(function(){
	//头部搜索功能
	$(".top_search .option").on("click",function(){
		$(".sbArea").css("display","inline-block");
	});
	$(".sbArea div").on("click",function(){
		$(".top_search .option>span").html($(this).html());
		$(".sbArea").css("display","none");
	})
	/*头部搜索功能结束*/
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