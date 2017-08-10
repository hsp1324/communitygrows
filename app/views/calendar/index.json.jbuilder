json.array!(@calendars.where(:hidden => false)) do |calendar|
    json.googleCalendarID calendar.link
    json.color calendar.color
end