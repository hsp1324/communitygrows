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
        //     var data = $(this).sortable('serialize');
    
        //     $.ajax({
        //         data: data,
        //         type: 'POST',
        //         url: '/categories/update_category_order'
        //     });
        // }
        
        start: function (event, ui) {
            startElement = $(this);
        },
        beforeStop: function(event, ui) {
            if (startElement.find('.docrow').length === 0) {
                // console.log(startElement.find('.hidden'))
                var row = startElement.find('.hidden')[0]
                $(row).addClass('empty');
                $(row).removeClass('hidden');
            }
        },
        cancel: ".empty",
        connectWith: $("#categories #sortable2")
    }).disableSelection();
});