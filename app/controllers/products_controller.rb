class ProductsController < ApplicationController

  before_filter :authenticate, :only => [:new, :create]
  before_filter :check_admin, :only => [:new, :create]

  respond_to :html
  layout 'app'

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create params[:product]
    respond_with @product do |format|
      format.html { redirect_to products_path }
    end
  end

  def show
    @product = Product.find_by_slug params[:id]
    @users = @product.users
    @page_title = "Who uses #{@product.name}?"
  end

  private

  def check_admin
    redirect_to '/' unless [1,2].include? current_user.id
  end
end
