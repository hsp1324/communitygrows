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
        connectWith: $("#categories #sortable2")
    }).disableSelection();
});