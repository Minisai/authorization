class SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.html
      format.js { render '/users/form'}
    end
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    user ||= User.find_by_login(params[:session][:email].downcase)  if user.blank?

    if user.present? && user.authenticate(params[:session][:password])
      log_in user
      redirect_to current_user
    else
      @errors = Array.new
      @errors << "User not found"
      respond_to do |format|
        format.html { redirect_to "log_in" }
        format.js { render '/users/form' }
      end
    end
  end

  def destroy
    log_out
    redirect_to index_path
  end
end
