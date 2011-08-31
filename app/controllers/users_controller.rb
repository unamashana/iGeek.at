class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]

  layout 'app'

  def new
    @user = User.new 
  end

  def create
    @user = User.new(params[:user])
    @user.geek_id = params[:user][:geek_id].downcase
    @user.provider = session[:omniauth]['provider']
    @user.uid = session[:omniauth]['uid']
    @user.name = session[:omniauth]['user_info']['name']
    if @user.save
      flash[:success] = "Signed In!!! Start adding apps below. Also setup your profile <a href=\"#{edit_user_path(@user)}\">here</a>".html_safe
      session[:user] = session[:omniauth]
      redirect_to "/setup" #geek_path(@user.geek_id)
    else
      render :new
    end  
  end

  def show
    @user = User.find_by_geek_id params[:geek_id].downcase
    @page_title = "#{@user.name} (#{@user.geek_id})'s geek address at iGeek.at"
    @products = @user.products
    all_products = Product.all
    @autocomplete_array = all_products.map {|p| {:label => p.name, :value => p.id} }
  end

  def edit 
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Your Profile has been successfully updated"
      redirect_to edit_user_path(@user)
    else
      render :edit
    end  
  end

  def random
    @user = false
    @user = User.random until @user
    redirect_to geek_path(@user.geek_id)
  end
end
