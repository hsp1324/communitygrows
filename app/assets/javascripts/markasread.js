$(document).ready(function() {
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
});