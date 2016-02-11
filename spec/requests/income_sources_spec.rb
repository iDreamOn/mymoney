require 'rails_helper'

RSpec.describe 'IncomeSources', type: :request do
  let(:income_source) do
    create(:income_source)
  end

  context 'respond with 200 (SUCCESS) when logged in' do
    before(:each) do
      login(income_source.owner)
    end

    it 'income_sources_path' do
      get income_sources_path
      expect(response).to have_http_status(200)
    end

    it 'new_income_source_path' do
      get new_income_source_path
      expect(response).to have_http_status(200)
    end

    it 'edit_income_source_path' do
      get edit_income_source_path(income_source)
      expect(response).to have_http_status(200)
    end

    it 'income_source_path' do
      get income_source_path(income_source)
      expect(response).to have_http_status(200)
    end
  end

  context 'respond with 302 (FOUND) when NOT logged in' do
    it 'income_sources_path' do
      get income_sources_path
      expect(response).to have_http_status(302)
    end

    it 'new_income_source_path' do
      get new_income_source_path
      expect(response).to have_http_status(302)
    end

    it 'edit_income_source_path' do
      get edit_income_source_path(income_source)
      expect(response).to have_http_status(302)
    end

    it 'income_source_path' do
      get income_source_path(income_source)
      expect(response).to have_http_status(302)
    end
  end
end
