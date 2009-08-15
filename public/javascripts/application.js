// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// inline form field labels for the search form
$(document).ready(function(){
	$('#search_form input').each(function(){
		if($(this).val() === ''){
			$(this).val($(this).attr('title'));
		}
		
		$(this).focus(function(){
			if($(this).val() === $(this).attr('title')){
				$(this).val('').addClass('focused');
			}
		});
		
		$(this).blur(function(){
			if($(this).val() === ''){
				$(this).val($(this).attr('title')).removeClass('focused');
			}
		});
	});
});

// making sure that when the search form is submitted the inline labels do not go too!
$(document).ready(function(){
	$('#search_form').submit(function(){
		$('#search_form input').each(function(){
			if($(this).val() === $(this).attr('title')){
				$(this).val('');
			}
		});
		
		
	});
});