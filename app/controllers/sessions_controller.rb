class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      render 'new'
    else
      log_in user
      redirect_to root_path
    end
  end

  def destroy
    log_out
    redirect_to new_sessions_path
  end
end
