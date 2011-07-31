class ProductsController < ApplicationController

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

end
