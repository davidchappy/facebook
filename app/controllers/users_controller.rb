class UsersController < ApplicationController
  def index
    @current_user = current_user
    @users = User.all
  end

  def show
    @current_user = current_user
    @user = User.find(params[:id]) if params[:id]
  end
end
