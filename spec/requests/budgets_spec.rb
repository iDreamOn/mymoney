require 'rails_helper'

RSpec.describe 'Budgets', type: :request do
  let(:budget) do
    create(:budget)
  end

  context 'respond with 200 (SUCCESS) when logged in' do
    before(:each) do
      login(budget.owner)
    end

    it 'reset_budgets_path' do
      get reset_budgets_path
      expect(response).to have_http_status(200)
    end

    it 'reset_current_month_budgets_path' do
      get reset_current_month_budgets_path
      expect(response).to have_http_status(200)
    end

    it 'budgets_by_month_budgets_path' do
      get budgets_by_month_budgets_path
      expect(response).to have_http_status(200)
    end

    it 'budgets_path' do
      get budgets_path
      expect(response).to have_http_status(200)
    end

    it 'new_budget_path' do
      get new_budget_path
      expect(response).to have_http_status(200)
    end

    it 'edit_budget_path' do
      get edit_budget_path(budget)
      expect(response).to have_http_status(200)
    end

    it 'budget_path' do
      get budget_path(budget)
      expect(response).to have_http_status(200)
    end
  end

  context 'respond with 302 (FOUND) when NOT logged in' do
    it 'reset_budgets_path' do
      get reset_budgets_path
      expect(response).to have_http_status(302)
    end

    it 'reset_current_month_budgets_path' do
      get reset_current_month_budgets_path
      expect(response).to have_http_status(302)
    end

    it 'budgets_by_month_budgets_path' do
      get budgets_by_month_budgets_path
      expect(response).to have_http_status(302)
    end

    it 'budgets_path' do
      get budgets_path
      expect(response).to have_http_status(302)
    end

    it 'new_budget_path' do
      get new_budget_path
      expect(response).to have_http_status(302)
    end

    it 'edit_budget_path' do
      get edit_budget_path(budget)
      expect(response).to have_http_status(302)
    end

    it 'budget_path' do
      get budget_path(budget)
      expect(response).to have_http_status(302)
    end
  end
end
