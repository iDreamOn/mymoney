require 'rails_helper'

RSpec.describe 'PaymentMethods', type: :request do
  let(:payment_method) do
    create(:payment_method)
  end
  context 'respond with 200 (SUCCESS) when logged in' do
    before(:each) do
      login(payment_method.owner)
    end
    it 'payment_methods_path' do
      get payment_methods_path
      expect(response).to have_http_status(200)
    end

    it 'new_payment_method_path' do
      get new_payment_method_path
      expect(response).to have_http_status(200)
    end

    it 'edit_payment_method_path' do
      get edit_payment_method_path(payment_method)
      expect(response).to have_http_status(200)
    end

    it 'payment_method_path' do
      get payment_method_path(payment_method)
      expect(response).to have_http_status(200)
    end

    it 'spendings_by_payment_method_spendings_path' do
      get spendings_by_payment_method_spendings_path
      expect(response).to have_http_status(200)
    end
  end

  context 'respond with 302 (FOUND) when NOT logged in' do
    it 'payment_methods_path' do
      get payment_methods_path
      expect(response).to have_http_status(302)
    end

    it 'new_payment_method_path' do
      get new_payment_method_path
      expect(response).to have_http_status(302)
    end

    it 'edit_payment_method_path' do
      get edit_payment_method_path(payment_method)
      expect(response).to have_http_status(302)
    end

    it 'payment_method_path' do
      get payment_method_path(payment_method)
      expect(response).to have_http_status(302)
    end

    it 'spendings_by_payment_method_spendings_path' do
      get spendings_by_payment_method_spendings_path
      expect(response).to have_http_status(302)
    end
  end
end
