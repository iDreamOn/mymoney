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

    it 'new_debt_path'

    it 'edit_debt_path'

    it 'debt_path'
  end

  context 'respond with 302 (FOUND) when NOT logged in' do
    it 'debts_path' do
      get debts_path
      expect(response).to have_http_status(302)
    end
    it 'new_debt_path'

    it 'edit_debt_path'

    it 'debt_path'
  end
end
