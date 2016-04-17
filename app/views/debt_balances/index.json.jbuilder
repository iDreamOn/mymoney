json.array!(@debt_balances) do |debt_balance|
  json.extract! debt_balance, :id, :debt_id, :due_date, :balance, :created_at, :updated_at, :payment_start_date, :target_balance
  json.url debt_balance_url(debt_balance, format: :json)
end
