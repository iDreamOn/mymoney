require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #index' do
    it 'assigns all contributors as @contributors' do
      login_user
      get :index
      expect(assigns(:contributors)).not_to be_nil
    end

    it 'assigns all non contributors as @non_contributors' do
      login_user
      get :index
      expect(assigns(:non_contributors)).not_to be_nil
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      login_user
      get :show, { id: current_user.to_param }
      expect(assigns(:user)).to eq(current_user)
    end
  end

  describe 'ADD CONTRIBUTOR #add_contributor' do
    it 'adds the requested contributor to the current user' do
      login_user
      contributor = create(:user)
      expect do
        get :add_contributor, id: contributor.to_param
      end.to change(current_user.contributors, :count).by(1)
    end

    it 'redirects to the users list' do
      login_user
      contributor = create(:user)
      get :add_contributor, id: contributor.to_param
      expect(response).to redirect_to(users_url)
    end
  end

  describe 'REMOVE CONTRIBUTOR #remove_contributor' do
    it 'remove the requested contributor from the current user' do
      user = create(:user_with_contributors)
      login(user)
      contributor = user.contributors.first
      expect do
        get :remove_contributor, id: contributor.to_param
      end.to change(current_user.contributors, :count).by(-1)
    end

    it 'redirects to the users list' do
      user = create(:user_with_contributors)
      login(user)
      contributor = user.contributors.first
      get :remove_contributor, id: contributor.to_param
      expect(response).to redirect_to(users_url)
    end
  end
end
