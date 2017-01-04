json.array!(@spendings) do |spending|
  json.extract! spending, :id, :description, :spending_date, :amount, :payment_method_id, :debt_balance_id, :budget_id, :created_at, :updated_at, :pending
  json.url spending_url(spending, format: :json)
end
