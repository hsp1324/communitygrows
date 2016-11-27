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
        start: function (event, ui) {
            startElement = $(this);
            var elements = ui.item.siblings('.checked.hidden').not('.ui-sortable-placeholder');
            ui.item.data('multidrag', elements);
        },
        beforeStop: function(event, ui) {
            if (startElement.find('.docrow').length === 0) {
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
            ui.item.siblings('.checked').removeClass('hidden');
            // ui.item.removeClass('checked');
            // $('.selected').removeClass('selected');
            var data = $(this).sortable('serialize');
            data += "&category[]=" + $(this).attr("class");
        
            $.ajax({
                data: data,
                type: 'POST',
                url: '/documents/update_document_order'
            });
        },
        receive: function(event, ui) {
            var elements = ui.item.data('multidrag');
            ui.item.before(elements);//.remove();
            var data = $(event.target).sortable('serialize');
            data += "&category[]=" + $(this).attr("class");
            $.ajax({
                data: data,
                type: 'POST',
                url: '/documents/update_document_order'
            });
        },
        helper: function(event, item) {
            if (!item.hasClass('checked')) {
                // var elements = item.clone();
                // item.data('multidrag', elements);
                // console.log('A');  
                item.find('input:checkbox').prop('checked', true);
                item.addClass('checked');
            }
            // else {
                var elements = $('.checked').not('.ui-sortable-placeholder').clone();//item.parent().children('.checked').clone();
                // item.data('multidrag', elements).siblings('.checked').remove();
            item.siblings('.checked').addClass('hidden');
                console.log('B');
            // }
            var helper = $('<tr/>');
            return helper.append(elements);
        },
        delay: 150,
        revert: 0,
        cancel: ".empty",
        connectWith: $("#categories #sortable2")
    }).disableSelection();

    $("tr #check_all").change(function() {
        $(this).closest('tbody').find('tr input:checkbox').prop('checked', this.checked);
        $(this).closest('tbody').find('#sortable2 tr:not(.hidden)').toggleClass('checked', this.checked);
    });

    // $("tr td input#check_row").hover(function() {
    //     console.log("?");
    //     // console.log($(this).attr('id'));
    // });

    $("tr #check_row").change(function(){
        $(this).closest('tr').toggleClass('checked');
    });

});

