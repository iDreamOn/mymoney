require 'rails_helper'

RSpec.describe 'AccountBalances', type: :request do
  describe 'GET /account_balances' do
    it 'works! (now write some real specs)' do
      skip 'TO BE IMPLEMENTED'
    end
  end
end
it 'make_payments_account_balance_path' do
  get make_payments_account_balance_path
  expect(response).to have_http_status(200)
end

it 'undo_payments_account_balance_path' do
  get undo_payments_account_balance_path
  expect(response).to have_http_status(200)
end

it 'balances_by_day_account_balances_path' do
  get balances_by_day_account_balances_path
  expect(response).to have_http_status(200)
end

it 'account_balances_path' do
  get account_balances_path
  expect(response).to have_http_status(200)
end

it 'new_account_balance_path' do
  get new_account_balance_path
  expect(response).to have_http_status(200)
end

it 'edit_account_balance_path' do
  get edit_account_balance_path(account_balance)
  expect(response).to have_http_status(200)
end

it 'account_balance_path' do
  get account_balance_path(account_balance)
  expect(response).to have_http_status(200)
end
