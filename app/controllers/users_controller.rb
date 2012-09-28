class UsersController < ApplicationController
  before_filter :authenticate, :only => [:show, :index]

  def show

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

  private

  def authenticate
    redirect_to new_users_path unless log_in?
  end

end
