class UsersController < ApplicationController
  def show
    redirect_to new_users_path unless current_user
  end

  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      log_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end

end
