class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit]

  def new
    @user = User.new 
  end

  def create
    @user.new(params[:user])
    @user.apply_omniauth(session[:omniauth])
    if @user.save
      flash[:success] = "Signed In!!"
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render :new
    end  
  end

  def edit 
    @user = current_user
  end
end
