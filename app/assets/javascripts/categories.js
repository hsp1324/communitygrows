$(document).ready( function(){
    $("#sortable1").sortable({
        update: function(event, ui) {
            var data = $(this).sortable('serialize');
    
            $.ajax({
                data: data,
                type: 'POST',
                url: '/categories/update_category_order'
            });
        }
    }).disableSelection();
    
    $("#categories #sortable2").sortable({
        // update: function(event, ui) {
            
        // }
        
        start: function (event, ui) {
            startElement = $(this);
        },
        beforeStop: function(event, ui) {
            if (startElement.find('.docrow').length === 0) {
                // console.log(startElement.find('.hidden'))
                var row = startElement.find('.hidden')[0];
                $(row).addClass('empty');
                $(row).removeClass('hidden');
            }
        },
        update: function(event, ui) {
             if ($(this).find('.docrow').length != 0) {
                var row = $(this).find('.empty')[0];
                $(row).addClass('hidden');
                $(row).removeClass('empty');
            }
        },
        stop: function(event, ui) {
            var data = $(this).sortable('serialize');
            data += "&category[]=" + $(this).attr("class");
        
            $.ajax({
                data: data,
                type: 'POST',
                url: '/documents/update_document_order'
            });
        },
        receive: function(event, ui) {
            var data = $(event.target).sortable('serialize');
            console.log(data);
            // console.log($(this).attr("class"));
            data += "&category[]=" + $(this).attr("class");
            $.ajax({
                data: data,
                type: 'POST',
                url: '/documents/update_document_order'
            });
        },
        cancel: ".empty",
        connectWith: $("#categories #sortable2")
    }).disableSelection();

    $("#check_all").change(function(e) {
        $(this).closest('tbody').find('td input:checkbox').prop('checked', this.checked);
    });
});

