json.array!(@payment_methods) do |payment_method|
  json.extract! payment_method, :id, :name, :description, :created_at, :updated_at, :user_id, :method_type
  json.url payment_method_url(payment_method, format: :json)
end
