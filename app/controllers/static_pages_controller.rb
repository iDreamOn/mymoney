class StaticPagesController < ApplicationController
  include ApplicationHelper

  skip_before_action :authenticate_user!, only: [:home]

  def home
    store_token(params[:code]) if params[:code]
  end
end
