class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :current_user_info  
    
  def authenticate
    redirect_to root_url unless session[:user]
  end

  private  
  def current_user  
    @current_user ||= User.find_by_uid(session[:user]['uid']) if session[:user]  
  end  
  
  def current_user_info  
    @current_user_info ||= session[:user] if session[:user]  
  end 
end
