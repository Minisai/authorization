class UserController < ApplicationController
  def index
  end

  def login
    @user = User.new
  end

  def registration
  end
end
