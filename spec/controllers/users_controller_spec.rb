require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    attributes_for(:user)
  end

  let(:invalid_attributes) do
    { first_name: nil, last_name: nil, email: 'doe.john@test', username: '', password: 'test', password_confirmation: 'test' }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all contributors as @contributors' do
      user = User.create! valid_attributes
      login(user)
      get :index
      expect(assigns(:contributors)).not_to be_nil
    end

    it 'assigns all non contributors as @non_contributors' do
      user = User.create! valid_attributes
      login(user)
      get :index
      expect(assigns(:non_contributors)).not_to be_nil
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      login(user)
      get :show, { id: user.to_param }, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #new' do
    it 'assigns a new user as @user' do
      user = User.create! valid_attributes
      login(user)
      get :new, {}, valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      login(user)
      get :edit, { id: user.to_param }, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect do
          post :create, { user: valid_attributes }, valid_session
        end.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, { user: valid_attributes }, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'redirects to the created user' do
        post :create, { user: valid_attributes }, valid_session
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        post :create, { user: invalid_attributes }, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, { user: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { first_name: 'joe', last_name: 'john', email: 'doe.john@test.com', username: 'doe', password: 'testtest', password_confirmation: 'testtest' }
      end

      it 'updates the requested user' do
        user = User.create! valid_attributes
        login(user)
        put :update, { id: user.to_param, user: new_attributes }, valid_session
        user.reload
        expect(user.first_name).to eq(new_attributes[:first_name])
      end

      it 'assigns the requested user as @user' do
        user = User.create! valid_attributes
        login(user)
        put :update, { id: user.to_param, user: valid_attributes }, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it 'redirects to the user' do
        user = User.create! valid_attributes
        login(user)
        put :update, { id: user.to_param, user: valid_attributes }, valid_session
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid params' do
      it 'assigns the user as @user' do
        user = User.create! valid_attributes
        login(user)
        put :update, { id: user.to_param, user: invalid_attributes }, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_attributes
        login(user)
        put :update, { id: user.to_param, user: invalid_attributes }, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_attributes
      login(user)
      expect do
        delete :destroy, { id: user.to_param }, valid_session
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      user = User.create! valid_attributes
      login(user)
      delete :destroy, { id: user.to_param }, valid_session
      expect(response).to redirect_to(users_url)
    end
  end

  describe 'ADD CONTRIBUTOR #add_contributor' do
    it 'adds a contributor to the current user' do
      user = create(:user)
      contributor = create(:user)
      login(user)
      expect do
        get :add_contributor, id: contributor.to_param
      end.to change(user.contributors, :count).by(1)
    end

    it 'redirects to the users list' do
      user = create(:user)
      contributor = create(:user)
      login(user)
      get :add_contributor, id: contributor.to_param
      expect(response).to redirect_to(users_url)
    end
  end

  describe 'REMOVE CONTRIBUTOR #remove_contributor' do
    it 'remove a contributor from the current user' do
      user = create(:user_with_contributors)
      contributor = user.contributors.first
      login(user)
      expect do
        get :remove_contributor, id: contributor.to_param
      end.to change(user.contributors, :count).by(-1)
    end

    it 'redirects to the users list' do
      user = create(:user_with_contributors)
      contributor = user.contributors.first
      login(user)
      get :remove_contributor, id: contributor.to_param
      expect(response).to redirect_to(users_url)
    end
  end
end
