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
      get '/spendings.json'
      expect(response).to have_http_status(200)
      expect(json.length).to eq(1)
    end
  end
end
