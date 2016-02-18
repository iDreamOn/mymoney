require 'rails_helper'

RSpec.describe 'DebtBalances', type: :request do
  let(:debt_balance) do
    create(:debt_balance)
  end

  context 'respond with 200 (SUCCESS) when logged in' do
    before(:each) do
      login(debt_balance.owner)
    end

    it 'debt_balances_path' do
      get debt_balances_path
      expect(response).to have_http_status(200)
    end

    it 'new_debt_balance_path' do
      get new_debt_balance_path
      expect(response).to have_http_status(200)
    end

    it 'edit_debt_balance_path' do
      get edit_debt_balance_path(debt_balance)
      expect(response).to have_http_status(200)
    end

    it 'debt_balance_path' do
      get debt_balance_path(debt_balance)
      expect(response).to have_http_status(200)
    end

    it 'ccs_by_month_debt_balances' do
      get ccs_by_month_debt_balances_path
      expect(response).to have_http_status(200)
    end

    it 'loans_by_month_debt_balances' do
      get loans_by_month_debt_balances_path
      expect(response).to have_http_status(200)
    end
  end

  context 'respond with 302 (FOUND) when NOT logged in' do
    it 'debt_balances_path' do
      get debt_balances_path
      expect(response).to have_http_status(302)
    end
    it 'new_debt_balance_path' do
      get new_debt_balance_path
      expect(response).to have_http_status(302)
    end

    it 'edit_debt_balance_path' do
      get edit_debt_balance_path(debt_balance)
      expect(response).to have_http_status(302)
    end

    it 'debt_balance_path' do
      get debt_balance_path(debt_balance)
      expect(response).to have_http_status(302)
    end

    it 'ccs_by_month_debt_balances' do
      get ccs_by_month_debt_balances_path
      expect(response).to have_http_status(302)
    end

    it 'loans_by_month_debt_balances' do
      get loans_by_month_debt_balances_path
      expect(response).to have_http_status(302)
    end

  end
end
