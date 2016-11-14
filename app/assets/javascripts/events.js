/* global $ */
$.fn.myAccordion = function(){
  return this.each(function(){
	$(this).addClass("ui-accordion ui-accordion-icons ui-widget ui-helper-reset")
  .find("span")
	.addClass("ui-accordion-header ui-helper-reset ui-state-default ui-corner-top ui-corner-bottom")
	.hover(function() { $(this).toggleClass("ui-state-hover"); })
	.prepend('<span class="ui-icon ui-icon-triangle-1-e"></span>')
	.click(function() {
      $(".ui-accordion-content").hide();
      $(".ui-accordion-header-active").addClass("ui-state-default ui-corner-bottom");
      $(".ui-accordion-header-active").removeClass("ui-accordion-header-active ui-state-active");  
	  $(this)
		.toggleClass("ui-accordion-header-active ui-state-active ui-state-default ui-corner-bottom")
		.find("> .ui-icon").toggleClass("ui-icon-triangle-1-e ui-icon-triangle-1-s").end()
		.next().slideToggle();
	  return false;
	})
	.next()
	  .addClass("ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom")
	  .hide();
  });
};

$(document).ready(function() {
    $('.ui-accordion').myAccordion({autoHeight: false, heightStyle: 'content'});
    $('.datepicker').datepicker();
});

$("#edit_doc_button").click(function(){
    $("#edit_doc_form").show();
    $("#edit_doc_button").hide();
});