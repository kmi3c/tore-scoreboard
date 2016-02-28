class SessionsController < ApplicationController
  def new
  end

  def create
    password = Digest::SHA1.hexdigest([params[:password],params[:login]].join)
    if hostes? password
      session[:password] = password
      flash[:notice] = "Successfully logged in"
      redirect_to after_session_path
    else
     flash[:alert] = "Bad user"
     render 'new'
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Successfully logged out"
    redirect_to login_path
  end
end