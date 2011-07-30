class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :show]

  def new
    @user = User.new 
  end

  def create
    @user = User.new(params[:user])
    @user.provider = session[:omniauth]['provider']
    @user.uid = session[:omniauth]['uid']
    @user.name = session[:omniauth]['user_info']['name']
    if @user.save
      flash[:success] = "Signed In!!"
      session[:user_id] = @user.id
      redirect_to geek_path(@user.geek_id)
    else
      render :new
    end  
  end

  def show
    @user = User.find_by_geek_id params[:geek_id]
  end

  def edit 
    @user = current_user
  end
end
