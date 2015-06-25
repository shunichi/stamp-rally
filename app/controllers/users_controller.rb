class UsersController < ApplicationController
  before_action :set_user, only: %i(show)

  def show
  end

  def start_rally
    current_user.start_rally
    redirect_to root_url
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end