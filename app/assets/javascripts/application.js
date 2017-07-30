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
//= require jquery-ui
//= require bootstrap.min
//= require categories
//= require markasread
//= require moment
//= require fullcalendar
//= require fullcalendar/gcal

$('#calendar').fullCalendar({
    googleCalendarApiKey: '697259088972-7ekksb7tm647t1km7ropn8l890hfh105.apps.googleusercontent.com',
    events: {
        googleCalendarId: '2gafbembi5bqqflftfva2o7rv8@group.calendar.google.com'
    }
});


