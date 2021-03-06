class UsersController < ApplicationController
  before_filter :authenticate, :only => [:show, :edit, :update]

  def show
    @user = User.find_by_id(params[:id])
    @user ||= current_user
    respond_to do |format|
      format.html
      format.js { render 'show' }
    end
  end

  def index
    @users = User.page(params[:page]).per(5)
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

  def edit

  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to profile_path
    else
      render "edit"
    end
  end

  private

  def authenticate
    unless logged_in?
      @user = User.new
      respond_to do |format|
        format.html { redirect_to log_in_path}
        format.js { render 'form'}
      end
    end
  end
end
