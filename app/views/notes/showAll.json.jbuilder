json.array!(@notes) do |note|
  json.extract! note, :id, :title, :description
  json.start note.eventDate
  json.end note.eventDate
  json.url note_url(note, format: :html)
end