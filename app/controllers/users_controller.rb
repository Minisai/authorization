class UsersController < ApplicationController
  before_filter :authenticate, :only => [:show]

  def show
    @user = User.find_by_id(params[:id])
    @user ||= current_user
    respond_to do |format|
      format.html
      format.js { render 'show' }
    end
  end

  def index
    @users = Role.user.users
    @users = @users.paginate(:per_page => 5, :page => params[:page])

  end

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.js { render 'register_form' }
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      log_in @user
      respond_to do |format|
        format.html { redirect_to current_user }
        format.js { render 'show' }
      end
    else
      respond_to do |format|
        format.html { render "new" }
        format.js { render 'register_form' }
      end
    end
  end

  private

  def authenticate
    unless log_in?
      @user = User.new
      respond_to do |format|
        format.html { redirect_to new_users_path}
        format.js { render 'form'}
      end
    end
  end
end
