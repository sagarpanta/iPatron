$(document).ready(function() {

	$('#home_page').live('pageinit' , function(){
		
		window_width = $(window).width();
		
		img_position = 0.5*window_width - 0.5*200;
		//14 is an some unknown constant added to the position to make it central
		//it is the difference between the programmatically calculate position and the actual postion
		$('#img').css('left', '0px');
		$('#store_img_pos').html('0px');
		$('#img').css('left', (parseInt(img_position)-14) + 'px');
		$('#clublevelname').css('left' , '10px');
		$('#clublevelid').css('left' , '150px');

		
		$('ul').css('left', '0').css('width', window_width)
		$('li').css('width', parseFloat(window_width/5));
		$('img.footer_img').height('40px');

	});
	

	$(".fhome").live('click', function(){
		var page = $('.page_home').html();
		$('tr').scrollTop(300);
		

		$.ajax({
			url: page,
			type: "get",
			cache: false,
			success: function(data) {
				content = $(data).find('#home_content').html();
				$('#home_content').html(content);
				$('html, body').animate({scrollTop:0}, 'fast');
				window_width = $(window).width();
		
		
				img_position = 0.5*window_width - 0.5*200;
				//14 is an some unknown constant added to the position to make it central
				//it is the difference between the programmatically calculate position and the actual postion
				$('#img').css('left', '0px');
				$('#store_img_pos').html('0px');
				$('#img').css('left', (parseInt(img_position)-14) + 'px');
				$('#clublevelname').css('left' , '10px');
				$('#clublevelid').css('left' , '150px');
				
				alignleft_data = $(data).find('.alignleft').html();
				
				$('.alignleft').html(alignleft_data);

				
			}
		});
		
		
	
	

		
		
		

	
	});
	


	
	
	$(".foffer").live('click', function(){
		var page = $('.page_offers').html();

		$.ajax({
			url: page,
			type: "get",
			cache: false,
			success: function(data) {
				content = $(data).find('#offers_content').html();
				$('#home_content').html(content);
				$('html, body').animate({scrollTop:0}, 'fast');

			}
		});
		
		$('.alignleft').html('Offers');
	});
	
	
	
	$(".fevent").live('click', function(){
		var page = $('.page_events').html();

		$.ajax({
			url: page,
			type: "get",
			cache: false,
			success: function(data) {
				content = $(data).find('#events_content').html();
				$('#home_content').html(content);
				$('html, body').animate({scrollTop:0}, 'fast');
			}
		});
		
		$('.alignleft').html('Events');
	});
	
	
	$(".fpromo").live('click', function(){
		var page = $('.page_promotions').html();

		$.ajax({
			url: page,
			type: "get",
			cache: false,
			success: function(data) {
				content = $(data).find('#promotions_content').html();
				$('#home_content').html(content);
				$('html, body').animate({scrollTop:0}, 'fast');
			}
		});
		
		$('.alignleft').html('Promotions');
	
	});
	
	
	$(".fnews").live('click', function(){
		var page = $('.page_news').html();

		$.ajax({
			url: page,
			type: "get",
			cache: false,
			success: function(data) {
				content = $(data).find('#news_content').html();
				$('#home_content').html(content);
				$('html, body').animate({scrollTop:0}, 'fast');
			}
		});
		
		$('.alignleft').html('News');
	
	});
	
	
	
	$('img[src="/assets/redlight.png"]').live('click', function(){
		var page = $('.page_notifications').html();

		$.ajax({
			url: page,
			type: "get",
			cache: false,
			success: function(data) {
				content = $(data).find('#notifications_content').html();
				$('#home_content').html(content);
				$('html, body').animate({scrollTop:0}, 'fast');
			}
		});
		
		$('.alignleft').html('Notifications');
	
	});
	
	

	$('img[src="/assets/greenlight.png"]').live('click', function(){
		var page = $('.page_notifications').html();

		$.ajax({
			url: page,
			type: "get",
			cache: false,
			success: function(data) {
				content = $(data).find('#notifications_content').html();
				$('#home_content').html(content);
				$('html, body').animate({scrollTop:0}, 'fast');
			}
		});
		
		$('.alignleft').html('Notifications');
	
	});
	
	

		
	
	
	
	
	

	

  $('[data-role="content"]').mousemove(function(e){
		pos = $('#img').css('left');
		$('#cursor').html("X Axis : " + e.pageX + " Y Axis : " + e.pageY + ' img pos:' + pos);

  });
  
  
  	$('#home1').live('click' , function(){
		$('#home_page').live('pageshow' , function(){
			left = $('#store_img_pos').html();
			$('#img').css('left', (parseInt(left))+ 'px');
			$('#clublevelname').css('left' , '60px');
			
		});
		
		
	});
  

  
  
	$('img[src="/assets/home.jpg"]').live('click', function() {
		$('img[src="/assets/home.jpg"]').attr('src', '/assets/homeover.jpg');
		$('img[src="/assets/offersover.jpg"]').attr('src', '/assets/offers.jpg');
		$('img[src="/assets/eventsover.jpg"]').attr('src', '/assets/events.jpg');
		$('img[src="/assets/promoover.jpg"]').attr('src', '/assets/promo.jpg');
		$('img[src="/assets/newsover.jpg"]').attr('src', '/assets/news.jpg');
		

	});
	
	$('img[src="/assets/offers.jpg"]').live('click', function() {
		$('img[src="/assets/homeover.jpg"]').attr('src', '/assets/home.jpg');
		$('img[src="/assets/offers.jpg"]').attr('src', '/assets/offersover.jpg');
		$('img[src="/assets/eventsover.jpg"]').attr('src', '/assets/events.jpg');
		$('img[src="/assets/promoover.jpg"]').attr('src', '/assets/promo.jpg');
		$('img[src="/assets/newsover.jpg"]').attr('src', '/assets/news.jpg');
		

	});
	
	$('img[src="/assets/events.jpg"]').live('click', function() {
		$('img[src="/assets/homeover.jpg"]').attr('src', '/assets/home.jpg');
		$('img[src="/assets/offersover.jpg"]').attr('src', '/assets/offers.jpg');
		$('img[src="/assets/events.jpg"]').attr('src', '/assets/eventsover.jpg');
		$('img[src="/assets/promoover.jpg"]').attr('src', '/assets/promo.jpg');
		$('img[src="/assets/newsover.jpg"]').attr('src', '/assets/news.jpg');
		
	});
	
	$('img[src="/assets/promo.jpg"]').live('click', function() {
		$('img[src="/assets/homeover.jpg"]').attr('src', '/assets/home.jpg');
		$('img[src="/assets/offersover.jpg"]').attr('src', '/assets/offers.jpg');
		$('img[src="/assets/eventsover.jpg"]').attr('src', '/assets/events.jpg');
		$('img[src="/assets/promo.jpg"]').attr('src', '/assets/promoover.jpg');
		$('img[src="/assets/newsover.jpg"]').attr('src', '/assets/news.jpg');
		
	});
	
	$('img[src="/assets/news.jpg"]').live('click', function() {
		$('img[src="/assets/homeover.jpg"]').attr('src', '/assets/home.jpg');
		$('img[src="/assets/offersover.jpg"]').attr('src', '/assets/offers.jpg');
		$('img[src="/assets/eventsover.jpg"]').attr('src', '/assets/events.jpg');
		$('img[src="/assets/promoover.jpg"]').attr('src', '/assets/promo.jpg');
		$('img[src="/assets/news.jpg"]').attr('src', '/assets/newsover.jpg');
		
		
	});
	
	$('img[src="/assets/redlight.png"]').live('click', function() {
		$('img[src="/assets/homeover.jpg"]').attr('src', '/assets/home.jpg');
		$('img[src="/assets/offersover.jpg"]').attr('src', '/assets/offers.jpg');
		$('img[src="/assets/eventsover.jpg"]').attr('src', '/assets/events.jpg');
		$('img[src="/assets/promoover.jpg"]').attr('src', '/assets/promo.jpg');
		$('img[src="/assets/newsover.jpg"]').attr('src', '/assets/news.jpg');
		
		
	});

	
	$('img[src="/assets/greenlight.png"]').live('click', function() {
		$('img[src="/assets/homeover.jpg"]').attr('src', '/assets/home.jpg');
		$('img[src="/assets/offersover.jpg"]').attr('src', '/assets/offers.jpg');
		$('img[src="/assets/eventsover.jpg"]').attr('src', '/assets/events.jpg');
		$('img[src="/assets/promoover.jpg"]').attr('src', '/assets/promo.jpg');
		$('img[src="/assets/newsover.jpg"]').attr('src', '/assets/news.jpg');
		
		$('img[src="/assets/greenlight.png"]').attr('src', '/assets/redlight.png');
	});



});

