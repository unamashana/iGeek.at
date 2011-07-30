class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]  
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if user 
      session[:user_id] = user.id  
      redirection = { :path => geek_path(user.geek_id) , :notice => "Welcome Back!" }
    else
      session[:omniauth] = auth.except('extra')  
      redirection = { :path => new_user_path, :notice => "We are almost done.. Give us the following" }
    end  
    redirect_to redirection[:path], :notice => redirection[:notice]
  end 

  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Signed out!"  
  end
  
end
