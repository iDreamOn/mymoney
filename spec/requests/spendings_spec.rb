require 'rails_helper'

RSpec.describe 'Spendings', type: :request do
  let(:spending) do
    create(:spending)
  end

  context 'respond with 200 (SUCCESS) when logged in' do
    before(:each) do
      login(spending.owner)
    end

    it 'spendings_path' do
      get spendings_path
      expect(response).to have_http_status(200)
    end

    it 'new_spending_path' do
      get new_spending_path
      expect(response).to have_http_status(200)
      xhr :get, new_spending_path, format: :js
      expect(response).to have_http_status(200)
    end

    it 'edit_spending_path' do
      get edit_spending_path(spending)
      expect(response).to have_http_status(200)
      xhr :get, edit_spending_path(spending), format: :js
      expect(response).to have_http_status(200)
    end

    it 'spending_path' do
      get spending_path(spending)
      expect(response).to have_http_status(200)
      xhr :get, spending_path(spending), format: :js
      expect(response).to have_http_status(200)
    end

    it 'spendings_by_month_spendings_path' do
      get spendings_by_month_spendings_path
      expect(response).to have_http_status(200)
    end

    it 'spendings_by_category_spendings_path' do
      get spendings_by_category_spendings_path
      expect(response).to have_http_status(200)
    end

    it 'spendings_by_payment_method_spendings_path' do
      get spendings_by_payment_method_spendings_path
      expect(response).to have_http_status(200)
    end

    it 'cc_purchase_vs_payment_spendings_path' do
      get cc_purchase_vs_payment_spendings_path
      expect(response).to have_http_status(200)
    end
  end

  context 'respond with 302 (FOUND) when NOT logged in' do
    it 'spendings_path' do
      get spendings_path
      expect(response).to have_http_status(302)
    end

    it 'new_spending_path' do
      get new_spending_path
      expect(response).to have_http_status(302)
    end

    it 'edit_spending_path' do
      get edit_spending_path(spending)
      expect(response).to have_http_status(302)
    end

    it 'spending_path' do
      get spending_path(spending)
      expect(response).to have_http_status(302)
    end

    it 'spendings_by_month_spendings_path' do
      get spendings_by_month_spendings_path
      expect(response).to have_http_status(302)
    end

    it 'spendings_by_category_spendings_path' do
      get spendings_by_category_spendings_path
      expect(response).to have_http_status(302)
    end

    it 'spendings_by_payment_method_spendings_path' do
      get spendings_by_payment_method_spendings_path
      expect(response).to have_http_status(302)
    end

    it 'cc_purchase_vs_payment_spendings_path' do
      get cc_purchase_vs_payment_spendings_path
      expect(response).to have_http_status(302)
    end
  end
end
