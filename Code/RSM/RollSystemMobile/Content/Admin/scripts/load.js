$(function()
{
    // main menu -> submenus
    
	$('#menu .collapse').on('show', function()
	{
		$(this).parents('.hasSubmenu:first').addClass('active');
	})
	.on('hidden', function()
	{
		$(this).parents('.hasSubmenu:first').removeClass('active');
	});
	
    /*
    $('#menu .collapse').show(function () {
        $(this).parents('.hasSubmenu:first').addClass('active');
    });

	$('#menu .collapse').hide(function () {
	    $(this).parents('.hasSubmenu:first').removeClass('active');
	});
    */
	// main menu visibility toggle
	$('.navbar.main .btn-navbar').click(function()
	{
		$('.container-fluid:first').toggleClass('menu-hidden');
		$('#menu').toggleClass('hidden-phone');
		
		if (typeof masonryGallery != 'undefined') 
			masonryGallery();
	});
	
	// tooltips
	$('[data-toggle="tooltip"]').tooltip();
	
	if ($('.widget-activity').length)
		$('.widget-activity .filters .glyphicons').click(function()
		{
			$('.widget-activity .filters .active').toggleClass('active');
			$(this).toggleClass('active');
		});
	
	$(window).resize(function()
	{
		if (!$('#menu').is(':visible') && !$('.container-fluid:first').is('.menu-hidden') && !$('.container-fluid:first').is('.documentation') && !$('.container-fluid:first').is('.login'))
			$('.container-fluid:first').addClass('menu-hidden');
	});
	
	$(window).resize();
	
	$('.btn-source-toggle').click(function(e){
		e.preventDefault();
		$('.code').toggleClass('hide');
	});
	
	$('#toggle-menu-position').on('change', function(){
		$('.container-fluid:first').toggleClass('menu-right');
		$.cookie('rightMenu', $(this).prop('checked') ? $(this).prop('checked') : null);
	});
	
	if ($.cookie('rightMenu') && $('#toggle-menu-position').length)
	{
		$('#toggle-menu-position').prop('checked', true);
		$('.container-fluid:first').not('.menu-right').addClass('menu-right');
	}
	
	/*
	 * Boostrap Extended
	 */
	// custom select for Boostrap using dropdowns
	$('.selectpicker').selectpicker();
	
	// bootstrap-toggle-buttons
	$('.toggle-button').toggleButtons();
	
});