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
});