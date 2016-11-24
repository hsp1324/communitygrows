$(document).ready( function() {
    $("#categories ul#sortable1").sortable({
        // connectWith: "#categories tbody#sortable2",
        axis: 'y',
        update: function (event, ui) {
            var data = $(this).sortable('serialize');
            // POST to server using $.post or $.ajax
            $.ajax({
                data: data,
                type: 'POST',
                url: '/categories/update_category_order'
            });
        }
        // start: function (event, ui) {
     //        startElement = $(this);
     //    },

        // receive: function(event, ui) {
        //  // console.log("EY YO");
        //  // console.log($(this));
        //  // if (event.target.id == "sortable1") {
         //     //  if (ui.item.id == "docrow") {
         //     //      ui.item.sortable("cancel");
         //     //  }
         //     // }
        // }
        // beforeStop: function (event, ui) {
        //  console.log(ui.item);
        //  console.log($(this));
        //  if (ui.item.id == "docrow") {
        //      ui.item.sortable("cancel");
        //  }
        //  // alert(Object.getOwnPropertyNames(startElement));
        //  // console.log(startElement.clone().get());
        //  // alert(Object.getOwnPropertyNames(startElement.context));
        //     // if (ui.item.context.id == "docrow") {
        //     //     startElement.sortable("cancel");
        //     // }
        // }
    });

    $("#categories tbody#sortable2").sortable({
        // receive: 
        connectWith: "#categories tbody#sortable2",
        axis: 'y',
        update: function (event, ui) {
            if ($("#empty") != null) {
                $("#empty").addClass("hidden");
            }
            // console.log($(this));
            
            // var data = $(this).sortable('serialize');
            // // POST to server using $.post or $.ajax
            // $.ajax({
            //     data: data,
            //     type: 'POST',
            //     url: '/categories/update_category_order'
            // });
        },

        receive: function (event, ui) {
            console.log()
            if (event.target == $(this)) {
                $("#empty").addClass("hidden");
            }
        }
        // forceHelperSize: true,
  //    containment: "tbody#sortable",
  //    helper: function(e, tr) {
        //     var $originals = tr.children();
        //     var $helper = tr.clone();
        //     $helper.children().each(function(index)
        //     {
        //       // Set helper cell sizes to match the original sizes
        //       $(this).width($originals.eq(index).width());
        //     });
        //     return $helper;
        // }
        // cancel
        // receive: function (event, ui) {
        //  // alert("Hm?")
        //  console.log(ui.item);
     //        if (!$(ui.item).is("tr")) {
     //         // alert("Golly")
     //            $(ui.sender).sortable("cancel");
     //        }
     //        // else {
     //        //     $(ui.item).find('input:radio')[1].checked = true;
     //        // }

     //    },
        // start: function (event, ui) {
     //        startElement = $(this);
     //    },
      //   beforeStop: function (event, ui) {
            // // alert("Hm?")
            // // console.log(ui.item);
      //       if (!$(ui.item).is("tr")) {
      //        // alert("Golly")
      //           $(ui.sender).sortable("cancel");
      //       }
      //       // else {
      //       //     $(ui.item).find('input:radio')[1].checked = true;
      //       // }

      //   }
        
    }).disableSelection();
});