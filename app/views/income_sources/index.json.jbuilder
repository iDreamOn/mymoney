json.array!(@income_sources) do |income_source|
  json.extract! income_source, :id, :name, :amount, :start_date, :end_date, :created_at, :updated_at, :account_id, :schedule_id
  json.url income_source_url(income_source, format: :json)
end
