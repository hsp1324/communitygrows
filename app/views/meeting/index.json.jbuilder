json.array!(@meetings) do |meeting|
    json.id = meeting.id
    json.title = meeting.name
    json.description = meeting.description
    
    json.start = meeting.date
    json.url = meeting_show_path(meeting.id)
end