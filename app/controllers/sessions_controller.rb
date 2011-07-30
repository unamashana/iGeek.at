class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]  
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if user 
      session[:user_id] = user.id  
      redirect_path = root_url
    else
      session[:omniauth] = auth.except('extra')  
      redirect_path = new_user_path
    end  
    redirect_to redirect_path
  end 

  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Signed out!"  
  end
  
end
