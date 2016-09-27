json.extract! workout, :id, :name, :instructor, :date, :time, :location, :category, :price, :duration, :level, :description, :created_at, :updated_at
json.url workout_url(workout, format: :json)