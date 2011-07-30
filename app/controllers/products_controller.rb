class ProductsController < ApplicationController

  respond_to :html
  layout 'app'

  def new
    @product = Product.new
  end

  def create
    @product = Product.create params[:product]

    respond_with @product

  end

end
