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
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap.min
//= require categories
//= require markasread
//= require moment
//= require fullcalendar
//= require fullcalendar/gcal

// $('#calendar').fullCalendar({ 
//     googleCalendarApiKey: 'AIzaSyAUNtsyZY_gIV4R8z9O4sX4jivvAi_uZ60',
//     //events: '/calendar.json'
//     eventSources: [
//         {googleCalendarId: '2gafbembi5bqqflftfva2o7rv8@group.calendar.google.com'},
//         {googleCalendarId: 'g2citgrrs9rbvjotogcs2btlo4@group.calendar.google.com'},
//     ]
// });

//   window.onload = function () {
//     var hey='hey';
//     $('#calendar').fullCalendar({ 
//       googleCalendarApiKey: 'AIzaSyAUNtsyZY_gIV4R8z9O4sX4jivvAi_uZ60',
//     //events: {googleCalendarId: '2gafbembi5bqqflftfva2o7rv8@group.calendar.google.com'},
//     });
//   }

console.log("TEST HERE")

$(document).on('ready', function() {
    console.log("HEYHEY");
    
    
    $.ajax({
      url: '/calendar.json',
      type: 'GET',
      dataType: 'json',
      beforeSend: function (xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      success: function(data){
        var calendars = [];
        for (var i=0; i < data.length; i++){
            console.log(data[i].googleCalendarID);
            calendars.push({googleCalendarId: data[i].googleCalendarID, color: data[i].color})
        }
        console.log(calendars);
        $('#calendar').fullCalendar({ 
            googleCalendarApiKey: 'AIzaSyAUNtsyZY_gIV4R8z9O4sX4jivvAi_uZ60',
            eventSources: calendars
        });
        console.log ("GET IN THERE");
      },
      error: function(xhr, status, response) {console.log("Ya dun goofed")}
    });
});

// events: [{
//     title: 'Event1',
//     start: '2017-08-08'
// }],