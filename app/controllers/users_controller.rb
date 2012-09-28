class UsersController < ApplicationController
  def index
  end

  def login
    @user = User.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save

    else
      render 'new'
    end
  end
end
