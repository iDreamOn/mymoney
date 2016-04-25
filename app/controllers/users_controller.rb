class UsersController < ApplicationController
  # before_filter :authenticate_user!
  before_action :set_user, only: [:show, :update]
  before_action :admin_only, except: [:show]

  # GET /users
  # GET /users.json
  def index
    @contributors = current_user.contributors
    @non_contributors = User.all - @contributors - [current_user]
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def update
    if @user.update_attributes(secure_params)
      redirect_to users_path, notice: 'User updated.'
    else
      redirect_to users_path, alert: 'Unable to update user.'
    end
  end

  def add_contributor
    current_user.contributors << User.find(params['id'])

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully added as contributor.' }
      format.json { head :no_content }
    end
  end

  def remove_contributor
    current_user.contributors.delete(User.find(params['id']))

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully removed as contributor.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def secure_params
    params.permit(:role)
  end
end
