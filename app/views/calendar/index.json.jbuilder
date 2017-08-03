json.array!(@calendars) do |calendar|
    json.googleCalendarID calendar.link
end