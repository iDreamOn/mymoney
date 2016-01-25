json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :rule
  json.url schedule_url(schedule, format: :json)
end
