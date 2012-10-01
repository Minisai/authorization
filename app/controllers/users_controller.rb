class UsersController < ApplicationController
  before_filter :authenticate, :only => [:show]

  def show
    @user = User.find_by_id(params[:id])
    @user ||= current_user
    respond_to do |format|
      format.html
      format.js { render 'show'}
    end
  end

  def index
    @users = Role.user.users
    @users = @users.paginate(:page => params[:page])

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
    unless log_in?
      @user = User.new
      respond_to do |format|
        format.html { redirect_to new_users_path}
        format.js { render 'register_form'}
      end
    end
  end
end
