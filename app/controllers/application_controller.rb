class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def authenticate_hostes
    redirect_to new_session_path unless hostes? session[:password]
  end
  def hostes? password
    passwords.include?(password)
  end
  def passwords
    [['h1','h1'],['h2','h2']].collect{|h|Digest::SHA1.hexdigest(h.join)}
  end
  def after_session_path
    passwords.index((session[:password])) == 0 ? new_user_path : users_path
  end
end