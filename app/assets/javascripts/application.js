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

$(document).ready(function() {
	//$('table.hidden').hide();
	$('div.alert').hide();
	
	function click_me(){
		alert("I am called");
	};
	
	// $('div.btn-group').click(hideGroup);
	// 	function hideGroup(event){
	// 		event.preventDefault();
	// 		$('table.visible').toggle().bind('click', hideGroup);
	// 		$('table.hidden').show().unbind('click', hideGroup);
	// 	};
	
	// $('input#submit').click(showNotice);
	// 	function showNotice(event){
	// 		event.preventDefault();
	// 		$('div.alert-success').show().delay(1500).fadeOut().bind('click', showNotice);
	// 	};
});