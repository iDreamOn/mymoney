require 'rails_helper'

RSpec.describe 'Debts', type: :request do
  let(:debt) do
    create(:debt)
  end

  context 'respond with 200 (SUCCESS) when logged in' do
    before(:each) do
      login(debt.owner)
    end

    it 'debts_path' do
      get debts_path
      expect(response).to have_http_status(200)
    end

    it 'new_debt_path' do
      get new_debt_path
      expect(response).to have_http_status(200)
    end

    it 'edit_debt_path' do
      get edit_debt_path(debt)
      expect(response).to have_http_status(200)
    end

    it 'debt_path' do
      get debt_path(debt)
      expect(response).to have_http_status(200)
    end
  end

  context 'respond with 302 (FOUND) when NOT logged in' do
    it 'debts_path' do
      get debts_path
      expect(response).to have_http_status(302)
    end
    it 'new_debt_path' do
      get new_debt_path
      expect(response).to have_http_status(302)
    end

    it 'edit_debt_path' do
      get edit_debt_path(debt)
      expect(response).to have_http_status(302)
    end

    it 'debt_path' do
      get debt_path(debt)
      expect(response).to have_http_status(302)
    end
  end
end
