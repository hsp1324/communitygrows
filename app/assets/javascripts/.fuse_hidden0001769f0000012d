// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min

$('#edit_doc_button').click(function() {
    $("#edit_doc_form").show();
    $("#edit_doc_button").hide();
});

$('#markasread').click(function() {
    var checkbox = $(this)
    var id = checkbox.val();
    $.ajax({
        type: 'POST',
        url: 'mark_as_read',
        contentType: 'application/json',
        data: JSON.stringify({id: id}),
        success: function(data) {
            console.log(data);
            $('#flashNotice').html("Document " + data.document + " marked as " + data.result);
            $('#' + data.user + '_read').html(data.result);
        },
        error: function(data) {
            $('#flashNotice').html("There was an error!");
            checkbox.prop('checked', !$('#markasread').is(':checked'))
        }
    });
});
