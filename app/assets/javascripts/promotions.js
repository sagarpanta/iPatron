$(document).ready(function() {

	$('#promotion_page').live('pageinit', function() {
		width = $(window).width();
		$('ul').css('left', '0').css('width', width)
		$('li').css('width', parseFloat(width/5));
		$('img.footer_img').height('40px');
	});
	



});