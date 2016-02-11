require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:category) do
    create(:category)
  end

  context 'respond with 200 (SUCCESS) when logged in' do
    before(:each) do
      login(category.owner)
    end

    it 'new_category_path' do
      get new_category_path
      expect(response).to have_http_status(200)
    end

    it 'edit_category_path' do
      get edit_category_path(category)
      expect(response).to have_http_status(200)
    end

    it 'category_path' do
      get category_path(category)
      expect(response).to have_http_status(200)
    end

    it 'spendings_by_category_spendings_path' do
      get spendings_by_category_spendings_path
      expect(response).to have_http_status(200)
    end
  end

  context 'respond with 302 (FOUND) when NOT logged in' do
    it 'new_category_path' do
      get new_category_path
      expect(response).to have_http_status(302)
    end

    it 'edit_category_path' do
      get edit_category_path(category)
      expect(response).to have_http_status(302)
    end

    it 'category_path' do
      get category_path(category)
      expect(response).to have_http_status(302)
    end
    it 'spendings_by_category_spendings_path' do
      get spendings_by_category_spendings_path
      expect(response).to have_http_status(302)
    end
  end
end
