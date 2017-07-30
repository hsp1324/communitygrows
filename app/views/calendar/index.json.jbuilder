json.array!(@calendars) do |calendar|
    json.googleCalendarId calendar.link
    json.className calendar.name
end