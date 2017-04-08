json.extract! meeting, :id, :date, :time, :book_id, :location, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
