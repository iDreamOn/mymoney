require 'rails_helper'

RSpec.describe 'Spendings', type: :request do
  let(:schedule) do
    create(:schedule)
  end

  context 'respond with 200 (SUCCESS) when logged in' do
    before(:each) do
      login_user
    end

    it 'schedules_path' do
      get schedules_path
      expect(response).to have_http_status(200)
    end

    it 'new_schedule_path' do
      get new_schedule_path
      expect(response).to have_http_status(200)
    end

    it 'edit_schedule_path' do
      get edit_schedule_path(schedule)
      expect(response).to have_http_status(200)
    end

    it 'schedule_path' do
      get schedule_path(schedule)
      expect(response).to have_http_status(200)
    end
  end

  context 'respond with 302 (FOUND) when NOT logged in' do
    it 'schedules_path' do
      get schedules_path
      expect(response).to have_http_status(302)
    end

    it 'new_schedule_path' do
      get new_schedule_path
      expect(response).to have_http_status(302)
    end

    it 'edit_schedule_path' do
      get edit_schedule_path(schedule)
      expect(response).to have_http_status(302)
    end

    it 'schedule_path' do
      get schedule_path(schedule)
      expect(response).to have_http_status(302)
    end
  end
end
