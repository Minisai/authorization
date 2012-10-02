class SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.html
      format.js { render '/users/form'}
    end
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      render 'new'
    else
      log_in user
      redirect_to current_user
    end
  end

  def destroy
    log_out
    redirect_to index_path
  end
end
