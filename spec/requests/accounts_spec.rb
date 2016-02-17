require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let(:account) do
    create(:account)
  end

  context 'respond with 200 (SUCCESS) when logged in' do
    before(:each) do
      login(account.owner)
    end

    it 'accounts_path' do
      get accounts_path
      expect(response).to have_http_status(200)
    end

    it 'new_account_path' do
      get new_account_path
      expect(response).to have_http_status(200)
    end

    it 'edit_account_path' do
      get edit_account_path(account)
      expect(response).to have_http_status(200)
    end

    it 'account_path' do
      get account_path(account)
      expect(response).to have_http_status(200)
    end
  end

  context 'respond with 302 (FOUND) when NOT logged in' do
    it 'accounts_path' do
      get accounts_path
      expect(response).to have_http_status(302)
    end

    it 'new_account_path' do
      get new_account_path
      expect(response).to have_http_status(302)
    end

    it 'edit_account_path' do
      get edit_account_path(account)
      expect(response).to have_http_status(302)
    end

    it 'account_path' do
      get account_path(account)
      expect(response).to have_http_status(302)
    end
  end
end
