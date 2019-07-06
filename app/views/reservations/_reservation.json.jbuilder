json.extract! reservation, :id, :space_id, :start_at, :end_at, :note, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
