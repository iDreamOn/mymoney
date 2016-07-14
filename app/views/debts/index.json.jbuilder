json.array!(@debts) do |debt|
  json.extract! debt, :id, :sub_category, :name, :created_at, :updated_at, :is_asset, :deleted_at, :fix_amount, :schedule, :start_date, :autopay, :category_id, :account_id
  json.url debt_url(debt, format: :json)
end
