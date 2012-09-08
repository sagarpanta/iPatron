// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .




$(document).ready(function(){
	
	$(".mark_as_read").live('click', function(){
		var page = $(this).children('p').html();
		$.ajax({
			url: page,
			type: "get",
			cache: false,
			success: function(data) {}
		});
		
		
		
		

		
		$(this).parent().css('background' , 'rgba(243, 243, 243, 0.9)');
		//$(this).html('<img alt="Unread" src="/assets/read.png">')
		$(this).hide();
		var count = $('#bulb_count').html();
		if (count>0){
		$('#bulb_count').html(parseInt(count,10)-1);
		}
		else {
			$('#bulb_count').html(0);
		}
		
		//the value decreases on every click
		var sum_bulb = 	$('#bulb_count').html();
		if (sum_bulb == 0){
			$('#home_notification').html('<img alt="dark" height="31px" src="/assets/redlight.png" width="35px" />');
			$('#event_notification').html('<img alt="dark" height="31px" src="/assets/redlight.png" width="35px" />');
			$('#promotion_notification').html('<img alt="dark" height="31px" src="/assets/redlight.png" width="35px" />');
			$('#offer_notification').html('<img alt="dark" height="31px" src="/assets/redlight.png" width="35px" />');	
			$('#announcement_notification').html('<img alt="dark" height="31px" src="/assets/redlight.png" width="35px" />');	
		}
	});
	
	
	//$(".unread").live('click', function(){
	//	var page = $(this).parent().children('p').html();
	//	var page = $(this).parent().children('p').html();
		
	//	$.ajax({
	//		url: page,
	//		type: 'get',
	//		cache: false,
	//		success: function(data) {}
	//	});
		
		
	//	$(this).parent().parent().css('background' , 'rgba(243, 243, 243, 0.9)');
		//$(this).html('<img alt="Unread" src="/assets/read.png">')
	//	$(this).hide();
	//	var count = $('#bulb_count').html();
	//	if (count>0){
	//	$('#bulb_count').html(parseInt(count,10)-1);
	//	}
	//	else {
	//		$('#bulb_count').html(0);
	//	}
		//the value decreases on every click
	//	var sum_bulb = 	$('#bulb_count').html();
	//	if (sum_bulb == 0){
	//		$('#event_notification').html('<a href="/notifications"><img alt="dark" src="/assets/dark.png" /></a>');
	//		$('#promotion_notification').html('<a href="/notifications"><img alt="dark" src="/assets/dark.png" /></a>');
	//		$('#offer_notification').html('<a href="/notifications"><img alt="dark" src="/assets/dark.png" /></a>');
			
	//	}

	

	
	
	
	
});



$(window).bind('orientationchange',function(e){

  if(window.orientation != 0)
  {
	$('html, body').animate({scrollTop:0}, 'fast');
    width = $(window).width();
	$('ul').css('left', '0').css('width', width);
	$('li').css('width', width/5);
	$('img[src="/assets/header.jpg"]').height('80px');
	
	window_width = $(window).width();
		
	img_position = 0.5*window_width - 0.5*200;
	//14 is an some unknown constant added to the position to make it central
	//it is the difference between the programmatically calculate position and the actual postion
	$('#img').css('left', '0px');
	$('#store_img_pos').html('0px');
	$('#img').css('left', (parseInt(img_position)-14) + 'px');
	$('#clublevelname').css('left' , '10px');
	$('#clublevelid').css('left' , '150px');

  }
  
  else
  {
	$('html, body').animate({scrollTop:0}, 'fast');
    width = $(window).width();
	$('ul').css('left', '0').css('width', width);
	$('li').css('width', width/5);
	
	
	
	window_width = $(window).width();
		
	img_position = 0.5*window_width - 0.5*200;
	//14 is an some unknown constant added to the position to make it central
	//it is the difference between the programmatically calculate position and the actual postion
	$('#img').css('left', '0px');
	$('#store_img_pos').html('0px');
	$('#img').css('left', (parseInt(img_position)-14) + 'px');
	$('#clublevelname').css('left' , '10px');
	$('#clublevelid').css('left' , '150px');
  }
  
    //var orientation = window.orientation;
    //var new_orientation = orientation*-1;
    //$('body').css({
    //    "-webkit-transform": "rotate(" + new_orientation + "deg)"
    //});
  
});







